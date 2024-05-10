// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SimpleReceiverAdapterUpdate, GovV3Helpers} from 'aave-helpers/adi/SimpleReceiverAdapterUpdate.sol';
import 'aave-helpers/ScriptUtils.sol';
import {ArbAdapterDeploymentHelper, BaseAdapterStructs} from 'adi-scripts/Adapters/DeployArbAdapter.sol';
import {TestNetChainIds} from 'adi-scripts/contract_extensions/TestNetChainIds.sol';
import {IBaseAdapter} from 'adi/adapters/IBaseAdapter.sol';
import {DeployArbAdapter} from '../adapters/DeployArbAdapter.s.sol';

abstract contract BaseArbPayload {
  address public immutable PREDICTED_ADDRESS;

  constructor(ArbAdapterDeploymentHelper.ArbAdapterArgs memory arbArgs) {
    bytes memory adapterCode = ArbAdapterDeploymentHelper.getAdapterCode(arbArgs);

    PREDICTED_ADDRESS = GovV3Helpers.predictDeterministicAddress(adapterCode);
  }
}

/**
 * @title Arbitrum bridge adapter update example
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/31
 */
contract AaveV3Arbitrum_New_Adapter_Payload is BaseArbPayload, SimpleReceiverAdapterUpdate {
  ArbAdapterDeploymentHelper.ArbAdapterArgs public arbAdapterConstructorArgs;

  constructor(
    ArbAdapterDeploymentHelper.ArbAdapterArgs memory arbArgs
  )
    BaseArbPayload(arbArgs)
    SimpleReceiverAdapterUpdate(
      SimpleReceiverAdapterUpdate.ConstructorInput({
        ccc: arbArgs.baseArgs.crossChainController,
        adapterToRemove: address(0),
        newAdapter: PREDICTED_ADDRESS
      })
    )
  {}

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
 * deploy-command: make deploy-pk contract=scripts/payloads/Deploy_ArbAdapter_Payload.s.sol:DeployArbitrumPayload chain=arbitrum_sepolia
 * verify-command: npx catapulta-verify -b broadcast/HyperlaneBridgeAdapterUpdateToV3_20240320.s.sol/42161/run-latest.json
 */
contract DeployArbitrumPayload is DeployArbAdapter {
  function run() public override {
    // @dev revision '1' will need to change depending on the revision of deployment configuration that we want to use
    // This could also be set on the make call ans env variable
    AddressesAndConfig memory configurations = _getAddressesAndConfigs(
      TestNetChainIds.ARBITRUM_SEPOLIA,
      '1',
      vm
    );

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

    vm.startBroadcast();
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      abi.encodePacked(type(AaveV3Arbitrum_New_Adapter_Payload).creationCode, abi.encode(arbArgs))
    );
    vm.stopBroadcast();
  }
}
