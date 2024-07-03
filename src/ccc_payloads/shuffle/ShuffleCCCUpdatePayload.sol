// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'aave-helpers/adi/BaseCCCUpdate.sol';
import {IReinitialize} from 'adi/revisions/update_to_rev_3/IReinitialize.sol';
import {ICrossChainForwarder} from 'adi/interfaces/ICrossChainForwarder.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';

/**
 * @title Ethereum payload to update ccc with new shuffle mechanism
 * @author BGD Labs @bgdlabs
 * - Discussion:
 * - Snapshot:
 */
contract Ethereum_Add_Shuffle_to_CCC_Payload is BaseCCCUpdate {
  constructor(CCCUpdateArgs memory cccUpdateArgs) BaseCCCUpdate(cccUpdateArgs) {}

  function getInitializeSignature() public pure override returns (bytes memory) {
    ICrossChainForwarder.OptimalBandwidthByChain[]
      memory optimalBandwidths = new ICrossChainForwarder.OptimalBandwidthByChain[](5);

    optimalBandwidths[0] = ICrossChainForwarder.OptimalBandwidthByChain({
      chainId: ChainIds.POLYGON,
      optimalBandwidth: 3 // remember the problem with polygon native???
    });
    optimalBandwidths[1] = ICrossChainForwarder.OptimalBandwidthByChain({
      chainId: ChainIds.AVALANCHE,
      optimalBandwidth: 2
    });
    optimalBandwidths[2] = ICrossChainForwarder.OptimalBandwidthByChain({
      chainId: ChainIds.BNB,
      optimalBandwidth: 2
    });
    optimalBandwidths[3] = ICrossChainForwarder.OptimalBandwidthByChain({
      chainId: ChainIds.GNOSIS,
      optimalBandwidth: 2
    });
    // not yet connected but we can set it up??
    optimalBandwidths[4] = ICrossChainForwarder.OptimalBandwidthByChain({
      chainId: ChainIds.CELO,
      optimalBandwidth: 2
    });

    // no need to set up all other networks as they are rollups so 0 = all bridges = 1 bridge

    return abi.encodeWithSelector(IReinitialize.initializeRevision.selector, optimalBandwidths);
  }
}

contract Polygon_Add_Shuffle_to_CCC_Payload is BaseCCCUpdate {
  constructor(CCCUpdateArgs memory cccUpdateArgs) BaseCCCUpdate(cccUpdateArgs) {}

  function getInitializeSignature() public pure override returns (bytes memory) {
    ICrossChainForwarder.OptimalBandwidthByChain[]
      memory optimalBandwidths = new ICrossChainForwarder.OptimalBandwidthByChain[](1);
    optimalBandwidths[0] = ICrossChainForwarder.OptimalBandwidthByChain({
      chainId: ChainIds.ETHEREUM,
      optimalBandwidth: 3 // remember the problem with polygon native???
    });
    return abi.encodeWithSelector(IReinitialize.initializeRevision.selector, optimalBandwidths);
  }
}

contract Avalanche_Add_Shuffle_to_CCC_Payload is BaseCCCUpdate {
  constructor(CCCUpdateArgs memory cccUpdateArgs) BaseCCCUpdate(cccUpdateArgs) {}

  function getInitializeSignature() public pure override returns (bytes memory) {
    ICrossChainForwarder.OptimalBandwidthByChain[]
      memory optimalBandwidths = new ICrossChainForwarder.OptimalBandwidthByChain[](1);
    optimalBandwidths[0] = ICrossChainForwarder.OptimalBandwidthByChain({
      chainId: ChainIds.ETHEREUM,
      optimalBandwidth: 2
    });
    return abi.encodeWithSelector(IReinitialize.initializeRevision.selector, optimalBandwidths);
  }
}

contract Arbitrum_Add_Shuffle_to_CCC_Payload is BaseCCCUpdate {
  constructor(CCCUpdateArgs memory cccUpdateArgs) BaseCCCUpdate(cccUpdateArgs) {}

  function getInitializeSignature() public pure override returns (bytes memory) {
    ICrossChainForwarder.OptimalBandwidthByChain[]
      memory optimalBandwidths = new ICrossChainForwarder.OptimalBandwidthByChain[](0);

    return abi.encodeWithSelector(IReinitialize.initializeRevision.selector, optimalBandwidths);
  }
}

contract Optimism_Add_Shuffle_to_CCC_Payload is BaseCCCUpdate {
  constructor(CCCUpdateArgs memory cccUpdateArgs) BaseCCCUpdate(cccUpdateArgs) {}

  function getInitializeSignature() public pure override returns (bytes memory) {
    ICrossChainForwarder.OptimalBandwidthByChain[]
      memory optimalBandwidths = new ICrossChainForwarder.OptimalBandwidthByChain[](0);

    return abi.encodeWithSelector(IReinitialize.initializeRevision.selector, optimalBandwidths);
  }
}

contract Metis_Add_Shuffle_to_CCC_Payload is BaseCCCUpdate {
  constructor(CCCUpdateArgs memory cccUpdateArgs) BaseCCCUpdate(cccUpdateArgs) {}

  function getInitializeSignature() public pure override returns (bytes memory) {
    ICrossChainForwarder.OptimalBandwidthByChain[]
      memory optimalBandwidths = new ICrossChainForwarder.OptimalBandwidthByChain[](0);

    return abi.encodeWithSelector(IReinitialize.initializeRevision.selector, optimalBandwidths);
  }
}

contract Binance_Add_Shuffle_to_CCC_Payload is BaseCCCUpdate {
  constructor(CCCUpdateArgs memory cccUpdateArgs) BaseCCCUpdate(cccUpdateArgs) {}

  function getInitializeSignature() public pure override returns (bytes memory) {
    ICrossChainForwarder.OptimalBandwidthByChain[]
      memory optimalBandwidths = new ICrossChainForwarder.OptimalBandwidthByChain[](0);

    return abi.encodeWithSelector(IReinitialize.initializeRevision.selector, optimalBandwidths);
  }
}

contract Base_Add_Shuffle_to_CCC_Payload is BaseCCCUpdate {
  constructor(CCCUpdateArgs memory cccUpdateArgs) BaseCCCUpdate(cccUpdateArgs) {}

  function getInitializeSignature() public pure override returns (bytes memory) {
    ICrossChainForwarder.OptimalBandwidthByChain[]
      memory optimalBandwidths = new ICrossChainForwarder.OptimalBandwidthByChain[](0);

    return abi.encodeWithSelector(IReinitialize.initializeRevision.selector, optimalBandwidths);
  }
}

contract Gnosis_Add_Shuffle_to_CCC_Payload is BaseCCCUpdate {
  constructor(CCCUpdateArgs memory cccUpdateArgs) BaseCCCUpdate(cccUpdateArgs) {}

  function getInitializeSignature() public pure override returns (bytes memory) {
    ICrossChainForwarder.OptimalBandwidthByChain[]
      memory optimalBandwidths = new ICrossChainForwarder.OptimalBandwidthByChain[](0);

    return abi.encodeWithSelector(IReinitialize.initializeRevision.selector, optimalBandwidths);
  }
}

contract Scroll_Add_Shuffle_to_CCC_Payload is BaseCCCUpdate {
  constructor(CCCUpdateArgs memory cccUpdateArgs) BaseCCCUpdate(cccUpdateArgs) {}

  function getInitializeSignature() public pure override returns (bytes memory) {
    ICrossChainForwarder.OptimalBandwidthByChain[]
      memory optimalBandwidths = new ICrossChainForwarder.OptimalBandwidthByChain[](0);

    return abi.encodeWithSelector(IReinitialize.initializeRevision.selector, optimalBandwidths);
  }
}

contract Celo_Add_Shuffle_to_CCC_Payload is BaseCCCUpdate {
  constructor(CCCUpdateArgs memory cccUpdateArgs) BaseCCCUpdate(cccUpdateArgs) {}

  function getInitializeSignature() public pure override returns (bytes memory) {
    ICrossChainForwarder.OptimalBandwidthByChain[]
      memory optimalBandwidths = new ICrossChainForwarder.OptimalBandwidthByChain[](0);

    return abi.encodeWithSelector(IReinitialize.initializeRevision.selector, optimalBandwidths);
  }
}
