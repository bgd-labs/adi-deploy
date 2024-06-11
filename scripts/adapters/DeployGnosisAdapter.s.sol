// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import '../BaseDeployerScript.sol';
import 'adi-scripts/Adapters/DeployGnosisChain.sol';

abstract contract DeployGnosisAdapter is BaseDeployerScript, BaseGnosisChainAdapter {
  function _execute(Addresses memory addresses) internal override {
    addresses.gnosisAdapter = _deployAdapter(addresses.crossChainController);
  }
}

contract Ethereum is DeployGnosisAdapter {
  function GNOSIS_AMB_BRIDGE() internal pure override returns (address) {
    return 0x4C36d2919e407f0Cc2Ee3c993ccF8ac26d9CE64e;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function REMOTE_CCC_BY_NETWORK() internal pure override returns (RemoteCCC[] memory) {
    return new RemoteCCC[](0);
  }
}

contract Gnosis is DeployGnosisAdapter {
  function GNOSIS_AMB_BRIDGE() internal pure override returns (address) {
    return 0x75Df5AF045d91108662D8080fD1FEFAd6aA0bb59;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.GNOSIS;
  }

  function REMOTE_CCC_BY_NETWORK() internal view override returns (RemoteCCC[] memory) {
    RemoteCCC[] memory remoteCCCByNetwork = new RemoteCCC[](1);
    remoteCCCByNetwork[0].chainId = ChainIds.ETHEREUM;
    remoteCCCByNetwork[0].crossChainController = _getAddresses(ChainIds.ETHEREUM)
      .crossChainController;
    return remoteCCCByNetwork;
  }
}
