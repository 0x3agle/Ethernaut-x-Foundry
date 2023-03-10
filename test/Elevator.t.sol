// SPDX-License-Identifier: Unlicense
pragma solidity >=0.6.0;
pragma experimental ABIEncoderV2;

import "./utils/BaseTest.sol";
import "src/levels/Elevator.sol";
import "src/levels/ElevatorFactory.sol";

contract TestElevator is BaseTest {
    Elevator private level;

    constructor() public {
        // SETUP LEVEL FACTORY
        levelFactory = new ElevatorFactory();
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
        level = Elevator(levelAddress);

        // Check that the contract is correctly setup
        assertEq(level.top(), false);
    }

    function exploitLevel() internal override {
        /** CODE YOUR EXPLOIT HERE */

        vm.startPrank(player, player);

        vm.stopPrank();
    }
}
