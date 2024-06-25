// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'aave-helpers/adi/BaseCCCUpdate.sol';
import {IReinitialize} from 'adi/revisions/update_to_rev_3/IReinitialize.sol';
import {ICrossChainForwarder} from 'adi/interfaces/ICrossChainForwarder.sol';

/**
 * @title Ethereum payload to update ccc with new shuffle mechanism
 * @author BGD Labs @bgdlabs
 * - Discussion:
 * - Snapshot:
 */
contract Add_Shuffle_to_CCC_Payload is BaseCCCUpdate {
  constructor(
    address crossChainController,
    address proxyAdmin,
    address newCCCImpl
  )
    BaseCCCUpdate(
      CCCUpdateArgs({
        crossChainController: crossChainController,
        proxyAdmin: proxyAdmin,
        newCCCImpl: newCCCImpl
      })
    )
  {}

  function getInitializeSignature() public pure override returns (bytes memory) {
    return
      abi.encodeWithSelector(
        IReinitialize.initializeRevision.selector,
        new ICrossChainForwarder.OptimalBandwidthByChain[](0) // TODO: this provably needs to be passed as param, as will depend on the network
      );
  }
}
