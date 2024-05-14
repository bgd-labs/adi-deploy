// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ArbAdapterDeploymentHelper, BaseAdapterStructs} from 'adi-scripts/Adapters/DeployArbAdapter.sol';
import {TestNetChainIds} from 'adi-scripts/contract_extensions/TestNetChainIds.sol';
import {IBaseAdapter} from 'adi/adapters/IBaseAdapter.sol';
import {DeployArbAdapter, ChainIds} from '../adapters/DeployArbAdapter.s.sol';
import {Create2Utils, ArbitrumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Arbitrum_New_Adapter_Payload} from './ArbAdapterPayload.sol';

/**
 * @dev Deploy Arbitrum
 * deploy-command: make deploy-pk contract=scripts/payloads/Deploy_ArbAdapter_Payload.s.sol:DeployArbitrumPayload chain=arbitrum_sepolia
 * verify-command: npx catapulta-verify -b broadcast/Deploy_ArbAdapter_Payload.s.sol/42161/run-latest.json
 */
contract DeployArbitrumPayload is DeployArbAdapter, ArbitrumScript {
  function _getPayloadArgs(
    uint256 network,
    string memory version
  ) internal view returns (address, address, bytes32, bytes memory) {
    // @dev revision '1' will need to change depending on the revision of deployment configuration that we want to use
    // This could also be set on the make call ans env variable
    AddressesAndConfig memory configurations = _getAddressesAndConfigs(network, version, vm);

    address crossChainController = _getCrossChainController(
      configurations.currentAddresses,
      configurations.revisionAddresses,
      configurations.config.chainId
    );

    IBaseAdapter.TrustedRemotesConfig[] memory trustedRemotes = _getTrustedRemotes(
      configurations.config
    );

    ArbAdapterDeploymentHelper.ArbAdapterArgs memory arbArgs = _getConstructorArgs(
      crossChainController,
      configurations.config,
      trustedRemotes
    );

    bytes memory adapterCode = ArbAdapterDeploymentHelper.getAdapterCode(arbArgs);
    bytes32 salt = keccak256(abi.encode(configurations.config.adapters.arbitrumAdapter.salt));
    address newAdapter = Create2Utils.computeCreate2Address(salt, adapterCode);

    return (crossChainController, newAdapter, salt, adapterCode);
  }

  function run() public override {
    vm.startBroadcast();
    (address crossChainController, address newAdapter, , ) = _getPayloadArgs(
      ChainIds.ARBITRUM,
      '1'
    );
    // deploy payloads
    new AaveV3Arbitrum_New_Adapter_Payload(crossChainController, newAdapter);

    vm.stopBroadcast();
  }
}
