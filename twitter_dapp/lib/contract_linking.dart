import 'dart:convert';
import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContratLinking extends ChangeNotifier {
  final String _rpcUrl = "http://127.0.0.1:7545";
  final String _wsUrl = "ws://127.0.0.1:7545";
  final String _privateKey =
      "91eacfd65d69428101364e44ae5cbcb3068cfb184a0df87d5fd01e82e62c75a1";

  Web3Client? _web3client;
  bool isLoading = true;

  String? _abiCode;
  EthereumAddress? _contractAddress;
  Credentials? _credentials;
  DeployedContract? _contract;
  ContractFunction? _message;
  ContractFunction? _setMessage;
  String? deployedName;

  ContratLinking() {
    setUp();
  }

  setUp() async {
    _web3client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile =
        await rootBundle.loadString('build/contracts/twitterdApp.json');

    final jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi['abi']);

    _contractAddress =
        EthereumAddress.fromHex(jsonAbi['networks']['5777']['address']);
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode!, "twitterdApp"), _contractAddress!);

    _message = _contract!.function('message');
    _setMessage = _contract!.function('setMessage');
    getMessage();
  }

  getMessage() async {
    final _mymessage = await _web3client!
        .call(contract: _contract!, function: _message!, params: []);

    deployedName = _mymessage[0];
    isLoading = false;
    notifyListeners();
  }

  setMessage(String message) async {
    isLoading = true;
    notifyListeners();
    await _web3client!.sendTransaction(
      _credentials!,
      Transaction.callContract(
          contract: _contract!, function: _setMessage!, parameters: [message]),
    );
    getMessage();
  }
}
