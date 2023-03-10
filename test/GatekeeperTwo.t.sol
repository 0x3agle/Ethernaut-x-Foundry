// SPDX-License-Identifier: Unlicense
pragma solidity >=0.6.0;
pragma experimental ABIEncoderV2;

import "./utils/BaseTest.sol";
import "src/levels/GatekeeperTwo.sol";
import "src/levels/GatekeeperTwoFactory.sol";

contract TestGatekeeperTwo is BaseTest {
    GatekeeperTwo private level;

    constructor() public {
        // SETUP LEVEL FACTORY
        levelFactory = new GatekeeperTwoFactory();
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
        level = GatekeeperTwo(levelAddress);

        // Check that the contract is correctly setup
        assertEq(level.entrant(), address(0));
    }

    function exploitLevel() internal override {
        vm.prank(player, player);

        assertEq(level.entrant(), player);
    }
}
