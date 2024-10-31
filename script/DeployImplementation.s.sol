// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Script} from "forge-std/Script.sol";
import {ImplementationV1} from "../src/ImplementationV1.sol";
import {ERC1967Proxy} from "@openzeppelin-contracts/proxy/ERC1967/ERC1967Proxy.sol";

/**
 * @title Deploy upgradeable proxy
 * @author Han
 * @notice This function deploys a proxy that points to box V1 initially.
 */
contract DeployImplementation is Script {
    function run() external returns (address) {
        address proxy = deployBox();
        return proxy;
    }

    function deployBox() internal returns (address) {
        vm.startBroadcast();
        ImplementationV1 box = new ImplementationV1(); // implementation (business logic)
        // Set proxy to point to box address
        ERC1967Proxy proxy = new ERC1967Proxy(address(box), "");
        vm.stopBroadcast();

        return address(proxy);
    }
}
