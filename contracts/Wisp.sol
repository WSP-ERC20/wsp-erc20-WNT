pragma solidity ^0.4.11;

//Wisp.deployed().then(function(instance) { return instance.creator() }).then(function(creator) { console.log(creator)});

contract Wisp {
	/*
		Wisp properties
	*/
	bytes32[] public wispStorage;						// Simple Storage
	address[] public addresses;							// List of potential followers
	address		public creator;								// Parent contract
	address 	public owner;									// Current owner
	address 	public newOwner;							// Used for property transfer
	uint24 		public weight;								// Represents converted WNT, max 1,000,000
	bool 			public positive;							// Weight is pos or neg
	uint24 		public maxWeight 	= 1000000;

	function() {
		throw;
	}

	modifier onlyBy(address _account) {
		require(msg.sender == _account);
		_;
	}

	function Wisp(address _owner, uint24 _weight) {
		owner = _owner;
		creator = msg.sender;
		weight = _weight;
		positive = true;//_positive;
	}

	function follow(address _addr) onlyBy(owner) {
		if (!isFollowing(_addr)) {
			addresses.push(_addr);
		}
		following[_addr] = true;
	}

	function unfollow(address _addr) onlyBy(owner) {
		following[_addr] = false;
	}

	function getFollowing() constant returns (address[]) {
		return addresses;
	}

	function isFollowing(address _addr) constant returns (bool) {
		return following[_addr];
	}

	function getAddresses(uint _start, uint _end) constant returns (bytes32[]) {
		return wispStorage;
	}	
/*
	function getWispData() constant returns (address, uint, bool, address, address, address)  {
		return (
			address(this),
			weight,
			positive,
			owner,
			creator,
			newOwner);
	}
*/
	mapping (address => bool) following;

}
