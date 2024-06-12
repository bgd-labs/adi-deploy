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
  function _execute(Addresses memory addresses) internal override {
    // deploy payloads
    new AaveV3Arbitrum_New_Adapter_Payload(
      addresses.crossChainController,
      _computeAdapterAddress(addresses.crossChainController)
    );
  }
}
