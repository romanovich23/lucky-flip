// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IFlipToken} from "src/IFlipToken.sol";
import {Ownable} from "@openzeppelin-contracts-5.0.2/access/Ownable.sol";
import {ERC20} from "@openzeppelin-contracts-5.0.2/token/ERC20/extensions/ERC20Burnable.sol";

/**
 * @title FlipToken
 * @author @romanovich23<https://github.com/romanovich23>
 * @notice FlipToken contract
 */
contract FlipToken is IFlipToken, ERC20, Ownable {
    string internal constant TOKEN_NAME = "FlipToken";
    string internal constant TOKEN_SYMBOL = "FLP";

    constructor() ERC20(TOKEN_NAME, TOKEN_SYMBOL) Ownable(_msgSender()) {}

    /**
     * @dev See {ERC20-_mint}.
     *
     * This function is only callable by the owner.
     */
    function registerPlayer(
        address _player,
        uint256 _amount
    ) external override onlyOwner returns (bool) {
        _checkPlayerExists(_player);
        _mint(_player, _amount);
        emit PlayerRegistered(_player, _amount);
        return true;
    }

    /**
     * @dev See {IFlipToken-placeBet}.
     */
    function placeBet(
        bool _guess,
        uint256 _betAmount
    ) external override returns (bool success_) {
        _checkPlayerExists(_msgSender());
        _checkEnoughBalance(_msgSender(), _betAmount);

        bool result = _random() == 1;
        uint256 prize = 0;

        if (result == _guess) {
            prize = _betAmount * 2;
            _mint(_msgSender(), prize);
            success_ = true;
        } else {
            _burn(_msgSender(), _betAmount);
        }

        emit BetPlaced(_msgSender(), _guess, prize);
    }

    /**
     * @dev See {ERC20-_burn}.
     *
     * This function is only callable by the owner.
     */
    function removePlayer(
        address _player
    ) external override onlyOwner returns (bool) {
        _checkPlayerExists(_player);
        uint256 playerBalance = balanceOf(_player);
        _burn(_player, playerBalance);
        emit PlayerRemoved(_player, playerBalance);
        return true;
    }

    /**
     * @dev Internal function to generate random number
     * TODO: Implement Chainlink VRF
     */
    function _random() private view returns (uint256) {
        return
            uint256(
                keccak256(
                    abi.encodePacked(
                        block.prevrandao,
                        block.timestamp,
                        block.number
                    )
                )
            ) % 2;
    }

    /**
     * @dev Check if player exists, reverts if not
     */
    function _checkPlayerExists(address _player) private view {
        if (balanceOf(_player) > 0) {
            revert PlayerAlreadyExists(_player);
        }
    }

    /**
     * @dev Check if player does not exist, reverts if not
     */
    function _checkPlayerDoesNotExist(address _player) private view {
        if (balanceOf(_player) == 0) {
            revert PlayerDoesNotExist(_player);
        }
    }

    /**
     * @dev Check if player has enough balance, reverts if not
     */
    function _checkEnoughBalance(
        address _player,
        uint256 _amount
    ) private view {
        uint256 fromBalance = balanceOf(_player);
        if (fromBalance < _amount) {
            revert ERC20InsufficientBalance(_player, fromBalance, _amount);
        }
    }
}
