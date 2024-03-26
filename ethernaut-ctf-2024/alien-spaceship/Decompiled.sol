// Decompiled by library.dedaub.com
// 2024.03.16 00:05 UTC
// Compiled using the solidity compiler version 0.8.12


// Data structures and variables inferred from the use of storage instructions
mapping (uint256 => struct_482) _roles; // STORAGE[0x0]
uint256 stor_2; // STORAGE[0x2]
uint256 _position; // STORAGE[0x3]
uint256 stor_4; // STORAGE[0x4]
uint256 stor_5; // STORAGE[0x5]
uint256 stor_6; // STORAGE[0x6]
uint256 stor_1_0_0; // STORAGE[0x1] bytes 0 to 0
uint256 stor_1_1_1; // STORAGE[0x1] bytes 1 to 1

struct struct_482 { uint256 field0; uint256 field1; uint256 field2; };


function 0x1465(uint256 varg0, uint256 varg1, uint256 varg2) private { 
    v0 = 0x149e(varg0);
    v1 = 0x149e(varg1);
    v2 = 0x149e(varg2);
    v3 = _SafeAdd(v2, v1);
    v4 = _SafeAdd(v3, v0);
    return v4;
}

function 0x149e(uint256 varg0) private { 
    if (varg0 < 0) {
        require(varg0 != int256.min, Panic(17)); // arithmetic overflow or underflow
        varg0 = v0 = 0 - varg0;
    }
    return varg0;
}

function _SafeAdd(uint256 varg0, uint256 varg1) private { 
    require(!((varg0 >= 0) & (varg1 > int256.max - varg0)), Panic(17)); // arithmetic overflow or underflow
    require(!((varg0 < 0) & (varg1 < int256.min - varg0)), Panic(17)); // arithmetic overflow or underflow
    return varg0 + varg1;
}

function function_selector() public payable { 
    revert();
}

function position() public payable { 
    return _position, stor_4, stor_5;
}

function 0x183aa328(uint256 varg0, uint256 varg1, uint256 varg2) public payable { 
    require(msg.data.length - 4 >= 96);
    v0 = 0x37e(varg2, varg1, varg0);
    v1 = new bytes[](v0.length);
    v2 = v3 = 0;
    while (v2 < v0.length) {
        v1[v2] = v0[v2];
        v2 += 32;
    }
    if (v2 > v0.length) {
        v1[v0.length] = 0;
    }
    return v1;
}

function distance() public payable { 
    v0 = 0x1465(stor_5, stor_4, _position);
    return v0;
}

function 0x4e85c36e(uint256 varg0) public payable { 
    require(msg.data.length - 4 >= 32);
    require(0x56a2da3687a5982774df44639b06a410da311ff14844c2f7ff0cab50d681571c == _roles[msg.sender].field0, Error('Invalid role'));
    require(varg0 <= stor_6, Error('Cannot dump more than what exists'));
    require(stor_6 >= varg0, Panic(17)); // arithmetic overflow or underflow
    require(stor_6 - varg0 > 0x1b1ae4d6e2ef500000, Error('Need to keep some food around'));
    stor_6 = stor_6 - varg0;
    emit 0x47d80da589b78424bfd7d9fed5ed5ffc1ba8ef667015e9400ab5b7b5db2afec2(msg.sender, stor_6, stor_6 - varg0);
}

function 0x5166bff7() public payable { 
    return stor_1_0_0;
}

function 0x6f445300(address varg0) public payable { 
    require(msg.data.length - 4 >= 32);
    require(0x3a1665efe60dbe93a7cdcf728baddc0d7ebafe407d444d0de3ed20e1e52a6a0d == _roles[msg.sender].field0, Error('Invalid role'));
    require(address(varg0 + msg.sender) == 51);
    stor_2 += 1;
    _position = 0x2a2fab8a32d35713000000;
    stor_4 = 0x2a2fab8a32d35713000000;
    stor_5 = 0x2a2fab8a32d35713000000;
    emit 0xa0a5c9040ba611f74e82c058673373f59bb2fed8a32a44537ebeefe75d58c478(msg.sender, 0x2a2fab8a32d35713000000, 0x2a2fab8a32d35713000000, 0x2a2fab8a32d35713000000);
}

function 0x7235a6d5() public payable { 
    require(0x3a1665efe60dbe93a7cdcf728baddc0d7ebafe407d444d0de3ed20e1e52a6a0d == _roles[msg.sender].field0, Error('Invalid role'));
    v0 = 0x1465(stor_5, stor_4, _position);
    require(v0 < 10 ** 24, Error('Must be within 1000km to abort mission'));
    require(stor_6 < 10 ** 21, Error('Must be weigh less than 1000kg to abort mission'));
    require(stor_2 > 0, Error('Must visit Area 51 and scare the humans before aborting mission'));
    require(0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 != EXTCODEHASH(msg.sender));
    stor_1_1_1 = 1;
    emit 0x36ecdc9a6fcd7296bb9e8ba1d0346958e5dc548c84186d854d2c4e65691ceed6();
}

function 0x8c0ff94b(uint256 varg0) public payable { 
    require(msg.data.length - 4 >= 32);
    v0 = v1 = varg0 == 0xb5b6b705a01c9fbc2f5b52325436afd32f5988596d999716ad1711063539b564;
    if (varg0 != 0xb5b6b705a01c9fbc2f5b52325436afd32f5988596d999716ad1711063539b564) {
        v0 = v2 = varg0 == 0x56a2da3687a5982774df44639b06a410da311ff14844c2f7ff0cab50d681571c;
    }
    if (!v0) {
        v0 = v3 = varg0 == 0x3a1665efe60dbe93a7cdcf728baddc0d7ebafe407d444d0de3ed20e1e52a6a0d;
    }
    if (!v0) {
        v0 = v4 = varg0 == 0x720a004d39b816addddcfa184666132ae9e307670a4e534d64e0af23c84ee0e1;
    }
    require(v0, Error('Invalid role'));
    v5 = v6 = varg0 == 0x3a1665efe60dbe93a7cdcf728baddc0d7ebafe407d444d0de3ed20e1e52a6a0d;
    if (v6) {
        v5 = v7 = 0xb5b6b705a01c9fbc2f5b52325436afd32f5988596d999716ad1711063539b564 == _roles[msg.sender].field0;
    }
    require(v5, Error('Promotion not available'));
    require(12 <= ~_roles[msg.sender].field1, Panic(17)); // arithmetic overflow or underflow
    require(12 + _roles[msg.sender].field1 <= block.timestamp, Error('You must hold a position for at least 12 seconds before being eligible for promotion'));
    require(uint8(_roles[msg.sender].field2));
    _roles[msg.sender].field0 = 0x3a1665efe60dbe93a7cdcf728baddc0d7ebafe407d444d0de3ed20e1e52a6a0d;
    _roles[msg.sender].field1 = block.timestamp;
    emit 0xfcfb5e407c67edddc9427bb960d67da62f80c86d3e0176134be84d0c0298cc51(msg.sender, 0xb5b6b705a01c9fbc2f5b52325436afd32f5988596d999716ad1711063539b564, 0x3a1665efe60dbe93a7cdcf728baddc0d7ebafe407d444d0de3ed20e1e52a6a0d);
}

function roles(address varg0) public payable { 
    require(msg.data.length - 4 >= 32);
    return _roles[varg0].field0, _roles[varg0].field1, bool(_roles[varg0].field2);
}

function ENGINEER() public payable { 
    return 0x56a2da3687a5982774df44639b06a410da311ff14844c2f7ff0cab50d681571c;
}

function 0xa15184c7(uint256 varg0) public payable { 
    require(msg.data.length - 4 >= 32);
    v0 = v1 = varg0 == 0xb5b6b705a01c9fbc2f5b52325436afd32f5988596d999716ad1711063539b564;
    if (varg0 != 0xb5b6b705a01c9fbc2f5b52325436afd32f5988596d999716ad1711063539b564) {
        v0 = v2 = varg0 == 0x56a2da3687a5982774df44639b06a410da311ff14844c2f7ff0cab50d681571c;
    }
    if (!v0) {
        v0 = v3 = varg0 == 0x3a1665efe60dbe93a7cdcf728baddc0d7ebafe407d444d0de3ed20e1e52a6a0d;
    }
    if (!v0) {
        v0 = v4 = varg0 == 0x720a004d39b816addddcfa184666132ae9e307670a4e534d64e0af23c84ee0e1;
    }
    require(v0, Error('Invalid role'));
    require(!_roles[msg.sender].field0, Error('Use the applyForPromotion function to get promoted'));
    if (varg0 != 0x56a2da3687a5982774df44639b06a410da311ff14844c2f7ff0cab50d681571c) {
        v5 = v6 = varg0 == 0xb5b6b705a01c9fbc2f5b52325436afd32f5988596d999716ad1711063539b564;
        if (v6) {
            v5 = v7 = 0x56a2da3687a5982774df44639b06a410da311ff14844c2f7ff0cab50d681571c == _roles[this].field0;
        }
        if (!v5) {
            require(varg0 == 0x720a004d39b816addddcfa184666132ae9e307670a4e534d64e0af23c84ee0e1, Error('Role is not hiring'));
            v8 = new uint256[](115);
            MEM[v8.data] = 'There is no blockchain security ';
            MEM[MEM[64] + 100] = 'researcher position on the space';
            MEM[MEM[64] + 132] = "ship but we've heard that OpenZe";
            MEM[MEM[64] + 164] = 'ppelin is hiring :)';
            revert(Error(v8));
        } else {
            _roles[msg.sender].field0 = 0xb5b6b705a01c9fbc2f5b52325436afd32f5988596d999716ad1711063539b564;
            _roles[msg.sender].field1 = block.timestamp;
            emit 0xd7b59a7335373cd670f56aaac22cb24e2d3b6efaa5f7eef93ae4d79b2d4f3ec2(msg.sender, 0xb5b6b705a01c9fbc2f5b52325436afd32f5988596d999716ad1711063539b564);
        }
    } else {
        _roles[msg.sender].field0 = 0x56a2da3687a5982774df44639b06a410da311ff14844c2f7ff0cab50d681571c;
        _roles[msg.sender].field1 = block.timestamp;
        emit 0xd7b59a7335373cd670f56aaac22cb24e2d3b6efaa5f7eef93ae4d79b2d4f3ec2(msg.sender, 0x56a2da3687a5982774df44639b06a410da311ff14844c2f7ff0cab50d681571c);
    }
}

function 0xace423ca() public payable { 
    require(_roles[msg.sender].field0, Error("Cannot quit if you don't have a job"));
    _roles[msg.sender].field0 = 0;
    _roles[msg.sender].field1 = 0;
    _roles[msg.sender].field2 = bytes31(_roles[msg.sender].field2);
    emit 0x37def82fce4fdcf8b69f22b7cb4e179b2080e5bca996893e2966b95f0cb49d9c(msg.sender, _roles[msg.sender].field0);
}

function 0xccc674f6() public payable { 
    return 0x720a004d39b816addddcfa184666132ae9e307670a4e534d64e0af23c84ee0e1;
}

function CAPTAIN() public payable { 
    return 0x3a1665efe60dbe93a7cdcf728baddc0d7ebafe407d444d0de3ed20e1e52a6a0d;
}

function 0xe42c7669() public payable { 
    require(0xb5b6b705a01c9fbc2f5b52325436afd32f5988596d999716ad1711063539b564 == _roles[msg.sender].field0, Error('Invalid role'));
    require(0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 == EXTCODEHASH(msg.sender));
    stor_1_0_0 = 1;
    _roles[msg.sender].field2 = 0x1 | bytes31(_roles[msg.sender].field2);
    emit 0x969eb872d3dc2b2e390cb79ccd3453c92553d561b80b34b24a54a8e70397bcb2();
}

function 0xe7511d8d() public payable { 
    return stor_1_1_1;
}

function 0xea93bc96(bytes varg0) public payable { 
    require(msg.data.length - 4 >= 32);
    require(varg0 <= uint64.max);
    require(4 + varg0 + 31 < msg.data.length);
    require(varg0.length <= uint64.max);
    require(4 + varg0 + varg0.length + 32 <= msg.data.length);
    require(0x56a2da3687a5982774df44639b06a410da311ff14844c2f7ff0cab50d681571c == _roles[msg.sender].field0, Error('Invalid role'));
    CALLDATACOPY(v0.data, varg0.data, varg0.length);
    MEM[varg0.length + v0.data] = 0;
    v1, /* uint256 */ v2 = address(this).call(v0.data).gas(msg.gas);
    if (RETURNDATASIZE() != 0) {
        v3 = new bytes[](RETURNDATASIZE());
        RETURNDATACOPY(v3.data, 0, RETURNDATASIZE());
    }
    require(v1, Error('Experiment failed!'));
}

function 0xf680a7cd() public payable { 
    return stor_2;
}

function 0xf705b2e2() public payable { 
    return stor_6;
}

function 0xfcd82757() public payable { 
    return 0xb5b6b705a01c9fbc2f5b52325436afd32f5988596d999716ad1711063539b564;
}

function 0x37e(uint256 varg0, uint256 varg1, uint256 varg2) private { 
    require(0x3a1665efe60dbe93a7cdcf728baddc0d7ebafe407d444d0de3ed20e1e52a6a0d == _roles[msg.sender].field0, Error('Invalid role'));
    if (stor_1_0_0) {
        if (stor_6 < 10 ** 21) {
            v0 = 0x1465(varg0, varg1, varg2);
            if (v0 > 10 ** 23) {
                _position = varg2;
                stor_4 = varg1;
                stor_5 = varg0;
                emit 0xa0a5c9040ba611f74e82c058673373f59bb2fed8a32a44537ebeefe75d58c478(msg.sender, varg2, varg1, varg0);
                require(!(bool(2) & (stor_6 > int256.max)), Panic(17)); // arithmetic overflow or underflow
                stor_6 = stor_6 << 1;
                emit 0x47d80da589b78424bfd7d9fed5ed5ffc1ba8ef667015e9400ab5b7b5db2afec2(msg.sender, stor_6, stor_6 << 1);
                return "You've almost solved the level!";
            } else {
                return 'Cannot get closer than 100km or the enemy will detect us!';
            }
        } else {
            return 'Must weigh less than 1,000kg to jump through wormhole';
        }
    } else {
        return 'Wormholes are disabled';
    }
}

// Note: The function selector is not present in the original solidity code.
// However, we display it for the sake of completeness.

function function_selector( function_selector) public payable { 
    MEM[64] = 128;
    require(!msg.value);
    if (msg.data.length >= 4) {
        if (0xa15184c7 > function_selector >> 224) {
            if (0x6f445300 > function_selector >> 224) {
                if (0x4851375c > function_selector >> 224) {
                    if (0x9218e91 == function_selector >> 224) {
                        position();
                    } else if (0x183aa328 == function_selector >> 224) {
                        0x183aa328();
                    }
                } else if (0x4851375c == function_selector >> 224) {
                    distance();
                } else if (0x4e85c36e == function_selector >> 224) {
                    0x4e85c36e();
                } else {
                    require(0x5166bff7 == function_selector >> 224);
                    0x5166bff7();
                }
            } else if (0x8c0ff94b > function_selector >> 224) {
                if (0x6f445300 == function_selector >> 224) {
                    0x6f445300();
                } else {
                    require(0x7235a6d5 == function_selector >> 224);
                    0x7235a6d5();
                }
            } else if (0x8c0ff94b == function_selector >> 224) {
                0x8c0ff94b();
            } else if (0x99374642 == function_selector >> 224) {
                roles(address);
            } else {
                require(0x99528032 == function_selector >> 224);
                ENGINEER();
            }
        } else if (0xe7511d8d > function_selector >> 224) {
            if (0xccc674f6 > function_selector >> 224) {
                if (0xa15184c7 == function_selector >> 224) {
                    0xa15184c7();
                } else {
                    require(0xace423ca == function_selector >> 224);
                    0xace423ca();
                }
            } else if (0xccc674f6 == function_selector >> 224) {
                0xccc674f6();
            } else if (0xd98b3eb4 == function_selector >> 224) {
                CAPTAIN();
            } else {
                require(0xe42c7669 == function_selector >> 224);
                0xe42c7669();
            }
        } else if (0xf680a7cd > function_selector >> 224) {
            if (0xe7511d8d == function_selector >> 224) {
                0xe7511d8d();
            } else {
                require(0xea93bc96 == function_selector >> 224);
                0xea93bc96();
            }
        } else if (0xf680a7cd == function_selector >> 224) {
            0xf680a7cd();
        } else if (0xf705b2e2 == function_selector >> 224) {
            0xf705b2e2();
        } else {
            require(0xfcd82757 == function_selector >> 224);
            0xfcd82757();
        }
    }
    fallback();
}
