// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {ADITestBase, ChainIds} from 'aave-helpers/adi/test/ADITestBase.sol';
import {AaveV3Arbitrum_New_Adapter_Payload} from '../../scripts/payloads/ArbAdapterPayload.sol';
import {ArbAdapterDeploymentHelper, BaseAdapterStructs} from 'adi-scripts/Adapters/DeployArbAdapter.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {DeployArbitrumPayload, Create2Utils} from '../../scripts/payloads/Deploy_ArbAdapter_Payload.s.sol';
import {IBaseAdapter} from 'adi/adapters/IBaseAdapter.sol';

// provably here we should just define the blockNumber and network. And use base test that in theory could generate diffs
contract ArbAdapterUpdatePayloadTest is ADITestBase, DeployArbitrumPayload {
  AaveV3Arbitrum_New_Adapter_Payload public payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 211127276);

    (
      address crossChainController,
      address newAdapter,
      bytes32 salt,
      bytes memory bytecode
    ) = _getPayloadArgs(ChainIds.ARBITRUM, '1');

    Create2Utils.create2Deploy(salt, bytecode);

    // deploy payload
    payload = new AaveV3Arbitrum_New_Adapter_Payload(crossChainController, newAdapter);
  }

  function test_defaultTest() public {
    defaultTest(
      'test_adi_diffs',
      GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER,
      address(payload),
      true
    );
  }
}
