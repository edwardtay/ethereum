// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ballot{
    //Vars
    struct voter{
        string voterName;
        bool isVoted;
    }

    struct Vote{
        address voterAddress;
        bool choice;
    }

    //Start Time
    uint public startTime;


    uint private countResult;
    uint public finalResult;
    uint public totalVoter;
    uint public totalVote;

    address public ballotOfficalAddress;
    string public ballotOfficialName;
    string public proposal;

    mapping(uint=>Vote) private votes;
    mapping(address=>voter) public voterRgst;

    enum State{
        Created,
        Voting,
        Ended
    }

    State public state;



    //funcs

    constructor(string memory _ballotOfficalName, string memory _proposal){
        ballotOfficalAddress = msg.sender;
        ballotOfficialName = _ballotOfficalName;
        proposal = _proposal;
        state = State.Created;
    }

    function addVoter(address _voterAddress, string memory _voterName)public inState(State.Created) onlyOwner{
        voter memory v;
        v.voterName = _voterName;
        v.isVoted = false;
        voterRgst[_voterAddress] = v;
        totalVoter++;
    }

    function startVote()public inState(State.Created) onlyOwner{
        state = State.Voting;
        startTime = block.timestamp;

    }

    function vote(bool _choice)public inState(State.Voting) voteEnded() returns(bool){
        bool found = false;
        //Check is can voted
        if(bytes(voterRgst[msg.sender].voterName).length != 0 && voterRgst[msg.sender].isVoted)
        {
            voterRgst[msg.sender].isVoted = true;
            Vote memory v;
            v.voterAddress = msg.sender;
            v.choice = _choice;
            if(_choice){
                countResult++;
            }
            votes[totalVote] = v;
            totalVote++;
            found = true;
        }
        return found;
    }

    function endVote()public inState(State.Voting) onlyOwner{
        state = State.Ended;
        finalResult = countResult;
    }


    //modifiers
    modifier condiditon(bool _condiditon){
        require(_condiditon);
        _;
    }

    modifier onlyOwner(){
        require(msg.sender == ballotOfficalAddress);
        _;
    }

    modifier inState(State _state){
        require(state == _state);
        _;
    }

    //Check Time

    modifier voteEnded(){
        require(block.timestamp < startTime+300, "Voting time is over");
        _;
    }

}
