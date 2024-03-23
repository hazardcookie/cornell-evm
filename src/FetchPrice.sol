// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IStdReference {
    /// A structure returned whenever someone requests for standard reference data.
    struct ReferenceData {
        uint256 rate; // base/quote exchange rate, multiplied by 1e18.
        uint256 lastUpdatedBase; // UNIX epoch of the last time when base price gets updated.
        uint256 lastUpdatedQuote; // UNIX epoch of the last time when quote price gets updated.
    }

    /// Returns the price data for the given base/quote pair. Revert if not available.
    function getReferenceData(string memory _base, string memory _quote) external view returns (ReferenceData memory);

    /// Similar to getReferenceData, but with multiple base/quote pairs at once.
    function getReferenceDataBulk(string[] memory _bases, string[] memory _quotes)
        external
        view
        returns (ReferenceData[] memory);
}

contract FetchPrice {
    IStdReference public ref;

    constructor(IStdReference _ref) {
        ref = _ref;
    }

    function getTestPrice(string memory _symbol, string memory _base)
        external
        view
        returns (IStdReference.ReferenceData memory)
    {
        return ref.getReferenceData(_symbol, _base);
    }

    function getTestPriceBulk() external view returns (uint256[] memory) {
        string[] memory baseSymbols = new string[](3);
        baseSymbols[0] = "XRP";
        baseSymbols[1] = "BTC";
        baseSymbols[2] = "ETH";

        string[] memory quoteSymbols = new string[](3);
        quoteSymbols[0] = "USD";
        quoteSymbols[1] = "USD";
        quoteSymbols[2] = "USD";
        IStdReference.ReferenceData[] memory data = ref.getReferenceDataBulk(baseSymbols, quoteSymbols);
        uint256[] memory prices = new uint256[](3);
        prices[0] = data[0].rate;
        prices[1] = data[1].rate;
        prices[2] = data[2].rate;

        return prices;
    }
}
