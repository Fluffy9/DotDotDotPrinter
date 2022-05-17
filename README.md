# DotDotDotPrinter
A bot to snipe the DotDotDot NFT collection

## What is it
DotDotDots are an NFT collection with an interesting gimmic that creates a MEV (Miner Extractable Value) opportunity. This repo contains a bot + Chainlink Keepers + a UI to capture the profit. Made for the Chainlink hackathon. The contracts are deployed on Rinkeby and there is also a demo video of its usage. 

## Why
This is actually a fully functioning, complete bot which could be deployed to mainnet. It may even be profitable. Why would I ruin something potentially profitable by putting it up on Github?

1. I have a suspicion that there are already bots for this opportunity. 
2. The risk/reward ratio here isn't to my preferences.
3. I like making pretty UI's sometimes.
4. I've added a fee (currently set at 0) to the contract, which you only pay if you successfully mint.
5. At the very least, it's a great repo for newbie Mevooors to learn from.

## How it Works
When ETH hits a new ATH (all time high), the max supply on the DotDotDots contract will increase. The mint price is only 0.05ETH, so you should easily be able to sell it for higher on OpenSea (where the floor is currently around 0.15 ETH) or another NFT marketplace. With Chainlink Keepers, we can effortlessly monitor the contract every block until the opportunity is present.

### The Contract
The contract implements Chainlinks' `KeeperCompatibleInterface`. The checkUpkeep function determines whether it's possible to mint a certain number of NFTs to a particular buyer. For that to be true: 
1. The buyer must be requesting 5 or less NFTs. The contract will only let you print 5 at a time.
2. The buyer must have enough WETH and give the contract enough allowance to pay for the mint cost (and fee) of the NFTs.
3. There needs to be enough supply available to mint for the buyer

When all these are true, the Keeper will call the `performUpkeep` function. This function unwraps the WETH to aquire ETH. It then uses the ETH to call `mint` on the DotDotDot contract. Lastly there are some sanity checks to ensure that funds were subtracted from the buyer and the buyer recieved the assets they paid for.

### Fees
As an extra feature, the contract has the ability to charge a service fee. This increases the amount of WETH the buyer must allow the contract to spend. The contract owner can later retrieve the collected fees using the `withdraw` function. The contract owner can change the fee with the `setFee` function. It's currently set to 0. 

### Risks
Luckily there is very little to exploit here. The contract never holds user funds, since pulling money from the users wallet and sending them a new NFT all happens in the same transaction.

## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).
