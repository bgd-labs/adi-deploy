// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import 'adi-scripts/Adapters/DeployGnosisChain.sol';
import '../BaseDeployerScript.sol';

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

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    return new uint256[](0);
  }
}

contract Gnosis is DeployGnosisAdapter {
  function GNOSIS_AMB_BRIDGE() internal pure override returns (address) {
    return 0x75Df5AF045d91108662D8080fD1FEFAd6aA0bb59;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.GNOSIS;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = ChainIds.ETHEREUM;
    return networks;
  }
}
