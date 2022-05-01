<template>
  <div>
    <h1>FAQs and Disclaimers</h1>
    <br>
    <div class="accordion" role="tablist">
      <b-card
        no-body
        bg-variant="dark"
        text-variant="light"
        class="mb-1 text-left"
      >
        <b-card-header header-tag="header" class="p-1" role="tab">
          <b-button block v-b-toggle.accordion-1 variant="dark"
            >My transaction succeeded. Where's my NFT?</b-button
          >
        </b-card-header>
        <b-collapse
          id="accordion-1"
          visible
          accordion="my-accordion"
          role="tabpanel"
        >
          <b-card-body>
            <b-card-text>
              <p class="text-left">
                The NFTs are sent directly to your wallet. 
              </p>
            </b-card-text>
            <b-card-text>{{ text }}</b-card-text>
          </b-card-body>
        </b-collapse>
      </b-card>

      <b-card
        no-body
        bg-variant="dark"
        text-variant="light"
        class="mb-1 text-left"
      >
        <b-card-header header-tag="header" class="p-1" role="tab">
          <b-button block v-b-toggle.accordion-2 variant="dark"
            >Am I guarenteed to get the NFT?</b-button
          >
        </b-card-header>
        <b-collapse
          id="accordion-2"
          visible
          accordion="my-accordion"
          role="tabpanel"
        >
          <b-card-body>
            <b-card-text>
              <p class="text-left">
                While there is a good chance you won't actually get the NFT,
                it's not quite as bad as one may think. This isn't an unknown
                opportunity at all so expect competition.
              </p>
              <table class="tg">
                <thead>
                  <tr>
                    <th class="tg-0lax">Pros</th>
                    <th class="tg-0lax">Cons</th>
                    <th class="tg-0lax">Uncertainty</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td class="tg-0lax">
                      Flashbots doesn't mine every block. If the opportunity is
                      available on a block Flashbots doesn't mine, no one using
                      Flashbots will succeed
                    </td>
                    <td class="tg-0lax">
                      Other people may use flashbots to bribe miners to secure
                      their mint. If the block is mined by Flashbots then it's unlikely you'll win
                    </td>
                    <td class="tg-0lax">
                      Gas prices will probably spike as people try and bid more
                      to mint first. This is why you must make sure to fund your
                      task with more than the bare minimum in anticipation of
                      gas spikes. Assuming there's enough gas, it's up to
                      Chainlink to use the appropriate amount for the market
                      conditions
                    </td>
                  </tr>
                </tbody>
              </table>
            </b-card-text>
            <b-card-text>{{ text }}</b-card-text>
          </b-card-body>
        </b-collapse>
      </b-card>

      <b-card
        no-body
        bg-variant="dark"
        text-variant="light"
        class="mb-1 text-left"
      >
        <b-card-header header-tag="header" class="p-1" role="tab">
          <b-button block v-b-toggle.accordion-3 variant="dark"
            >Will I lose money if the transaction reverts?</b-button
          >
        </b-card-header>
        <b-collapse id="accordion-3" accordion="my-accordion" role="tabpanel">
          <b-card-body>
            <b-card-text>Yes, you will lose some of the Link token you deposited. Deposit only what you are comfortable losing. Realize that this is a CALCULATED RISK. If you follow the guidelines you will have the best chance of success but it's not a guarentee!</b-card-text>
          </b-card-body>
        </b-collapse>
      </b-card>

      <b-card
        no-body
        bg-variant="dark"
        text-variant="light"
        class="mb-1 text-left"
      >
        <b-card-header header-tag="header" class="p-1" role="tab">
          <b-button block v-b-toggle.accordion-4 variant="dark"
            >It didn't work! I didn't make a profit!</b-button
          >
        </b-card-header>
        <b-collapse id="accordion-4" accordion="my-accordion" role="tabpanel">
          <b-card-body>
            <b-card-text>Sorry 😢</b-card-text>
          </b-card-body>
        </b-collapse>
      </b-card>
    </div>

  </div>
</template>
<script>
import Pagination from "../components/Pagination.vue";
export default {
  components: { Pagination },
};
</script>
<style scoped>
.tg {
  border-collapse: collapse;
  border-spacing: 0;
}
.tg td {
  border-color: black;
  border-style: solid;
  border-width: 1px;
  font-size: 14px;
  overflow: hidden;
  padding: 10px 5px;
  word-break: normal;
}
.tg th {
  border-color: black;
  border-style: solid;
  border-width: 1px;
  font-size: 14px;
  font-weight: normal;
  overflow: hidden;
  padding: 10px 5px;
  word-break: normal;
}
.tg .tg-0pky {
  border-color: inherit;
  text-align: left;
  vertical-align: top;
}
.tg .tg-0lax {
  text-align: left;
  vertical-align: top;
}
</style>