pragma solidity ^0.4.24;

contract LotorryPjt {
    address[] public betters ; // Investor 
    address public owner ;
    address public winneraddr ;


    bytes32 public winnerName ;
    uint public winneridex ;
    bool    public isOpen ;

    address public tmpAddr ;
    uint    public tmpAmt ;
    uint    public tmpTotVotingCnt ;
    uint    public winnerindex ;    
    uint    constant fixedCnt   = 3 ;
    uint    public totLotteryAm = 0 ;    
    
    uint    public lotteryNum1 = 0 ;
    uint    public lotteryNum2 = 0 ;
    uint    public lotteryNum3 = 0 ;    

    uint    public rank1Cnt = 0 ;
    uint    public rank2Cnt = 0 ;
    uint    public rank3Cnt = 0 ;
    
    uint    public rank1Amt = 0 ;
    uint    public rank2Amt = 0 ;
    uint    public rank3Amt = 0 ;    

    Candidate[] public candidate ;
    
    uint[] public lotto_result; 

    struct Candidate{
        address addr ;
        uint num1    ;
        uint num2    ;
        uint num3    ;        
        uint amount  ;
        uint okCnt   ;
        uint rank    ;   
        uint dividend;        
    }


    constructor() public payable{
        owner  = msg.sender ;
        isOpen = false ;
    }

    modifier chkOwner() {
        require(owner == msg.sender );
        _;
    }    
    
    modifier checkStart(bool chk) {
        require(isOpen == chk );
        _;
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

    function mybalance() public view returns (uint) {
        return address(msg.sender).balance ;
    }

    // step2
    function lotteryGo(uint no1, uint no2, uint no3) public payable checkStart(true) {
        
        totLotteryAm += msg.value ;

        candidate.push(
            Candidate(
                { addr   : msg.sender,
                  num1   : no1,
                  num2   : no2,
                  num3   : no3,
                  amount : msg.value,
                  okCnt  : 0,
                  rank   : 0,
                  dividend : 0
                }
            )
        );
    }

    // step2_confirm
    function lotteryGo_confirm(uint no) public {
        tmpTotVotingCnt = candidate.length ;

        require(no <= tmpTotVotingCnt || (tmpTotVotingCnt == 1 && no ==0 )) ;

        tmpAddr = candidate[no].addr   ;
        tmpAmt  = candidate[no].amount ;

    }

    // 
    function publish() public checkStart(false) {
        uint l_num1 ;
        uint l_num2 ;
        uint l_num3 ;
        uint l_okCnt  = 0 ;

        address l_winneraddr ;

        uint   l_length = candidate.length ;
        
        lotteryNum1 =lotto_result[0] ;
        lotteryNum2 =lotto_result[1] ;
        lotteryNum3 =lotto_result[2] ;

        for(uint i = 0 ; i < l_length ; i++){
            l_num1 = candidate[i].num1 ;
            l_num2 = candidate[i].num2 ;
            l_num3 = candidate[i].num3 ;

            if (((lotteryNum1 == l_num1) || (lotteryNum1 == l_num2)  || (lotteryNum1 == l_num3))
                || ((lotteryNum2 == l_num1) || (lotteryNum2 == l_num2)  || (lotteryNum2 == l_num3))
                || ((lotteryNum3 == l_num1) || (lotteryNum3 == l_num2)  || (lotteryNum3 == l_num3))
               ){
                candidate[i].okCnt += 1 ;
            }

            if(candidate[i].okCnt == fixedCnt  ) candidate[i].rank = 1 ;
            if(candidate[i].okCnt == fixedCnt-1) candidate[i].rank = 2 ;
            if(candidate[i].okCnt == fixedCnt-2) candidate[i].rank = 3 ;              
        }

        // Finally
        for(uint j = 0 ; j < l_length ; j++ ){
            if(candidate[j].okCnt == 3   ){
                rank1Cnt += 1 ;
            }else if(candidate[j].okCnt == 2   ){
                rank2Cnt += 1 ;                
            }else if(candidate[j].okCnt == 1   ){
                rank3Cnt += 1 ;                
            }
        }
        rank1Amt = (totLotteryAm*50/100)/rank1Cnt;
        rank2Amt = (totLotteryAm*30/100)/rank2Cnt;
        rank3Amt = (totLotteryAm*20/100)/rank3Cnt;
        
        for(uint k = 0 ; k < l_length ; k++ ){
            if(candidate[k].okCnt == 3   ){
                candidate[i].dividend =  rank1Amt ;
            }else if(candidate[k].okCnt == 2   ){
               candidate[i].dividend =  rank2Amt ;         
            }else if(candidate[k].okCnt == 1   ){
               candidate[i].dividend =  rank3Amt ;             
            }else{
               candidate[i].dividend =  0 ;
            }
        }
    }


    function open() public payable{ isOpen = true ; }

    function close() public payable{ isOpen = false ; }

    function vote() public payable{
        betters.push(msg.sender);
    }

     function lotto_Num() public payable{ 
         //randomly pick a number 
          
         address operator = 0xca35b7d915458ef540ade6068dfe2f44e8fa733c; 
          
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

    function () public payable {}
}
