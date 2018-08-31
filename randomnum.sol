pragma solidity ^0.4.24;

contract Lotto {
    address[] public betters;
    address owner;
    address public winneraddr;
    
    uint[] public lotto_result;
    uint public prize;
    
    function senders(uint) public view returns (address[])
    {
        return betters;
    }
    function get_gas_data(uint) public view returns (uint)
    {
        return address(this).balance;
    }
    function get_lotto_result() public view returns (uint[])
    {
        if (lotto_result.length == 3)
        {
            return lotto_result;    
        }
        else
        {
            
        }
    }
 
    constructor() public {
        owner = msg.sender;

    }
    function lotto_Num() public payable{
        //randomly pick a number
        
        address operator = 0x4be9fff5d658286c38fdc77b0c7b8827188b6752;
        
        if(msg.sender == operator)
        {
            uint[3] memory data_result;
            for (uint i = 0; i < data_result.length; i++)
            {
                data_result[i] = uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, gasleft()))) % 10 + 1;
                for (uint j = 0; j < i; j++)
                {
                    if (data_result[j] == data_result[i])
                    {
                        data_result[i] = uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, gasleft()))) % 10 + 1;        
                    }
                    else
                    {
                        
                    }
                }
            }
             lotto_result = data_result;
        }
       else
       {
           
       }

    }
}

0x7784d900fe167c473346994a959c2ec054049d02
