// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../../../src/ccc_payloads/shuffle/ShuffleCCCUpdatePayload.sol';
import {Ethereum} from '../../../scripts/payloads/ccc/shuffle/Network_Deployments.s.sol';
import 'aave-helpers/adi/test/ADITestBase.sol';

contract BaseShufflePayloadTest is ADITestBase {
  Add_Shuffle_to_CCC_Payload internal payload;
  address internal crossChainController;

  string internal immutable NETWORK;
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

contract EthereumShufflePayloadTest is Ethereum, BaseShufflePayloadTest('mainnet', 20160400) {
  function _getPayload() internal view override returns (Add_Shuffle_to_CCC_Payload) {
    Addresses memory addresses = _getAddresses(TRANSACTION_NETWORK());
    address cccImpl = _deployCCCImpl();
    crossChainController = addresses.crossChainController;
    return new Add_Shuffle_to_CCC_Payload(crossChainController, addresses.proxyAdmin, cccImpl);
  }
}
