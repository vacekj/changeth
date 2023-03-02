// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4;

import "./semaphore/interfaces/ISemaphore.sol";

contract PetitionManager {
    event NewUser(uint256 identityCommitment);
    event PetitionCreated(uint256 petitionId);

    struct Petition {
        /// Allowed group IDs
        uint256[] groupIds;
        /// Metadata about the petition, stored on IPFS, Arweave etc.
        string metadata;
    }

    ISemaphore public semaphore;
    mapping(uint256 => bytes32) public users;
    mapping(uint256 => Petition) public petitions;
    uint256 petitionCount;

    constructor(address semaphoreAddress) {
        semaphore = ISemaphore(semaphoreAddress);
    }

    function createPetition(uint256[] calldata groupIds, string metadata) public {
        petitions[++petitionCount] = Petition(groupIds, metadata);
        emit PetitionCreated(petitionCount);
    }

    function joinGroup(uint256 identityCommitment, uint256 groupId) external {
        /* TODO: provide a VC, verify that it's correct and corresponds to the group and add the user to the group*/
        semaphore.addMember(groupId, identityCommitment);

        emit NewUser(identityCommitment);
    }

    /// Sign a petition
    /// @param groupId An eligible groupId that the user is claiming to
    function sign(uint256 petitionId, uint256 id, uint256 groupId, uint256 nullifierHash, int256[8] calldata proof) public {

        Petition petition = petitions[petitionId];

        /* 1. Verify that the petition allows this particular groupId */
        require(isInArray(petition.groupIds, groupId), "Group not allowed by petition");

        semaphore.verifyProof(groupId, 1, nullifierHash, petitionId, proof);
    }

    function isInArray(uint256[] memory array, uint256 value) public pure returns (bool) {
        for (uint i = 0; i < array.length; i++) {
            if (array[i] == value) {
                return true;
            }
        }
        return false;
    }
}
