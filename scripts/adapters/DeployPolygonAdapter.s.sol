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

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = ChainIds.POLYGON;
    return networks;
  }
}

contract Polygon is DeployPolygonAdapter {
  function FX_TUNNEL() internal pure override returns (address) {
    return 0xF30FA9e36FdDd4982B722432FD39914e9ab2b033;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.POLYGON;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = ChainIds.ETHEREUM;
    return networks;
  }
}
