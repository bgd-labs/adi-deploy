// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import 'forge-std/console.sol';
import {ADITestBase} from '../../adi/ADITestBase.sol';
import {Addresses, Ethereum as PayloadEthereumScript} from '../../../scripts/payloads/adapters/ethereum/Network_Deployments.s.sol';
import {Ethereum_Monad_Path_Payload, AddForwarderAdapterArgs} from '../../../src/adapter_payloads/Ethereum_Monad_Path_Payload.sol';

abstract contract BaseAddMonadPathPayloadTest is ADITestBase {
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
      string.concat('add_monad_path_to_adi', NETWORK),
      _crossChainController,
      address(_payload),
      true,
      vm
    );
  }

  function test_samePayloadAddress() public {
    Ethereum_Monad_Path_Payload deployedPayload = Ethereum_Monad_Path_Payload(
      _getDeployedPayload()
    );
    Ethereum_Monad_Path_Payload predictedPayload = Ethereum_Monad_Path_Payload(_getPayload());

    assertEq(predictedPayload.DESTINATION_CHAIN_ID(), deployedPayload.DESTINATION_CHAIN_ID());
    assertEq(predictedPayload.CROSS_CHAIN_CONTROLLER(), deployedPayload.CROSS_CHAIN_CONTROLLER());
    assertEq(
      predictedPayload.CURRENT_CHAIN_HL_BRIDGE_ADAPTER(),
      deployedPayload.CURRENT_CHAIN_HL_BRIDGE_ADAPTER()
    );
    assertEq(
      predictedPayload.DESTINATION_CHAIN_HL_BRIDGE_ADAPTER(),
      deployedPayload.DESTINATION_CHAIN_HL_BRIDGE_ADAPTER()
    );
    assertEq(
      predictedPayload.CURRENT_CHAIN_CCIP_BRIDGE_ADAPTER(),
      deployedPayload.CURRENT_CHAIN_CCIP_BRIDGE_ADAPTER()
    );
    assertEq(
      predictedPayload.DESTINATION_CHAIN_CCIP_BRIDGE_ADAPTER(),
      deployedPayload.DESTINATION_CHAIN_CCIP_BRIDGE_ADAPTER()
    );
  }
}

contract EthereumAddMonadPathPayloadTest is
  PayloadEthereumScript,
  BaseAddMonadPathPayloadTest('ethereum', 25294679)
{
  function _getDeployedPayload() internal pure override returns (address) {
    return 0xB6d264B1322d7ec61dEDE1B60369AFf25229E39a;
  }

  function _getCurrentNetworkAddresses() internal view override returns (Addresses memory) {
    return _getAddresses(TRANSACTION_NETWORK());
  }

  function _getPayload() internal override returns (address) {
    Addresses memory currentAddresses = _getCurrentNetworkAddresses();
    Addresses memory destinationAddresses = _getAddresses(DESTINATION_CHAIN_ID());

    AddForwarderAdapterArgs memory args = AddForwarderAdapterArgs({
      crossChainController: currentAddresses.crossChainController,
      currentChainHLBridgeAdapter: currentAddresses.hlAdapter,
      destinationChainHLBridgeAdapter: destinationAddresses.hlAdapter,
      currentChainCCIPBridgeAdapter: currentAddresses.ccipAdapter,
      destinationChainCCIPBridgeAdapter: destinationAddresses.ccipAdapter,
      destinationChainId: DESTINATION_CHAIN_ID()
    });
    return _deployPayload(args);
  }
}
