// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import 'adi-scripts/Adapters/DeployArbAdapter.sol';
import '../BaseDeployerScript.sol';

abstract contract DeployArbAdapter is BaseDeployerScript, BaseDeployArbAdapter {
  function _execute(Addresses memory addresses) internal override {
    addresses.arbAdapter = _deployAdapter(addresses.crossChainController);
  }
}

contract Ethereum is DeployArbAdapter {
  function INBOX() internal pure override returns (address) {
    return 0x4Dbd4fc535Ac27206064B68FfCf827b0A60BAB3f;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function REMOTE_NETWORKS() internal view override returns (uint256[] memory) {
    return new uint256[](0);
  }

  function REFUND_ADDRESS() internal view override returns (address) {
    return _getAddresses(ChainIds.ARBITRUM).crossChainController;
  }
}

contract Arbitrum is DeployArbAdapter {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ARBITRUM;
  }

  function REMOTE_NETWORKS() internal view override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = ChainIds.ETHEREUM;
    return networks;
  }
}

contract Ethereum_testnet is DeployArbAdapter {
  function INBOX() internal pure override returns (address) {
    return 0x6BEbC4925716945D46F0Ec336D5C2564F419682C;
  }

  function isTestnet() internal pure override returns (bool) {
    return true;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.ETHEREUM_SEPOLIA;
  }

  function REMOTE_NETWORKS() internal view override returns (uint256[] memory) {
    return new uint256[](0);
  }

  function REFUND_ADDRESS() internal view override returns (address) {
    return _getAddresses(TestNetChainIds.ARBITRUM_SEPOLIA).crossChainController;
  }
}

contract Arbitrum_testnet is DeployArbAdapter {
  function isTestnet() internal pure override returns (bool) {
    return true;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.ARBITRUM_SEPOLIA;
  }

  function REMOTE_NETWORKS() internal view override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = TestNetChainIds.ETHEREUM_SEPOLIA;
    return networks;
  }
}
