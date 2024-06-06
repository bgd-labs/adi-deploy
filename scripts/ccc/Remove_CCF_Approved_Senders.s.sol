// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {ICrossChainForwarder} from 'adi/interfaces/ICrossChainForwarder.sol';
import '../BaseDeployerScript.sol';

/**
 * @notice This script needs to be implemented from where the senders are known
 */
abstract contract BaseRemoveCCFApprovedSenders is BaseDeployerScript {
  function getSendersToRemove() public virtual returns (address[] memory);

  function _execute(Addresses memory addresses) internal override {
    ICrossChainForwarder(addresses.crossChainController).removeSenders(getSendersToRemove());
  }
}