// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import '../BaseDeployerScript.sol';
import 'adi/access_control/GranularGuardianAccessControl.sol';
import {GovernanceV3Polygon} from 'aave-address-book/GovernanceV3Polygon.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {GovernanceV3BNB} from 'aave-address-book/GovernanceV3BNB.sol';
import {GovernanceV3Gnosis} from 'aave-address-book/GovernanceV3Gnosis.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {GovernanceV3Optimism} from 'aave-address-book/GovernanceV3Optimism.sol';
import {GovernanceV3Scroll} from 'aave-address-book/GovernanceV3Scroll.sol';
import {GovernanceV3Metis} from 'aave-address-book/GovernanceV3Metis.sol';
import {GovernanceV3Base} from 'aave-address-book/GovernanceV3Base.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {MiscBNB} from 'aave-address-book/MiscBNB.sol';
import {MiscGnosis} from 'aave-address-book/MiscGnosis.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {MiscOptimism} from 'aave-address-book/MiscOptimism.sol';
import {MiscBase} from 'aave-address-book/MiscBase.sol';
import {MiscScroll} from 'aave-address-book/MiscScroll.sol';
import {MiscMetis} from 'aave-address-book/MiscMetis.sol';
import 'adi-scripts/access_control/Deploy_Granular_CCC_Guardian.sol';

abstract contract DeployGranularGuardian is BaseDeployerScript, BaseDeployGranularGuardian {
  function _execute(Addresses memory addresses) internal override {
    addresses.granularCCCGuardian = _deployGranularGuardian();
  }
}

contract Ethereum is DeployGranularGuardian {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function DEFAULT_ADMIN() internal pure override returns (address) {
    return MiscEthereum.PROTOCOL_GUARDIAN;
  }

  function RETRY_GUARDIAN() internal pure override returns (address) {
    return 0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF; // bgd guardian
  }

  function SOLVE_EMERGENCY_GUARDIAN() internal pure override returns (address) {
    return MiscEthereum.PROTOCOL_GUARDIAN;
  }

  function CROSS_CHAIN_CONTROLLER() internal pure override returns (address) {
    return GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER;
  }
}

contract Avalanche is DeployGranularGuardian {
  function DEFAULT_ADMIN() internal pure override returns (address) {
    return MiscAvalanche.PROTOCOL_GUARDIAN;
  }

  function RETRY_GUARDIAN() internal pure override returns (address) {
    return 0x3DBA1c4094BC0eE4772A05180B7E0c2F1cFD9c36; // bgd guardian
  }

  function SOLVE_EMERGENCY_GUARDIAN() internal pure override returns (address) {
    return MiscAvalanche.PROTOCOL_GUARDIAN;
  }

  function CROSS_CHAIN_CONTROLLER() internal pure override returns (address) {
    return GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.AVALANCHE;
  }
}

contract Polygon is DeployGranularGuardian {
  function DEFAULT_ADMIN() internal pure override returns (address) {
    return MiscPolygon.PROTOCOL_GUARDIAN;
  }

  function RETRY_GUARDIAN() internal pure override returns (address) {
    return 0xbCEB4f363f2666E2E8E430806F37e97C405c130b; // bgd guardian
  }

  function SOLVE_EMERGENCY_GUARDIAN() internal pure override returns (address) {
    return MiscPolygon.PROTOCOL_GUARDIAN;
  }

  function CROSS_CHAIN_CONTROLLER() internal pure override returns (address) {
    return GovernanceV3Polygon.CROSS_CHAIN_CONTROLLER;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.POLYGON;
  }
}

contract Binance is DeployGranularGuardian {
  function DEFAULT_ADMIN() internal pure override returns (address) {
    return MiscBNB.PROTOCOL_GUARDIAN;
  }

  function RETRY_GUARDIAN() internal pure override returns (address) {
    return 0xE8C5ab722d0b1B7316Cc4034f2BE91A5B1d29964; // bgd guardian
  }

  function SOLVE_EMERGENCY_GUARDIAN() internal pure override returns (address) {
    return MiscBNB.PROTOCOL_GUARDIAN;
  }

  function CROSS_CHAIN_CONTROLLER() internal pure override returns (address) {
    return GovernanceV3BNB.CROSS_CHAIN_CONTROLLER;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.BNB;
  }
}

contract Gnosis is DeployGranularGuardian {
  function DEFAULT_ADMIN() internal pure override returns (address) {
    return MiscGnosis.PROTOCOL_GUARDIAN;
  }

  function RETRY_GUARDIAN() internal pure override returns (address) {
    return 0xcb8a3E864D12190eD2b03cbA0833b15f2c314Ed8; // bgd guardian
  }

  function SOLVE_EMERGENCY_GUARDIAN() internal pure override returns (address) {
    return MiscGnosis.PROTOCOL_GUARDIAN;
  }

  function CROSS_CHAIN_CONTROLLER() internal pure override returns (address) {
    return GovernanceV3Gnosis.CROSS_CHAIN_CONTROLLER;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.GNOSIS;
  }
}

contract Metis is DeployGranularGuardian {
  function DEFAULT_ADMIN() internal pure override returns (address) {
    return MiscMetis.PROTOCOL_GUARDIAN;
  }

  function RETRY_GUARDIAN() internal pure override returns (address) {
    return 0x9853589F951D724D9f7c6724E0fD63F9d888C429; // bgd guardian
  }

  function SOLVE_EMERGENCY_GUARDIAN() internal pure override returns (address) {
    return MiscMetis.PROTOCOL_GUARDIAN;
  }

  function CROSS_CHAIN_CONTROLLER() internal pure override returns (address) {
    return GovernanceV3Metis.CROSS_CHAIN_CONTROLLER;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.METIS;
  }
}

contract Scroll is DeployGranularGuardian {
  function DEFAULT_ADMIN() internal pure override returns (address) {
    return MiscScroll.PROTOCOL_GUARDIAN;
  }

  function RETRY_GUARDIAN() internal pure override returns (address) {
    return 0x4aAa03F0A61cf93eA252e987b585453578108358; // bgd guardian
  }

  function SOLVE_EMERGENCY_GUARDIAN() internal pure override returns (address) {
    return MiscScroll.PROTOCOL_GUARDIAN;
  }

  function CROSS_CHAIN_CONTROLLER() internal pure override returns (address) {
    return GovernanceV3Scroll.CROSS_CHAIN_CONTROLLER;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.SCROLL;
  }
}

contract Optimism is DeployGranularGuardian {
  function DEFAULT_ADMIN() internal pure override returns (address) {
    return MiscOptimism.PROTOCOL_GUARDIAN;
  }

  function RETRY_GUARDIAN() internal pure override returns (address) {
    return 0x3A800fbDeAC82a4d9c68A9FA0a315e095129CDBF; // bgd guardian
  }

  function SOLVE_EMERGENCY_GUARDIAN() internal pure override returns (address) {
    return MiscOptimism.PROTOCOL_GUARDIAN;
  }

  function CROSS_CHAIN_CONTROLLER() internal pure override returns (address) {
    return GovernanceV3Optimism.CROSS_CHAIN_CONTROLLER;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.OPTIMISM;
  }
}

contract Arbitrum is DeployGranularGuardian {
  function DEFAULT_ADMIN() internal pure override returns (address) {
    return MiscArbitrum.PROTOCOL_GUARDIAN;
  }

  function RETRY_GUARDIAN() internal pure override returns (address) {
    return 0x1Fcd437D8a9a6ea68da858b78b6cf10E8E0bF959; // bgd guardian
  }

  function SOLVE_EMERGENCY_GUARDIAN() internal pure override returns (address) {
    return MiscArbitrum.PROTOCOL_GUARDIAN;
  }

  function CROSS_CHAIN_CONTROLLER() internal pure override returns (address) {
    return GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ARBITRUM;
  }
}

contract Base is DeployGranularGuardian {
  function DEFAULT_ADMIN() internal pure override returns (address) {
    return MiscBase.PROTOCOL_GUARDIAN;
  }

  function RETRY_GUARDIAN() internal pure override returns (address) {
    return 0x7FDA7C3528ad8f05e62148a700D456898b55f8d2; // bgd guardian
  }

  function SOLVE_EMERGENCY_GUARDIAN() internal pure override returns (address) {
    return MiscBase.PROTOCOL_GUARDIAN;
  }

  function CROSS_CHAIN_CONTROLLER() internal pure override returns (address) {
    return GovernanceV3Base.CROSS_CHAIN_CONTROLLER;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.BASE;
  }
}
