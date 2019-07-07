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
          'Pay <b>17%</b> of your annual income only if your salary reaches the <b>$4,166 monthly threshold</b>'
        ],
        stats: {
          rate: '19%',
          employment_rate: '87%',
          months_to_repay: '78'
        },
        students: [
          { 
            id: 1,
            name: "Satya Narayana Nadella",
            gdp: "4.0",
            github: "https://github.com/satyanadella",
            internship: "Microsoft",
            enrolled: "07/01/2019"
          },
          {
            id: 2,
            name: "Nat Friedman",
            gdp: "4.0",
            github: "https://github.com/nat",
            internship: "Github",
            enrolled: "07/01/2019"
          }
        ]
      },
      {
        name: 'Purdue University Computer Science',
        logo: 'purdue-logo.png',
        terms: [
          'Pay <b>14%</b> of your annual income only if your salary reaches the <b>$4,166 monthly threshold</b>'
        ],
        stats: {
          rate: '24%',
          employment_rate: '97%',
          months_to_repay: '88'
        },
        students: [
          { 
            id: 3,
            name: "Brad Surak",
            gdp: "4.0",
            github: "",
            internship: "GE Digital",
            enrolled: "09/01/2018"
          },
          { 
            id: 4,
            name: "Beatrice Yormark" ,
            gdp: "4.0",
            github: "https://github.com/nat",
            internship: "Connect, Inc.",
            enrolled: "09/01/2018"
          }
        ]
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