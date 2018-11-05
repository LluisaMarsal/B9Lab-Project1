pragma solidity ^0.4.19;

contract Splitter {
    address public owner; 
    uint256 sendAmount;

    function Splitter() public payable {
        owner = msg.sender; 
        sendAmount = msg.value/2;
        msg.value % 2 == 0; 
    }
   
    function send (address  recipient1, address  recipient2) public payable {
        recipient1.transfer(msg.value/2);
        recipient2.transfer(msg.value/2);
    } 

    function killMe() public returns (bool) {
        require(msg.sender == owner);
        selfdestruct(owner);
        return true;
    }
}

