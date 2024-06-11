// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import 'adi-scripts/Adapters/DeployScrollAdapter.sol';
import '../BaseDeployerScript.sol';

abstract contract DeployScrollAdapter is BaseDeployerScript, BaseScrollAdapter {
  function _execute(Addresses memory addresses) internal override {
    addresses.scrollAdapter = _deployAdapter(addresses.crossChainController);
  }
}

contract Ethereum is DeployScrollAdapter {
  function OVM() internal pure override returns (address) {
    return 0x6774Bcbd5ceCeF1336b5300fb5186a12DDD8b367;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    return new uint256[](0);
  }
}

contract Scroll is DeployScrollAdapter {
  function OVM() internal pure override returns (address) {
    return 0x781e90f1c8Fc4611c9b7497C3B47F99Ef6969CbC;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.SCROLL;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = ChainIds.ETHEREUM;
    return networks;
  }
}

contract Ethereum_testnet is DeployScrollAdapter {
  function OVM() internal pure override returns (address) {
    return 0x50c7d3e7f7c656493D1D76aaa1a836CedfCBB16A;
  }

  function isTestnet() internal pure override returns (bool) {
    return true;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.ETHEREUM_SEPOLIA;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    return new uint256[](0);
  }
}

contract Scroll_testnet is DeployScrollAdapter {
  function OVM() internal pure override returns (address) {
    return 0xBa50f5340FB9F3Bd074bD638c9BE13eCB36E603d;
  }

  function isTestnet() internal pure override returns (bool) {
    return true;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.SCROLL_SEPOLIA;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = TestNetChainIds.ETHEREUM_SEPOLIA;
    return networks;
  }
}
