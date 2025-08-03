// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FallBackExample {
    uint256 public result;

    receive() external payable { result = 1; }
    // the recieve function is triggered everytime we send a tracnsaction to this contract
    // even if the amount is 0 it gets triggered    
    // recieve is only triggered when calldata is blank

    fallback() external payable { result = 2; }
    // fallback function can work even if there is something in the call data 
}

// Explainer from: https://solidity-by-example.org/fallback/
// Ether is sent to contract
//      is msg.data empty?
//          /   \
//         yes  no
//         /     \
//    receive()?  fallback()
//     /   \
//   yes   no
//  /        \
//receive()  fallback()