pragma solidity ^0.4.24;

contract Lotto {
  uint[] public lotto_result;

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
  
  function randomNum() public payable{
        //randomly pick a number
        
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
}
