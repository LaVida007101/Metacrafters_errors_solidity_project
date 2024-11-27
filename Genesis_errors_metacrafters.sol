// SPDX-License-Identifier: MIT
// 202111019@fit.edu.ph
pragma solidity ^0.8.13;

contract LegalAgreementNiGenesis {
    address public partyA; 
    address public partyB; 
    string public agreementTerms; 
    bool public terminated;

    event AgreementProposed(address indexed partyA, string agreementTerms);
    event AgreementTerminated(address indexed partyB);

    constructor(string memory _agreementTerms, address _partyB) {
        require(bytes(_agreementTerms).length > 0, "Looks like you forgot to write the terms of your agreement.");
        
        partyA = msg.sender;
        partyB = _partyB;
        agreementTerms = _agreementTerms;
        terminated = false;

        emit AgreementProposed(partyA, _agreementTerms);
    }

    function terminateAgreement() external {
         if (msg.sender != partyA) {
             revert("Only party A can terminate this agreement");
         }
        require(!terminated, "Agreement is already TERMINATED");

        terminated = true;
        emit AgreementTerminated(partyB);
    }

    function verifyAgreement() public view {
        assert(partyA != address(0) && partyB != address(0)); 
    }
}
