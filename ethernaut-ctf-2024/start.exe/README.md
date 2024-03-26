# start.exe

<p align="center">start.exe | 10 points</p>
<p align="center">This transaction seems to be the start of something big. Can you figure out what it is? https://sepolia.etherscan.io/tx/0x73fcb6eec33280c39a696b8db0f7b3f71f789c28ef722e0c716f9c8cef6aa040</p>
<p align="center">Author: cairoeth | Flag format: OZCTF{flag}</p>

This is a welcome challenge for the CTF. Upon inspecting the transaction, EOA address `0x741cB6A6a8dC16363666462769D8dEc996311466` sent a transaction to contract address `0xf3D770D9E5046536BaF4c0d7AC1205Eb34918E28`. The `msg.data` included in the transaction is as follow:

```

0xa777d0dc000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000214f5a4354467b304e335f4731344e545f4c3341505f4630525f4d344e4b314e447d00000000000000000000000000000000000000000000000000000000000000

```

`0xa777d0dc` corresponds to the function selector `hello(string)` and the string input corresponds to the rest of the 128 bytes. Etherscan is able to decode the string input and we get our flag `OZCTF{0N3_G14NT_L3AP_F0R_M4NK1ND}`.
