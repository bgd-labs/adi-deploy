// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SimpleReceiverAdapterUpdate} from 'aave-helpers/adi/SimpleReceiverAdapterUpdate.sol';
import {TestNetChainIds} from 'adi-scripts/contract_extensions/TestNetChainIds.sol';

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
