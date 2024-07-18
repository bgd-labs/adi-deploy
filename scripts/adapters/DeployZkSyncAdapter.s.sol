// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import 'adi-scripts/Adapters/DeployZkSyncAdapter.sol';
import '../BaseDeployerScript.sol';

abstract contract DeployZkSyncAdapter is BaseDeployerScript, BaseZkSyncAdapter {
  function _execute(Addresses memory addresses) internal virtual override {
    addresses.zksyncAdapter = _deployAdapter(addresses.crossChainController);
  }
}

contract Ethereum is DeployZkSyncAdapter {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function PROVIDER_GAS_LIMIT() internal view virtual override returns (uint256) {
    return 650_000;
  }

  function REFUND_ADDRESS() internal view override returns (address) {
    Addresses memory remoteAddresses = _getAddresses(ChainIds.ZK_SYNC);
    return remoteAddresses.crossChainController;
  }

  function REMOTE_CCC_BY_NETWORK() internal pure override returns (RemoteCCC[] memory) {
    return new RemoteCCC[](0);
  }

  function BRIDGE_HUB() internal pure override returns (address) {
    return 0x32400084C286CF3E17e7B677ea9583e60a000324; // TODO: REPLACE WITH CORRECT ADDRESS WHEN DEPLOYED TO MAINNET
  }
}

contract Zksync is DeployZkSyncAdapter {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ZK_SYNC;
  }

  function REMOTE_CCC_BY_NETWORK() internal view override returns (RemoteCCC[] memory) {
    RemoteCCC[] memory remoteCCCByNetwork = new RemoteCCC[](1);
    remoteCCCByNetwork[0].chainId = ChainIds.ETHEREUM;
    remoteCCCByNetwork[0].crossChainController = _getAddresses(ChainIds.ETHEREUM)
      .crossChainController;
    return remoteCCCByNetwork;
  }

  function BRIDGE_HUB() internal pure override returns (address) {
    return 0x32400084C286CF3E17e7B677ea9583e60a000324; // TODO: REPLACE WITH CORRECT ADDRESS WHEN DEPLOYED TO MAINNET
  }
}

contract Ethereum_testnet is DeployZkSyncAdapter {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.ETHEREUM_SEPOLIA;
  }

  function REFUND_ADDRESS() internal view override returns (address) {
    Addresses memory remoteAddresses = _getAddresses(TestNetChainIds.ZK_SYNC_SEPOLIA);
    return remoteAddresses.crossChainController;
  }

  function REMOTE_CCC_BY_NETWORK() internal pure override returns (RemoteCCC[] memory) {
    return new RemoteCCC[](0);
  }

  function BRIDGE_HUB() internal pure override returns (address) {
    return 0x35A54c8C757806eB6820629bc82d90E056394C92;
  }

  function isTestnet() internal pure override returns (bool) {
    return true;
  }
}

contract Zksync_testnet is DeployZkSyncAdapter {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.ZK_SYNC_SEPOLIA;
  }

  function REMOTE_CCC_BY_NETWORK() internal view override returns (RemoteCCC[] memory) {
    RemoteCCC[] memory remoteCCCByNetwork = new RemoteCCC[](1);
    remoteCCCByNetwork[0].chainId = TestNetChainIds.ETHEREUM_SEPOLIA;
    remoteCCCByNetwork[0].crossChainController = _getAddresses(TestNetChainIds.ETHEREUM_SEPOLIA)
      .crossChainController;
    return remoteCCCByNetwork;
  }

  function BRIDGE_HUB() internal pure override returns (address) {
    return 0x9A6DE0f62Aa270A8bCB1e2610078650D539B1Ef9; // TODO: REPLACE WITH CORRECT ADDRESS WHEN DEPLOYED TO MAINNET
  }

  function isTestnet() internal pure override returns (bool) {
    return true;
  }
}
