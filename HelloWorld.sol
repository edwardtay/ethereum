pragma solidity ^0.8.6;

contract HelloWorld {
    string message;

    constructor() {
        message = "Hello, Hollywood!";
    }

    function storeNumber(uint _message) public {
        message = _message;
    }

    function retrieveNumber() public view returns (uint) {
        return message;
    }
}
