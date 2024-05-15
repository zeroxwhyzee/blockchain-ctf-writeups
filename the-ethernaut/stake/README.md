# [Stake](https://ethernaut.openzeppelin.com/level/0xB99f27b94fCc8b9b6fF88e29E1741422DFC06224)

<p align="center">Stake is safe for staking native ETH and ERC20 WETH, considering the same 1:1 value of the tokens. Can you drain the contract? To complete this level, the contract state must meet the following conditions:</p>

---

## Goal 1: require(address(stake).balance > 0)

The default ETH balance of the `Stake` contract is 0. We need to find a way to increase the ETH balance of the contract.

## Goal 2: require(stake.totalStaked > address(stake).balance)

The variable `totalStaked` in the `Stake` contract must be greater than its ETH balance.

## Goal 3: Player must be a staker

As a player, we need to be a staker of the contract.

## Goal 4: Player's staked balance must be 0

As a player, our staked balance must be 0 upon completion of the challenge.

## Analysis

Upon looking at the contract, there is no `receive` function marked `payable`, which means that we cannot send ether to the contract via `transfer`, `send` or the `call` function. We can send ether forcefully to this contract via `selfdestruct` too, but the contract provides a `StakeETH` function, which helps us to achieve goal 1 and 3 conveniently.

To achieve goal 4, we can call the `Unstake` function to reduce `UserStake[player]` to 0 while still achieving goal 3. However, goal 1 wouldn't be achieved after calling the `Unstake` function. Moreover, goal 2 could not be achieved with these actions. Let us scrutinize the `StakeWETH` function and find out if we can leverage this function to reach our goals.

Let us breakdown what these lines of code are doing in the `StakeWETH` function:

```solidity
(, bytes memory allowance) = WETH.call(abi.encodeWithSelector(0xdd62ed3e, msg.sender, address(this)));
require(bytesToUint(allowance) >= amount, "How am I moving the funds honey?");
```

The function signature `0xdd62ed3e` corresponds to `allowance(address owner, address spender)`, which returns the number of `WETH` tokens the spender can spend on the owner's behalf through the `transferFrom` function. In the context of this contract, it checks how many `WETH` tokens we (`msg.sender`) approved the `Stake` contract to spend on our behalf when doing `transferFrom`.

In the `bytesToUint` function:

- `mload` - reads a word (32 bytes) from the memory at the specified offset
- `add(data, 0x20)` - adds 32 bytes to the memory address that `data` is located in

The first 32 bytes of the `data` field specifies the length, followed by the actual data, thus `result := mload(add(data, 0x20))` in the `bytesToUint` function would read the actual data in the `data` field, store it in the `result` variable and return it.

```solidity
(bool transfered,) = WETH.call(abi.encodeWithSelector(0x23b872dd, msg.sender, address(this), amount));
```

The function signature `0x23b872dd` corresponds to `transferFrom(address sender, address recipient, uint256 value)`, which moves `value` tokens from `sender` to `recipient` using the allowance mechanism. In the context of this contract, it would send the specified `amount` of `WETH` from us (`msg.sender`) to the `Stake` contract. Observe that the `transferFrom` function returns a `boolean` value as the return result but the contract did not check if the transfer is successful.

This means that as the player, we can call the `StakeWETH` function and increase `UserStake[player]` for free even without having `WETH` tokens even though the `transferFrom` function fails. Thereafter, we can call the `Unstake` function and drain any ether in the contract to tweak the ETH balance of the contract. To achieve all 4 goals, the exploit steps are listed below:

1. Call `stake.StakeETH` with value `x` where `x >= 0.001 ether + 2` as a third party to increase the ETH balance of `Stake` contract, as well as `totalStaked`.
2. Approve `y` amount of `WETH` tokens where `0.001 ether + 1 <= y < x` as the player and call `stake.StakeWETH` with `y` as `amount`. The `transferFrom` function would fail because we as the player do not have any `WETH` tokens. However, value of `UserStake[player]` would be updated with `y`.
3. Call `stake.Unstake` with `y` amount as the player.

At this point, player is able to drain the ETH balance deposited by the third party in step 1 by calling `stake.Unstake` while still maintaining at least `1 wei` of ETH balance in the `Stake` contract, achieving goal 1. The value of `totalStaked` is also greater than the ETH balance as well, achieving goal 2. Player is a staker of the contract after calling the `StakeWETH` function, achieving goal 3. `UserStake[player]` is 0 after step 3, achieving goal 4.

The exploit I used for this challenge is [here](./StakeSolver.sol) and with this, the challenge is completed!
