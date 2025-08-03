// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SimpleStorage {
    uint256 public MyfavouriteNum; // gets initialized to 0 if no value given

    function favNum(uint256 Favnum) public {
        MyfavouriteNum = Favnum;
        MyfavouriteNum = MyfavouriteNum + 1;
    }

    // view, pure -> can only see things in a blockchain and can't modify it
    // view func disallow updating state
    // pure disallow updating and reading state or storge
    // calling a view or pure func dont cost gas untill they are called by some other func 
    // that costs gas 
    function retrieve() public view returns(uint256) {
        return MyfavouriteNum;
    }

    function store(uint256 _favouriteNumber) public virtual  {
        MyfavouriteNum = _favouriteNumber;
    }

    // arrays
    uint256[] ListofFavNums; 
    // struct 
    struct Person {
        uint256 favouriteNum;
        string name;
    }

    // Person public pat = Person({favouriteNum:7, name:"Pat"});

    Person[] public listOfPeople;

    // mapping
    mapping(string => uint256) public nameToFavouriteNumber;

    function addPerson(string memory name, uint256 Fnum) public {
        listOfPeople.push(Person(Fnum, name));
        nameToFavouriteNumber[name] = Fnum;
    }

}
