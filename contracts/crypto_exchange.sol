// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/*********************************************************************************************************************************************/
// To be noted --- 

/* This is a common smart contract template for centralized exchange, decentralized exchange and hybrid exchange.
   Contract for centralized exchange is compiled and deployed for demonstration purpose.
   Contracts for decentralized exchange and hybrid exchange are given below in commented out manner.
   Kindly uncomment the required template and use, as needed. Compilation and deployment process will be same for all. */

/*********************************************************************************************************************************************/

contract CryptoExchange {
    address public owner;

    event TradeExecuted(
        address indexed trader,
        address indexed fromToken,
        address indexed toToken,
        uint256 fromAmount,
        uint256 toAmount
    );

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function executeTrade(
        address fromToken,
        address toToken,
        uint256 fromAmount
    ) external {
        require(fromToken != toToken, "Cannot trade the same token");
        require(fromAmount > 0, "Amount must be greater than 0");

        // In a real DEX, you would perform order matching, handle liquidity pools, and other complex logic.
        // This example assumes a 1:1 token swap for simplicity.

        require(IERC20(fromToken).transferFrom(msg.sender, address(this), fromAmount), "Transfer failed");
        uint256 toAmount = fromAmount;
        require(IERC20(toToken).transfer(msg.sender, toAmount), "Transfer failed");

        emit TradeExecuted(msg.sender, fromToken, toToken, fromAmount, toAmount);
    }

    // Additional functions for managing liquidity pools, order books, and other DEX features can be added.
}
