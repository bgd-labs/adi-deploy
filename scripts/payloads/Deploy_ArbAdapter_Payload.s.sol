// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SimpleReceiverAdapterUpdate} from 'aave-helpers/adi/SimpleReceiverAdapterUpdate.sol';
import {ArbAdapterDeploymentHelper, BaseAdapterStructs} from 'adi-scripts/Adapters/DeployArbAdapter.sol';
import {TestNetChainIds} from 'adi-scripts/contract_extensions/TestNetChainIds.sol';
import {IBaseAdapter} from 'adi/adapters/IBaseAdapter.sol';
import {DeployArbAdapter} from '../adapters/DeployArbAdapter.s.sol';
import {Create2Utils} from 'aave-helpers/ScriptUtils.sol';

//import {ChainIds} from 'aave-helpers/ChainIds.sol';

/**
 * @title Arbitrum bridge adapter update example
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/31
 */
contract AaveV3Arbitrum_New_Adapter_Payload is SimpleReceiverAdapterUpdate {
  constructor(
    address crossChainController,
    address newAdapter
  )
    SimpleReceiverAdapterUpdate(
      SimpleReceiverAdapterUpdate.ConstructorInput({
        ccc: crossChainController,
        adapterToRemove: address(0),
        newAdapter: newAdapter
      })
    )
  {}

  function getChainsToReceive() public pure override returns (uint256[] memory) {
    uint256[] memory chains = new uint256[](1);
    chains[0] = TestNetChainIds.ETHEREUM_SEPOLIA;
    return chains;
  }
}

/**
 * @dev Deploy Arbitrum
 * deploy-command: make deploy-pk contract=scripts/payloads/Deploy_ArbAdapter_Payload.s.sol:DeployArbitrumPayload chain=arbitrum_sepolia
 * verify-command: npx catapulta-verify -b broadcast/HyperlaneBridgeAdapterUpdateToV3_20240320.s.sol/42161/run-latest.json
 */
contract DeployArbitrumPayload is DeployArbAdapter {
  function run() public override {
    vm.startBroadcast();

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

    bytes memory adapterCode = ArbAdapterDeploymentHelper.getAdapterCode(arbArgs);

    address newAdapter = Create2Utils.computeCreate2Address(
      keccak256(abi.encode(configurations.config.adapters.arbitrumAdapter.salt)),
      adapterCode
    );

    // deploy payloads
    new AaveV3Arbitrum_New_Adapter_Payload(crossChainController, newAdapter);

    vm.stopBroadcast();
  }
}
