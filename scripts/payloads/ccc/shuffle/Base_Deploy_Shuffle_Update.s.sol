// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../../../BaseDeployerScript.sol';
import '../../../../src/ccc_payloads/shuffle/ShuffleCCCUpdatePayload.sol';
import 'adi-scripts/CCC/DeployCrossChainController.sol';

/**
 * @title Ethereum payload to update ccc with new shuffle mechanism
 * @author BGD Labs @bgdlabs
 * - Discussion:
 * - Snapshot:
 */
abstract contract Base_Deploy_Shuffle_Update_Payload is BaseDeployerScript, BaseCCCDeploy {
  function _deployPayload(
    address crossChainController,
    address proxyAdmin,
    address crossChainControllerImpl
  ) internal returns (address) {
    return
      new Add_Shuffle_to_CCC_Payload(crossChainController, proxyAdmin, crossChainControllerImpl);
  }

  function _execute(Addresses memory addresses) internal virtual override {
    addresses.crossChainControllerImpl = _deployCCCImpl();

    _deployPayload(
      addresses.crossChainController,
      addresses.proxyAdmin,
      addresses.crossChainControllerImpl
    );
  }
}
