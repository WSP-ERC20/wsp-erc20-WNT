pragma solidity ^0.4.6;

import './StandardToken.sol';
import './Wisp.sol';

contract WispNetworkToken is StandardToken {
	string public name;
	uint8 public decimals;
	string public symbol;
	uint24 public maxWeight;

	function () {
		throw;
	}

	function WispNetworkToken() {
		decimals 							= 6;
		totalSupply 					= 100000000000000;	// 100M Market coins
		balances[msg.sender] 	= 20000000000000; 	// 10M Dev coins
		name 									= 'Wisp Network Token';
		symbol 								= 'WNT';
		maxWeight							= 1000000;
	 }

  function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);

    if(!_spender.call(bytes4(bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData)) { throw; }
    return true;
  }

	// Negative values will cause _weight to count from uint24 max backwards
  // Cannot prevent them being sent but can check their values
	function createWisp(uint24 _weight, bool _positive) returns (address) {
		if (balances[msg.sender] > _weight && _weight > 0 && _weight <= maxWeight) {
			balances[msg.sender] -= _weight;
			Wisp newWisp = new Wisp(msg.sender, _weight, _positive);
			CreateWisp(msg.sender, address(this), address(newWisp), _weight, _positive);
		} else {
			throw;
		}
    return address(newWisp);
  }

	function getBalance(address addr) returns(uint) {
		return balances[addr];
	}

	event CreateWisp(address owner, address creator, address wispAddr, uint24 weight, bool positive);

}
