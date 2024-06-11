// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IBaseAdapter} from 'adi-scripts/Adapters/DeployArbAdapter.sol';
import {Arbitrum, Addresses, BaseAdapterArgs} from '../adapters/DeployArbAdapter.s.sol';
import {Create2Utils, ArbitrumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Arbitrum_New_Adapter_Payload, ChainIds} from './ArbAdapterPayload.sol';

/**
 * @dev Deploy Arbitrum
 * deploy-command: make deploy-pk contract=scripts/payloads/Deploy_ArbAdapter_Payload.s.sol:DeployArbitrumPayload chain=arbitrum_sepolia
 * verify-command: npx catapulta-verify -b broadcast/Deploy_ArbAdapter_Payload.s.sol/42161/run-latest.json
 */
contract DeployArbitrumPayload is Arbitrum, ArbitrumScript {
  function _getPayloadArgs() internal view returns (address, address, bytes32, bytes memory) {
    Addresses memory addresses = _getAddresses(ChainIds.ARBITRUM);
    IBaseAdapter.TrustedRemotesConfig[] memory trustedRemotes = _getTrustedRemotes();

    BaseAdapterArgs memory baseArgs = BaseAdapterArgs({
      crossChainController: addresses.crossChainController,
      providerGasLimit: PROVIDER_GAS_LIMIT(),
      trustedRemotes: trustedRemotes,
      isTestnet: isTestnet()
    });
    bytes memory adapterCode = _getAdapterByteCode(baseArgs);

    bytes32 salt = keccak256(abi.encode(SALT()));
    address newAdapter = Create2Utils.computeCreate2Address(salt, adapterCode);

    return (addresses.crossChainController, newAdapter, salt, adapterCode);
  }

  function run() public override {
    vm.startBroadcast();
    (address crossChainController, address newAdapter, , ) = _getPayloadArgs();
    // deploy payloads
    new AaveV3Arbitrum_New_Adapter_Payload(crossChainController, newAdapter);

    vm.stopBroadcast();
  }
}
