import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)


import Web3Modal from "web3modal";
import WalletConnectProvider from "@walletconnect/web3-provider";
//import { markRaw } from 'vue';
const { providers, Wallet, ethers, BigNumber } = require("ethers");
const NATIVE_TOKEN = "0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE"

export default new Vuex.Store({
  state: {
    Rinkeby:{
      DotDotDot: "0xA7C07884442C407A1D97Ef86C0c305a1A45a264B",
      DotDotDotPrinter: "0xC381Ae8a22825aa95A49e8e10D09C0466d937e1D",
      WETH: "0xc778417e063141139fce010982780140aa0cd5ab"
    },
    DotDotDotPrice: 0.05,
    web3Modal: null,
    serviceFee: 0,
    provider: null,
    network: null,
    signer: null,
    user: null,  
    //contract: markRaw(new ethers.Contract("0x503cdba19c484fc4aec22f0e8f3dc37a5c327c27", require("../../../ABI/Babysitter.json"), new providers.JsonRpcProvider({ url: RPC }, CHAIN_ID))),
    send: async function(tx, provider){
      await provider.send('eth_sendTransaction',[{from: tx.from, to: tx.to, data: tx["data"], value: tx["value"]}])
    },
    generateCalldata: function(buyer, amount){
      return ethers.utils.defaultAbiCoder.encode(["address","uint256"],[buyer, amount])
    }
  },
  mutations: {
    setWeb3Modal(state, payload){
      state.web3Modal = payload //markRaw(payload)
    },
    setSigner(state, payload){
      state.signer = payload //markRaw(payload)
    },
    setProvider(state, payload){
      state.provider = payload //markRaw(payload)
    },
    setNetwork(state, payload){
      state.network = payload 
    },
    setServiceFee(state, payload){
      state.serviceFee = payload
    },
    setUser(state, payload){
      state.user = payload
    }, 
    setContract(state, payload){
      state.contract = payload
    }
  },
  actions: {
    async Connect({ commit, state }) {
      const providerOptions = {
        walletconnect: {
          package: WalletConnectProvider, // required
          options: {
            infuraId: "INFURA_ID" // required
          }
        }
      };
      const web3Modal = new Web3Modal({
        cacheProvider: true, // optional
        providerOptions // required
      });

      const provider = new providers.Web3Provider(await web3Modal.connect());
      const signer = provider.getSigner();
      commit('setSigner', signer)
      commit('setUser', await signer.getAddress())
      commit('setProvider', provider)
      commit('setNetwork', (await provider.getNetwork()).name)
      commit('setWeb3Modal', web3Modal)
      //commit('setContract', markRaw(new ethers.Contract("0x503cdba19c484fc4aec22f0e8f3dc37a5c327c27", require("../../../ABI/Babysitter.json"), signer)))
    },
    async Disconnect({ state, commit }) {
      await state.web3Modal.clearCachedProvider();
      commit('setSigner', null)
      commit('setProvider', null)
      commit('setNetwork', null)
      window.location.reload();
    },
    async Approve({state}, amount){
      amount = amount ? ethers.utils.parseEther(amount.toString()) : ethers.constants.MaxUint256
      if(state.network.toLowerCase() == "rinkeby"){
        //let contract = new ethers.Contract(state.Rinkeby.DotDotDotPrinter, require("../assets/ABIs/DotDotDotPrinter.json"), state.provider)
        let WETH = new ethers.Contract(state.Rinkeby.WETH, require("../assets/ABIs/WETH.json"), state.signer)
        let tx = await WETH.populateTransaction["approve(address,uint256)"](state.Rinkeby.DotDotDotPrinter,amount)
        await state.send(tx, state.provider)
      }
      else if(state.network.toLowerCase() == "homestead"){
        let WETH = new ethers.Contract(state.Homestead.WETH, require("../assets/ABIs/WETH.json"), state.provider)
        let tx = await WETH.populateTransaction["approve(address,uint256)"](state.Homestead.DotDotDotPrinter,amount)
        await state.send(tx, state.provider)
      }
    },
    async IncreaseSupply({state}){
      if(state.network.toLowerCase() == "rinkeby"){
        let contract = new ethers.Contract(state.Rinkeby.DotDotDot, require("../assets/ABIs/DotDotDots.json"), state.signer)
        let current = await contract.MAX_SUPPLY()
        let tx = await contract.populateTransaction["setMaxTokenSupply(uint256)"](current.add(BigNumber.from(5)))
        await state.send(tx, state.provider)
      }  
    },
    async toggleSale({state}){
      let contract = new ethers.Contract(state.Rinkeby.DotDotDot, require("../assets/ABIs/DotDotDots.json"), state.signer)
      let tx = await contract.populateTransaction["flipSaleState()"]()
      // let tx = await contract.populateTransaction["setBaseURI(string)"]("https://dotdotdotnft.herokuapp.com/api/")
      await state.send(tx, state.provider)
    }
  },
  modules: {
  }
})
