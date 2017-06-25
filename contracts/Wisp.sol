pragma solidity ^0.4.11;

//Wisp.deployed().then(function(instance) { return instance.creator() }).then(function(creator) { console.log(creator)});

contract Wisp {
	/*
		Wisp properties
	*/
	bytes32[] public wispStorage;						// Simple Storage
	uint24 		public weight;								// Represents converted WNT, max 1,000,000
	uint24 		public maxWeight = 1000000;		// Maximum size of a Wisp
	address[] public addresses;							// List of potential followers
	address		public creator;								// Parent contract
	address 	public owner;									// Current owner
	address 	public newOwner;							// Used for property transfer
	bool 			public positive;							// Weight is pos or neg

	function() {
		throw;
	}

	modifier onlyBy(address _account) {
		require(msg.sender == _account);
		_;
	}

	function Wisp(address _owner, uint24 _weight, bool _positive) {
		owner 		= _owner;
		creator 	= msg.sender;
		weight 		= _weight;
		positive 	= _positive;
	}

	function follow(address _addr) onlyBy(owner) {
		if (!isFollowed(_addr)) {
			addresses.push(_addr);
			followed[_addr] = true;
		}
		following[_addr] = true;
	}

	function unfollow(address _addr) onlyBy(owner) {
		following[_addr] = false;
	}

	function isFollowing(address _addr) constant returns (bool) {
		return following[_addr];
	}

	function isFollowed(address _addr) constant returns (bool) {
		return followed[_addr];
	}

	function addToStorage(bytes32 _data) onlyBy(owner) {
		wispStorage.push(_data);
	}

	mapping (address => bool) following;
}
