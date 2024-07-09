// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../../../BaseDeployerScript.sol';
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
abstract contract Base_Deploy_Shuffle_Update_Payload is BaseDeployerScript {
  function _getShufflePayloadByteCode() internal virtual returns (bytes memory);

  function CL_EMERGENCY_ORACLE() internal view virtual returns (address) {
    return address(0);
  }

  function SALT() internal pure virtual returns (string memory) {
    return 'a.DI CrossChainController';
  }

  function PAYLOAD_SALT() internal pure virtual returns (string memory) {
    return 'CrossChainController Shuffle Update Payload';
  }

  function _deployPayload(
    address crossChainController,
    address proxyAdmin,
    address crossChainControllerImpl
  ) internal returns (address) {
    bytes memory payloadCode = abi.encodePacked(
      _getShufflePayloadByteCode(),
      abi.encode(
        CCCUpdateArgs({
          crossChainController: crossChainController,
          proxyAdmin: proxyAdmin,
          crossChainControllerImpl: crossChainControllerImpl
        })
      )
    );

    return _deployByteCode(payloadCode, PAYLOAD_SALT());
  }

  function _deployCrossChainControllerImpl() internal returns (address) {
    bytes memory cccImplCode = CCCUpdateDeploymentHelper.getCCCImplCode(CL_EMERGENCY_ORACLE());

    return _deployByteCode(cccImplCode, SALT());
  }

  function _execute(Addresses memory addresses) internal virtual override {
    addresses.crossChainControllerImpl = _deployCrossChainControllerImpl();
    _deployPayload(
      addresses.crossChainController,
      addresses.proxyAdmin,
      addresses.crossChainControllerImpl
    );
  }
}
