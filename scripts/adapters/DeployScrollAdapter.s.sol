// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import '../BaseDeployerScript.sol';
import 'adi-scripts/Adapters/DeployScrollAdapter.sol';

abstract contract DeployScrollAdapter is BaseDeployerScript, BaseScrollAdapter {
  function _execute(Addresses memory addresses) internal override {
    IBaseAdapter.TrustedRemotesConfig[] memory trustedRemotes = _getTrustedRemotes();

    addresses.scrollAdapter = _deployAdapter(addresses.crossChainController, trustedRemotes);
  }
}

contract Ethereum is DeployScrollAdapter {
  function OVM() internal pure override returns (address) {
    return 0x6774Bcbd5ceCeF1336b5300fb5186a12DDD8b367;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function REMOTE_CCC_BY_NETWORK() internal pure override returns (RemoteCCC[] memory) {
    return new RemoteCCC[](0);
  }
}

contract Scroll is DeployScrollAdapter {
  function OVM() internal pure override returns (address) {
    return 0x781e90f1c8Fc4611c9b7497C3B47F99Ef6969CbC;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.SCROLL;
  }

  function REMOTE_CCC_BY_NETWORK() internal view override returns (RemoteCCC[] memory) {
    RemoteCCC[] memory remoteCCCByNetwork = new RemoteCCC[](1);
    remoteCCCByNetwork[0].chainId = ChainIds.ETHEREUM;
    remoteCCCByNetwork[0].crossChainController = _getAddresses(ChainIds.ETHEREUM)
      .crossChainController;
    return remoteCCCByNetwork;
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

  function REMOTE_CCC_BY_NETWORK() internal pure override returns (RemoteCCC[] memory) {
    return new RemoteCCC[](0);
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

  function REMOTE_CCC_BY_NETWORK() internal view override returns (RemoteCCC[] memory) {
    RemoteCCC[] memory remoteCCCByNetwork = new RemoteCCC[](1);
    remoteCCCByNetwork[0].chainId = TestNetChainIds.ETHEREUM_SEPOLIA;
    remoteCCCByNetwork[0].crossChainController = _getAddresses(TestNetChainIds.ETHEREUM_SEPOLIA)
      .crossChainController;
    return remoteCCCByNetwork;
  }
}
