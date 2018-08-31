     function lotto_Num() public payable{ 
         //randomly pick a number 
          
         //address operator = 0x4be9fff5d658286c38fdc77b0c7b8827188b6752; 
         address operator = 0xca35b7d915458ef540ade6068dfe2f44e8fa733c;
         
         
         if(msg.sender == operator) 
         { 
             uint[3] memory data_result; 
             uint temp1;
             uint temp2;
             uint temp3;
             
             
             for (uint i = 0; i < 100; i++)
             {
                temp1 = uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, gasleft()))) % 10 + 1;
                temp2 = uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, gasleft()))) % 10 + 1; 
                temp3 = uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, gasleft()))) % 10 + 1; 
                if((temp1 == temp2) || (temp1 == temp3) || (temp2 == temp3))
                {
                    
                }
                else
                {
                    data_result[0] = temp1;
                    data_result[1] = temp2;
                    data_result[2] = temp3;
                    break;
                }
             }
             lotto_result = data_result; 
     } 
        else 
        { 
             
        } 
    
    }
