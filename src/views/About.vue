<template>
  <div class="about">
    <h1>What is a DotDotDot?</h1>
    <b-row height="10%" class="mx-auto">
      <b-col>
      </b-col>
      <b-col>
        <dot-dot-dots></dot-dot-dots>
      </b-col>
      <b-col>
        <dot-dot-dots></dot-dot-dots>
      </b-col>
      <b-col>
        <dot-dot-dots></dot-dot-dots>
      </b-col>
      <b-col>
      </b-col>
      </b-row>
    <br>
      <p class="text-left">
        DotDotDots are an NFT collection created in January 2022. It doesn't have a roadmap or a marketing team. There's a lot of mystery behind them and their creator, which is what makes it popular. 
        <a href="https://medium.com/@rabbidfly/dotdotdots-just-an-nft-puzzle-or-something-more-ominous-693be5091bb9">It seems to be an on-chain puzzle of some sort with every NFT playing a part in it. </a> They're also pretty cute in my opinion.
        Anyway, here's the relevant parts of it:
        <ul>
          <li>DotDotDots has a weird gimic where the max supply of the NFT is linked to the price of Ether. </li>
          <li>Every time Ether reaches a new all time high, more DotDotDots will be able to be minted up to a maximum of 10,000 total supply.</li>
          <li>It costs 0.05 ETH to mint a new DotDotDot.</li>
          <li>The current floor price of DotDotDots on <a href="https://opensea.io/collection/dotdotdots">OpenSea</a> (as of April 2022) is 0.15 ETH</li>
          <li>... therefore, if you mint the DotDotDot as soon as the max supply increases, you can flip it for almost 3x your investment (ignoring gas costs)</li>
          <li>Let's get some juicy <a href="https://ethereum.org/en/developers/docs/mev/">MEV</a> profits!</li>
        </ul>
      </p>

    </div>
</template>
<script>
import DotDotDots from "../components/DotDotDots.vue";
import Pagination from "../components/Pagination.vue";
export default {
  components: { Pagination, DotDotDots },
};
</script>