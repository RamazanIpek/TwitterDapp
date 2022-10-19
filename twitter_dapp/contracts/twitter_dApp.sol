// SPDX-License-Identifier: MIT 

pragma solidity >=0.7.0 <0.9.0;

contract twitterdApp {
    string public message;

    constructor() {
        message = "Hello World";
    }

    function setMassage(string memory _message) public {
        message = _message;
    }
}