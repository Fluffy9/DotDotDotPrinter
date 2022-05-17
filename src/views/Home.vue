<template>
  <div>
    <h1 class="display-3 mt-4">DotDotDots Printer</h1>
    <b-row>
      <b-col>
        <dot-dot-dots></dot-dot-dots>
      </b-col>
      <b-col class="text-left">
        <h1>Welcome! Let's get straight to the point:</h1>
        <b-card role="button" bg-variant="dark" @click="$router.push('About')"
          >WTF is this?</b-card
        >
        <br />
        <b-card role="button" bg-variant="dark" @click="$router.push('Print')"
          >Let's get printing!</b-card
        >
        <br />
        <b-card role="button" bg-variant="dark" @click="$router.push('FAQs')"
          >FAQs/Disclaimers.</b-card
        >
        <br />
        <b-card
          role="button"
          bg-variant="dark"
          @click="
            window.location = 'https://github.com/Fluffy9/DotDotDotsPrinter'
          "
          >Documentation.</b-card
        >
        <br />
        <b-button variant="link" size="lg" @click="window.location='https://youtu.be/oXWZOmQJwQA'"
          ><b-icon-youtube variant="light"></b-icon-youtube
        ></b-button>
        <b-button variant="link" size="lg" @click="window.location='https://github.com/Fluffy9/DotDotDotsPrinter'"
          ><b-icon-github variant="light"></b-icon-github
        ></b-button>
        <b-button variant="link" size="lg" :href="'https://dashboard.tenderly.co/contract/rinkeby/' + $store.state.Rinkeby.DotDotDotPrinter + '/source'"
          ><b-icon-code-slash variant="light"></b-icon-code-slash
        > Rinkeby</b-button>
      </b-col>
    </b-row>
  </div>
</template>
<script>
import { BIcon, BIconGithub, BIconCodeSlash, BIconYoutube } from "bootstrap-vue";
import DotDotDots from "../components/DotDotDots.vue";
export default {
  components: { BIcon, BIconGithub, BIconCodeSlash, BIconYoutube, DotDotDots },
  data() {
    return {};
  },
};
</script>
<style scoped>
.display-3 {
  transition: font-family 0.2s;
}
</style>

