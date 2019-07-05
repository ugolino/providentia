<template>
  <v-container grid-list-md>
    <v-layout row wrap>
      <v-flex xs12>
        <h1 class="text-xs-center py-2">Portfolio</h1>
        <p class="headline text-xs-center">Check how your investment are performing</p>
      </v-flex>
      <v-flex xs12>
        <v-data-table
          :headers="investmentHeaders"
          :items="investments"
          class="elevation-0"
          light
          hide-actions
        >
          <template v-slot:items="props">
            <td>{{ props.item.name }}</td>
            <td>{{ props.item.size }}</td>
            <td>{{ props.item.createdAt }}</td>
            <td>{{ props.item.return }}</td>
          </template>
        </v-data-table>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import { mapState } from 'vuex'

  export default {
    
    data() {
      return {
        investmentHeaders: [
          {text: 'School', value: 'name' },
          {text: 'Amount', value: 'size' },
          {text: 'CreatedAt', value: 'createdAt' },
          {text: 'Current Return', value: 'return' }
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