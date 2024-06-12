// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import '../BaseDeployerScript.sol';
import {ICrossChainForwarder} from 'adi/interfaces/ICrossChainForwarder.sol';
import {ICrossChainReceiver} from 'adi/interfaces/ICrossChainReceiver.sol';

abstract contract BaseDisableCCFAdapter is BaseDeployerScript {
  function getBridgeAdaptersToDisable()
  public
  pure
  virtual
  returns (ICrossChainForwarder.BridgeAdapterToDisable[] memory);

  function _execute(Addresses memory addresses) internal override {
    ICrossChainForwarder(addresses.crossChainController).disableBridgeAdapters(
      getBridgeAdaptersToDisable()
    );
  }
}

contract Ethereum_testnet is BaseDisableCCFAdapter {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.ETHEREUM_SEPOLIA;
  }

  function getBridgeAdaptersToDisable()
  public
  pure
  override
  returns (ICrossChainForwarder.BridgeAdapterToDisable[] memory)
  {
    ICrossChainForwarder.BridgeAdapterToDisable[]
    memory adapters = new ICrossChainForwarder.BridgeAdapterToDisable[](1);
    adapters[0].bridgeAdapter = 0xc3f2AB225a94c3c8315e52D3b2B86a2af260c804;
    adapters[0].chainIds = new uint256[](1);
    adapters[0].chainIds[0] = TestNetChainIds.SCROLL_SEPOLIA;
    return adapters;
  }
}

abstract contract BaseDisableCCRAdapter is BaseDeployerScript {
  function getBridgeAdaptersToDisable()
  public
  pure
  virtual
  returns (ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[] memory);

  function _execute(Addresses memory addresses) internal override {
    ICrossChainReceiver(addresses.crossChainController).disallowReceiverBridgeAdapters(
      getBridgeAdaptersToDisable()
    );
  }
}

contract Scroll_testnet is BaseDisableCCRAdapter {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.SCROLL_SEPOLIA;
  }

  function getBridgeAdaptersToDisable()
  public
  pure
  override
  returns (ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[] memory)
  {
    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
    memory adapters = new ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[](1);
    adapters[0].bridgeAdapter = 0x18536013913f763bc199A5b20c1d170b6058373e;
    adapters[0].chainIds = new uint256[](1);
    adapters[0].chainIds[0] = TestNetChainIds.ETHEREUM_SEPOLIA;
    return adapters;
  }
}
