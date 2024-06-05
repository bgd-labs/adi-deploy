// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {BaseDeployArbAdapter, IBaseAdapter, ChainIds, TestNetChainIds, RemoteCCC} from 'adi-scripts/Adapters/DeployArbAdapter.sol';
import {BaseDeployerScript, Addresses} from '../BaseDeployerScript.sol';

abstract contract DeployArbAdapter is BaseDeployerScript, BaseDeployArbAdapter {
  function _execute(Addresses memory addresses) internal override {
    IBaseAdapter.TrustedRemotesConfig[] memory trustedRemotes = _getTrustedRemotes();

    addresses.arbAdapter = _deployAdapter(addresses.crossChainController, trustedRemotes);
  }
}

contract Ethereum is DeployArbAdapter {
  function INBOX() internal pure override returns (address) {
    return 0x4Dbd4fc535Ac27206064B68FfCf827b0A60BAB3f;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function REMOTE_CCC_BY_NETWORK() internal pure override returns (RemoteCCC[] memory) {
    return new RemoteCCC[](0);
  }

  function PROVIDER_GAS_LIMIT() internal pure override returns (uint256) {
    return 150_000;
  }

  function DESTINATION_CCC() internal view override returns (address) {
    return _getAddresses(ChainIds.ARBITRUM).crossChainController;
  }
}

contract Arbitrum is DeployArbAdapter {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ARBITRUM;
  }

  function REMOTE_CCC_BY_NETWORK() internal view override returns (RemoteCCC[] memory) {
    RemoteCCC[] memory remoteCCCByNetwork = new RemoteCCC[](1);
    remoteCCCByNetwork[0].chainId = ChainIds.ETHEREUM;
    remoteCCCByNetwork[0].crossChainController = _getAddresses(ChainIds.ETHEREUM)
      .crossChainController;
    return remoteCCCByNetwork;
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

  function REMOTE_CCC_BY_NETWORK() internal pure override returns (RemoteCCC[] memory) {
    return new RemoteCCC[](0);
  }

  function PROVIDER_GAS_LIMIT() internal pure override returns (uint256) {
    return 150_000;
  }

  function DESTINATION_CCC() internal view override returns (address) {
    return _getAddresses(TestNetChainIds.ARBITRUM_SEPOLIA).crossChainController;
  }
}

contract Arbitrum_testnet is DeployArbAdapter {
  function isTestnet() internal pure override returns (bool) {
    return true;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.ARBITRUM_SEPOLIA;
  }

  function REMOTE_CCC_BY_NETWORK() internal view override returns (RemoteCCC[] memory) {
    RemoteCCC[] memory remoteCCCByNetwork = new RemoteCCC[](1);
    remoteCCCByNetwork[0].chainId = TestNetChainIds.ETHEREUM_SEPOLIA;
    remoteCCCByNetwork[0].crossChainController = _getAddresses(TestNetChainIds.ETHEREUM_SEPOLIA)
      .crossChainController;
    return remoteCCCByNetwork;
  }
}
