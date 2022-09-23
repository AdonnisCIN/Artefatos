// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.8.7;
contract Voting {
   address public admin; // Administrator or organizer of the vote.
   string public position;
   string[] public candidates; // List of candidates who are running for office.
   bool public votingClosed;
 
 
 
   mapping (string => uint256) vote;
   mapping (address => bool) elector;
 
 
 
   constructor (string memory _position, string[] memory name){
       admin = msg.sender;     // Stores the address of the organizer (admin) of the vote.
       position = _position;   // Organizer informs the position for voting.
       candidates= name;       // Organizer informs list with the names of the candidates for the position.
     
   }
 
   function voteIn (string memory candidatesCurrent) external {
       require(!elector[msg.sender], "The voter has already voted."); // It requires that the voter's account can only vote if they have not done so previously.
       require(candidateValid(candidatesCurrent)); // It demands that the voter only vote for the candidates informed by the organizer.
       require(!votingClosed,"Election over!");
 
       vote[candidatesCurrent] +=1;
       elector[msg.sender] = true;
   }
 
   function viewResult (string  memory candidatesCurrent) external view returns (uint256 ){
       return (vote[candidatesCurrent]); // It shows the amount of votes each candidate received.
   }
 

// Verification that the candidate the voter wants to vote for is valid, that is: it was the candidates informed by the organizer.
 
   function candidateValid (string memory candidatesCurrent) public view returns (bool){
       for(uint i = 0; i < candidates.length; i++){
           if (keccak256(bytes(candidates[i])) == keccak256(bytes(candidatesCurrent)) ){
               return true;
           }
       }
       return false;
   }
 
 
   function endVoting ( address finisher) external  returns (bool){
       if(finisher == admin){
           
            return votingClosed= true;
       }
       return votingClosed= false;
   }
}
