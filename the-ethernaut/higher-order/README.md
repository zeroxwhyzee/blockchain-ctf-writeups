# [HigherOrder](https://ethernaut.openzeppelin.com/level/0xd459773f02e53F6e91b0f766e42E495aEf26088F)

<p align="center">Imagine a world where the rules are meant to be broken, and only the cunning and the bold can rise to power. Welcome to the Higher Order, a group shrouded in mystery, where a treasure awaits and a commander rules supreme. Your objective is to become the Commander of the Higher Order! Good luck!</p>

---

## Goal: Set `commander` to be our address

The goal of this challenge is straightforward and we need to set the `commander` variable to be our address.

## Analysis

Notice that the `claimLeadership` function sets the `commander` variable to be `msg.sender`, which helps us to achieve our goal. However, we need to meet the condition where `treasury > 255`.

The `registerTreasury` function is exposed to us to set the `treasury` variable. However, it takes in one argument of type `uint8`, which supports only values from 0 to 255. How do we set a value more than 255 in this case?

Let us take a deeper look at how the `treasury` variable is updated in this function:

```solidity
    assembly {
        sstore(treasury_slot, calldataload(4))
    }
```

In Solidity, storage is represented as a key-value store where both `key` and `value` are represented in 256 bits (32 bytes or 1 word). Another way to think about it is that storage is represented as an array with `2^256` slots indexed from `0` to `2^256 - 1` where `value` stored is up to 256 bits:

```
slot[0] = value
slot[1] = value
slot[2] = value
slot[3] = value
.
.
.
slot[2^256 - 1] = value
```

The `_slot` keyword is used to access the storage slot of the contract's state variable (`.slot` in newer versions of the Solidity compiler) and the `sstore` opcode is used to store a 256-bit value into a storage slot identified by a 256-bit key.

The `calldataload` opcode loads a 256-bit value starting from a specified byte offset in the `calldata`. The `calldata` is a temporary read-only data storage location that is used to hold input data that is passed in to a function from an external caller. When `calldataload` is called, it operates on the input data, which includes the function selector (4 bytes) and the function arguments.

In our example, the `registerTreasury` is trying to store a `value` into the storage slot of the `treasury` variable, where `value` is a 256-bit value specified after the function selector (`calldataload(4)` skips the first 4 bytes denoting the function selector). If we call the `registerTreasury` function normally, we cannot complete the challenge as we are restricted to values 0 to 255 because of the `uint8` requirement. However, what if we make a low level `CALL` instead?

```solidity
    // 0x211c85ab0000000000000000000000000000000000000000000000000000000000000100
    bytes memory data = abi.encodeWithSelector(HigherOrder.registerTreasury.selector, 256);
    (bool success,) = address(higherOrder).call(data);
```

The `registerTreasury` function would still be called successfully although our input value `0x100` is more than 255 (`0xff`). This is because the `uint8` function argument would typecast `0x100` to `0x00` and it is still a valid function argument. Thereafter, `calldataload(4)` would read 256 bits after the function selector, which is `0000000000000000000000000000000000000000000000000000000000000100` and set this 256 bits as the value for the `treasury` variable. With this, we can simply call the `claimLeadership` function and be the commander!

The exploit I used for this challenge is [here](./HigherOrderSolver.sol) and it is not possible to conduct this exploit if the code uses a compiler version >= `0.8.0`.

There is a term for this behavior called the "dirty higher order bits", where unused bits can result in an unintended outcome. Here are some resources mentioning this behavior in more detail:

- https://www.immunebytes.com/blog/high-order-bytes-in-solidity-can-clean-up-storage-why-does-it-matter/
- https://medium.com/@solidity101/solidity-security-pitfalls-best-practices-101-a9a64010310e
- https://docs.soliditylang.org/en/latest/security-considerations.html#minor-details
