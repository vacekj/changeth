// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4;

import "./semaphore/interfaces/ISemaphore.sol";

contract PetitionManager {
    event NewUser(uint256 identityCommitment);
    event PetitionCreated(uint256 petitionId);
    event PetitionSigned(uint256 petitionId, uint256 newSignatureCount);

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
    mapping(uint256 => uint) public signatureCount;

    constructor(address semaphoreAddress) {
        semaphore = ISemaphore(semaphoreAddress);
    }

    /// Create a petition
    /// @param groupIds The groupIds you want to allow to sign this petition
    /// @param metadata IPFS Metadata
    function createPetition(
        uint256[] calldata groupIds,
        string memory metadata
    ) public {
        petitions[++petitionCount] = Petition(groupIds, metadata);
        emit PetitionCreated(petitionCount);
    }

    function getGroupIdsForPetition(uint256 petitionId) public view returns (uint256[] memory) {
        return petitions[petitionId].groupIds;
    }

    function joinGroup(uint256 identityCommitment, uint256 groupId) external {
        /* TODO: provide a VC, verify that it's correct and corresponds to the group and add the user to the group*/
        semaphore.addMember(groupId, identityCommitment);

        emit NewUser(identityCommitment);
    }

    /// Sign a petition
    /// @param groupId An eligible groupId that the user is claiming to
    function sign(
        uint256 petitionId,
        uint256 groupId,
        uint256 nullifierHash,
        uint256[8] calldata proof
    ) public {
        Petition memory petition = petitions[petitionId];

        /* 1. Verify that the petition allows this particular groupId */
        require(
            isInArray(petition.groupIds, groupId),
            "Group not allowed by petition"
        );

        /* Verify the proof */
        semaphore.verifyProof(groupId, 1, nullifierHash, petitionId, proof);

        /* Count the signature */
        signatureCount[petitionId]++;

        /* Emit that the signature happened */
        emit PetitionSigned(petitionId, signatureCount[petitionId]);
    }

    function isInArray(
        uint256[] memory array,
        uint256 value
    ) public pure returns (bool) {
        for (uint i = 0; i < array.length; i++) {
            if (array[i] == value) {
                return true;
            }
        }
        return false;
    }
}
