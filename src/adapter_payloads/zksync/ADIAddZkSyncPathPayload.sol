// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ChainIds} from 'aave-helpers/ChainIds.sol';
import 'aave-helpers/adi/SimpleAddForwarderAdapter.sol';

/**
 * @title Add ZkSync communication path to a.DI
 * @author BGD Labs @bgdlabs
 * - Discussion:
 */
contract Ethereum_ADI_Add_ZkSYnc_Path_Payload is SimpleAddForwarderAdapter {
  constructor(AddForwarderAdapterArgs memory args) SimpleAddForwarderAdapter(args) {}
}
