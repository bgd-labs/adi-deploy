// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './Ethereum_Deploy_Shuffle_Update.s.sol';

contract Ethereum is Base_Deploy_Add_Shuffle_to_CCC_Payload {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }
}
