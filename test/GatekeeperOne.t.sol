// SPDX-License-Identifier: Unlicense
pragma solidity >=0.6.0;
pragma experimental ABIEncoderV2;

import "./utils/BaseTest.sol";
import "src/levels/GatekeeperOne.sol";
import "src/levels/GatekeeperOneFactory.sol";
import "forge-std/console.sol";

contract TestGatekeeperOne is BaseTest {
    GatekeeperOne private level;

    constructor() public {
        // SETUP LEVEL FACTORY
        levelFactory = new GatekeeperOneFactory();
    }

    function setUp() public override {
        // Call the BaseTest setUp() function that will also create testsing accounts
        super.setUp();
    }

    function testRunLevel() public {
        runLevel();
    }

    function setupLevel() internal override {
        /** CODE YOUR SETUP HERE */

        levelAddress = payable(this.createLevelInstance(true));
        level = GatekeeperOne(levelAddress);

        // Check that the contract is correctly setup
        assertEq(level.entrant(), address(0));
    }

    function exploitLevel() internal override {
        /** CODE YOUR EXPLOIT HERE */

        vm.prank(player, player);

        // Check we have solved the challenge
        assertEq(level.entrant(), player);
    }
}
