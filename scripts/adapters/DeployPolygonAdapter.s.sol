contract Ethereum is BasePolygonAdapter {
  function FX_TUNNEL() public pure override returns (address) {
    return 0xF30FA9e36FdDd4982B722432FD39914e9ab2b033;
  }

  function TRANSACTION_NETWORK() public pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function REMOTE_NETWORKS() public pure override returns (uint256[] memory) {
    uint256[] memory remoteNetworks = new uint256[](1);
    remoteNetworks[0] = ChainIds.POLYGON;
    return remoteNetworks;
  }

  function _deployAdapter(
    DeployerHelpers.Addresses memory addresses,
    IBaseAdapter.TrustedRemotesConfig[] memory trustedRemotes
  ) internal override {
    addresses.polAdapter = address(
      new PolygonAdapterEthereum(
        addresses.crossChainController,
        FX_TUNNEL(),
        GET_BASE_GAS_LIMIT(),
        trustedRemotes
      )
    );
  }
}

contract Polygon is BasePolygonAdapter {
  function FX_TUNNEL() public pure override returns (address) {
    return 0xF30FA9e36FdDd4982B722432FD39914e9ab2b033;
  }

  function TRANSACTION_NETWORK() public pure override returns (uint256) {
    return ChainIds.POLYGON;
  }

  function REMOTE_NETWORKS() public pure override returns (uint256[] memory) {
    uint256[] memory remoteNetworks = new uint256[](1);
    remoteNetworks[0] = ChainIds.ETHEREUM;
    return remoteNetworks;
  }

  function _deployAdapter(
    DeployerHelpers.Addresses memory addresses,
    IBaseAdapter.TrustedRemotesConfig[] memory trustedRemotes
  ) internal override {
    console2.log(addresses.crossChainController);

    addresses.polAdapter = address(
      new PolygonAdapterPolygon(
        addresses.crossChainController,
        FX_TUNNEL(),
        GET_BASE_GAS_LIMIT(),
        trustedRemotes
      )
    );
  }
}

// careful as this is deployed on goerli
contract Ethereum_testnet is BasePolygonAdapter {
  function FX_TUNNEL() public pure override returns (address) {}

  function TRANSACTION_NETWORK() public pure override returns (uint256) {
    return TestNetChainIds.ETHEREUM_GOERLI;
  }

  function REMOTE_NETWORKS() public pure override returns (uint256[] memory) {
    uint256[] memory remoteNetworks = new uint256[](1);
    remoteNetworks[0] = TestNetChainIds.POLYGON_MUMBAI;
    return remoteNetworks;
  }

  function _deployAdapter(
    DeployerHelpers.Addresses memory addresses,
    IBaseAdapter.TrustedRemotesConfig[] memory trustedRemotes
  ) internal override {
    addresses.polAdapter = address(
      new PolygonAdapterGoerli(
        addresses.crossChainController,
        FX_TUNNEL(),
        GET_BASE_GAS_LIMIT(),
        trustedRemotes
      )
    );
  }
}

// careful as the path is with goerli
contract Polygon_testnet is BasePolygonAdapter {
  function FX_TUNNEL() public pure override returns (address) {}

  function TRANSACTION_NETWORK() public pure override returns (uint256) {
    return TestNetChainIds.POLYGON_MUMBAI;
  }

  function REMOTE_NETWORKS() public pure override returns (uint256[] memory) {
    uint256[] memory remoteNetworks = new uint256[](1);
    remoteNetworks[0] = TestNetChainIds.ETHEREUM_GOERLI;
    return remoteNetworks;
  }

  function _deployAdapter(
    DeployerHelpers.Addresses memory addresses,
    IBaseAdapter.TrustedRemotesConfig[] memory trustedRemotes
  ) internal override {
    addresses.polAdapter = address(
      new PolygonAdapterMumbai(
        addresses.crossChainController,
        FX_TUNNEL(),
        GET_BASE_GAS_LIMIT(),
        trustedRemotes
      )
    );
  }
}
