<template>
  <div id="app" class="text-white">
    <b-navbar toggleable="sm" type="dark" variant="faded" bg-variant="dark">
      <b-navbar-toggle target="nav-text-collapse"></b-navbar-toggle>

      <!-- <b-navbar-brand>DotDotDots Printer</b-navbar-brand> -->

      <b-collapse id="nav-text-collapse" is-nav>
        <b-navbar-nav>
          <b-nav-item to="/">Home</b-nav-item>
          <b-nav-item to="About">About</b-nav-item>
          <b-nav-item to="Print">Print</b-nav-item>
          <b-nav-item to="FAQs">FAQs</b-nav-item>
          <b-nav-item href="https://github.com/Fluffy9/DotDotDotPrinter"
            >Documentation</b-nav-item
          >
        </b-navbar-nav>
      </b-collapse>
      <b-navbar-nav class="ml-auto">
        <!-- <b-button variant="light">CONNECT</b-button> -->
        <connect></connect>
      </b-navbar-nav>
    </b-navbar>
    <div class="container h-100">
      <transition name="fade" mode="out-in">
        <router-view :key="$route.fullPath"></router-view>
      </transition>
    </div>
    <br />
  </div>
</template>
<script>
import Connect from "./components/Connect.vue";
export default {
  components: { Connect }, 
  
}
</script>

<style lang="scss">
// Import custom SASS variable overrides, or alternatively
// define your variable overrides here instead

$primary: #fffce8;
$dark: #20212c;

// Import Bootstrap and BootstrapVue source SCSS files
@import "~bootstrap/scss/bootstrap.scss";
@import "~bootstrap-vue/src/index.scss";
@import "~bootstrap-vue/src/icons.scss";

@font-face {
  font-family: "Abyss";
  src: url("./assets/fonts/Abyss.otf") format("opentype");
}
html,
body {
  background-color: $dark;
}
p,
mark,
.accordion {
  //font-family: Avenir, Helvetica, Arial, sans-serif;
  font-family: monospace;
}
mark {
  background-color: $primary;
}
#app {
  //font-family: Avenir, Helvetica, Arial, sans-serif;
  font-family: Abyss;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

#nav {
  padding: 30px;
}

#nav a {
  font-weight: bold;
  color: #2c3e50;
}

#nav a.router-link-exact-active {
  color: #42b983;
}
.fade-enter-active, .fade-leave-active {
  transition-property: opacity;
  transition-duration: .15s;
}

.fade-enter-active {
  transition-delay: .15s;
}

.fade-enter, .fade-leave-active {
  opacity: 0
}

</style>
