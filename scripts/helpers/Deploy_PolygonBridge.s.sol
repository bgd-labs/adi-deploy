// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import 'forge-std/console2.sol';
import 'forge-std/Script.sol';

import {FxTunnelPolygon} from 'adi/adapters/polygon/tunnel/FxTunnelPolygon.sol';
import {FxTunnelEthereum} from 'adi/adapters/polygon/tunnel/FxTunnelEthereum.sol';

address constant ETHEREUM_CHECKPOINT_MANAGER = 0x86E4Dc95c7FBdBf52e33D563BbDB00823894C287;
address constant ETHEREUM_FX_ROOT = 0xfe5e5D361b2ad62c541bAb87C45a0B9B018389a2;
address constant POLYGON_FX_CHILD = 0x8397259c983751DAf40400790063935a11afa28a;

contract Polygon is Script {
  address FX_TUNNEL_ETHEREUM = 0xF30FA9e36FdDd4982B722432FD39914e9ab2b033;

  function run() external {
    vm.broadcast(vm.envUint('PRIVATE_KEY'));
    require(FX_TUNNEL_ETHEREUM != address(0), 'Zero tunnel');
    FxTunnelPolygon tunnel = new FxTunnelPolygon(POLYGON_FX_CHILD, FX_TUNNEL_ETHEREUM);
    console2.log('FxTunnelPolygon: %s', address(tunnel));
  }
}

contract Ethereum is Script {
  address FX_TUNNEL_POLYGON = 0xF30FA9e36FdDd4982B722432FD39914e9ab2b033;

  function run() external {
    vm.broadcast(vm.envUint('PRIVATE_KEY'));
    require(FX_TUNNEL_POLYGON != address(0), 'Zero tunnel');
    FxTunnelEthereum tunnel = new FxTunnelEthereum(
      ETHEREUM_CHECKPOINT_MANAGER,
      ETHEREUM_FX_ROOT,
      FX_TUNNEL_POLYGON
    );
    console2.log('FxTunnelEthereum: %s', address(tunnel));
  }
}

