// SPDX-License-Identifier: MIT  

pragma solidity ^0.6.7;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
pragma experimental ABIEncoderV2;

contract PriceConsumerV3 {

    AggregatorV3Interface internal priceFeed;

    struct PairInfo{
        string pair;
        int priceFeed;
        uint8 decimals;
    }

    uint pairAggregatorCount;

    struct PairAggregator {
        string aggregator;
        address pairAddress;
        AggregatorV3Interface priceFeed;
    }

    PairAggregator[] internal PairAggregatorList;
    

    /**
     * Network: Binance Smart Chain
     * Aggregator: BNB/USD
     * address bsdc test net: 0x2514895c72f50D8bd4B4F9b1110F0D6bD2c97526
     * Address: 0x0567F2323251f0Aab15c8dFb1967E4e8A7D42aeE
     */
    constructor() public {
        pairAggregatorCount = 0;

        PairAggregatorList.push(PairAggregator('BTCUSD', 0x5741306c21795FdCBb9b265Ea0255F499DFe515C,AggregatorV3Interface(0x5741306c21795FdCBb9b265Ea0255F499DFe515C)));
        pairAggregatorCount++;

        PairAggregatorList.push(PairAggregator('ETHUSD', 0x143db3CEEfbdfe5631aDD3E50f7614B6ba708BA7,AggregatorV3Interface(0x143db3CEEfbdfe5631aDD3E50f7614B6ba708BA7)));
        pairAggregatorCount++;

        PairAggregatorList.push(PairAggregator('BNBUSD', 0x2514895c72f50D8bd4B4F9b1110F0D6bD2c97526,AggregatorV3Interface(0x2514895c72f50D8bd4B4F9b1110F0D6bD2c97526)));
        pairAggregatorCount++;

        PairAggregatorList.push(PairAggregator('ADAUSD', 0x5e66a1775BbC249b5D51C13d29245522582E671C,AggregatorV3Interface(0x5e66a1775BbC249b5D51C13d29245522582E671C)));
        pairAggregatorCount++;

        PairAggregatorList.push(PairAggregator('MATICUSD', 0x957Eb0316f02ba4a9De3D308742eefd44a3c1719,AggregatorV3Interface(0x957Eb0316f02ba4a9De3D308742eefd44a3c1719)));
        pairAggregatorCount++;

        
        priceFeed = AggregatorV3Interface(0x2514895c72f50D8bd4B4F9b1110F0D6bD2c97526);
    }

    function getLatestPriceFeed() public view returns(PairInfo [] memory) {
        PairInfo[] memory pairInfoList = new PairInfo[](pairAggregatorCount);
        for (uint i = 0; i < pairAggregatorCount; i++) {
            string memory aggregator = PairAggregatorList[i].aggregator;

            int ff = getLatestPrice(PairAggregatorList[i].priceFeed);

            pairInfoList[i] = PairInfo(aggregator,ff, PairAggregatorList[i].priceFeed.decimals());
        }

        return pairInfoList;
    }

    function getLatestPrice(AggregatorV3Interface priceFeed1) internal view returns (int) {
       (
            uint80 roundID,
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = priceFeed1.latestRoundData();
        return price;
    }
}
