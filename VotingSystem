pragma solidity ^0.4.20;

contract VotingSystem {
    
    // This sctructure holds info about the person who votes
    struct Voter {
        bool voted;
        bytes32 vote;
    }
    
    // This sctructure holds info about the person who you can vote for
    struct Candidate {
        bytes32 name;
        uint8 numberOfVotes;
    }
    
    // Contract owner's address
    address contractOwner;
    
    
    // Mapping adresse's to voter info
    mapping(address => Voter) voters;
    Candidate[] candidates;
    
    // Our constructor assigns names of candidates to the Candidate 
    // array we stor on block chain.
    // Also stors the contractOwner address on the block chain
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
    // Check wheter the voter has voted, if not:
    // Mark the fact that he voted, also store the person he voted for
    // Finally increment candidate's numberOfVotes
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
