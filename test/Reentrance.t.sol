// SPDX-License-Identifier: Unlicense
pragma solidity >=0.6.0;
pragma experimental ABIEncoderV2;

import "./utils/BaseTest.sol";
import "src/levels/Reentrance.sol";
import "src/levels/ReentranceFactory.sol";

contract TestReentrance is BaseTest {
    Reentrance private level;

    constructor() public {
        // SETUP LEVEL FACTORY
        levelFactory = new ReentranceFactory();
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

        uint256 insertCoin = ReentranceFactory(payable(address(levelFactory))).insertCoin();
        levelAddress = payable(this.createLevelInstance{value: insertCoin}(true));
        level = Reentrance(levelAddress);

        // Check that the contract is correctly setup
        assertEq(address(level).balance, insertCoin);
    }

    function exploitLevel() internal override {
        /** CODE YOUR EXPLOIT HERE */

        vm.startPrank(player, player);

        vm.stopPrank();
    }
}
