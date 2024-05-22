//SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.0;


contract Marketplace {
    address public seller;
    //address public buyer;
    mapping (address => uint) public balances;

    event ListItem(address seller, uint price);
    event PurchasedItem(address seller, address buyer, uint price);

    enum StateType {
          ItemAvailable,
          ItemPurchased
    }

    StateType public State;

    constructor() {
        seller = msg.sender;
        State = StateType.ItemAvailable;
    }

    function buy(address buyer, uint price) public payable {
        require(price <= balances[buyer], "Insufficient balance");
        State = StateType.ItemPurchased;
        balances[buyer] -= price;
        balances[seller] += price;

        emit PurchasedItem(seller, buyer, msg.value);
    }

    function setBalance(address player, uint balance) public payable {
        balances[player] = balance;
    }

}