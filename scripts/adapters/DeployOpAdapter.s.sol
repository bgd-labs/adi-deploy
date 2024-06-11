// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import 'adi-scripts/Adapters/DeployOpAdapter.sol';
import '../BaseDeployerScript.sol';

abstract contract DeployOpAdapter is BaseDeployerScript, BaseOpAdapter {
  function _execute(Addresses memory addresses) internal override {
    addresses.opAdapter = _deployAdapter(addresses.crossChainController);
  }
}

contract Ethereum is DeployOpAdapter {
  function OVM() internal pure override returns (address) {
    return 0x25ace71c97B33Cc4729CF772ae268934F7ab5fA1;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    return new uint256[](0);
  }
}

contract Optimism is DeployOpAdapter {
  function OVM() internal pure override returns (address) {
    return 0x4200000000000000000000000000000000000007;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.OPTIMISM;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = ChainIds.ETHEREUM;
    return networks;
  }
}
