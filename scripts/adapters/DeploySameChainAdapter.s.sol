// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import '../BaseDeployerScript.sol';
import 'adi-scripts/Adapters/DeploySameChainAdapter.sol';

abstract contract DeploySameChainAdapter is BaseDeployerScript, BaseSameChainAdapter {
  function _execute(Addresses memory addresses) internal override {
    addresses.sameChainAdapter = _deployAdapter(
      address(0),
      new IBaseAdapter.TrustedRemotesConfig[](0)
    );
  }
}

contract Ethereum is DeploySameChainAdapter {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return ChainIds.ETHEREUM;
  }

  function REMOTE_CCC_BY_NETWORK() internal pure override returns (RemoteCCC[] memory) {
    return new RemoteCCC[](0);
  }
}

contract Ethereum_testnet is DeploySameChainAdapter {
  function TRANSACTION_NETWORK() internal pure override returns (uint256) {
    return TestNetChainIds.ETHEREUM_SEPOLIA;
  }

  function REMOTE_CCC_BY_NETWORK() internal pure override returns (RemoteCCC[] memory) {
    return new RemoteCCC[](0);
  }
}
