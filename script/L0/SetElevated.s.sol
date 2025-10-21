// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Script, console} from "forge-std/Script.sol";
import {Helper} from "./Helper.sol";
import {ElevatedMinterBurner} from "../../src/layerzero/ElevatedMinterBurner.sol";
import {OFTUSDTadapter} from "../../src/layerzero/OFTUSDTAdapter.sol";
import {USDTk} from "../../src/BridgeToken/USDTk.sol";

contract SetElevated is Script, Helper {
    address public owner = vm.envAddress("PUBLIC_KEY");
    ElevatedMinterBurner public elevatedminterburner;

    function run() external {
        vm.createSelectFork(vm.rpcUrl("arb_mainnet"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        _setElevated();
        _setOperator();

        vm.stopBroadcast();
    }

    function _setElevated() internal {
        elevatedminterburner = new ElevatedMinterBurner(address(ARB_USDTK), owner);
        elevatedminterburner.setOperator(address(ARB_OFT_USDTK_ADAPTER), true);
        OFTUSDTadapter(ARB_OFT_USDTK_ADAPTER).setElevatedMinterBurner(address(elevatedminterburner));
        console.log("address public ARB_USDTK_ELEVATED_MINTER_BURNER =", address(elevatedminterburner), ";");
    }

    function _setOperator() internal {
        USDTk(ARB_USDTK).setOperator(ARB_USDTK_ELEVATED_MINTER_BURNER, true);
        USDTk(ARB_USDTK).setOperator(ARB_OFT_USDTK_ADAPTER, true);
    }
}

// RUN
// forge script SetElevated --broadcast -vvv
