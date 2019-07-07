<template>
  <v-container grid-list-md>
    <v-layout row wrap>
      <v-flex xs12>
        <h1 class="text-xs-center py-2">Repay your financing</h1>
      </v-flex>
      <v-flex xs12>
        <v-card
          light
          class="elevation-0"
          >
          <v-card-title secondary-title class="secondary white--text">
            Your repayment status
          </v-card-title>
          <v-card-text>
            <v-layout row wrap class="text-xs-center mt-2">
              <v-flex xs12 md3>
                <vue-numeric currency="$" separator="," v-model="stats.remaingTotal" class="text-xs-center headline"></vue-numeric>
                <p>Remaining Amount to repay</p>
              </v-flex>
              <v-flex xs12 md3>
                <h4 class="headline">{{stats.remainingMonths}}</h4>
                <p>months to the end</p>
              </v-flex>
              <v-flex xs12 md3>
                <vue-numeric currency="$" separator="," v-model="stats.currentMonthlyRepayment" class="text-xs-center headline"></vue-numeric>
                <p>current monthly repayment</p>
              </v-flex>
              <v-flex xs12 md3>
                <vue-numeric currency="$" separator="," v-model="stats.currentAnnualSalary" class="text-xs-center headline"></vue-numeric>
                <p>current annual salary</p>
              </v-flex>
            </v-layout>

            <v-layout row wrap align-content-space-between mt-4>
              
              <v-flex xs12 md6>
                <h4 class="text-xs-center mb-2">Months to pay</h4>
                <v-list-tile
                  v-for="(repayment, index) in toBePaid"
                  :key="index"
                  >
                  <v-list-tile-content>
                    <v-list-tile-title>{{ repayment.month }}</v-list-tile-title>
                  </v-list-tile-content>
                  <v-list-tile-action>
                    <v-btn 
                      class="primary"
                      @click="repay(stats.currentMonthlyRepayment)"
                    >
                      Pay
                    </v-btn>
                  </v-list-tile-action>


                </v-list-tile>
              </v-flex>

              <v-flex xs12 md6>
                <h4 class="text-xs-center mb-2">Paid Months</h4>
                <v-list-tile
                  v-for="(repayment, index) in paid"
                  :key="index"
                  >
                  <v-list-tile-content>
                    <v-list-tile-title>{{ repayment.month }}</v-list-tile-title>
                  </v-list-tile-content>
                  <v-list-tile-action>
                    <v-icon 
                      color="primary"
                      >
                      check
                    </v-icon>
                  </v-list-tile-action>
                </v-list-tile>
              </v-flex>

            </v-layout>


          </v-card-text>
           
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import VueNumeric from 'vue-numeric'

  export default {

  components: {
    VueNumeric
  },


    data() {
      return {
        stats:
        {
          remaingTotal: 13600,
          remainingMonths: 12,
          totalMonths: 15,
          currentAnnualSalary: 80000,
          currentMonthlyRepayment: 1130,
        },
        payments: [
          {
            month: 'May 2019',
            paid: true
          },
          {
            month: 'June 2019',
            paid: true
            },
          {
            month: 'July 2019',
            paid: true
            },
          {
            month: 'August 2019',
            paid: false
            },
          {
            month: 'September 2019',
            paid: false
            },
          {
            month: 'October 2019',
            paid: false
            },
          {
            month: 'November 2019',
            paid: false
            },
          {
            month: 'December 2019',
            paid: false
            },
          {
            month: 'January 2020',
            paid: false
          },
          {
            month: 'February 2020',
            paid: false
          },
          {
            month: 'March 2020',
            paid: false
          },
          {
            month: 'April 2020',
            paid: false
          },
          {
            month: 'May 2020',
            paid: false
          },
          {
            month: 'June 2020',
            paid: false
          },
          {
            month: 'July 2020',
            paid: false
          }
        ]
      }
    },

    computed:{
      toBePaid(){
        return this.payments.filter(repayment => !repayment.paid)
      },
      paid(){
        return this.payments.filter(repayment => repayment.paid)
      }
    },

    mounted() {
      
    },
    methods: {
      repay(amount){
        console.log(amount)
      }
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