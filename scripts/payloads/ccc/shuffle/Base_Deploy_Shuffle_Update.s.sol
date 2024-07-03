// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../../../BaseDeployerScript.sol';
import 'adi-scripts/CCC/DeployCrossChainController.sol';
import {CrossChainControllerUpgradeRev3} from 'adi/revisions/update_to_rev_3/CrossChainController.sol';
import {CrossChainControllerWithEmergencyModeUpgradeRev3} from 'adi/revisions/update_to_rev_3/CrossChainControllerWithEmergencyMode.sol';
import {CCCUpdateArgs} from 'aave-helpers/adi/BaseCCCUpdate.sol';

// Library to get the code of ccc revision 3 (shuffle)
library CCCUpdateDeploymentHelper {
  function getCCCImplCode(address emergencyOracle) internal pure returns (bytes memory) {
    bytes memory cccImplCode = emergencyOracle == address(0)
      ? abi.encodePacked(type(CrossChainControllerUpgradeRev3).creationCode, abi.encode())
      : abi.encodePacked(
        type(CrossChainControllerWithEmergencyModeUpgradeRev3).creationCode,
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
  function _getShufflePayloadByteCode() internal virtual returns (bytes memory);

  function _deployPayload(
    address crossChainController,
    address proxyAdmin,
    address crossChainControllerImpl
  ) internal returns (address) {
    bytes memory adapterCode = abi.encodePacked(
      _getShufflePayloadByteCode(),
      abi.encode(
        CCCUpdateArgs({
          crossChainController: crossChainController,
          proxyAdmin: proxyAdmin,
          crossChainControllerImpl: crossChainControllerImpl
        })
      )
    );

    return _deployByteCode(adapterCode, 'CCC Shuffle Update Payload');
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
