pragma solidity ^0.4.6;

import './GoldWisp.sol';

contract GoldWispGenerator {
  address public owner;

	function () {
		throw;
	}

	function GoldWispGenerator() {
    owner = msg.sender;
	}

	function createGoldWisp() returns (address) {
    GoldWisp gw = new GoldWisp(msg.sender);
    CreateGoldWisp(msg.sender, address(this), address(gw));
    return address(gw);
  }

	event CreateGoldWisp(address owner, address creator, address goldWispAddr);

}
