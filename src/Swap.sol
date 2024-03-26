// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {AggregatorV3Interface} from "lib/foundry-chainlink-toolkit/src/interfaces/feeds/AggregatorV3Interface.sol";
import {IERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";


contract Swap {

    AggregatorV3Interface internal datafeed;

    address ethUsdAddress = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
    address daiUsdAddress = 0x14866185B1962B63C3Ea9E03Bc1da838bab34C19;
    address linkUsdAddress = 0xc59E3633BAAC79493d908e63626716e204A45EdF;

    function swapEthToLink(uint _amount) external {

        //WETH address
        require(IERC20(0x7b79995e5f793A07Bc00c21412e50Ecae098E7f9).transferFrom(msg.sender, address(this), _amount), "Transfer Failed");

        (int ethUsdRate, int linkUsdRate) = getRate(ethUsdAddress, linkUsdAddress);

        uint amountOfEthinUsd = _amount * uint(ethUsdRate);

        uint eqAmountofLink = amountOfEthinUsd / uint(linkUsdRate);
        
        //LINK address
        require(IERC20(0x779877A7B0D9E8603169DdbD7836e478b4624789).transferFrom(address(this), msg.sender, eqAmountofLink), "Failed!");

    }

    function swapLinkToEth(uint _amount) external {

        //LINK address
        require(IERC20(0x779877A7B0D9E8603169DdbD7836e478b4624789).transfer(address(this), _amount), "Transfer Failed");

        (int linkUsdRate, int ethUsdRate) = getRate(linkUsdAddress, ethUsdAddress);

        uint amountOfLINKinUsd = _amount * uint(linkUsdRate);

        uint eqAmountofEth = amountOfLINKinUsd / uint(ethUsdRate);

            
        //WETH address
        require(IERC20(0x7b79995e5f793A07Bc00c21412e50Ecae098E7f9).transferFrom(address(this), msg.sender, eqAmountofEth), "Failed!");

    }

    function swapLinkToDai(uint _amount) external {

        //LINK address
        require(IERC20(0x779877A7B0D9E8603169DdbD7836e478b4624789).transfer(address(this), _amount), "Transfer Failed");

        (int linkUsdRate, int daiUsdRate) = getRate(linkUsdAddress, daiUsdAddress);

        uint amountOfLINKinUsd = _amount * uint(linkUsdRate);

        uint eqAmountofdai = amountOfLINKinUsd / uint(daiUsdRate);

            
        //DAI address
        require(IERC20(0x3e622317f8C93f7328350cF0B56d9eD4C620C5d6).transferFrom(address(this), msg.sender, eqAmountofdai), "Failed!");
    }

    function swapDaiToLink(uint _amount) external {

        //DAI address
        require(IERC20(0x3e622317f8C93f7328350cF0B56d9eD4C620C5d6).transfer(address(this), _amount), "Transfer Failed"); 

        (int daiUsdRate, int linkUsdRate) = getRate(daiUsdAddress, linkUsdAddress);

        uint amountOfDAIinUsd = _amount * uint(daiUsdRate);

        uint eqAmountofLINK = amountOfDAIinUsd / uint(linkUsdRate);

            
        //LINK address
        require(IERC20(0x779877A7B0D9E8603169DdbD7836e478b4624789).transferFrom(address(this), msg.sender, eqAmountofLINK), "Failed!");
    }

    function swapDaiToEth(uint _amount) external {

        //DAI address
        require(IERC20(0x3e622317f8C93f7328350cF0B56d9eD4C620C5d6).transfer(address(this), _amount), "Transfer Failed"); 

        (int daiUsdRate, int ethUsdRate) = getRate(daiUsdAddress, ethUsdAddress);

        uint amountOfDAIinUsd = _amount * uint(daiUsdRate);

        uint eqAmountofETH = amountOfDAIinUsd / uint(ethUsdRate);

            
        //WETH address
        require(IERC20(0x7b79995e5f793A07Bc00c21412e50Ecae098E7f9).transferFrom(address(this), msg.sender, eqAmountofETH), "Failed!");
    }

    function swapEthToDAI(uint _amount) external {

        //WETH address
        require(IERC20(0x7b79995e5f793A07Bc00c21412e50Ecae098E7f9).transfer(address(this), _amount), "Transfer Failed"); 

        (int ethUsdRate, int daiUsdRate) = getRate(ethUsdAddress, daiUsdAddress);

        uint amountOfDAIinUsd = _amount * uint(ethUsdRate);

        uint eqAmountofDAI = amountOfDAIinUsd / uint(daiUsdRate);

            
        //DAI address
        require(IERC20(0x3e622317f8C93f7328350cF0B56d9eD4C620C5d6).transferFrom(address(this), msg.sender, eqAmountofDAI), "Failed!");
    }


    function getRate(address _from, address _to) internal returns(int fromRate, int toRate){

        datafeed = AggregatorV3Interface(_from);

        (/*do not need*/,
        fromRate,
        /*do not need*/,
        /*do not need*/,
        /*do not need*/) = datafeed.latestRoundData();

        datafeed = AggregatorV3Interface(_to);

         (/*do not need*/,
        toRate,
        /*do not need*/,
        /*do not need*/,
        /*do not need*/) = datafeed.latestRoundData();

    }

}