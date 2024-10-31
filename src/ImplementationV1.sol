// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

// storage is stored in the proxy, NOT in the implementation
// Proxy -> implementation

contract ImplementationV1 is UUPSUpgradeable, OwnableUpgradeable {
    uint256 internal number;

    // For verbosity
    // @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        //Disable intialize of this contract
        _disableInitializers();
    }
    
    // Constructor function for upgradeable contracts
    function initialize() public initializer {
        // set owner to msg.sender
        __Ownable_init(msg.sender);
        __UUPSUpgradeable_init();
    }

    function getNumber() external view returns (uint256) {
        return number;
    }

    function version() external pure returns (uint256) {
        return 1;
    }

    // Must implement for an upgradeable contract
    function _authorizeUpgrade(address newImplementation) internal override {}
}
