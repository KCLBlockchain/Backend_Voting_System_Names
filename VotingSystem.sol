pragma solidity ^0.4.20;

contract VotingSystem {
    
    // This struct holds info about the person who votes
    struct Voter {
        bool voted;
        bytes32 vote;
    }
    
    // This struct holds info about the person who you can vote for
    struct Candidate {
        bytes32 name;
        uint8 numberOfVotes;
    }
    
    // Contract owner's address
    address contractOwner;
    
    // Mapping adresse's to voter info
    mapping(address => Voter) voters;
    Candidate[] candidates;
    
    // The constructor assigns names of candidates to the Candidate array we store on blockchain.
    // Also stores the contractOwner address on the blockchain.  
    function VotingSystem (bytes32[] candidateNames) {
        contractOwner = msg.sender;
        for (uint8 i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate({
                name : candidateNames[i],
                numberOfVotes : 0
            }));
        } 
    }
    
    // Voting function:
    // Check whether the voter has voted, if not:
    // - Mark the fact that he voted, also stores the person he voted for
    // - Increment candidate's numberOfVotes
    function vote (bytes32 voteFor) {  
    
        Voter storage sender = voters[msg.sender];  
        if(sender.voted) return;      
        sender.voted = true;
        sender.vote = voteFor;
        
        for (uint i = 0; i < candidates.length; i++) {
             if (candidates[i].name == voteFor) {         
                candidates[i].numberOfVotes+=1;   
             }          
        }      
    }


    // This function returns the candidate with most votes. 
    function winningCandidate () constant returns(string winnerName) {
        
        uint8 tempWinnerName;
        uint maxVote = 0;
        
        for (uint8 i = 0; i < candidates.length; i++) {     
            if (candidates[i].numberOfVotes >= maxVote) {            
                maxVote = candidates[i].numberOfVotes;
                tempWinnerName = i;
            }
        }
        
        bytes32 winner = candidates[tempWinnerName].name;
        return bytes32ToString(winner);
    }
    
    // Convert bytes32 to string (used to display the winner's name)
    function bytes32ToString(bytes32 x) constant returns (string) {
    
        bytes memory bytesString = new bytes(32);
        uint charCount = 0;
        
        for (uint j = 0; j < 32; j++) {
            byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
            if (char != 0) {
                bytesString[charCount] = char;
                charCount++;
            }
        }
        
        bytes memory bytesStringTrimmed = new bytes(charCount);
        for (j = 0; j < charCount; j++) {
            bytesStringTrimmed[j] = bytesString[j];
        }
        
        return string(bytesStringTrimmed);
    }
    
}
