// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Addresses, Ethereum, Polygon, Avalanche, Arbitrum, Optimism, Metis, Binance, Base, Gnosis, Scroll} from '../../../scripts/payloads/ccc/shuffle/Network_Deployments.s.sol';
import 'aave-helpers/adi/test/ADITestBase.sol';
import 'forge-std/console.sol';

abstract contract BaseShufflePayloadTest is ADITestBase {
  address internal _payload;
  address internal _crossChainController;
  address internal _proxyAdmin;

  string internal NETWORK;
  uint256 internal immutable BLOCK_NUMBER;

  constructor(string memory network, uint256 blockNumber) {
    NETWORK = network;
    BLOCK_NUMBER = blockNumber;
  }

  //  function _getDeployedPayload() internal virtual returns (address);

  function _getPayload() internal virtual returns (address);

  function _getCurrentNetworkAddresses() internal virtual returns (Addresses memory);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl(NETWORK), BLOCK_NUMBER);

    Addresses memory addresses = _getCurrentNetworkAddresses();
    _crossChainController = addresses.crossChainController;
    _proxyAdmin = addresses.proxyAdmin;

    _payload = _getPayload();
  }

  function test_defaultTest() public {
    defaultTest(
      string.concat('add_shuffle_to_ccc_', NETWORK),
      _crossChainController,
      address(_payload),
      false,
      vm
    );
  }

  //  function test_samePayloadAddress() public {
  //    assertEq(_payload, _getDeployedPayload());
  //  }
}

contract EthereumShufflePayloadTest is Ethereum, BaseShufflePayloadTest('ethereum', 20160500) {
  //  function _getDeployedPayload() internal pure override returns (address) {
  //    return address(0);
  //  }

  function _getCurrentNetworkAddresses() internal view override returns (Addresses memory) {
    return _getAddresses(TRANSACTION_NETWORK());
  }

  function _getPayload() internal override returns (address) {
    return _deployPayload(_crossChainController, _proxyAdmin);
  }
}

contract PolygonShufflePayloadTest is Polygon, BaseShufflePayloadTest('polygon', 59181700) {
  //  function _getDeployedPayload() internal pure override returns (address) {
  //    return address(0);
  //  }

  function _getCurrentNetworkAddresses() internal view override returns (Addresses memory) {
    return _getAddresses(TRANSACTION_NETWORK());
  }

  function _getPayload() internal override returns (address) {
    return _deployPayload(_crossChainController, _proxyAdmin);
  }
}

contract AvalancheShufflePayloadTest is Avalanche, BaseShufflePayloadTest('avalanche', 47783432) {
  //  function _getDeployedPayload() internal pure override returns (address) {
  //    return address(0);
  //  }

  function _getCurrentNetworkAddresses() internal view override returns (Addresses memory) {
    return _getAddresses(TRANSACTION_NETWORK());
  }

  function _getPayload() internal override returns (address) {
    return _deployPayload(_crossChainController, _proxyAdmin);
  }
}

contract ArbitrumShufflePayloadTest is Arbitrum, BaseShufflePayloadTest('arbitrum', 230678009) {
  //  function _getDeployedPayload() internal pure override returns (address) {
  //    return address(0);
  //  }

  function _getCurrentNetworkAddresses() internal view override returns (Addresses memory) {
    return _getAddresses(TRANSACTION_NETWORK());
  }

  function _getPayload() internal override returns (address) {
    return _deployPayload(_crossChainController, _proxyAdmin);
  }
}

contract OptimismShufflePayloadTest is Optimism, BaseShufflePayloadTest('arbitrum', 122500476) {
  //  function _getDeployedPayload() internal pure override returns (address) {
  //    return address(0);
  //  }

  function _getCurrentNetworkAddresses() internal view override returns (Addresses memory) {
    return _getAddresses(TRANSACTION_NETWORK());
  }

  function _getPayload() internal override returns (address) {
    return _deployPayload(_crossChainController, _proxyAdmin);
  }
}

contract MetisShufflePayloadTest is Metis, BaseShufflePayloadTest('metis', 17614221) {
  //  function _getDeployedPayload() internal pure override returns (address) {
  //    return address(0);
  //  }

  function _getCurrentNetworkAddresses() internal view override returns (Addresses memory) {
    return _getAddresses(TRANSACTION_NETWORK());
  }

  function _getPayload() internal override returns (address) {
    return _deployPayload(_crossChainController, _proxyAdmin);
  }
}

contract BinanceShufflePayloadTest is Binance, BaseShufflePayloadTest('binance', 40345866) {
  //  function _getDeployedPayload() internal pure override returns (address) {
  //    return address(0);
  //  }

  function _getCurrentNetworkAddresses() internal view override returns (Addresses memory) {
    return _getAddresses(TRANSACTION_NETWORK());
  }

  function _getPayload() internal override returns (address) {
    return _deployPayload(_crossChainController, _proxyAdmin);
  }
}

contract CBaseShufflePayloadTest is Base, BaseShufflePayloadTest('base', 16905250) {
  //  function _getDeployedPayload() internal pure override returns (address) {
  //    return address(0);
  //  }

  function _getCurrentNetworkAddresses() internal view override returns (Addresses memory) {
    return _getAddresses(TRANSACTION_NETWORK());
  }

  function _getPayload() internal override returns (address) {
    return _deployPayload(_crossChainController, _proxyAdmin);
  }
}

contract GnosisShufflePayloadTest is Gnosis, BaseShufflePayloadTest('gnosis', 34891878) {
  //  function _getDeployedPayload() internal pure override returns (address) {
  //    return address(0);
  //  }

  function _getCurrentNetworkAddresses() internal view override returns (Addresses memory) {
    return _getAddresses(TRANSACTION_NETWORK());
  }

  function _getPayload() internal override returns (address) {
    return _deployPayload(_crossChainController, _proxyAdmin);
  }
}

contract ScrollShufflePayloadTest is Scroll, BaseShufflePayloadTest('scroll', 7298668) {
  //  function _getDeployedPayload() internal pure override returns (address) {
  //    return address(0);
  //  }

  function _getCurrentNetworkAddresses() internal view override returns (Addresses memory) {
    return _getAddresses(TRANSACTION_NETWORK());
  }

  function _getPayload() internal override returns (address) {
    return _deployPayload(_crossChainController, _proxyAdmin);
  }
}
