// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {BaseDeployArbAdapter, Addresses, IBaseAdapter, ChainIds, TestNetChainIds} from 'adi-scripts/Adapters/DeployArbAdapter.sol';
import {BaseDeployerScript} from '../BaseDeployerScript.sol';

abstract contract DeployArbAdapter is BaseDeployerScript, BaseDeployArbAdapter {
  function _execute(Addresses memory addresses) internal override {
    IBaseAdapter.TrustedRemotesConfig[] memory trustedRemotes = _getTrustedRemotes();

    addresses.arbAdapter = _deployAdapter(addresses, trustedRemotes);
  }
}

contract Ethereum is DeployArbAdapter {
  function INBOX() internal pure override returns (address) {
    return 0x4Dbd4fc535Ac27206064B68FfCf827b0A60BAB3f;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory remoteNetworks = new uint256[](0);
    return remoteNetworks;
  }

  function PROVIDER_GAS_LIMIT() internal pure override returns (uint256) {
    return 150_000;
  }
}

contract Arbitrum is DeployArbAdapter {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ARBITRUM;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory remoteNetworks = new uint256[](1);
    remoteNetworks[0] = ChainIds.ETHEREUM;
    return remoteNetworks;
  }
}

contract Ethereum_testnet is DeployArbAdapter {
  function INBOX() internal pure override returns (address) {
    return 0x6BEbC4925716945D46F0Ec336D5C2564F419682C;
  }

  function isTestnet() internal pure override returns (bool) {
    return true;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.ETHEREUM_SEPOLIA;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory remoteNetworks = new uint256[](0);

    return remoteNetworks;
  }

  function PROVIDER_GAS_LIMIT() internal pure override returns (uint256) {
    return 150_000;
  }
}

contract Arbitrum_testnet is DeployArbAdapter {
  function isTestnet() internal pure override returns (bool) {
    return true;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.ARBITRUM_SEPOLIA;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory remoteNetworks = new uint256[](1);
    remoteNetworks[0] = TestNetChainIds.ETHEREUM_SEPOLIA;
    return remoteNetworks;
  }
}
