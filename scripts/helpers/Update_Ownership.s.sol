// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// This Scripts change the ownership of the V3 contracts from Deployer to the correct addresses. For most of the cases
// ownership will be changed to executor lvl1, and guardian to the aave safes. BGD will mantain for now the guardian of aDI
// Effects of executing this changes on tenderly fork can be found here: https://github.com/bgd-labs/aave-permissions-list/pull/42

import {ZkSyncScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {OwnableWithGuardian} from 'solidity-utils/contracts/access-control/OwnableWithGuardian.sol';
import {Ownable} from 'solidity-utils/contracts/oz-common/Ownable.sol';
import {IWithGuardian} from 'solidity-utils/contracts/access-control/interfaces/IWithGuardian.sol';
import {GovernanceV3ZkSync} from 'aave-address-book/AaveAddressBook.sol';
import {ICrossChainForwarder} from 'aave-delivery-infrastructure/contracts/interfaces/ICrossChainForwarder.sol';

// Effects of executing this changes on tenderly fork can be found here: https://github.com/bgd-labs/aave-permissions-list/pull/42

abstract contract UpdateV3Permissions {
  function targetOwner() public pure virtual returns (address);

  function targetGovernanceGuardian() public pure virtual returns (address);

  function targetADIGuardian() public pure virtual returns (address);

  function govContractsToUpdate() public pure virtual returns (address[] memory);

  function aDIContractsToUpdate() public pure virtual returns (address[] memory);

  // @dev should be set not to 0x0 if requires removal of msg.sender from allowed senders
  function CROSS_CHAIN_CONTROLLER() public pure virtual returns (address) {
    return address(0);
  }

  function _changeOwnerAndGuardian(
    address owner,
    address guardian,
    address[] memory contracts
  ) internal {
    require(owner != address(0), 'NEW_OWNER_CANT_BE_0');
    require(guardian != address(0), 'NEW_GUARDIAN_CANT_BE_0');

    for (uint256 i = 0; i < contracts.length; i++) {
      OwnableWithGuardian contractWithAC = OwnableWithGuardian(contracts[i]);
      try contractWithAC.guardian() returns (address currentGuardian) {
        if (currentGuardian != guardian) {
          IWithGuardian(contracts[i]).updateGuardian(guardian);
        }
      } catch {}
      if (contractWithAC.owner() != owner) {
        contractWithAC.transferOwnership(owner);
      }
    }
  }

  function _changeOwnerAndGuardian() internal {
    _changeOwnerAndGuardian(targetOwner(), targetGovernanceGuardian(), govContractsToUpdate());
    _changeOwnerAndGuardian(targetOwner(), targetADIGuardian(), aDIContractsToUpdate());
  }
}

contract UpdateV3ContractsPermissionsZkSync is UpdateV3Permissions {
  function targetOwner() public pure override returns (address) {
    return GovernanceV3ZkSync.EXECUTOR_LVL_1;
  }

  function targetADIGuardian() public pure override returns (address) {
    return GovernanceV3ZkSync.GRANULAR_GUARDIAN;
  }

  function targetGovernanceGuardian() public pure override returns (address) {
    return GovernanceV3ZkSync.GOVERNANCE_GUARDIAN;
  }

  function govContractsToUpdate() public pure override returns (address[] memory) {
    address[] memory contracts = new address[](1);
    contracts[0] = address(GovernanceV3ZkSync.PAYLOADS_CONTROLLER);
    return contracts;
  }

  function aDIContractsToUpdate() public pure override returns (address[] memory) {
    address[] memory contracts = new address[](1);
    contracts[0] = GovernanceV3ZkSync.CROSS_CHAIN_CONTROLLER;
    return contracts;
  }
}

contract ZkSync is ZkSyncScript, UpdateV3ContractsPermissionsZkSync {
  function run() external {
    vm.startBroadcast();
    _changeOwnerAndGuardian();
    vm.stopBroadcast();
  }
}
