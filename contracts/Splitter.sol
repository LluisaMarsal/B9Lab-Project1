pragma solidity ^0.4.19;

import "./ConvertLib.sol";

contract Splitter {
    address public owner;
    uint256 sendAmount;

    function Splitter() public payable {
        owner = msg.sender;
        sendAmount = 0.5 ether;
    }

    function getBalance() public view returns (uint) {
         return address(this).balance;
    }

    function getWei() public {
        msg.sender.transfer(sendAmount);
    }

    function sendWei(address toWhom) public {
        toWhom.transfer(sendAmount);
    }

    function getSendAmount() public view returns (uint256) {
        return sendAmount;
    }

    function killMe() public returns (bool) {
        require(msg.sender == owner);
        selfdestruct(owner);
        return true;
    }

    function() public payable {}
} 

