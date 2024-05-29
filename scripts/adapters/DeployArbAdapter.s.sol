// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {BaseAdapterScript, DeployerHelpers, ChainIds, TestNetChainIds, IBaseAdapter} from './BaseAdapterScript.sol';
import {ArbAdapterDeploymentHelper, BaseAdapterStructs} from 'adi-scripts/Adapters/DeployArbAdapter.sol';
import {Create2Utils} from 'aave-helpers/ScriptUtils.sol';

abstract contract BaseDeployArbAdapter is BaseAdapterScript {
  function INBOX() internal view virtual returns (address) {
    return address(0);
  }

  function _getConstructorArgs(
    address crossChainController,
    IBaseAdapter.TrustedRemotesConfig[] memory trustedRemotes
  ) internal view returns (ArbAdapterDeploymentHelper.ArbAdapterArgs memory) {
    require(crossChainController != address(0), 'CCC needs to be deployed');

    DeployerHelpers.Addresses memory remoteAddresses;
    if (isTestnet()) {
      if (TRANSACTION_NETWORK() == TestNetChainIds.ETHEREUM_SEPOLIA) {
        remoteAddresses = _getAddresses(TestNetChainIds.ARBITRUM_SEPOLIA);
        require(
          remoteAddresses.crossChainController != address(0),
          'Arbitrum CCC must be deployed'
        );
        require(INBOX() != address(0), 'Arbitrum inbox can not be 0');
      }
    } else {
      if (TRANSACTION_NETWORK() == ChainIds.ETHEREUM) {
        remoteAddresses = _getAddresses(ChainIds.ARBITRUM);
        require(
          remoteAddresses.crossChainController != address(0),
          'Arbitrum CCC must be deployed'
        );
        require(INBOX() != address(0), 'Arbitrum inbox can not be 0');
      }
    }

    return
      ArbAdapterDeploymentHelper.ArbAdapterArgs({
        baseArgs: BaseAdapterStructs.BaseAdapterArgs({
          crossChainController: crossChainController,
          providerGasLimit: PROVIDER_GAS_LIMIT(),
          trustedRemotes: trustedRemotes,
          isTestnet: isTestnet()
        }),
        inbox: INBOX(),
        destinationCCC: remoteAddresses.crossChainController
      });
  }

  function _deployAdapter(
    DeployerHelpers.Addresses memory addresses,
    IBaseAdapter.TrustedRemotesConfig[] memory trustedRemotes
  ) internal override {
    ArbAdapterDeploymentHelper.ArbAdapterArgs memory constructorArgs = _getConstructorArgs(
      addresses.crossChainController,
      trustedRemotes
    );

    addresses.arbAdapter = Create2Utils.create2Deploy(
      keccak256(abi.encode(SALT())),
      ArbAdapterDeploymentHelper.getAdapterCode(constructorArgs)
    );
  }
}

contract Ethereum is BaseDeployArbAdapter {
  function INBOX() internal pure override returns (address) {
    return 0x4Dbd4fc535Ac27206064B68FfCf827b0A60BAB3f;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory remoteNetworks = new uint256[](0);
    return remoteNetworks;
  }

  function PROVIDER_GAS_LIMIT() internal pure override returns (uint256) {
    return 150_000;
  }
}

contract Arbitrum is BaseDeployArbAdapter {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ARBITRUM;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory remoteNetworks = new uint256[](1);
    remoteNetworks[0] = ChainIds.ETHEREUM;
    return remoteNetworks;
  }
}

contract Ethereum_testnet is BaseDeployArbAdapter {
  function INBOX() internal pure override returns (address) {
    return 0x6BEbC4925716945D46F0Ec336D5C2564F419682C;
  }

  function isTestnet() internal pure override returns (bool) {
    return true;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.ETHEREUM_SEPOLIA;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory remoteNetworks = new uint256[](0);

    return remoteNetworks;
  }

  function PROVIDER_GAS_LIMIT() internal pure override returns (uint256) {
    return 150_000;
  }
}

contract Arbitrum_testnet is BaseDeployArbAdapter {
  function isTestnet() internal pure override returns (bool) {
    return true;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.ARBITRUM_SEPOLIA;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory remoteNetworks = new uint256[](1);
    remoteNetworks[0] = TestNetChainIds.ETHEREUM_GOERLI;
    return remoteNetworks;
  }
}
