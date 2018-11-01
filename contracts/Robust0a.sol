pragma solidity ^0.4.19;

contract Robust0a {
    bool alreadyPaid;

    // Fail early, marked paid before paying
    function give() public {
        require(!alreadyPaid);
        alreadyPaid = true;
        // Harsh way, to revert everything
        require(msg.sender.call.value(address(this).balance / 2)());
    }
}
