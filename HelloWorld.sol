pragma solidity ^0.8.6;

contract HelloWorld {
    string message;
    
//store an unsigned integer
    function storeNumber(uint _message) public {
        message = _message;
    }

//retrieve unsigned integer
    function retrieveNumber() public view returns (uint) {
        return message;
    }
}
