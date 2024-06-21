// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'adi-tests/BaseTest.sol';
import '../../../src/ccc_payloads/shuffle/ShuffleCCCUpdatePayload.sol';
import {Ethereum} from '../../../scripts/payloads/ccc/shuffle/Network_Deployments.s.sol';

contract BaseShufflePayloadTest is BaseTest {
  Add_Shuffle_to_CCC_Payload internal payload;

  string internal immutable NETWORK;
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
}

contract EthereumShufflePayloadTest is BaseShufflePayloadTest, Ethereum {}
