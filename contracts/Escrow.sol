pragma solidity >=0.4.21 <0.6.0;

contract Escrow {

	address escrowAgent;
	mapping(address => uint256) public deposits;

	modifier onlyEscrowAgent () {

		require (msg.sender == escrowAgent);
		_;
	}

	constructor() public {
		escrowAgent = msg.sender;
	}

	function depositFunds(address payee) public onlyEscrowAgent payable {
		uint256 amount = msg.value;
		deposits[payee] = deposits[payee] + amount;
	}

	function withdrawFunds(address payable payee) public onlyEscrowAgent {
		uint256 payement = deposits[payee];
		deposits[payee] = 0;
		payee.transfer(payement);
	}

}