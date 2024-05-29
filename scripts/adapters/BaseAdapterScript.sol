// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import '../BaseScript.sol';
import 'adi/adapters/IBaseAdapter.sol';

abstract contract BaseAdapterScript is BaseScript {
  function REMOTE_NETWORKS() internal view virtual returns (uint256[] memory);

  function PROVIDER_GAS_LIMIT() internal view virtual returns (uint256) {
    return 0;
  }

  function SALT() internal view virtual returns (string memory) {
    return 'a.DI Adapter';
  }

  function isTestnet() internal view virtual returns (bool) {
    return false;
  }

  function _deployAdapter(
    DeployerHelpers.Addresses memory addresses,
    IBaseAdapter.TrustedRemotesConfig[] memory trustedRemotes
  ) internal virtual;

  function _getTrustedRemotes() internal view returns (IBaseAdapter.TrustedRemotesConfig[] memory) {
    uint256[] memory remoteNetworks = REMOTE_NETWORKS();
    // generate trusted trustedRemotes
    IBaseAdapter.TrustedRemotesConfig[]
      memory trustedRemotes = new IBaseAdapter.TrustedRemotesConfig[](remoteNetworks.length);

    for (uint256 i = 0; i < remoteNetworks.length; i++) {
      // fetch remote addresses
      DeployerHelpers.Addresses memory remoteAddresses = _getAddresses(remoteNetworks[i]);

      trustedRemotes[i] = IBaseAdapter.TrustedRemotesConfig({
        originForwarder: remoteAddresses.crossChainController,
        originChainId: remoteNetworks[i]
      });
    }
    return trustedRemotes;
  }

  function _execute(DeployerHelpers.Addresses memory addresses) internal override {
    IBaseAdapter.TrustedRemotesConfig[] memory trustedRemotes = _getTrustedRemotes();

    _deployAdapter(addresses, trustedRemotes);
  }
}
