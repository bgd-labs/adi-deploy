// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './Base_Add_Zksync_Path.s.sol';
import {BaseAdapterArgs, BaseZkSyncAdapter, RemoteCCC} from '../../../adapters/DeployZkSyncAdapter.s.sol';

contract Ethereum is Base_Deploy_Add_ZkSync_Path_Payload, BaseZkSyncAdapter {
  // TODO: not entirely sure on how to correctly build inheritance to directly import from Ethereum
  // script of zksync adapter deployment, so that we dont have to duplicate parameters already defined
  // there.
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function PROVIDER_GAS_LIMIT() internal view virtual override returns (uint256) {
    return 650_000;
  }

  function REFUND_ADDRESS() internal view override returns (address) {
    Addresses memory remoteAddresses = _getAddresses(ChainIds.ZK_SYNC);
    return remoteAddresses.crossChainController;
  }

  function REMOTE_CCC_BY_NETWORK() internal pure override returns (RemoteCCC[] memory) {
    return new RemoteCCC[](0);
  }

  function BRIDGE_HUB() internal pure override returns (address) {
    return 0x303a465B659cBB0ab36eE643eA362c509EEb5213;
  }

  function _getPayloadByteCode() internal pure override returns (bytes memory) {
    return type(SimpleAddForwarderAdapter).creationCode;
  }

  function _getAdapterAddress(address crossChainController) internal override returns (address) {
    BaseAdapterArgs memory baseArgs = BaseAdapterArgs({
      crossChainController: crossChainController,
      providerGasLimit: PROVIDER_GAS_LIMIT(),
      trustedRemotes: _getTrustedRemotes(),
      isTestnet: isTestnet()
    });
    return _computeByteCodeAddress(_getAdapterByteCode(baseArgs), SALT());
  }

  function DESTINATION_CHAIN_ID() internal pure override returns (uint256) {
    return ChainIds.ZK_SYNC;
  }
}
