pragma solidity ^0.4.11;

import './Wisp.sol';
import './StandardToken.sol';

contract WispAsset is StandardToken {
  address owner;
  uint8 decimals;
  string name;
  string symbol;


	modifier onlyBy(address _account) {
		require(msg.sender == _account);
		_;
	}

  function () {
    throw;
  }

  function WispAsset(
    uint256 _totalSupply,
    uint256 _initialBalance,
    uint8 _decimals,
    string _name,
    string _symbol

    ) {
    owner                 = msg.sender;
    totalSupply          = _totalSupply;
    balances[msg.sender]  = _initialBalance;
    decimals              = _decimals;
    name                  = _name;
    symbol                = _symbol;
  }

  function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);

    if(!_spender.call(bytes4(bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData)) { throw; }
    return true;
  }

  function acceptOwnership(address _addr) onlyBy(owner) {
    Wisp w = Wisp(_addr);
    w.acceptOwnership();
  }
}