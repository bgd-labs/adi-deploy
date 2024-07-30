// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {ICrossChainForwarder} from 'adi/interfaces/ICrossChainForwarder.sol';
import '../BaseDeployerScript.sol';

abstract contract BaseCCFSenderAdapters is BaseDeployerScript {
  function getBridgeAdaptersToEnable(
    Addresses memory addresses
  ) public view virtual returns (ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[] memory);

  function _execute(Addresses memory addresses) internal override {
    ICrossChainForwarder(addresses.crossChainController).enableBridgeAdapters(
      getBridgeAdaptersToEnable(addresses)
    );
  }
}

contract Ethereum is BaseCCFSenderAdapters {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function getBridgeAdaptersToEnable(
    Addresses memory addresses
  ) public view override returns (ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[] memory) {
    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory bridgeAdaptersToEnable = new ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[](
        24
      );

    // polygon path
    Addresses memory addressesPolygon = _getAddresses(ChainIds.POLYGON);
    bridgeAdaptersToEnable[0] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.polAdapter,
      destinationBridgeAdapter: addressesPolygon.polAdapter,
      destinationChainId: addressesPolygon.chainId
    });
    bridgeAdaptersToEnable[1] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.ccipAdapter,
      destinationBridgeAdapter: addressesPolygon.ccipAdapter,
      destinationChainId: addressesPolygon.chainId
    });
    bridgeAdaptersToEnable[2] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.lzAdapter,
      destinationBridgeAdapter: addressesPolygon.lzAdapter,
      destinationChainId: addressesPolygon.chainId
    });
    bridgeAdaptersToEnable[3] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.hlAdapter,
      destinationBridgeAdapter: addressesPolygon.hlAdapter,
      destinationChainId: addressesPolygon.chainId
    });

    // avalanche path
    Addresses memory addressesAvax = _getAddresses(ChainIds.AVALANCHE);
    bridgeAdaptersToEnable[4] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.ccipAdapter,
      destinationBridgeAdapter: addressesAvax.ccipAdapter,
      destinationChainId: addressesAvax.chainId
    });
    bridgeAdaptersToEnable[5] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.lzAdapter,
      destinationBridgeAdapter: addressesAvax.lzAdapter,
      destinationChainId: addressesAvax.chainId
    });
    bridgeAdaptersToEnable[6] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.hlAdapter,
      destinationBridgeAdapter: addressesAvax.hlAdapter,
      destinationChainId: addressesAvax.chainId
    });

    // binance path
    Addresses memory addressesBNB = _getAddresses(ChainIds.BNB);
    bridgeAdaptersToEnable[7] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.lzAdapter,
      destinationBridgeAdapter: addressesBNB.lzAdapter,
      destinationChainId: addressesBNB.chainId
    });
    bridgeAdaptersToEnable[8] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.hlAdapter,
      destinationBridgeAdapter: addressesBNB.hlAdapter,
      destinationChainId: addressesBNB.chainId
    });
    bridgeAdaptersToEnable[9] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.ccipAdapter,
      destinationBridgeAdapter: addressesBNB.ccipAdapter,
      destinationChainId: addressesBNB.chainId
    });

    // optimism
    Addresses memory addressesOp = _getAddresses(ChainIds.OPTIMISM);
    bridgeAdaptersToEnable[10] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.opAdapter,
      destinationBridgeAdapter: addressesOp.opAdapter,
      destinationChainId: addressesOp.chainId
    });
    // arbitrum
    Addresses memory addressesArb = _getAddresses(ChainIds.ARBITRUM);
    bridgeAdaptersToEnable[11] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.arbAdapter,
      destinationBridgeAdapter: addressesArb.arbAdapter,
      destinationChainId: addressesArb.chainId
    });
    // metis
    Addresses memory addressesMetis = _getAddresses(ChainIds.METIS);
    bridgeAdaptersToEnable[12] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.metisAdapter,
      destinationBridgeAdapter: addressesMetis.metisAdapter,
      destinationChainId: addressesMetis.chainId
    });
    //base
    Addresses memory addressesBase = _getAddresses(ChainIds.BASE);
    bridgeAdaptersToEnable[13] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.baseAdapter,
      destinationBridgeAdapter: addressesBase.baseAdapter,
      destinationChainId: addressesBase.chainId
    });

    // same chain path
    bridgeAdaptersToEnable[14] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.sameChainAdapter,
      destinationBridgeAdapter: addresses.sameChainAdapter,
      destinationChainId: addresses.chainId
    });

    // gnosis
    Addresses memory addressesGnosis = _getAddresses(ChainIds.GNOSIS);
    bridgeAdaptersToEnable[15] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.gnosisAdapter,
      destinationBridgeAdapter: addressesGnosis.gnosisAdapter,
      destinationChainId: addressesGnosis.chainId
    });
    bridgeAdaptersToEnable[16] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.lzAdapter,
      destinationBridgeAdapter: addressesGnosis.lzAdapter,
      destinationChainId: addressesGnosis.chainId
    });
    bridgeAdaptersToEnable[17] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.hlAdapter,
      destinationBridgeAdapter: addressesGnosis.hlAdapter,
      destinationChainId: addressesGnosis.chainId
    });

    // ZkEVM
    Addresses memory addressesZkEVM = _getAddresses(ChainIds.POLYGON_ZK_EVM);
    bridgeAdaptersToEnable[18] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.zkevmAdapter,
      destinationBridgeAdapter: addressesZkEVM.zkevmAdapter,
      destinationChainId: addressesZkEVM.chainId
    });

    // Scroll
    Addresses memory addressesScroll = _getAddresses(ChainIds.SCROLL);
    bridgeAdaptersToEnable[19] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.scrollAdapter,
      destinationBridgeAdapter: addressesScroll.scrollAdapter,
      destinationChainId: addressesScroll.chainId
    });

    // Celo
    Addresses memory addressesCelo = _getAddresses(ChainIds.CELO);
    bridgeAdaptersToEnable[20] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.wormholeAdapter,
      destinationBridgeAdapter: addressesCelo.wormholeAdapter,
      destinationChainId: addressesCelo.chainId
    });
    bridgeAdaptersToEnable[21] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.lzAdapter,
      destinationBridgeAdapter: addressesCelo.lzAdapter,
      destinationChainId: addressesCelo.chainId
    });
    bridgeAdaptersToEnable[22] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.hlAdapter,
      destinationBridgeAdapter: addressesCelo.hlAdapter,
      destinationChainId: addressesCelo.chainId
    });

    // ZkSync
    Addresses memory addressesZkSync = _getAddresses(ChainIds.ZK_SYNC);
    bridgeAdaptersToEnable[23] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.zksyncAdapter,
      destinationBridgeAdapter: addressesZkSync.zksyncAdapter,
      destinationChainId: addressesZkSync.chainId
    });
    return bridgeAdaptersToEnable;
  }
}

contract Polygon is BaseCCFSenderAdapters {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.POLYGON;
  }

  function getBridgeAdaptersToEnable(
    Addresses memory addresses
  ) public view override returns (ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[] memory) {
    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory bridgeAdaptersToEnable = new ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[](
        4
      );

    // ethereum path
    Addresses memory ethereumAddresses = _getAddresses(ChainIds.ETHEREUM);

    bridgeAdaptersToEnable[0] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.ccipAdapter,
      destinationBridgeAdapter: ethereumAddresses.ccipAdapter,
      destinationChainId: ethereumAddresses.chainId
    });
    bridgeAdaptersToEnable[1] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.lzAdapter,
      destinationBridgeAdapter: ethereumAddresses.lzAdapter,
      destinationChainId: ethereumAddresses.chainId
    });
    bridgeAdaptersToEnable[2] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.hlAdapter,
      destinationBridgeAdapter: ethereumAddresses.hlAdapter,
      destinationChainId: ethereumAddresses.chainId
    });
    bridgeAdaptersToEnable[3] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.polAdapter,
      destinationBridgeAdapter: ethereumAddresses.polAdapter,
      destinationChainId: ethereumAddresses.chainId
    });
    return bridgeAdaptersToEnable;
  }
}

contract Avalanche is BaseCCFSenderAdapters {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.AVALANCHE;
  }

  function getBridgeAdaptersToEnable(
    Addresses memory addresses
  ) public view override returns (ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[] memory) {
    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory bridgeAdaptersToEnable = new ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[](
        3
      );

    // ethereum path
    Addresses memory ethereumAddresses = _getAddresses(ChainIds.ETHEREUM);

    bridgeAdaptersToEnable[0] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.ccipAdapter,
      destinationBridgeAdapter: ethereumAddresses.ccipAdapter,
      destinationChainId: ethereumAddresses.chainId
    });
    bridgeAdaptersToEnable[1] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.lzAdapter,
      destinationBridgeAdapter: ethereumAddresses.lzAdapter,
      destinationChainId: ethereumAddresses.chainId
    });
    bridgeAdaptersToEnable[2] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.hlAdapter,
      destinationBridgeAdapter: ethereumAddresses.hlAdapter,
      destinationChainId: ethereumAddresses.chainId
    });

    return bridgeAdaptersToEnable;
  }
}

contract Ethereum_testnet is BaseCCFSenderAdapters {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.ETHEREUM_SEPOLIA;
  }

  function getBridgeAdaptersToEnable(
    Addresses memory addresses
  ) public view override returns (ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[] memory) {
    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory bridgeAdaptersToEnable = new ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[](
        16
      );

    //     polygon path
    Addresses memory addressesPolygon = _getAddresses(TestNetChainIds.POLYGON_AMOY);

    bridgeAdaptersToEnable[0] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.ccipAdapter,
      destinationBridgeAdapter: addressesPolygon.ccipAdapter,
      destinationChainId: addressesPolygon.chainId
    });
    bridgeAdaptersToEnable[1] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.lzAdapter,
      destinationBridgeAdapter: addressesPolygon.lzAdapter,
      destinationChainId: addressesPolygon.chainId
    });
    bridgeAdaptersToEnable[2] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.hlAdapter,
      destinationBridgeAdapter: addressesPolygon.hlAdapter,
      destinationChainId: addressesPolygon.chainId
    });

    //         avalanche path
    Addresses memory addressesAvax = _getAddresses(TestNetChainIds.AVALANCHE_FUJI);

    bridgeAdaptersToEnable[3] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.ccipAdapter,
      destinationBridgeAdapter: addressesAvax.ccipAdapter,
      destinationChainId: addressesAvax.chainId
    });
    bridgeAdaptersToEnable[4] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.lzAdapter,
      destinationBridgeAdapter: addressesAvax.lzAdapter,
      destinationChainId: addressesAvax.chainId
    });
    bridgeAdaptersToEnable[5] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.hlAdapter,
      destinationBridgeAdapter: addressesAvax.hlAdapter,
      destinationChainId: addressesAvax.chainId
    });

    //     binance path
    Addresses memory addressesBNB = _getAddresses(TestNetChainIds.BNB_TESTNET);

    bridgeAdaptersToEnable[6] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.lzAdapter,
      destinationBridgeAdapter: addressesBNB.lzAdapter,
      destinationChainId: addressesBNB.chainId
    });
    bridgeAdaptersToEnable[7] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.hlAdapter,
      destinationBridgeAdapter: addressesBNB.hlAdapter,
      destinationChainId: addressesBNB.chainId
    });

    // gnosis path
    Addresses memory addressesGnosis = _getAddresses(TestNetChainIds.GNOSIS_CHIADO);

    bridgeAdaptersToEnable[8] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.gnosisAdapter,
      destinationBridgeAdapter: addressesGnosis.gnosisAdapter,
      destinationChainId: addressesGnosis.chainId
    });

    //         rollups
    Addresses memory addressesOp = _getAddresses(TestNetChainIds.OPTIMISM_SEPOLIA);
    bridgeAdaptersToEnable[9] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.opAdapter,
      destinationBridgeAdapter: addressesOp.opAdapter,
      destinationChainId: addressesOp.chainId
    });

    Addresses memory addressesArb = _getAddresses(TestNetChainIds.ARBITRUM_SEPOLIA);
    bridgeAdaptersToEnable[10] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.arbAdapter,
      destinationBridgeAdapter: addressesArb.arbAdapter,
      destinationChainId: addressesArb.chainId
    });

    Addresses memory addressesMetis = _getAddresses(TestNetChainIds.METIS_TESTNET);
    bridgeAdaptersToEnable[11] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.metisAdapter,
      destinationBridgeAdapter: addressesMetis.metisAdapter,
      destinationChainId: addressesMetis.chainId
    });
    Addresses memory addressesBase = _getAddresses(TestNetChainIds.BASE_SEPOLIA);
    bridgeAdaptersToEnable[12] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.baseAdapter,
      destinationBridgeAdapter: addressesBase.baseAdapter,
      destinationChainId: addressesBase.chainId
    });

    //         same chain path
    bridgeAdaptersToEnable[13] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.sameChainAdapter,
      destinationBridgeAdapter: addresses.sameChainAdapter,
      destinationChainId: addresses.chainId
    });

    Addresses memory addressesScrollSepolia = _getAddresses(TestNetChainIds.SCROLL_SEPOLIA);

    bridgeAdaptersToEnable[14] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.scrollAdapter,
      destinationBridgeAdapter: addressesScrollSepolia.scrollAdapter,
      destinationChainId: addressesScrollSepolia.chainId
    });

    // Celo
    Addresses memory addressesCelo = _getAddresses(TestNetChainIds.CELO_ALFAJORES);
    bridgeAdaptersToEnable[15] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.wormholeAdapter,
      destinationBridgeAdapter: addressesCelo.wormholeAdapter,
      destinationChainId: addressesCelo.chainId
    });
    return bridgeAdaptersToEnable;
  }
}

contract Polygon_testnet is BaseCCFSenderAdapters {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.POLYGON_AMOY;
  }

  function getBridgeAdaptersToEnable(
    Addresses memory addresses
  ) public view override returns (ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[] memory) {
    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory bridgeAdaptersToEnable = new ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[](
        1
      );

    // ethereum path
    Addresses memory ethereumAddresses = _getAddresses(TestNetChainIds.ETHEREUM_SEPOLIA);

    bridgeAdaptersToEnable[0] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.ccipAdapter,
      destinationBridgeAdapter: ethereumAddresses.ccipAdapter,
      destinationChainId: ethereumAddresses.chainId
    });
    bridgeAdaptersToEnable[1] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.lzAdapter,
      destinationBridgeAdapter: ethereumAddresses.lzAdapter,
      destinationChainId: ethereumAddresses.chainId
    });
    bridgeAdaptersToEnable[2] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.hlAdapter,
      destinationBridgeAdapter: ethereumAddresses.hlAdapter,
      destinationChainId: ethereumAddresses.chainId
    });

    return bridgeAdaptersToEnable;
  }
}

contract Avalanche_testnet is BaseCCFSenderAdapters {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.AVALANCHE_FUJI;
  }

  function getBridgeAdaptersToEnable(
    Addresses memory addresses
  ) public view override returns (ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[] memory) {
    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory bridgeAdaptersToEnable = new ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[](
        3
      );

    // ethereum path
    Addresses memory ethereumAddresses = _getAddresses(TestNetChainIds.ETHEREUM_SEPOLIA);

    bridgeAdaptersToEnable[0] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.ccipAdapter,
      destinationBridgeAdapter: ethereumAddresses.ccipAdapter,
      destinationChainId: ethereumAddresses.chainId
    });
    bridgeAdaptersToEnable[1] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.lzAdapter,
      destinationBridgeAdapter: ethereumAddresses.lzAdapter,
      destinationChainId: ethereumAddresses.chainId
    });
    bridgeAdaptersToEnable[2] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: addresses.hlAdapter,
      destinationBridgeAdapter: ethereumAddresses.hlAdapter,
      destinationChainId: ethereumAddresses.chainId
    });

    return bridgeAdaptersToEnable;
  }
}
