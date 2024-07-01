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
  ICrossChainForwarder.OptimalBandwidthByChain[] public optimalBandwidths;

  constructor(
    address crossChainController,
    address proxyAdmin,
    address newCCCImpl,
    ICrossChainForwarder.OptimalBandwidthByChain[] memory _optimalBandwidths
  )
    BaseCCCUpdate(
      CCCUpdateArgs({
        crossChainController: crossChainController,
        proxyAdmin: proxyAdmin,
        newCCCImpl: newCCCImpl
      })
    )
  {
    for (uint256 i = 0; i < _optimalBandwidths.length; i++) {
      optimalBandwidths[i] = _optimalBandwidths[i];
    }
  }

  function getInitializeSignature() public view override returns (bytes memory) {
    return abi.encodeWithSelector(IReinitialize.initializeRevision.selector, optimalBandwidths);
  }
}
