// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../../../BaseDeployerScript.sol';
import '../../../../src/ccc_payloads/shuffle/ShuffleCCCUpdatePayload.sol';
import 'adi-scripts/CCC/DeployCrossChainController.sol';
import {CrossChainController} from 'adi/revisions/update_to_rev_3/CrossChainController.sol';
import {CrossChainControllerWithEmergencyMode} from 'adi/revisions/update_to_rev_3/CrossChainControllerWithEmergencyMode.sol';

// Library to get the code of ccc revision 3 (shuffle)
library CCCUpdateDeploymentHelper {
  function getCCCImplCode(address emergencyOracle) internal pure returns (bytes memory) {
    bytes memory cccImplCode = emergencyOracle == address(0)
      ? abi.encodePacked(type(CrossChainController).creationCode, abi.encode())
      : abi.encodePacked(
        type(CrossChainControllerWithEmergencyMode).creationCode,
        abi.encode(emergencyOracle)
      );

    return cccImplCode;
  }
}

/**
 * @title Ethereum payload to update ccc with new shuffle mechanism
 * @author BGD Labs @bgdlabs
 * - Discussion:
 * - Snapshot:
 */
abstract contract Base_Deploy_Shuffle_Update_Payload is BaseDeployerScript, BaseCCCDeploy {
  function _getOptimalBandwidths()
    internal
    pure
    virtual
    returns (ICrossChainForwarder.OptimalBandwidthByChain[] memory)
  {
    return new ICrossChainForwarder.OptimalBandwidthByChain[](0);
  }

  function _deployPayload(
    address crossChainController,
    address proxyAdmin,
    address crossChainControllerImpl
  ) internal returns (Add_Shuffle_to_CCC_Payload) {
    // TODO: provably makes sense to also deploy with create2 here
    return
      new Add_Shuffle_to_CCC_Payload(
        crossChainController,
        proxyAdmin,
        crossChainControllerImpl,
        _getOptimalBandwidths()
      );
  }

  function _deployCCCImpl() internal virtual override returns (address) {
    bytes memory cccCode = CCCUpdateDeploymentHelper.getCCCImplCode(CL_EMERGENCY_ORACLE());

    return _deployByteCode(cccCode, SALT());
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
