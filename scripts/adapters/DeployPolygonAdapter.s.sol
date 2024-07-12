// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import 'adi-scripts/Adapters/DeployPolygon.sol';
import '../BaseDeployerScript.sol';

abstract contract DeployPolygonAdapter is BaseDeployerScript, BasePolygonAdapter {
  function _execute(Addresses memory addresses) internal override {
    addresses.polAdapter = _deployAdapter(addresses.crossChainController);
  }
}

contract Ethereum is DeployPolygonAdapter {
  function FX_TUNNEL() internal pure override returns (address) {
    return 0xF30FA9e36FdDd4982B722432FD39914e9ab2b033;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function REMOTE_CCC_BY_NETWORK() internal view override returns (RemoteCCC[] memory) {
    RemoteCCC[] memory remoteCCCByNetwork = new RemoteCCC[](1);
    remoteCCCByNetwork[0].chainId = ChainIds.POLYGON;
    remoteCCCByNetwork[0].crossChainController = _getAddresses(ChainIds.POLYGON)
      .crossChainController;
    return remoteCCCByNetwork;
  }
}

contract Polygon is DeployPolygonAdapter {
  function FX_TUNNEL() internal pure override returns (address) {
    return 0xF30FA9e36FdDd4982B722432FD39914e9ab2b033;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.POLYGON;
  }

  function REMOTE_CCC_BY_NETWORK() internal view override returns (RemoteCCC[] memory) {
    RemoteCCC[] memory remoteCCCByNetwork = new RemoteCCC[](1);
    remoteCCCByNetwork[0].chainId = ChainIds.ETHEREUM;
    remoteCCCByNetwork[0].crossChainController = _getAddresses(ChainIds.ETHEREUM)
      .crossChainController;
    return remoteCCCByNetwork;
  }
}
