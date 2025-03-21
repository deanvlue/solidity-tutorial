// SPDX-License-Identifier:MIT 
// license required for checking the use of the program

pragma solidity ^0.8.26;

contract seguridadMod {
    address public owner; 
    mapping (address => uint256) public balances; 
}

modifier onlyOwner(){
    require(msg.sender==owner, "No tiene permiso para ejecutar esta funcion";)
}