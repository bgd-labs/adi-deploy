// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {BaseDeployArbAdapter, IBaseAdapter, ChainIds, TestNetChainIds, RemoteCCC} from 'adi-scripts/Adapters/DeployArbAdapter.sol';
import {BaseDeployerScript, Addresses} from '../BaseDeployerScript.sol';

abstract contract BaseCBAdapter is BaseDeployerScript, BaseDeployArbAdapter {
  function isTestnet() public view virtual returns (bool) {
    return false;
  }

  function _execute(Addresses memory addresses) internal override {
    IBaseAdapter.TrustedRemotesConfig[] memory trustedRemotes = _getTrustedRemotes();

    addresses.arbAdapter = _deployAdapter(addresses.crossChainController, trustedRemotes);
  }
}

contract Ethereum is BaseCBAdapter {
  function OVM() public pure override returns (address) {
    return 0x866E82a600A1414e583f7F13623F1aC5d58b0Afa;
  }

  function TRANSACTION_NETWORK() public pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function REMOTE_NETWORKS() public pure override returns (uint256[] memory) {
    uint256[] memory remoteNetworks = new uint256[](0);

    return remoteNetworks;
  }
}

contract Base is BaseCBAdapter {
  function OVM() public pure override returns (address) {
    return 0x4200000000000000000000000000000000000007;
  }

  function TRANSACTION_NETWORK() public pure override returns (uint256) {
    return ChainIds.BASE;
  }

  function REMOTE_NETWORKS() public pure override returns (uint256[] memory) {
    uint256[] memory remoteNetworks = new uint256[](1);
    remoteNetworks[0] = ChainIds.ETHEREUM;

    return remoteNetworks;
  }
}

contract Ethereum_testnet is BaseCBAdapter {
  function OVM() public pure override returns (address) {
    return 0x8e5693140eA606bcEB98761d9beB1BC87383706D;
  }

  function isTestnet() public pure override returns (bool) {
    return true;
  }

  function TRANSACTION_NETWORK() public pure override returns (uint256) {
    return TestNetChainIds.ETHEREUM_GOERLI;
  }

  function REMOTE_NETWORKS() public pure override returns (uint256[] memory) {
    uint256[] memory remoteNetworks = new uint256[](0);

    return remoteNetworks;
  }
}

contract Base_testnet is BaseCBAdapter {
  function OVM() public pure override returns (address) {
    return 0x4200000000000000000000000000000000000007;
  }

  function isTestnet() public pure override returns (bool) {
    return true;
  }

  function TRANSACTION_NETWORK() public pure override returns (uint256) {
    return TestNetChainIds.BASE_GOERLI;
  }

  function REMOTE_NETWORKS() public pure override returns (uint256[] memory) {
    uint256[] memory remoteNetworks = new uint256[](1);
    remoteNetworks[0] = TestNetChainIds.ETHEREUM_GOERLI;

    return remoteNetworks;
  }
}
