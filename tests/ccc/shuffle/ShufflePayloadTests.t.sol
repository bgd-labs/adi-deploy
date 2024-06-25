// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Add_Shuffle_to_CCC_Payload} from '../../../src/ccc_payloads/shuffle/ShuffleCCCUpdatePayload.sol';
import {Addresses, Ethereum} from '../../../scripts/payloads/ccc/shuffle/Network_Deployments.s.sol';
import 'aave-helpers/adi/test/ADITestBase.sol';

abstract contract BaseShufflePayloadTest is ADITestBase {
  Add_Shuffle_to_CCC_Payload internal payload;
  address internal crossChainController;

  string internal NETWORK;
  uint256 internal immutable BLOCK_NUMBER;

  constructor(string memory network, uint256 blockNumber) {
    NETWORK = network;
    BLOCK_NUMBER = blockNumber;
  }

  function _getPayload() internal virtual returns (Add_Shuffle_to_CCC_Payload);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl(NETWORK), BLOCK_NUMBER);

    payload = _getPayload();
  }

  function test_defaultTest() public {
    defaultTest('add_shuffle_to_ccc', crossChainController, address(payload), true);
  }
}

contract EthereumShufflePayloadTest is Ethereum, BaseShufflePayloadTest('ethereum', 20160400) {
  function _getPayload() internal override returns (Add_Shuffle_to_CCC_Payload) {
    Addresses memory addresses = _getAddresses(TRANSACTION_NETWORK());
    address cccImpl = _deployCCCImpl();
    crossChainController = addresses.crossChainController;
    return _deployPayload(crossChainController, addresses.proxyAdmin, cccImpl);
  }
}
