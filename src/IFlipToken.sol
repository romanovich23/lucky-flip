// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title IFlipToken
 * @author @romanovich23<https://github.com/romanovich23>
 * @notice FlipToken interface
 */
interface IFlipToken {
    /**
     * @notice Player registered event
     */
    event PlayerRegistered(address indexed player, uint256 amount);

    /**
     * @notice Bet placed event
     */
    event BetPlaced(address indexed player, bool guess, uint256 prize);

    /**
     * @notice Player removed event
     */
    event PlayerRemoved(address indexed player, uint256 amount);

    /**
     * @notice Player already exists error
     */
    error PlayerAlreadyExists(address player);

    /**
     * @notice Player does not exist error
     */
    error PlayerDoesNotExist(address player);

    /**
     * @notice Register player
     * @param player Player address
     * @param amount Player amount
     * @return bool
     */
    function registerPlayer(
        address player,
        uint256 amount
    ) external returns (bool);

    /**
     * @notice Place bet
     * @param _guess Player guess
     * @param _betAmount Player bet amount
     * @return bool
     */
    function placeBet(bool _guess, uint256 _betAmount) external returns (bool);

    /**
     * @notice Remove player
     * @param player Player address
     * @return bool
     */
    function removePlayer(address player) external returns (bool);
}
