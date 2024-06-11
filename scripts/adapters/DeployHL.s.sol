// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import 'adi-scripts/Adapters/DeployHL.sol';
import '../BaseDeployerScript.sol';

abstract contract DeployHLAdapter is BaseDeployerScript, BaseHLAdapter {
  function _execute(Addresses memory addresses) internal override {
    addresses.hlAdapter = _deployAdapter(addresses.crossChainController);
  }
}

contract Ethereum is DeployHLAdapter {
  function HL_MAIL_BOX() internal pure override returns (address) {
    return 0xc005dc82818d67AF737725bD4bf75435d065D239;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](2);
    networks[0] = ChainIds.POLYGON;
    networks[1] = ChainIds.AVALANCHE;
    return networks;
  }
}

contract Ethereum_testnet is DeployHLAdapter {
  function HL_MAIL_BOX() internal pure override returns (address) {
    return 0xfFAEF09B3cd11D9b20d1a19bECca54EEC2884766;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.ETHEREUM_SEPOLIA;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](2);
    networks[0] = TestNetChainIds.POLYGON_AMOY;
    networks[1] = TestNetChainIds.AVALANCHE_FUJI;
    return networks;
  }
}

contract Avalanche is DeployHLAdapter {
  function HL_MAIL_BOX() internal pure override returns (address) {
    return 0xFf06aFcaABaDDd1fb08371f9ccA15D73D51FeBD6;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.AVALANCHE;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = ChainIds.ETHEREUM;
    return networks;
  }
}

contract Avalanche_testnet is DeployHLAdapter {
  function HL_MAIL_BOX() internal pure override returns (address) {
    return 0x5b6CFf85442B851A8e6eaBd2A4E4507B5135B3B0;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.AVALANCHE_FUJI;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = TestNetChainIds.ETHEREUM_SEPOLIA;
    return networks;
  }
}

contract Polygon is DeployHLAdapter {
  function HL_MAIL_BOX() internal pure override returns (address) {
    return 0x5d934f4e2f797775e53561bB72aca21ba36B96BB;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.POLYGON;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = ChainIds.ETHEREUM;
    return networks;
  }
}

contract Polygon_testnet is DeployHLAdapter {
  function HL_MAIL_BOX() internal pure override returns (address) {
    return 0x2d1889fe5B092CD988972261434F7E5f26041115;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.POLYGON_AMOY;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = TestNetChainIds.ETHEREUM_SEPOLIA;
    return networks;
  }
}

contract Binance is DeployHLAdapter {
  function HL_MAIL_BOX() internal pure override returns (address) {
    return 0x2971b9Aec44bE4eb673DF1B88cDB57b96eefe8a4;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.BNB;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = ChainIds.ETHEREUM;
    return networks;
  }
}

contract Binance_testnet is DeployHLAdapter {
  function HL_MAIL_BOX() internal pure override returns (address) {
    return 0xF9F6F5646F478d5ab4e20B0F910C92F1CCC9Cc6D;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.BNB_TESTNET;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = TestNetChainIds.ETHEREUM_SEPOLIA;
    return networks;
  }
}

contract Gnosis is DeployHLAdapter {
  function HL_MAIL_BOX() internal pure override returns (address) {
    return 0xaD09d78f4c6b9dA2Ae82b1D34107802d380Bb74f;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.GNOSIS;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = ChainIds.ETHEREUM;
    return networks;
  }
}

contract Celo is DeployHLAdapter {
  function HL_MAIL_BOX() internal pure override returns (address) {
    return 0x50da3B3907A08a24fe4999F4Dcf337E8dC7954bb;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.CELO;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = TestNetChainIds.ETHEREUM_SEPOLIA;
    return networks;
  }
}

contract Celo_testnet is DeployHLAdapter {
  function HL_MAIL_BOX() internal pure override returns (address) {
    return 0xEf9F292fcEBC3848bF4bB92a96a04F9ECBb78E59;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.CELO_ALFAJORES;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = TestNetChainIds.ETHEREUM_SEPOLIA;
    return networks;
  }
}
