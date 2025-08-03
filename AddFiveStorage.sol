// We want this contract to do all the things exactly same as SimpleStorage but just one change
// We need store function to add 5 more
// We can do this with inheritence 
// To modify the store function and add 5 we will use override

// in order to override a function from the parent class we need to add the keyword "virtual" in the 
// parent class to do override 

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {SimpleStorage} from "contracts/SimpleStorage.sol";

// is keyword used for inheratence 
contract AddFiveStorage is SimpleStorage {
    function store(uint256 _newNumber) public  override {
        MyfavouriteNum = _newNumber + 5;
    }   
}