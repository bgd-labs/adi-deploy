// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'aave-helpers/adi/BaseCCCUpdate.sol';
import {IReinitialize} from 'adi/revisions/update_to_rev_3/IReinitialize.sol';
import {ICrossChainForwarder} from 'adi/interfaces/ICrossChainForwarder.sol';
import 'forge-std/console.sol';

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
    address newCCCImpl,
    ICrossChainForwarder.OptimalBandwidthByChain[] memory optimalBandwidths
  )
    BaseCCCUpdate(
      CCCUpdateArgs({
        crossChainController: crossChainController,
        proxyAdmin: proxyAdmin,
        newCCCImpl: newCCCImpl
      })
    )
  {
    console.log('------', optimalBandwidths.length);
    initializeSignature = abi.encodeWithSelector(
      IReinitialize.initializeRevision.selector,
      optimalBandwidths
    );
    console.log('-----asdfasdfaf');
    console.logBytes(initializeSignature);
  }
}
