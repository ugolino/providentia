<template>
  <v-container grid-list-md>
    <v-layout row wrap>
      <v-flex xs12>
        <h1 class="text-xs-center py-2">Portfolio</h1>
        <p class="headline text-xs-center">Check how your investment are performing</p>
      </v-flex>
      <v-flex xs12>
        <v-card
          light
          class="elevation-0"
          >
          <v-card-title secondary-title class="secondary white--text">
            <v-layout row justify-space-between wrap>
            <v-flex v-for="(header, index) in investmentsHeaders" :key="index" :class="header.class">
              {{ header.text }}
            </v-flex>
            </v-layout>
          </v-card-title>
          <v-container>
             <v-layout v-for="(investment, index) in investments" :key="index" row justify-space-between wrap xs12 class="py-3">
              <v-flex xs12 md4>
                <b>{{investment.name}}</b>
              </v-flex>
              <v-flex xs4 md2>
                {{investment.size}}
              </v-flex>
              <v-flex xs4 md2>
                {{investment.createdAt}}
              </v-flex>
              <v-flex xs4 md2 class="text-sm-right">
                <b>{{investment.return}}</b>
              </v-flex>
            </v-layout>
           
          </v-container>
           
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import { mapState } from 'vuex'

  export default {
    
    data() {
      return {
        investmentsHeaders: [
          {text: 'School', value: 'name', class: "xs6 md4" },
          {text: 'Amount', value: 'size', class: "xs3 md2" },
          {text: 'Date', value: 'createdAt', class: "xs3 md2" },
          {text: 'Current Return', value: 'return', class: "xs3 md2 text-sm-right" }
        ],
        investments: [
          {
            name: 'Lambda School',
            size: 50000,
            createdAt: "07/05/2019",
            return: '11%',
          },
          {
            name: 'Purdue University Computer Science',
            size: 50000,
            createdAt: "07/04/2019",
            return: '8%',
          },
        ]
      }
    },

    computed:{
      ...mapState(['schools'])
    },

    mounted() {
      
    },
    methods: {
      
    }
  }
</script>

<style lang="scss">
  thead {
    background-color: #898ed8;
    th,i {
      color: #fff !important;
    }
  }
</style>