// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {FlipToken} from "src/FlipToken.sol";
import {FlipTokenHelper} from "../helper/FlipTokenHelper.sol";

contract TestFlipTokenRegisterPlayer is Test, FlipTokenHelper {
    function test_balanceWhenRegisterPlayerIsCalled() public {
        address player = address(0x1);
        uint256 amount = 100;
        flipToken.registerPlayer(player, amount);
        assertEq(flipToken.balanceOf(player), amount);
    }
}
