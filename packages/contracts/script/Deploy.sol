// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4;

import {Script} from "forge-std/Script.sol";
import {PetitionManager} from "../src/PetitionManager.sol";
import {Semaphore} from "../src/semaphore/Semaphore.sol";
import {Pairing} from "../src/semaphore/base/Pairing.sol";
import {SemaphoreVerifier} from "../src/semaphore/base/SemaphoreVerifier.sol";

/// @dev See the Solidity Scripting tutorial: https://book.getfoundry.sh/tutorials/solidity-scripting
contract DeployFoo is Script {
    address internal deployer;
    PetitionManager internal groupManager;
    Semaphore internal semaphore;
    SemaphoreVerifier internal semaphoreVerifier;

    function setUp() public virtual {
        string memory mnemonic = vm.envString("MNEMONIC");
        (deployer,) = deriveRememberKey(mnemonic, 0);
    }

    function run() public {
        vm.startBroadcast(deployer);

        /*Deploy supporting semaphore*/
        semaphoreVerifier = new SemaphoreVerifier();

        semaphore = new Semaphore(semaphoreVerifier);

        groupManager = new PetitionManager(address(semaphore));
        vm.stopBroadcast();
    }
}
