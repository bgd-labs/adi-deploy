// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import '../BaseScript.sol';
import 'adi/adapters/IBaseAdapter.sol';

abstract contract BaseAdapterScript is BaseScript {
  function REMOTE_NETWORKS() public view virtual returns (uint256[] memory);

  function GET_BASE_GAS_LIMIT() public view virtual returns (uint256) {
    return 0;
  }

  function _deployAdapter(
    DeployerHelpers.Addresses memory addresses,
    IBaseAdapter.TrustedRemotesConfig[] memory trustedRemotes
  ) internal virtual;

  function _execute(DeployerHelpers.Addresses memory addresses) internal override {
    uint256[] memory remoteNetworks = REMOTE_NETWORKS();

    // generate trusted trustedRemotes
    IBaseAdapter.TrustedRemotesConfig[]
      memory trustedRemotes = new IBaseAdapter.TrustedRemotesConfig[](remoteNetworks.length);

    for (uint256 i = 0; i < remoteNetworks.length; i++) {
      DeployerHelpers.Addresses memory remoteAddresses = _getAddresses(remoteNetworks[i]);
      trustedRemotes[i] = IBaseAdapter.TrustedRemotesConfig({
        originForwarder: remoteAddresses.crossChainController,
        originChainId: remoteAddresses.chainId
      });
    }

    _deployAdapter(addresses, trustedRemotes);
  }
}

abstract contract BaseAdapterScript is DeploymentConfigurationBaseScript {
  function REMOTE_NETWORKS(
    ChainDeploymentInfo memory config
  ) internal view virtual returns (uint256[] memory);

  function _deployAdapter(
    address crossChainController,
    Addresses memory currentAddresses,
    Addresses memory revisionAddresses,
    ChainDeploymentInfo memory config,
    IBaseAdapter.TrustedRemotesConfig[] memory trustedRemotes
  ) internal virtual;

  function _getTrustedRemotes(
    ChainDeploymentInfo memory config
  ) internal view returns (IBaseAdapter.TrustedRemotesConfig[] memory) {
    uint256[] memory remoteNetworks = REMOTE_NETWORKS(config);
    // generate trusted trustedRemotes
    IBaseAdapter.TrustedRemotesConfig[]
      memory trustedRemotes = new IBaseAdapter.TrustedRemotesConfig[](remoteNetworks.length);

    for (uint256 i = 0; i < remoteNetworks.length; i++) {
      // fetch current addresses
      Addresses memory remoteCurrentAddresses = _getCurrentAddressesByChainId(
        remoteNetworks[i],
        vm
      );
      // fetch revision addresses
      Addresses memory remoteRevisionAddresses = _getRevisionAddressesByChainId(
        remoteNetworks[i],
        config.revision,
        vm
      );
      address remoteCCC = _getCrossChainController(
        remoteCurrentAddresses,
        remoteRevisionAddresses,
        remoteNetworks[i]
      );

      require(remoteCCC != address(0), 'Remote CCC needs to be deployed');

      trustedRemotes[i] = IBaseAdapter.TrustedRemotesConfig({
        originForwarder: remoteCCC,
        originChainId: remoteNetworks[i]
      });
    }
    return trustedRemotes;
  }

  function _execute(
    Addresses memory currentAddresses,
    Addresses memory revisionAddresses,
    ChainDeploymentInfo memory config
  ) internal override {
    address crossChainController = _getCrossChainController(
      currentAddresses,
      revisionAddresses,
      config.chainId
    );

    IBaseAdapter.TrustedRemotesConfig[] memory trustedRemotes = _getTrustedRemotes(config);

    _deployAdapter(
      crossChainController,
      currentAddresses,
      revisionAddresses,
      config,
      trustedRemotes
    );
  }
}
