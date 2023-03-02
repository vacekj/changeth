// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4;

import {Script} from "forge-std/Script.sol";
import {GroupManager} from "../src/GroupManager.sol";
import {Semaphore} from "semaphore/Semaphore.sol";
import {Pairing} from "semaphore/base/Pairing.sol";
import {SemaphoreVerifier} from "semaphore/base/SemaphoreVerifier.sol";

/// @dev See the Solidity Scripting tutorial: https://book.getfoundry.sh/tutorials/solidity-scripting
contract DeployFoo is Script {
    address internal deployer;
    GroupManager internal groupManager;
    Semaphore internal semaphore;
    SemaphoreVerifier internal semaphoreVerifier;

    function setUp() public virtual {
        string memory mnemonic = vm.envString("MNEMONIC");
        (deployer,) = deriveRememberKey(mnemonic, 0);
    }

    function run() public {
        vm.startBroadcast(deployer);

        /*Deploy supporting contracts*/
        semaphoreVerifier = new SemaphoreVerifier();

        semaphore = new Semaphore(semaphoreVerifier);

        groupManager = new GroupManager(address(semaphore), 1);
        vm.stopBroadcast();
    }
}
