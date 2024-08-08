// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './Base_Add_Zksync_Path.s.sol';

contract Ethereum is Base_Deploy_Add_ZkSync_Path_Payload {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function _getPayloadByteCode() internal pure override returns (bytes memory) {
    return type(SimpleAddForwarderAdapter).creationCode;
  }

  function DESTINATION_CHAIN_ID() internal pure override returns (uint256) {
    return ChainIds.ZKSYNC;
  }
}
