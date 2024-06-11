// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import 'adi-scripts/Adapters/DeployCBaseAdapter.sol';
import '../BaseDeployerScript.sol';

abstract contract DeployCBAdapter is BaseDeployerScript, BaseCBAdapter {
  function _execute(Addresses memory addresses) internal override {
    addresses.baseAdapter = _deployAdapter(addresses.crossChainController);
  }
}

contract Ethereum is DeployCBAdapter {
  function OVM() internal pure override returns (address) {
    return 0x866E82a600A1414e583f7F13623F1aC5d58b0Afa;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function REMOTE_NETWORKS() internal view override returns (uint256[] memory) {
    return new uint256[](0);
  }
}

contract Base is DeployCBAdapter {
  function OVM() internal pure override returns (address) {
    return 0x4200000000000000000000000000000000000007;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.BASE;
  }

  function REMOTE_NETWORKS() internal view override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = ChainIds.ETHEREUM;
    return networks;
  }
}
