contract Ethereum is BaseOpAdapter {
  function OVM() public pure override returns (address) {
    return 0x25ace71c97B33Cc4729CF772ae268934F7ab5fA1;
  }

  function TRANSACTION_NETWORK() public pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function REMOTE_NETWORKS() public pure override returns (uint256[] memory) {
    uint256[] memory remoteNetworks = new uint256[](0);

    return remoteNetworks;
  }
}

contract Optimism is BaseOpAdapter {
  function OVM() public pure override returns (address) {
    return 0x4200000000000000000000000000000000000007;
  }

  function TRANSACTION_NETWORK() public pure override returns (uint256) {
    return ChainIds.OPTIMISM;
  }

  function REMOTE_NETWORKS() public pure override returns (uint256[] memory) {
    uint256[] memory remoteNetworks = new uint256[](1);
    remoteNetworks[0] = ChainIds.ETHEREUM;

    return remoteNetworks;
  }
}

contract Ethereum_testnet is BaseOpAdapter {
  function OVM() public pure override returns (address) {
    return 0x5086d1eEF304eb5284A0f6720f79403b4e9bE294;
  }

  function isTestnet() public pure override returns (bool) {
    return true;
  }

  function TRANSACTION_NETWORK() public pure override returns (uint256) {
    return TestNetChainIds.ETHEREUM_GOERLI;
  }

  function REMOTE_NETWORKS() public pure override returns (uint256[] memory) {
    uint256[] memory remoteNetworks = new uint256[](0);

    return remoteNetworks;
  }
}

contract Optimism_testnet is BaseOpAdapter {
  function OVM() public pure override returns (address) {
    return 0x4200000000000000000000000000000000000007;
  }

  function isTestnet() public pure override returns (bool) {
    return true;
  }

  function TRANSACTION_NETWORK() public pure override returns (uint256) {
    return TestNetChainIds.OPTIMISM_GOERLI;
  }

  function REMOTE_NETWORKS() public pure override returns (uint256[] memory) {
    uint256[] memory remoteNetworks = new uint256[](1);
    remoteNetworks[0] = TestNetChainIds.ETHEREUM_GOERLI;

    return remoteNetworks;
  }
}
