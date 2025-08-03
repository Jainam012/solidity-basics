// get funds from users
// withdraw funds 
// set a minimum value in USD


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// 887658
// gas efficiency? -> adding constant to minimumUsd Or adding immutable to required variable

// another was-> instead of using we can use custom error
error NotOwner(); // declare this before the contract -> see line 71    

import {PriceConverter} from "contracts/PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5 * 1e18;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    // varibles like owner can be set as immutable as we are just changing them once 
    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Not enough balance"); // 1e18 = 1ETH = 10^18 wei
        // heren all uint256 can use the library that is priceconverter and 
        // the msg.value is the first input in the getConversionRate() function

        // what is a revert?
        // undo any actions that have been done and send the remaining gas back
        // for example if the require does not meet then there will be no change in myValue
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        // require(msg.sender == owner, "Must be Owner!"); -> we use modifier for this one
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;

        }
        funders = new address[](0); // reset the array 

        // actually withdraw the funds 

        // 1. transfer - automatically reverts
        // msg.sender = address type
        // payable(msg.sender) payable address type [type casting]
        // payable(msg.sender).transfer(address(this).balance);
        
        // 2. send - does not revert automatically (we will need to add require to revert)
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

        // 3. call - low level , returns bool 
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner() {
        // require(msg.sender == i_owner, "Sender is not owner");
        if(msg.sender != i_owner) { revert NotOwner();} // this can save gas as we are not storing any string like the one in the require() statement
        _; // this means we execute the remaining code inside the function 
    }

    // what happens if someone sends this contract ETH without calling the fund function?
    // see the FallBackExample.sol file for this

    receive() external payable { 
        fund();
    }

    fallback() external payable {
        fund();
     }
    

}