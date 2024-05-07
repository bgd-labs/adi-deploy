// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import './BaseAdapterScript.sol';
import {ArbAdapterDeploymentHelper} from 'adi-scripts/Adapters/DeployArbAdapter.sol';
import {IBaseAdapter} from 'adi/adapters/IBaseAdapter.sol';
import 'aave-helpers/GovV3Helpers.sol';

contract DeployArbAdapter is BaseAdapterScript {
  function REMOTE_NETWORKS(
    ChainDeploymentInfo memory config
  ) internal pure override returns (uint256[] memory) {
    return config.adapters.arbitrumAdapter.remoteNetworks;
  }

  function _deployAdapter(
    address crossChainController,
    Addresses memory currentAddresses,
    Addresses memory revisionAddresses,
    ChainDeploymentInfo memory config,
    IBaseAdapter.TrustedRemotesConfig[] memory trustedRemotes
  ) internal override {
    require(crossChainController != address(0), 'CCC needs to be deployed');

    EndpointAdapterInfo memory arbConfig = config.adapters.arbitrumAdapter;

    address arbAdapter;
    address destinationCCC;
    if (PathHelpers.isTestNet(config.chainId)) {
      if (config.chainId == TestNetChainIds.ETHEREUM_SEPOLIA) {
        // fetch current addresses
        Addresses memory remoteCurrentAddresses = _getCurrentAddressesByChainId(
          TestNetChainIds.ARBITRUM_SEPOLIA,
          vm
        );
        // fetch revision addresses
        Addresses memory remoteRevisionAddresses = _getRevisionAddressesByChainId(
          TestNetChainIds.ARBITRUM_SEPOLIA,
          config.revision,
          vm
        );
        destinationCCC = _getCrossChainController(
          remoteCurrentAddresses,
          remoteRevisionAddresses,
          TestNetChainIds.ARBITRUM_SEPOLIA
        );

        require(arbConfig.endpoint != address(0), 'Arbitrum inbox can not be 0');
        require(destinationCCC != address(0), 'Arbitrum CCC must be deployed');
      }
    } else {
      if (config.chainId == ChainIds.ETHEREUM) {
        // fetch current addresses
        Addresses memory remoteCurrentAddresses = _getCurrentAddressesByChainId(
          ChainIds.ARBITRUM,
          vm
        );
        // fetch revision addresses
        Addresses memory remoteRevisionAddresses = _getRevisionAddressesByChainId(
          ChainIds.ARBITRUM,
          config.revision,
          vm
        );
        destinationCCC = _getCrossChainController(
          remoteCurrentAddresses,
          remoteRevisionAddresses,
          ChainIds.ARBITRUM
        );

        require(arbConfig.endpoint != address(0), 'Arbitrum inbox can not be 0');
        require(destinationCCC != address(0), 'Arbitrum CCC must be deployed');
      }
    }

    arbAdapter = GovV3Helpers.deployDeterministic(
      ArbAdapterDeploymentHelper.getAdapterCode(
        ArbAdapterDeploymentHelper.BaseAdapterArgs({
          crossChainController: crossChainController,
          providerGasLimit: arbConfig.providerGasLimit,
          trustedRemotes: trustedRemotes,
          isTestnet: true
        }),
        arbConfig.endpoint,
        destinationCCC
      )
    );

    currentAddresses.arbAdapter = revisionAddresses.arbAdapter = arbAdapter;
  }
}
