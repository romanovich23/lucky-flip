// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.20;

import {FlipToken} from "src/FlipToken.sol";

abstract contract FlipTokenHelper {

    FlipToken public flipToken;

    function setUp() public {
        flipToken = new FlipToken();
    }

}