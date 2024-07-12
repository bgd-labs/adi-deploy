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

  function REMOTE_CCC_BY_NETWORK() internal pure override returns (RemoteCCC[] memory) {
    return new RemoteCCC[](0);
  }
}

contract Optimism is DeployOpAdapter {
  function OVM() internal pure override returns (address) {
    return 0x4200000000000000000000000000000000000007;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.OPTIMISM;
  }

  function REMOTE_CCC_BY_NETWORK() internal view override returns (RemoteCCC[] memory) {
    RemoteCCC[] memory remoteCCCByNetwork = new RemoteCCC[](1);
    remoteCCCByNetwork[0].chainId = ChainIds.ETHEREUM;
    remoteCCCByNetwork[0].crossChainController = _getAddresses(ChainIds.ETHEREUM)
      .crossChainController;
    return remoteCCCByNetwork;
  }
}
