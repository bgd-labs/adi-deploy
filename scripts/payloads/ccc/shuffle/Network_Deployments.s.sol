// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './Base_Deploy_Shuffle_Update.s.sol';
import '../../../../src/ccc_payloads/shuffle/ShuffleCCCUpdatePayload.sol';

contract Ethereum is Base_Deploy_Shuffle_Update_Payload {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function _getShufflePayloadByteCode() internal override returns (bytes memory) {
    return type(Ethereum_Add_Shuffle_to_CCC_Payload).creationCode;
  }
}

contract Polygon is Base_Deploy_Shuffle_Update_Payload {
  function CL_EMERGENCY_ORACLE() internal pure override returns (address) {
    return 0xDAFA1989A504c48Ee20a582f2891eeB25E2fA23F;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.POLYGON;
  }

  function _getShufflePayloadByteCode() internal override returns (bytes memory) {
    return type(Polygon_Add_Shuffle_to_CCC_Payload).creationCode;
  }
}

contract Avalanche is Base_Deploy_Shuffle_Update_Payload {
  function CL_EMERGENCY_ORACLE() internal pure override returns (address) {
    return 0x41185495Bc8297a65DC46f94001DC7233775EbEe;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.AVALANCHE;
  }

  function _getShufflePayloadByteCode() internal override returns (bytes memory) {
    return type(Avalanche_Add_Shuffle_to_CCC_Payload).creationCode;
  }
}

contract Arbitrum is Base_Deploy_Shuffle_Update_Payload {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ARBITRUM;
  }

  function _getShufflePayloadByteCode() internal override returns (bytes memory) {
    return type(Arbitrum_Add_Shuffle_to_CCC_Payload).creationCode;
  }
}

contract Optimism is Base_Deploy_Shuffle_Update_Payload {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.OPTIMISM;
  }

  function _getShufflePayloadByteCode() internal override returns (bytes memory) {
    return type(Optimism_Add_Shuffle_to_CCC_Payload).creationCode;
  }
}

contract Metis is Base_Deploy_Shuffle_Update_Payload {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.METIS;
  }

  function _getShufflePayloadByteCode() internal override returns (bytes memory) {
    return type(Metis_Add_Shuffle_to_CCC_Payload).creationCode;
  }
}

contract Binance is Base_Deploy_Shuffle_Update_Payload {
  function CL_EMERGENCY_ORACLE() internal pure override returns (address) {
    return 0xcabb46FfB38c93348Df16558DF156e9f68F9F7F1;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.BNB;
  }

  function _getShufflePayloadByteCode() internal override returns (bytes memory) {
    return type(Binance_Add_Shuffle_to_CCC_Payload).creationCode;
  }
}

contract Base is Base_Deploy_Shuffle_Update_Payload {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.BASE;
  }

  function _getShufflePayloadByteCode() internal override returns (bytes memory) {
    return type(Base_Add_Shuffle_to_CCC_Payload).creationCode;
  }
}

contract Gnosis is Base_Deploy_Shuffle_Update_Payload {
  function CL_EMERGENCY_ORACLE() internal pure override returns (address) {
    return 0xF937ffAeA1363e4Fa260760bDFA2aA8Fc911F84D;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.GNOSIS;
  }

  function _getShufflePayloadByteCode() internal override returns (bytes memory) {
    return type(Gnosis_Add_Shuffle_to_CCC_Payload).creationCode;
  }
}

contract Scroll is Base_Deploy_Shuffle_Update_Payload {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.SCROLL;
  }

  function _getShufflePayloadByteCode() internal override returns (bytes memory) {
    return type(Scroll_Add_Shuffle_to_CCC_Payload).creationCode;
  }
}

contract Celo is Base_Deploy_Shuffle_Update_Payload {
  function CL_EMERGENCY_ORACLE() internal pure override returns (address) {
    return 0x91b21900E91CD302EBeD05E45D8f270ddAED944d;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.CELO;
  }

  function _getShufflePayloadByteCode() internal override returns (bytes memory) {
    return type(Celo_Add_Shuffle_to_CCC_Payload).creationCode;
  }
}
