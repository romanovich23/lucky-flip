// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";

import {FlipToken} from "src/FlipToken.sol";

contract TestFlipToken is Test {
    FlipToken ft;

    function setUp() public {
        ft = new FlipToken();
    }

    function testBar() public {
        assertEq(uint256(1), uint256(1), "ok");
    }

    function testFoo(uint256 x) public {
        vm.assume(x < type(uint128).max);
        assertEq(x + x, x * 2);
    }
}
