import Vuex from 'vuex'
import Vue from 'vue'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    schools: [
      {
        name: 'Lambda School',
        logo: 'lambda-logo.png',
        terms: [
          'Pay <b>2.2%</b> of your annual income only if your salary reaches the <b>$4,166 monthly threshold</b>'
        ],
        stats: {
          rate: '2.2%',
          employment_rate: '97%',
          months_to_repay: '78'
        }
      },
      {
        name: 'Purdue University Computer Science',
        logo: 'purdue-logo.png',
        terms: [
          'Pay <b>2.6%</b> of your annual income only if your salary reaches the <b>$4,166 monthly threshold</b>'
        ],
        stats: {
          rate: '2.6%',
          employment_rate: '87%',
          months_to_repay: '88'
        }
      }
    ],
  },
  
  getters: {
    
  },
  
  mutations: {
    
  },
  
  actions: {
    
  }
});