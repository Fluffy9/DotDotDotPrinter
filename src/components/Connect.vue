<template>
  <div>
    <b-button v-if="!$store.state.user" variant="light" @click="Connect()">Connect</b-button>
    <div v-else>
        <b-avatar alt="Ethereum blockies avatar" :src="blocky" :title="$store.state.user" @click="toggle()"></b-avatar>
        <b-badge variant="light" class="ml-2">{{$store.state.user.substring(0,10)}}...</b-badge>
    </div>
  </div>
</template>
<script>
import makeBlockie from 'ethereum-blockies-base64';
export default {
    name: "Connect",
    data(){
        return {
            dialog: false,
        }
    }, 
    methods: {
        async Connect(){
            this.$store.dispatch("Connect")
        },
        async Disconnect(){
            this.$store.dispatch("Connect")
        },
        toggle(){
            let modal = document.getElementById('dialog-default');  
            this.dialog = this.dialog ? false : true
            this.dialog ? modal.showModal() : modal.close();
        }
    },
    computed: {
        signer(){
            return this.$store.state.signer
        },
        blocky(){
            let user = this.$store.state.user
            if(user){
                return makeBlockie(user);
            }
            return ""
        }
    }
}

</script>