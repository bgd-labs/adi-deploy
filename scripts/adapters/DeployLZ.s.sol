// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import 'adi-scripts/Adapters/DeployLZ.sol';
import '../BaseDeployerScript.sol';

abstract contract DeployLZAdapter is BaseDeployerScript, BaseLZAdapter {
  function _execute(Addresses memory addresses) internal override {
    addresses.lzAdapter = _deployAdapter(addresses.crossChainController);
  }
}

contract Ethereum is DeployLZAdapter {
  function LZ_ENDPOINT() internal pure override returns (address) {
    return 0x1a44076050125825900e736c501f859c50fE728c;
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

contract Ethereum_testnet is DeployLZAdapter {
  function LZ_ENDPOINT() internal pure override returns (address) {
    return 0x6EDCE65403992e310A62460808c4b910D972f10f;
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

  function isTestnet() internal pure override returns (bool) {
    return true;
  }
}

contract Avalanche is DeployLZAdapter {
  function LZ_ENDPOINT() internal pure override returns (address) {
    return 0x1a44076050125825900e736c501f859c50fE728c;
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

contract Avalanche_testnet is DeployLZAdapter {
  function LZ_ENDPOINT() internal pure override returns (address) {
    return 0x6EDCE65403992e310A62460808c4b910D972f10f;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.AVALANCHE_FUJI;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = TestNetChainIds.ETHEREUM_SEPOLIA;
    return networks;
  }

  function isTestnet() internal pure override returns (bool) {
    return true;
  }
}

contract Polygon is DeployLZAdapter {
  function LZ_ENDPOINT() internal pure override returns (address) {
    return 0x1a44076050125825900e736c501f859c50fE728c;
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

contract Polygon_testnet is DeployLZAdapter {
  function LZ_ENDPOINT() internal pure override returns (address) {
    return 0x6EDCE65403992e310A62460808c4b910D972f10f;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.POLYGON_AMOY;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = TestNetChainIds.ETHEREUM_SEPOLIA;
    return networks;
  }

  function isTestnet() internal pure override returns (bool) {
    return true;
  }
}

contract Binance is DeployLZAdapter {
  function LZ_ENDPOINT() internal pure override returns (address) {
    return 0x1a44076050125825900e736c501f859c50fE728c;
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

contract Binance_testnet is DeployLZAdapter {
  function LZ_ENDPOINT() internal pure override returns (address) {
    return 0x6EDCE65403992e310A62460808c4b910D972f10f;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.BNB_TESTNET;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = TestNetChainIds.ETHEREUM_SEPOLIA;
    return networks;
  }

  function isTestnet() internal pure override returns (bool) {
    return true;
  }
}

contract Gnosis is DeployLZAdapter {
  function LZ_ENDPOINT() internal pure override returns (address) {
    return 0x1a44076050125825900e736c501f859c50fE728c;
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

contract Gnosis_testnet is DeployLZAdapter {
  function LZ_ENDPOINT() internal pure override returns (address) {
    return 0x6EDCE65403992e310A62460808c4b910D972f10f;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.GNOSIS_CHIADO;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = TestNetChainIds.ETHEREUM_SEPOLIA;
    return networks;
  }

  function isTestnet() internal pure override returns (bool) {
    return true;
  }
}

contract Celo is DeployLZAdapter {
  function LZ_ENDPOINT() internal pure override returns (address) {
    return 0x1a44076050125825900e736c501f859c50fE728c;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.CELO;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = ChainIds.ETHEREUM;
    return networks;
  }
}

contract Celo_testnet is DeployLZAdapter {
  function LZ_ENDPOINT() internal pure override returns (address) {
    return 0x6EDCE65403992e310A62460808c4b910D972f10f;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.CELO_ALFAJORES;
  }

  function REMOTE_NETWORKS() internal pure override returns (uint256[] memory) {
    uint256[] memory networks = new uint256[](1);
    networks[0] = TestNetChainIds.ETHEREUM_SEPOLIA;
    return networks;
  }

  function isTestnet() internal pure override returns (bool) {
    return true;
  }
}
