// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import 'adi-scripts/Adapters/DeployMetisAdapter.sol';
import '../BaseDeployerScript.sol';

abstract contract DeployMetisAdapter is BaseDeployerScript, BaseMetisAdapter {
  function _execute(Addresses memory addresses) internal override {
    addresses.metisAdapter = _deployAdapter(addresses.crossChainController);
  }
}

contract Ethereum is DeployMetisAdapter {
  function OVM() internal pure override returns (address) {
    return 0x081D1101855bD523bA69A9794e0217F0DB6323ff;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    return new uint256[](0);
  }
}

contract Metis is DeployMetisAdapter {
  function OVM() internal pure override returns (address) {
    return 0x4200000000000000000000000000000000000007;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.METIS;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = ChainIds.ETHEREUM;
    return networks;
  }
}
