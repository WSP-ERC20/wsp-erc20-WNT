pragma solidity ^0.4.11;

import './StandardToken.sol';
import './Wisp.sol';

contract WispNetworkToken is StandardToken {
	string public name;
	uint8 public decimals;
	string public symbol;	

	function () {
		throw;
	}

	function WispNetworkToken() {
		 balances[msg.sender] = 1000000; 	// 1M Dev coins
		 totalSupply 					= 10000000;	// 9M Market coins
		 name 								= 'Wisp Network Token';				
		 decimals 						= 18;
		 symbol 							= 'WNT';
	 }

  function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);

    if(!_spender.call(bytes4(bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData)) { throw; }
    return true;
  }

	function createWisp(uint _weight, bool _positive) returns (address) {
		balances[msg.sender] -= _weight ;
    Wisp newWisp = new Wisp(msg.sender);
		CreateWisp(msg.sender, address(this), address(newWisp));	
    //isWisp[address(newWisp)] = true;
    //CreateWisp(msg.sender, address(this), address(newWisp));
    //HumanStandardToken newToken = (new HumanStandardToken(_initialAmount, _name, _decimals, _symbol));
    //created[msg.sender].push(address(newToken));
    //isHumanToken[address(newToken)] = true;
    //newToken.transfer(msg.sender, _initialAmount); //the factory will own the created tokens. You must transfer them.
    return address(newWisp);
  }

	function getBalance(address addr) returns(uint) {
		return balances[addr];
	}
	
	event CreateWisp(address owner, address creator, address wispAddr);

}
