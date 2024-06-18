// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import 'adi/access_control/GranularGuardianAccessControl.sol';
import 'adi-scripts/access_control/Deploy_Granular_CCC_Guardian.sol';
import '../BaseDeployerScript.sol';

abstract contract DeployGranularGuardian is BaseDeployerScript, BaseDeployGranularGuardian {
  function _execute(Addresses memory addresses) internal override {
    addresses.granularCCCGuardian = _deployGranularGuardian(addresses.crossChainController);
  }
}
