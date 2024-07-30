// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'aave-helpers/adi/BaseCCCUpdate.sol';
import {IReinitialize} from 'adi/revisions/update_to_rev_3/IReinitialize.sol';
import {ICrossChainForwarder} from 'adi/interfaces/ICrossChainForwarder.sol';
import {ChainIds} from 'solidity-utils/contracts/utils/ChainHelpers.sol';

/**
 * @title Ethereum payload to update CrossChainController with new shuffle mechanism
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/39
 */
contract Ethereum_Add_Shuffle_to_CCC_Payload is BaseCCCUpdate {
  constructor(CCCUpdateArgs memory cccUpdateArgs) BaseCCCUpdate(cccUpdateArgs) {}

  function getInitializeSignature() public pure override returns (bytes memory) {
    ICrossChainForwarder.OptimalBandwidthByChain[]
      memory optimalBandwidths = new ICrossChainForwarder.OptimalBandwidthByChain[](5);

    optimalBandwidths[0] = ICrossChainForwarder.OptimalBandwidthByChain({
      chainId: ChainIds.POLYGON,
      optimalBandwidth: 3
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
    // not yet connected but we can set it up
    optimalBandwidths[4] = ICrossChainForwarder.OptimalBandwidthByChain({
      chainId: ChainIds.CELO,
      optimalBandwidth: 2
    });

    // no need to set up all other networks as they are rollups so 0 = all bridges = 1 bridge

    return abi.encodeWithSelector(IReinitialize.initializeRevision.selector, optimalBandwidths);
  }
}

/**
 * @title Ethereum payload to update CrossChainController with new shuffle mechanism
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/39
 */
/// @dev Use all currently registered bridges to account for the manual trigger of the native polygon bridge. This way we ensure
// that with current configuration it can reach consensus on destination network (ethereum). On a future AIP this can be lowered
// once the manual trigger of polygon native bridge is solved
contract Polygon_Add_Shuffle_to_CCC_Payload is BaseCCCUpdate {
  constructor(CCCUpdateArgs memory cccUpdateArgs) BaseCCCUpdate(cccUpdateArgs) {}

  function getInitializeSignature() public pure override returns (bytes memory) {
    ICrossChainForwarder.OptimalBandwidthByChain[]
      memory optimalBandwidths = new ICrossChainForwarder.OptimalBandwidthByChain[](1);
    optimalBandwidths[0] = ICrossChainForwarder.OptimalBandwidthByChain({
      chainId: ChainIds.ETHEREUM,
      optimalBandwidth: 4
    });
    return abi.encodeWithSelector(IReinitialize.initializeRevision.selector, optimalBandwidths);
  }
}

/**
 * @title Ethereum payload to update CrossChainController with new shuffle mechanism
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/39
 */
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

/**
 * @title Ethereum payload to update CrossChainController with new shuffle mechanism
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/39
 */
contract Arbitrum_Add_Shuffle_to_CCC_Payload is BaseCCCUpdate {
  constructor(CCCUpdateArgs memory cccUpdateArgs) BaseCCCUpdate(cccUpdateArgs) {}

  function getInitializeSignature() public pure override returns (bytes memory) {
    ICrossChainForwarder.OptimalBandwidthByChain[]
      memory optimalBandwidths = new ICrossChainForwarder.OptimalBandwidthByChain[](0);

    return abi.encodeWithSelector(IReinitialize.initializeRevision.selector, optimalBandwidths);
  }
}

/**
 * @title Ethereum payload to update CrossChainController with new shuffle mechanism
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/39
 */
contract Optimism_Add_Shuffle_to_CCC_Payload is BaseCCCUpdate {
  constructor(CCCUpdateArgs memory cccUpdateArgs) BaseCCCUpdate(cccUpdateArgs) {}

  function getInitializeSignature() public pure override returns (bytes memory) {
    ICrossChainForwarder.OptimalBandwidthByChain[]
      memory optimalBandwidths = new ICrossChainForwarder.OptimalBandwidthByChain[](0);

    return abi.encodeWithSelector(IReinitialize.initializeRevision.selector, optimalBandwidths);
  }
}

/**
 * @title Ethereum payload to update CrossChainController with new shuffle mechanism
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/39
 */
contract Metis_Add_Shuffle_to_CCC_Payload is BaseCCCUpdate {
  constructor(CCCUpdateArgs memory cccUpdateArgs) BaseCCCUpdate(cccUpdateArgs) {}

  function getInitializeSignature() public pure override returns (bytes memory) {
    ICrossChainForwarder.OptimalBandwidthByChain[]
      memory optimalBandwidths = new ICrossChainForwarder.OptimalBandwidthByChain[](0);

    return abi.encodeWithSelector(IReinitialize.initializeRevision.selector, optimalBandwidths);
  }
}

/**
 * @title Ethereum payload to update CrossChainController with new shuffle mechanism
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/39
 */
contract Binance_Add_Shuffle_to_CCC_Payload is BaseCCCUpdate {
  constructor(CCCUpdateArgs memory cccUpdateArgs) BaseCCCUpdate(cccUpdateArgs) {}

  function getInitializeSignature() public pure override returns (bytes memory) {
    ICrossChainForwarder.OptimalBandwidthByChain[]
      memory optimalBandwidths = new ICrossChainForwarder.OptimalBandwidthByChain[](0);

    return abi.encodeWithSelector(IReinitialize.initializeRevision.selector, optimalBandwidths);
  }
}

/**
 * @title Ethereum payload to update CrossChainController with new shuffle mechanism
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/39
 */
contract Base_Add_Shuffle_to_CCC_Payload is BaseCCCUpdate {
  constructor(CCCUpdateArgs memory cccUpdateArgs) BaseCCCUpdate(cccUpdateArgs) {}

  function getInitializeSignature() public pure override returns (bytes memory) {
    ICrossChainForwarder.OptimalBandwidthByChain[]
      memory optimalBandwidths = new ICrossChainForwarder.OptimalBandwidthByChain[](0);

    return abi.encodeWithSelector(IReinitialize.initializeRevision.selector, optimalBandwidths);
  }
}

/**
 * @title Ethereum payload to update CrossChainController with new shuffle mechanism
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/39
 */
contract Gnosis_Add_Shuffle_to_CCC_Payload is BaseCCCUpdate {
  constructor(CCCUpdateArgs memory cccUpdateArgs) BaseCCCUpdate(cccUpdateArgs) {}

  function getInitializeSignature() public pure override returns (bytes memory) {
    ICrossChainForwarder.OptimalBandwidthByChain[]
      memory optimalBandwidths = new ICrossChainForwarder.OptimalBandwidthByChain[](0);

    return abi.encodeWithSelector(IReinitialize.initializeRevision.selector, optimalBandwidths);
  }
}

/**
 * @title Ethereum payload to update CrossChainController with new shuffle mechanism
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/39
 */
contract Scroll_Add_Shuffle_to_CCC_Payload is BaseCCCUpdate {
  constructor(CCCUpdateArgs memory cccUpdateArgs) BaseCCCUpdate(cccUpdateArgs) {}

  function getInitializeSignature() public pure override returns (bytes memory) {
    ICrossChainForwarder.OptimalBandwidthByChain[]
      memory optimalBandwidths = new ICrossChainForwarder.OptimalBandwidthByChain[](0);

    return abi.encodeWithSelector(IReinitialize.initializeRevision.selector, optimalBandwidths);
  }
}
