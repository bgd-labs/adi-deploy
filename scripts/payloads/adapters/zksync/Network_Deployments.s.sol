//// SPDX-License-Identifier: MIT
//pragma solidity ^0.8.0;
//
//import './Base_Add_Zksync_Path.s.sol';
//import {Base_Deploy_Add_ZkSync_Path_Payload} from '../../../../src/adapter_payloads/zksync/ADIAddZkSyncPathPayload.sol';
//
//contract Ethereum is Base_Deploy_Add_ZkSync_Path_Payload {
//  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
//    return ChainIds.ETHEREUM;
//  }
//
//  function _getShufflePayloadByteCode() internal pure override returns (bytes memory) {
//    return type(Ethereum_ADI_Add_ZkSYnc_Path_Payload).creationCode;
//  }
//
//  function DESTINATION_CHAIN_ID() internal pure override returns (uint256) {
//    return ChainIds.ZK_SYNC;
//  }
//}
