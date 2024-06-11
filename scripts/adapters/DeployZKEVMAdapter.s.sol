// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import 'adi-scripts/Adapters/DeployZkEVMAdapter.sol';
import '../BaseDeployerScript.sol';

abstract contract DeployZKEVMAdapter is BaseDeployerScript, BaseZKEVMAdapter {
  function _execute(Addresses memory addresses) internal override {
    addresses.polAdapter = _deployAdapter(addresses.crossChainController);
  }
}

contract Ethereum is DeployZKEVMAdapter {
  function ZK_EVM_BRIDGE() internal pure override returns (address) {
    return 0x2a3DD3EB832aF982ec71669E178424b10Dca2EDe;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = ChainIds.POLYGON_ZK_EVM;
    return networks;
  }
}

contract Zkevm is DeployZKEVMAdapter {
  function ZK_EVM_BRIDGE() internal pure override returns (address) {
    return 0x2a3DD3EB832aF982ec71669E178424b10Dca2EDe;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.POLYGON_ZK_EVM;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = ChainIds.ETHEREUM;
    return networks;
  }
}
