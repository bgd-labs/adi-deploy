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

  function REMOTE_CCC_BY_NETWORK() internal view override returns (RemoteCCC[] memory) {
    RemoteCCC[] memory remoteCCCByNetwork = new RemoteCCC[](1);
    remoteCCCByNetwork[0].chainId = ChainIds.POLYGON_ZK_EVM;
    remoteCCCByNetwork[0].crossChainController = _getAddresses(ChainIds.POLYGON_ZK_EVM)
      .crossChainController;
    return remoteCCCByNetwork;
  }
}

contract Zkevm is DeployZKEVMAdapter {
  function ZK_EVM_BRIDGE() internal pure override returns (address) {
    return 0x2a3DD3EB832aF982ec71669E178424b10Dca2EDe;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.POLYGON_ZK_EVM;
  }

  function REMOTE_CCC_BY_NETWORK() internal view override returns (RemoteCCC[] memory) {
    RemoteCCC[] memory remoteCCCByNetwork = new RemoteCCC[](1);
    remoteCCCByNetwork[0].chainId = ChainIds.ETHEREUM;
    remoteCCCByNetwork[0].crossChainController = _getAddresses(ChainIds.ETHEREUM)
      .crossChainController;
    return remoteCCCByNetwork;
  }
}
