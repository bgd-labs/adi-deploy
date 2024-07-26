// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../../../BaseDeployerScript.sol';
import 'aave-helpers/adi/SimpleAddForwarderAdapter.sol';

abstract contract Base_Deploy_Add_ZkSync_Path_Payload is BaseDeployerScript {
  function _getPayloadByteCode() internal virtual returns (bytes memory);

  function PAYLOAD_SALT() internal pure virtual returns (string memory) {
    return 'Add ZkSync path to a.DI';
  }

  function DESTINATION_CHAIN_ID() internal pure virtual returns (uint256);

  function _deployPayload(AddForwarderAdapterArgs memory args) internal returns (address) {
    bytes memory payloadCode = abi.encodePacked(_getPayloadByteCode(), abi.encode(args));

    return _deployByteCode(payloadCode, PAYLOAD_SALT());
  }

  function _getAdapterAddress(address crossChainController) internal virtual returns (address);

  function _execute(Addresses memory addresses) internal virtual override {
    Addresses memory destinationAddresses = _getAddresses(DESTINATION_CHAIN_ID());

    _deployPayload(
      AddForwarderAdapterArgs({
        crossChainController: addresses.crossChainController,
        currentChainBridgeAdapter: _getAdapterAddress(addresses.crossChainController), //addresses.zksyncAdapter,
        destinationChainBridgeAdapter: destinationAddresses.zksyncAdapter,
        destinationChainId: DESTINATION_CHAIN_ID()
      })
    );
  }
}
