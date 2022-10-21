import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:twitter_dapp/contract_linking.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final contratLink = Provider.of<ContratLinking>(context);
    final _messageController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Twitter dApp'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: contratLink.isLoading
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Form(
                      child: Column(
                  children: <Widget>[
                    Text('Welcome to Twitter dApp ${contratLink.deployedName}'),
                    TextFormField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        labelText: 'Message',
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        contratLink.setMessage(_messageController.text);
                        _messageController.clear();
                      },
                      child: const Text('Set Message'),
                    ),
                  ],
                ))),
        ),
      ),
    );
  }
}
