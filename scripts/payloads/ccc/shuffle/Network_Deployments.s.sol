// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './Base_Deploy_Shuffle_Update.s.sol';
import '../../../../src/ccc_payloads/shuffle/ShuffleCCCUpdatePayload.sol';
import {GovernanceV3Polygon} from 'aave-address-book/GovernanceV3Polygon.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {GovernanceV3BNB} from 'aave-address-book/GovernanceV3BNB.sol';
import {GovernanceV3Gnosis} from 'aave-address-book/GovernanceV3Gnosis.sol';

contract Ethereum is Base_Deploy_Shuffle_Update_Payload {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function _getShufflePayloadByteCode() internal pure override returns (bytes memory) {
    return type(Ethereum_Add_Shuffle_to_CCC_Payload).creationCode;
  }
}

contract Polygon is Base_Deploy_Shuffle_Update_Payload {
  function CL_EMERGENCY_ORACLE() internal pure override returns (address) {
    return GovernanceV3Polygon.CL_EMERGENCY_ORACLE;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.POLYGON;
  }

  function _getShufflePayloadByteCode() internal pure override returns (bytes memory) {
    return type(Polygon_Add_Shuffle_to_CCC_Payload).creationCode;
  }
}

contract Avalanche is Base_Deploy_Shuffle_Update_Payload {
  function CL_EMERGENCY_ORACLE() internal pure override returns (address) {
    return GovernanceV3Avalanche.CL_EMERGENCY_ORACLE;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.AVALANCHE;
  }

  function _getShufflePayloadByteCode() internal pure override returns (bytes memory) {
    return type(Avalanche_Add_Shuffle_to_CCC_Payload).creationCode;
  }
}

contract Arbitrum is Base_Deploy_Shuffle_Update_Payload {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ARBITRUM;
  }

  function _getShufflePayloadByteCode() internal pure override returns (bytes memory) {
    return type(Arbitrum_Add_Shuffle_to_CCC_Payload).creationCode;
  }
}

contract Optimism is Base_Deploy_Shuffle_Update_Payload {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.OPTIMISM;
  }

  function _getShufflePayloadByteCode() internal pure override returns (bytes memory) {
    return type(Optimism_Add_Shuffle_to_CCC_Payload).creationCode;
  }
}

contract Metis is Base_Deploy_Shuffle_Update_Payload {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.METIS;
  }

  function _getShufflePayloadByteCode() internal pure override returns (bytes memory) {
    return type(Metis_Add_Shuffle_to_CCC_Payload).creationCode;
  }
}

contract Binance is Base_Deploy_Shuffle_Update_Payload {
  function CL_EMERGENCY_ORACLE() internal pure override returns (address) {
    return GovernanceV3BNB.CL_EMERGENCY_ORACLE;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.BNB;
  }

  function _getShufflePayloadByteCode() internal pure override returns (bytes memory) {
    return type(Binance_Add_Shuffle_to_CCC_Payload).creationCode;
  }
}

contract Base is Base_Deploy_Shuffle_Update_Payload {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.BASE;
  }

  function _getShufflePayloadByteCode() internal pure override returns (bytes memory) {
    return type(Base_Add_Shuffle_to_CCC_Payload).creationCode;
  }
}

contract Gnosis is Base_Deploy_Shuffle_Update_Payload {
  function CL_EMERGENCY_ORACLE() internal pure override returns (address) {
    return GovernanceV3Gnosis.CL_EMERGENCY_ORACLE;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.GNOSIS;
  }

  function _getShufflePayloadByteCode() internal pure override returns (bytes memory) {
    return type(Gnosis_Add_Shuffle_to_CCC_Payload).creationCode;
  }
}

contract Scroll is Base_Deploy_Shuffle_Update_Payload {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.SCROLL;
  }

  function _getShufflePayloadByteCode() internal pure override returns (bytes memory) {
    return type(Scroll_Add_Shuffle_to_CCC_Payload).creationCode;
  }
}
