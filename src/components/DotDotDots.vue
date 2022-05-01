<template>
    <div>
        <b-card
          no-body
          bg-variant="dark"
          text-variant="white"
          :footer="'DotDotDots #'+(tokenId || 3140)"
          :img-src="source || 'https://gateway.pinata.cloud/ipfs/QmVqMYxaEkifE7FoMkdNtryXhPNgHwA89msFQUBQbEYwKE/images/3140.png'"
          :onerror="onerror"
        ></b-card>
    </div>
</template>
<script>
export default {
    name: 'animateddotdotdots',
    props: ['hover'],
    data(){
        return {
            source: null,
            animation: null,
            tokenId: null,
            onerror: null,
        }
    },
    // methods: { 
    //     animate(){
    //         if(this.animation){ console.log("An animation is already ongoing"); return }
    //         let i = 0
    //         this.animation = setInterval(function(){
    //             if(i > this.sources.length){ i = 0 }
    //             this.tokenId = this.sources[i]
    //             this.source = `../src/assets/DotDotDots/${this.tokenId}.png`
    //             i++
    //         }.bind(this), 5000)
    //     },
    //     stop(){
    //         if(!this.animation){ console.log("there is no animation to clear");  return }
    //         clearInterval(this.animation)
    //         this.animation = null
    //     }

    // },
    mounted(){
        // get 15 random dotdotdots images
        //this.tokenId = Math.floor(Math.random() * 4870)//sources[Math.floor(Math.random() * sources.length)]
        //this.source = "https://gateway.pinata.cloud/ipfs/QmVqMYxaEkifE7FoMkdNtryXhPNgHwA89msFQUBQbEYwKE/images/" + this.tokenId + ".png"
        this.tokenId = [477,671,1585,1689,1780,2034,2537,3068,3976,4819][Math.floor(Math.random()*10)]
        this.source = require("@/assets/DotDotDots/" + this.tokenId + ".png")
        this.onerror = "this.onerror=null;this.src='" + require("@/assets/DotDotDots/" + [477,671,1585,1689,1780,2034,2537,3068,3976,4819][Math.floor(Math.random()*10)] + ".png")+"'"

    }
}
</script>