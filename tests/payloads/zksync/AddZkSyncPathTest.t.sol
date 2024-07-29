// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import 'forge-std/console.sol';
import {ADITestBase} from 'aave-helpers/adi/test/ADITestBase.sol';
import {Addresses, Ethereum as PayloadEthereumScript} from '../../../scripts/payloads/adapters/zksync/Network_Deployments.s.sol';
import {AddForwarderAdapterArgs} from 'aave-helpers/adi/SimpleAddForwarderAdapter.sol';

abstract contract BaseAddZkSyncPathPayloadTest is ADITestBase {
  address internal _payload;
  address internal _crossChainController;

  string internal NETWORK;
  uint256 internal immutable BLOCK_NUMBER;

  constructor(string memory network, uint256 blockNumber) {
    NETWORK = network;
    BLOCK_NUMBER = blockNumber;
  }

  function _getDeployedPayload() internal virtual returns (address);

  function _getPayload() internal virtual returns (address);

  function _getCurrentNetworkAddresses() internal virtual returns (Addresses memory);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl(NETWORK), BLOCK_NUMBER);

    Addresses memory addresses = _getCurrentNetworkAddresses();
    _crossChainController = addresses.crossChainController;

    _payload = _getPayload();
  }

  function test_defaultTest() public {
    defaultTest(
      string.concat('add_zksync_path_to_adi', NETWORK),
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

contract EthereumAddZkSyncPathPayloadTest is
  PayloadEthereumScript,
  BaseAddZkSyncPathPayloadTest('ethereum', 20412168)
{
  function _getDeployedPayload() internal pure override returns (address) {
    return address(0); // TODO: add payload address when deployed
  }

  function _getCurrentNetworkAddresses() internal view override returns (Addresses memory) {
    return _getAddresses(TRANSACTION_NETWORK());
  }

  function _getPayload() internal override returns (address) {
    Addresses memory currentAddresses = _getCurrentNetworkAddresses();
    Addresses memory destinationAddresses = _getAddresses(DESTINATION_CHAIN_ID());

    AddForwarderAdapterArgs memory args = AddForwarderAdapterArgs({
      crossChainController: currentAddresses.crossChainController,
      currentChainBridgeAdapter: 0x6aD9d4147467f08b165e1b6364584C5d28898b84,
      destinationChainBridgeAdapter: 0x1BC5C10CAe378fDbd7D52ec4F9f34590a619c68E,
      destinationChainId: DESTINATION_CHAIN_ID()
    });
    return _deployPayload(args);
  }
}
