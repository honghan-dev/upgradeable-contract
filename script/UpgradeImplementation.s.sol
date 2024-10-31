// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {ImplementationV2} from "../src/ImplementationV2.sol";
import {ImplementationV1} from "../src/ImplementationV1.sol";

contract UpgradeImplementation is Script {
    function run() external returns (address) {
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);

        vm.startBroadcast();
        ImplementationV2 newBox = new ImplementationV2();

        vm.stopBroadcast();

        address proxy = upgradeImplementation(mostRecentDeployed, address(newBox));
        return proxy;
    }

    function upgradeImplementation(address proxyAddress, address newBox) public returns (address) {
        vm.startBroadcast();
        ImplementationV2 proxy = ImplementationV2(proxyAddress);
        proxy.upgradeToAndCall(address(newBox), ""); // proxy contract now points to a new address
        vm.stopBroadcast();

        return address(proxy);
    }
}
