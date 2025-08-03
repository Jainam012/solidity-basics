// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// import "contracts/SimpleStorage.sol"; // import whole file

import {SimpleStorage} from "contracts/SimpleStorage.sol"; // import a specific contract form a file

contract StorageFactory {

    // uint256 public favouriteNumber
    // type   visibility  name
    SimpleStorage[] public listOfSimpleStorageContracts ; // creating a variable of type SimpleStorage (the above contract)
 
    function createSimpleStorageContract() public  {
        SimpleStorage newSimpleStorage = new SimpleStorage();
        listOfSimpleStorageContracts.push(newSimpleStorage);
    }
    
    // to interact with contract we need an address and ABI (Application Binary Interface)
    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
        listOfSimpleStorageContracts[_simpleStorageIndex].store(_newSimpleStorageNumber);

    }   

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        return listOfSimpleStorageContracts[_simpleStorageIndex].retrieve();
    }
}