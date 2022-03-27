// SPDX-License-Identifier:MIT
pragma solidity >=0.5.0<0.9.9;

contract CrowdFunding{

    mapping (address=>uint) public contributors;
    address payable public manager;
    uint public minContribution;
    uint public deadline;
    uint public targetAmount;
    uint public raisedAmount;
    uint public noOfContributors;

    constructor (uint _targetAmount, uint _deadline) public {
        minContribution = 100 wei;
        deadline = block.timestamp + _deadline;
        targetAmount = _targetAmount;
        manager = msg.sender;
    }

    function sendEth() payable public {
        require(deadline > block.timestamp,"deadline has passed");
        require(msg.value >= minContribution,"please send atleast minimun contribution! ");
        // manager.transfer(msg.value);

        if(contributors[msg.sender] == 0){
            noOfContributors ++;
        }
        contributors[msg.sender] += msg.value;
        raisedAmount += msg.value;

    }

    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }

}