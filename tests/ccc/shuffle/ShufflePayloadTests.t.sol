// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Addresses, Ethereum} from '../../../scripts/payloads/ccc/shuffle/Network_Deployments.s.sol';
import 'aave-helpers/adi/test/ADITestBase.sol';
import 'forge-std/console.sol';

abstract contract BaseShufflePayloadTest is ADITestBase {
  address internal payload;
  address internal crossChainController;

  string internal NETWORK;
  uint256 internal immutable BLOCK_NUMBER;

  constructor(string memory network, uint256 blockNumber) {
    NETWORK = network;
    BLOCK_NUMBER = blockNumber;
  }

  function _getPayload() internal virtual returns (address);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl(NETWORK), BLOCK_NUMBER);

    payload = _getPayload();
  }

  function test_defaultTest() public {
    defaultTest('add_shuffle_to_ccc', crossChainController, address(payload), false, vm);
  }
}

contract EthereumShufflePayloadTest is Ethereum, BaseShufflePayloadTest('ethereum', 20160500) {
  function _getPayload() internal override returns (address) {
    Addresses memory addresses = _getAddresses(TRANSACTION_NETWORK());
    address cccImpl = _deployCrossChainControllerImpl();
    crossChainController = addresses.crossChainController;
    return _deployPayload(crossChainController, addresses.proxyAdmin, cccImpl);
  }
}
