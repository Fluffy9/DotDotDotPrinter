<template>
  <div>
    <h1>Let's get Printing</h1>
    <i>Available on Rinkeby Testnet</i>
    <div v-if="provider">
      <b-badge variant="light">Current Network: {{ network }}</b-badge
      ><br />
      <br />
      <hr class="border-solid text-white" />
      <div v-if="network == 'rinkeby'">
        <rinkeby-instructions></rinkeby-instructions>
      </div>
      <!-- <div v-else-if="network == 'homestead'">
        <b-card bg-variant="dark" text-variant="light" class="text-left">
          <template #header>
            1. Aquire <mark>WETH</mark> and <mark>LINK</mark>
          </template>
        </b-card>
        <br />
        <b-card bg-variant="dark" text-variant="light" class="text-left">
          <template #header>
            2. Approve the DotDotDots Printer contract to use your
            <mark>WETH</mark>
          </template>
        </b-card>
        <br />
        <b-card bg-variant="dark" text-variant="light" class="text-left">
          <template #header> 3. Set up Chainlink Keepers </template>
        </b-card>
        <br />
        <b-card bg-variant="dark" text-variant="light" class="text-left">
          <template #header> 4. Wait! </template>
        </b-card>
      </div> -->
      <b-alert class="text-left" show variant="danger" v-else>Please switch your network to Rinkeby Testnet and refresh the page</b-alert>
    </div>
    <div v-else>
      <p>Please connect your wallet to continue.</p>
      <connect></connect>
    </div>
  </div>
</template>
<script>
import Pagination from "../components/Pagination.vue";
import Connect from "../components/Connect.vue";
import RinkebyInstructions from "../components/Rinkeby/Instructions.vue"
export default {
  components: {
    Pagination,
    Connect,
    RinkebyInstructions

  },
  computed: {
    user() {
      return this.$store.state.user;
    },
    provider() {
      return this.$store.state.provider;
    },
    network() {
      return this.$store.state.network;
    },
  },
};
</script>