// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console, Vm} from "forge-std/Test.sol";
import {Swap} from "../src/Swap.sol";
import {IERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract SwapTest is Test {
    Swap public swap;

    address DAIAddressHolder = 0x71C7656EC7ab88b098defB751B7401B5f6d8976F;
    address LINKHolderAddress = 0xC7Ce6bfe1E69e58557a21Ad6E832d26cA8FB03AE;
    address EthHolderAddress = 0x6c7ADA9da10a7185C8E12dF2d13563A02F92F38f;

    function setUp() public {
        swap = new Swap();
      
    }

    function test_swapEthtoLink() public {
        string memory url = "https://eth-sepolia.g.alchemy.com/v2/dxQbx8DUIKZTbw_qS1qSvmUBKm-GnJGH";
        vm.createFork(url);

        vm.startPrank(LINKHolderAddress);
        console.log("MSG Sender:", msg.sender);
        
        uint amount = 1000000;

        IERC20(0x779877A7B0D9E8603169DdbD7836e478b4624789).balanceOf(0xC7Ce6bfe1E69e58557a21Ad6E832d26cA8FB03AE);
        IERC20(0x779877A7B0D9E8603169DdbD7836e478b4624789).transferFrom(msg.sender, address(swap), amount);
       
        vm.stopPrank();

        // vm.startPrank(EthHolderAddress);
        // uint amount = 25000;

        // IERC20(0x7b79995e5f793A07Bc00c21412e50Ecae098E7f9).approve(address(swap), amount);

        // IERC20(0x7b79995e5f793A07Bc00c21412e50Ecae098E7f9).balanceOf(EthHolderAddress);



        // swap.swapEthToLink(amount);

        // assertEq(address(swap).balance, amount);
    }

    // function testFuzz_SetNumber(uint256 x) public {
    //     counter.setNumber(x);
    //     assertEq(counter.number(), x);
    // }
}
