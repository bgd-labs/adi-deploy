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

  function REMOTE_CCC_BY_NETWORK() internal pure override returns (RemoteCCC[] memory) {
    return new RemoteCCC[](0);
  }
}

contract Base is DeployCBAdapter {
  function OVM() internal pure override returns (address) {
    return 0x4200000000000000000000000000000000000007;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.BASE;
  }

  function REMOTE_CCC_BY_NETWORK() internal view override returns (RemoteCCC[] memory) {
    RemoteCCC[] memory remoteCCCByNetwork = new RemoteCCC[](1);
    remoteCCCByNetwork[0].chainId = ChainIds.ETHEREUM;
    remoteCCCByNetwork[0].crossChainController = _getAddresses(ChainIds.ETHEREUM)
      .crossChainController;

    return remoteCCCByNetwork;
  }
}
