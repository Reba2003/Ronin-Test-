// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "forge-std/Test.sol";
import "./TransferUpgradeableProxy.sol";

contract TransferUpgradeableProxyTest is Test {
    TransferUpgradeableProxy proxy;
    address logic = address(0x1234); // replace with logic contract address

    function setUp() public {
        // Initialize the proxy contract with some initial Ether
        proxy = new TransferUpgradeableProxy{value: 1 ether}(logic, address(this), "");
    }

    function testLockedEther() public {
        // Check that the proxy has a balance of 1 ether
        assertEq(address(proxy).balance, 1 ether);

        // Try to withdraw the Ether (expected to fail)
        (bool success, ) = address(proxy).call(abi.encodeWithSignature("withdraw()"));
        
        // Assert that the call failed, indicating Ether is locked
        assertTrue(!success, "Ether should be locked in the contract");
    }
}
