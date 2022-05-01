<template>
  <div>
    <b-card bg-variant="dark" text-variant="light" class="text-left">
      <template #header> 1. Aquire Testnet WETH and Testnet LINK </template>
      <p>First get some Rinkeby ETH from the faucet</p>
      <b-button class="mr-2" href="https://rinkebyfaucet.com/"
        >Free Rinkeby ETH</b-button
      >
      <br />
      <br />
      <p>
        You need .05 WETH per DotDotDot you want to purchase. You can swap for
        them on Uniswap
      </p>
      <b-button
        class="mr-2"
        href="https://app.uniswap.org/#/swap?chain=rinkeby&inputCurrency=ETH&outputCurrency=WETH"
        >Get Testnet WETH</b-button
      >
      <b-button class="ml-2" href="https://faucets.chain.link/rinkeby"
        >Get Testnet LINK</b-button
      >
    </b-card>
    <br />
    <b-card bg-variant="dark" text-variant="light" class="text-left">
      <template #header>
        2. Approve the DotDotDots Printer contract to use your Testnet WETH
      </template>
      <p>
        The DotDotDotPrinter contract will attempt to pull Testnet WETH from
        your address to pay for your NFTs. Funds will only be deducted in the
        case of a successful purchase. It costs
        {{ this.$store.state.DotDotDotPrice }} WETH per DotDotDot{{
          $store.state.serviceFee
            ? " plus a service fee of " + $store.state.serviceFee + " WETH"
            : ""
        }}.
      </p>
      <b-input-group prepend="NFTs to Purchase" class="mt-3">
        <b-form-input
          variant="dark"
          v-model="amount"
          type="number"
          min="1"
          max="5"
        ></b-form-input>
        <b-input-group-append>
          <b-button variant="outline-light" @click="approve(price)"
            >Approve {{ price }} WETH</b-button
          >
        </b-input-group-append>
      </b-input-group>
    </b-card>
    <br />
    <b-card bg-variant="dark" text-variant="light" class="text-left">
      <template #header> 3. Set up Chainlink Keepers for Rinkeby</template>
      <p>
        Next, you'll need to register your task for Chainlink to upkeep. These
        are the parameters you need:
        <br />
        <br />
        Email address: <code>your email address</code> <br />
        Upkeep name: <code>a unique name</code> <br />
        Upkeep address:
        <code>{{ $store.state.Rinkeby["DotDotDotPrinter"] }}</code> <br />
        Admin address: <code>{{ $store.state.user }}</code> <br />
        Gas limit: <code>300000</code> <br />
        Check data (Hexadecimal): <code>{{ calldata }}</code> Starting balance
        (MINIMUM): <code>5</code> <br />
      </p>
      <br />
      <b-button href="https://keepers.chain.link/new">Register</b-button>
      <b-button class="d-none" @click="toggleSale()">toggle</b-button>
    </b-card>
    <br />
    <!-- <b-card bg-variant="dark" text-variant="light" class="text-left">
      <template #header>
        4. Increase the Max Supply on the Rinkeby DotDotDots contract (optional)</template
      >
      <p>
        To make testing less annoying, we redeployed the DotDotDots NFT contract
        on Rinkeby to without the 'onlyOwner' modifier on the
        'setMaxTokenSupply' function. Anyone can increase the max supply with a
        simple function call, so that the Chainlink Keepers have something to
        find. 
      </p>
      <b-button @click="increaseSupply()">Supply +5</b-button>
    </b-card> -->
    <br />
    <b-card bg-variant="dark" text-variant="light" class="text-left">
      <template #header> 4. Wait! </template>
      <p>
        Chainlink Keepers should figure out that there is DotDotDots to print
        immediately, then it should successfully execute the function. Depending
        on how long it takes blocks to be mined on Rinkeby, it shouldn't be long
        before you should see a new NFT sent to your address.
      </p>
    </b-card>
  </div>
</template>
<script>
export default {
  name: "instructions",
  data() {
    return {
      amount: 1,
    };
  },
  methods: {
    async approve(amount) {
      try {
        await this.$store.dispatch("Approve", amount);
        this.$bvToast.toast("The transaction succeeded", {
          title: "Success",
        });
      } catch (err) {
        this.$bvToast.toast(err["message"], {
          title: "Error",
        });
      }
    },
    async increaseSupply() {
      try {
        await this.$store.dispatch("IncreaseSupply");
        this.$bvToast.toast("The transaction succeeded", {
          title: "Success",
        });
      } catch (err) {
        this.$bvToast.toast(err["message"], {
          title: "Error",
        });
      }
    },
    async toggleSale() {
      // try {
        await this.$store.dispatch("toggleSale");
        this.$bvToast.toast("The transaction succeeded", {
          title: "Success",
        });
      // } catch (err) {
      //   this.$bvToast.toast(err["message"], {
      //     title: "Error",
      //   });
      // }
    },    
  },
  computed: {
    price() {
      return (
        (
          this.$store.state.DotDotDotPrice * this.amount +
          this.$store.state.serviceFee
        ).toFixed(4) || 0
      );
    },
    calldata() {
      return this.$store.state.generateCalldata(
        this.$store.state.user,
        this.amount
      );
    },
  },
};
</script>