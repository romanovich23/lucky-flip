// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin-contracts-5.0.2/token/ERC20/ERC20.sol";

contract FlipToken is ERC20 {
    constructor() ERC20("FlipToken", "FLP") {}
}
