// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract HelloWorld {
    uint number;
    
//store an unsigned integer
    function storeNumber(uint num) public {
        number = num;
    }

//retrieve unsigned integer
    function retrieveNumber() public view returns (uint) {
        return number;
    }
}
