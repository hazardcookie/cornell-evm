// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "src/interfaces/IStdReference.sol";

contract FetchPrice {
    IStdReference public ref;

    constructor(IStdReference _ref) {
        ref = _ref;
    }

    function getPrice(string memory _symbol, string memory _base)
        external
        view
        returns (IStdReference.ReferenceData memory)
    {
        return ref.getReferenceData(_symbol, _base);
    }
}
