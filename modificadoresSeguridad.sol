// SPDX-License-Identifier:MIT 
// license required for checking the use of the program

pragma solidity ^0.8.26;

contract seguridadMod {
    address public owner; 
    mapping (address => uint256) public balances; 

    modifier onlyOwner(){
        require(msg.sender==owner, "No tiene permiso para ejecutar esta funcion");
        _; // ahi pone el resto de la funcion
    }

    modifier hasEnoughFunds(uint256 _amount){
        require(balances[msg.sender] >= _amount, "Fondos insuficientes");
        _;
    }

    constructor(){
        owner = msg.sender;
    }

    function depositar() public payable {
        require(msg.value > 0, "Debe depositar una cantidad positiva");
        balances[msg.sender] += msg.value;
    }

    function withdrawal(uint256 _amount)  public hasEnoughFunds(_amount){
        balances[msg.sender] -= _amount;
        payable (msg.sender).transfer(_amount);
    }

    function retirarTodo() public onlyOwner{
        uint256 balanceContrato = address(this).balance;
        require(balanceContrato > 0, "no hay fondos en el contrato");
        payable(owner).transfer(balanceContrato);
    }

    receive() external payable{
        depositar();
    }

}

