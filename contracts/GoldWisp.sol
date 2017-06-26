pragma solidity ^0.4.11;

import './Wisp.sol';
import './StandardToken.sol';

contract GoldWisp is StandardToken {
  address public owner;
  address public creator;
  uint8 public decimals;
  string public name;
  string public symbol;
  bool public wispLocked = false;

	modifier onlyBy(address _account) {
		require(msg.sender == _account);
		_;
	}

  function () {
    throw;
  }

  function GoldWisp(address _owner) {
    owner   = _owner;
    creator = msg.sender;
  }

  function createAsset(
    uint256 _totalSupply,
    uint256 _initialBalance,
    uint8 _decimals,
    string _name,
    string _symbol
    ) onlyBy(owner) {
    totalSupply           = _totalSupply;
    balances[msg.sender]  = _initialBalance;
    decimals              = _decimals;
    name                  = _name;
    symbol                = _symbol;
    wispLocked            = true;
  }

  function acceptOwnership(address _addr) onlyBy(owner) {
    Wisp w = Wisp(_addr);
    w.acceptOwnership();
  }

  function changeOwner(address _addr, address _newOwner) onlyBy(owner) {
    if (!wispLocked) {
      Wisp w = Wisp(_addr);
      w.changeOwner(_newOwner);
    }
	}

  function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);

    if(!_spender.call(bytes4(bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData)) { throw; }
    return true;
  }

}