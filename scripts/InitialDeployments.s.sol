// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import './BaseDeployerScript.sol';
import {TransparentProxyFactory} from 'solidity-utils/contracts/transparent-proxy/TransparentProxyFactory.sol';
import {MiscArbitrum, MiscAvalanche, MiscBase, MiscEthereum, MiscOptimism, MiscPolygon, MiscMetis, MiscGnosis, MiscBNB, MiscScroll, MiscPolygonZkEvm} from 'aave-address-book/AaveAddressBook.sol';

abstract contract BaseInitialDeployment is BaseDeployerScript {
  function OWNER() internal virtual returns (address) {
    return address(msg.sender); // as first owner we set deployer, this way its easier to configure
  }

  function GUARDIAN() internal virtual returns (address) {
    return address(msg.sender);
  }

  function TRANSPARENT_PROXY_FACTORY() internal pure virtual returns (address) {
    return address(0);
  }

  function PROXY_ADMIN() internal virtual returns (address) {
    return address(0);
  }

  function SALT() internal pure returns (string memory) {
    return 'Proxy Admin';
  }

  function _execute(Addresses memory addresses) internal override {
    addresses.proxyFactory = TRANSPARENT_PROXY_FACTORY() == address(0)
      ? address(new TransparentProxyFactory())
      : TRANSPARENT_PROXY_FACTORY();
    addresses.proxyAdmin = PROXY_ADMIN() == address(0)
      ? TransparentProxyFactory(addresses.proxyFactory).createDeterministicProxyAdmin(
        OWNER(),
        keccak256(abi.encode(SALT()))
      )
      : PROXY_ADMIN();
    addresses.owner = OWNER();
    addresses.guardian = GUARDIAN();
  }
}

contract Ethereum is BaseInitialDeployment {
  function TRANSPARENT_PROXY_FACTORY() internal pure override returns (address) {
    return MiscEthereum.TRANSPARENT_PROXY_FACTORY;
  }

  function PROXY_ADMIN() internal pure override returns (address) {
    return MiscEthereum.PROXY_ADMIN;
  }

  function GUARDIAN() internal pure override returns (address) {
    return MiscEthereum.PROTOCOL_GUARDIAN;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }
}

contract Polygon is BaseInitialDeployment {
  function TRANSPARENT_PROXY_FACTORY() internal pure override returns (address) {
    return MiscPolygon.TRANSPARENT_PROXY_FACTORY;
  }

  function PROXY_ADMIN() internal pure override returns (address) {
    return MiscPolygon.PROXY_ADMIN;
  }

  function GUARDIAN() internal pure override returns (address) {
    return MiscPolygon.PROTOCOL_GUARDIAN;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.POLYGON;
  }
}

contract Avalanche is BaseInitialDeployment {
  function TRANSPARENT_PROXY_FACTORY() internal pure override returns (address) {
    return MiscAvalanche.TRANSPARENT_PROXY_FACTORY;
  }

  function PROXY_ADMIN() internal pure override returns (address) {
    return MiscAvalanche.PROXY_ADMIN;
  }

  function GUARDIAN() internal pure override returns (address) {
    return MiscAvalanche.PROTOCOL_GUARDIAN;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.AVALANCHE;
  }
}

contract Optimism is BaseInitialDeployment {
  function TRANSPARENT_PROXY_FACTORY() internal pure override returns (address) {
    return MiscOptimism.TRANSPARENT_PROXY_FACTORY;
  }

  function PROXY_ADMIN() internal pure override returns (address) {
    return MiscOptimism.PROXY_ADMIN;
  }

  function GUARDIAN() internal pure override returns (address) {
    return MiscOptimism.PROTOCOL_GUARDIAN;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.OPTIMISM;
  }
}

contract Arbitrum is BaseInitialDeployment {
  function TRANSPARENT_PROXY_FACTORY() internal pure override returns (address) {
    return MiscArbitrum.TRANSPARENT_PROXY_FACTORY;
  }

  function PROXY_ADMIN() internal pure override returns (address) {
    return MiscArbitrum.PROXY_ADMIN;
  }

  function GUARDIAN() internal pure override returns (address) {
    return MiscArbitrum.PROTOCOL_GUARDIAN;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ARBITRUM;
  }
}

contract Metis is BaseInitialDeployment {
  function TRANSPARENT_PROXY_FACTORY() internal pure override returns (address) {
    return MiscMetis.TRANSPARENT_PROXY_FACTORY;
  }

  function PROXY_ADMIN() internal pure override returns (address) {
    return MiscMetis.PROXY_ADMIN;
  }

  function GUARDIAN() internal pure override returns (address) {
    return MiscMetis.PROTOCOL_GUARDIAN;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.METIS;
  }
}

contract Binance is BaseInitialDeployment {
  function TRANSPARENT_PROXY_FACTORY() internal pure override returns (address) {
    return MiscBNB.TRANSPARENT_PROXY_FACTORY;
  }

  function PROXY_ADMIN() internal pure override returns (address) {
    return MiscBNB.PROXY_ADMIN;
  }

  function GUARDIAN() internal pure override returns (address) {
    return MiscBNB.PROTOCOL_GUARDIAN;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.BNB;
  }
}

contract Gnosis is BaseInitialDeployment {
  function TRANSPARENT_PROXY_FACTORY() internal pure override returns (address) {
    return MiscGnosis.TRANSPARENT_PROXY_FACTORY;
  }

  function PROXY_ADMIN() internal pure override returns (address) {
    return MiscGnosis.PROXY_ADMIN;
  }

  function GUARDIAN() internal pure override returns (address) {
    return MiscGnosis.PROTOCOL_GUARDIAN;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.GNOSIS;
  }
}

contract Base is BaseInitialDeployment {
  function TRANSPARENT_PROXY_FACTORY() internal pure override returns (address) {
    return MiscBase.TRANSPARENT_PROXY_FACTORY;
  }

  function PROXY_ADMIN() internal pure override returns (address) {
    return MiscBase.PROXY_ADMIN;
  }

  function GUARDIAN() internal pure override returns (address) {
    return MiscBase.PROTOCOL_GUARDIAN;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.BASE;
  }
}

contract Scroll is BaseInitialDeployment {
  function TRANSPARENT_PROXY_FACTORY() internal pure override returns (address) {
    return MiscScroll.TRANSPARENT_PROXY_FACTORY;
  }

  function PROXY_ADMIN() internal pure override returns (address) {
    return MiscScroll.PROXY_ADMIN;
  }

  function GUARDIAN() internal pure override returns (address) {
    return MiscScroll.PROTOCOL_GUARDIAN;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.SCROLL;
  }
}

contract Zkevm is BaseInitialDeployment {
  function TRANSPARENT_PROXY_FACTORY() internal pure override returns (address) {
    return MiscPolygonZkEvm.TRANSPARENT_PROXY_FACTORY;
  }

  function PROXY_ADMIN() internal pure override returns (address) {
    return MiscPolygonZkEvm.PROXY_ADMIN;
  }

  function GUARDIAN() internal pure override returns (address) {
    return MiscPolygonZkEvm.PROTOCOL_GUARDIAN;
  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.POLYGON_ZK_EVM;
  }
}

contract Celo is BaseInitialDeployment {
  function TRANSPARENT_PROXY_FACTORY() internal pure override returns (address) {
    return 0xb172a90A7C238969CE9B27cc19D13b60A91e7F00;
  }

  //
  //  function PROXY_ADMIN() internal pure override returns (address) {
  //    return 0x01d678F1bbE148C96e7501F1Ac41661904F84F61;
  //  }

  //  function GUARDIAN() internal pure override returns (address) {
  //    return;
  //  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.CELO;
  }
}

contract Zksync is BaseInitialDeployment {
  function TRANSPARENT_PROXY_FACTORY() internal pure override returns (address) {
    return 0x8Ef21C75Ce360078cAD162565ED0c27617eCccE0;
  }

  function PROXY_ADMIN() internal pure override returns (address) {
    return 0x158d6c497317367CEa3CBAb0BD84E6de236F060D;
  }

  //  function GUARDIAN() internal pure override returns (address) {
  //    return;
  //  }

  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ZKSYNC;
  }
}

contract Ethereum_testnet is BaseInitialDeployment {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.ETHEREUM_SEPOLIA;
  }
}

contract Polygon_testnet is BaseInitialDeployment {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.POLYGON_AMOY;
  }
}

contract Avalanche_testnet is BaseInitialDeployment {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.AVALANCHE_FUJI;
  }
}

contract Arbitrum_testnet is BaseInitialDeployment {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.ARBITRUM_SEPOLIA;
  }
}

contract Optimism_testnet is BaseInitialDeployment {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.OPTIMISM_SEPOLIA;
  }
}

contract Metis_testnet is BaseInitialDeployment {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.METIS_TESTNET;
  }
}

contract Binance_testnet is BaseInitialDeployment {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.BNB_TESTNET;
  }
}

contract Base_testnet is BaseInitialDeployment {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.BASE_SEPOLIA;
  }
}

contract Gnosis_testnet is BaseInitialDeployment {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.GNOSIS_CHIADO;
  }
}

contract Scroll_testnet is BaseInitialDeployment {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.SCROLL_SEPOLIA;
  }
}

contract Celo_testnet is BaseInitialDeployment {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.CELO_ALFAJORES;
  }
}
