// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import 'adi-scripts/Adapters/DeploySameChainAdapter.sol';
import '../BaseDeployerScript.sol';

abstract contract DeploySameChainAdapter is BaseDeployerScript, BaseSameChainAdapter {
  function _execute(Addresses memory addresses) internal override {
    addresses.sameChainAdapter = _deployAdapter(addresses.crossChainController);
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    return new uint256[](0);
  }
}

contract Ethereum is DeploySameChainAdapter {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }
}

contract Ethereum_testnet is DeploySameChainAdapter {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.ETHEREUM_SEPOLIA;
  }
}
