// SPDX-License-Identifier:  MIT

pragma solidty ^0.8.8;


import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256; 

    uint256 public minimumUsd = 50 * 1e18; // 1 * 10 ** 18

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded; 

    address public owner;

    constructor(){
        owner = msg.sender;
    }
    
    function fund() public payable {
        require(msg.value >= minimumUsd, "Didnt send enough!";)
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value; 
    }

    function withdraw() public onlyOnwer {
        

        /* starting index, ending index, step amount  */
        for(uint256 funderIndex = 0;, funderIndex < funders.length, funderIndex++){
            //code
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
         //reset the array
         funders = new address[](0); 
         //actually withdraw the funds

         //transfer
         payable(msg.sender).transfer(address(this).balance);
         //send
         bool sendSuccess = payable(msg.sender).send(address(this).balance);
         require(sendSuccess, "Send failed");
         //call 
         (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");

        //msg.sender = address
        //payable(msg.sender) = payable address
       

    }

        modifier onlyOwner {
            require(msg.sender == owner, "Sender is not owner!");
            _;
        }
}