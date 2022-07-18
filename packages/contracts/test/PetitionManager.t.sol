// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4;

import "forge-std/Test.sol";
import "../src/PetitionManager.sol";
import {PetitionManager} from "../src/PetitionManager.sol";
import {Semaphore} from "../src/semaphore/Semaphore.sol";
import {Pairing} from "../src/semaphore/base/Pairing.sol";
import {SemaphoreVerifier} from "../src/semaphore/base/SemaphoreVerifier.sol";

contract TestPetitionManager is Test {
    PetitionManager internal pm;
    Semaphore internal semaphore;
    SemaphoreVerifier internal semaphoreVerifier;

    function setUp() public {
        semaphoreVerifier = new SemaphoreVerifier();
        semaphore = new Semaphore(semaphoreVerifier);
        pm = new PetitionManager(address(semaphore));
    }

    function testCreatePetition() public {
        uint256[] memory groupIds = new uint256[](2);
        groupIds[0] = 1;
        groupIds[1] = 2;
        pm.createPetition(groupIds, "ipfs_hash");
        uint256[] memory resultGroupIds = pm.getGroupIdsForPetition(1);
        assertEq(resultGroupIds[0], 1, "Group ID 1 should be present");
        assertEq(resultGroupIds[1], 2, "Group ID 2 should be present");
    }
}
