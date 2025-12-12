// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol"; 

library PriceConverter {
    
    // 1. We accept the priceFeed as an input argument here
    function getPrice(AggregatorV3Interface priceFeed) internal view returns (uint256) {
        
        // 2. Now we use the 'priceFeed' parameter directly (which holds your Mock address)
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        
        // ETH/USD rate in 18 digit
        return uint256(answer * 10000000000);
    }

    function getConversionRate(
        uint256 ethAmount, AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice(priceFeed);
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        return ethAmountInUsd;
    }
}