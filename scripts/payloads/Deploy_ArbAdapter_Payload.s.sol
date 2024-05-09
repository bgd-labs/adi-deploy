// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'aave-helpers/adi/SimpleReceiverAdapterUpdate.sol';
import 'aave-helpers/ScriptUtils.sol';
import {ArbAdapterDeploymentHelper, BaseAdapterStructs} from 'adi-scripts/Adapters/DeployArbAdapter.sol';
import {IBaseAdapter} from 'adi/adapters/IBaseAdapter.sol';
import {DeployArbAdapter} from '../adapters/DeployArbAdapter.s.sol';

/**
 * @title Arbitrum bridge adapter update example
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/31
 */
contract AaveV3Arbitrum_New_Adapter_Payload is SimpleReceiverAdapterUpdate {
  ArbAdapterDeploymentHelper.ArbAdapterArgs public arbAdapterConstructorArgs;

  constructor(
    ArbAdapterDeploymentHelper.ArbAdapterArgs memory arbArgs
  )
    SimpleReceiverAdapterUpdate(
      SimpleReceiverAdapterUpdate.ConstructorInput({
        ccc: arbArgs.baseArgs.crossChainController,
        adapterToRemove: address(0)
      })
    )
  {
    for (uint256 i = 0; i < arbArgs.baseArgs.trustedRemotes.length; i++) {
      arbAdapterConstructorArgs.baseArgs.trustedRemotes[i] = arbArgs.baseArgs.trustedRemotes[i];
    }
    arbAdapterConstructorArgs.baseArgs.crossChainController = arbArgs.baseArgs.crossChainController;
    arbAdapterConstructorArgs.baseArgs.isTestnet = arbArgs.baseArgs.isTestnet;
    arbAdapterConstructorArgs.baseArgs.providerGasLimit = arbArgs.baseArgs.providerGasLimit;
    arbAdapterConstructorArgs.destinationCCC = arbArgs.destinationCCC;
    arbAdapterConstructorArgs.inbox = arbArgs.inbox;
  }

  function getChainsToReceive() public pure override returns (uint256[] memory) {
    uint256[] memory chains = new uint256[](1);
    chains[0] = ChainIds.MAINNET;
    return chains;
  }

  function getNewAdapterCode() public view override returns (bytes memory) {
    return ArbAdapterDeploymentHelper.getAdapterCode(arbAdapterConstructorArgs);
  }
}

/**
 * @dev Deploy Arbitrum
 * deploy-command: make deploy-ledger contract=src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/HyperlaneBridgeAdapterUpdateToV3_20240320.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: npx catapulta-verify -b broadcast/HyperlaneBridgeAdapterUpdateToV3_20240320.s.sol/42161/run-latest.json
 */
contract DeployArbitrumPayload is DeployArbAdapter, ArbitrumScript {
  function run() public override broadcast {
    // @dev revision '1' will need to change depending on the revision of deployment configuration that we want to use
    // This could also be set on the make call ans env variable
    AddressesAndConfig memory configurations = _getAddressesAndConfigs(ChainIds.ARBITRUM, '1', vm);

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

    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      abi.encodePacked(type(AaveV3Arbitrum_New_Adapter_Payload).creationCode, abi.encode(arbArgs))
    );
  }
}
