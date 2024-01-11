// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {DeployBasicNFT} from "../script/DeployBasicNFT.s.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract BasicNFTTest is Test {
    DeployBasicNFT public deployer;
    BasicNFT public basicNft;
    address public USER = makeAddr("user");
    string public constant URI ="https://ipfs.io/ipfs/bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
    uint256 public constant MINT_PRICE = 0.1 ether;

    function setUp() public {
        deployer = new DeployBasicNFT();
        basicNft = deployer.run();
    }   
//"BasicNFT", "BNFT"
    function testNameIsCorrect() public view {
        string memory expectedName = "BasicNFT";
        string memory actualName = basicNft.name();
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNFT(URI);

        assert(basicNft.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(URI)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));

    }
}