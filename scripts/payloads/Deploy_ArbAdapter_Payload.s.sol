// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'aave-helpers/adi/SimpleReceiverAdapterUpdate.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import 'aave-helpers/ScriptUtils.sol';
import 'aave-helpers/GovV3Helpers.sol';
import {ArbAdapterDeploymentHelper, BaseAdapterStructs} from 'adi-scripts/Adapters/DeployArbAdapter.sol';

/**
 * @title Hyperlane bridge adapter update to V3
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/31
 */
contract AaveV3Arbitrum_New_Adapter_Payload is
  SimpleReceiverAdapterUpdate(
    SimpleReceiverAdapterUpdate.ConstructorInput({
      ccc: GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER,
      adapterToRemove: address(0)
    })
  )
{
  function getChainsToReceive() public pure override returns (uint256[] memory) {
    uint256[] memory chains = new uint256[](1);
    chains[0] = ChainIds.MAINNET;
    return chains;
  }

  function getNewAdapterCode() public override returns (bytes memory) {
    IBaseAdapter.TrustedRemotesConfig[]
      memory trustedRemotes = new IBaseAdapter.TrustedRemotesConfig[](1);
    trustedRemotes[0] = IBaseAdapter.TrustedRemotesConfig({
      originChainId: ChainIds.MAINNET,
      originForwarder: GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER
    });

    // Problem I see with this is that we will have to put the constructor args. We will need to get them from
    // the config json file
    return
      ArbAdapterDeploymentHelper.getAdapterCode(
        ArbAdapterDeploymentHelper.ArbAdapterArgs({
          baseArgs: BaseAdapterStructs.BaseAdapterArgs({
            crossChainController: GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER,
            providerGasLimit: 150_000,
            trustedRemotes: trustedRemotes,
            isTestnet: false
          }),
          inbox: address(0),
          destinationCCC: address(0)
        })
      );
  }
}

/**
 * @dev Deploy Arbitrum
 * deploy-command: make deploy-ledger contract=src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/HyperlaneBridgeAdapterUpdateToV3_20240320.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: npx catapulta-verify -b broadcast/HyperlaneBridgeAdapterUpdateToV3_20240320.s.sol/42161/run-latest.json
 */
contract DeployArbitrumPayload is ArbitrumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Arbitrum_New_Adapter_Payload).creationCode
    );
  }
}
