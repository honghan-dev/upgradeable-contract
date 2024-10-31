// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {DeployImplementation} from "../script/DeployImplementation.s.sol";
import {UpgradeImplementation} from "../script/UpgradeImplementation.s.sol";
import {ImplementationV1} from "../src/ImplementationV1.sol";
import {ImplementationV2} from "../src/ImplementationV2.sol";

contract DeployAndUpgradeTest is Test {
    DeployImplementation public deployer;
    UpgradeImplementation public upgrader;

    address public proxy;

    function setUp() public {
        deployer = new DeployImplementation();
        upgrader = new UpgradeImplementation();
        proxy = deployer.run(); // points to implementation v1 currently
    }

    function testUpgrade() public {
        ImplementationV2 v2 = new ImplementationV2();

        upgrader.upgradeImplementation(proxy, address(v2));
        assertEq(ImplementationV2(proxy).version(), 2);
    }
}
