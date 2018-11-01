pragma solidity ^0.4.19;

contract Splitter {
    address owner = 0x89063abe69934a06e1a8f636d448725fc8d57cbf;  
    address[] recipients = [0x0ca374e9226edfda1bb47ba22cd679c8f2fd150d,
    0xb1004fb128ee03ed57e1104285363ac2d46fcd24];
   
    function send (address _recipient1, address _recipient2) public payable {
     _recipient1.transfer(msg.value/2);
     _recipient2.transfer(msg.value/2);
    } 

    function killMe() public returns (bool) {
        require(msg.sender == owner);
        selfdestruct(owner);
        return true;
    }
} 

