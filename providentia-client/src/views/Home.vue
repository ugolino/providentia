<template>
  <v-container grid-list-md text-xs-center>
    <v-layout row wrap>
      <v-flex xs12>
        <h1>Providentia</h1>
        <h4>Student funding</h4>
      </v-flex>
      <v-flex xs12 sm6>
        <router-link to="students">
          <v-card
              class="mx-auto"
              color="teal darken-4"
              dark
              max-width="400"
            >
            <v-card-text >
              <img src="https://img.icons8.com/wired/64/ffffff/student-center.png" height="50px">
              <h2 class="headline font-weight-bold">Are you a student?</h2>
              <h4>Apply for a student financing</h4>
            </v-card-text>
          </v-card>
        </router-link>
      </v-flex>
      <v-flex xs12 sm6>
        <router-link to="investors">
          <v-card
              class="mx-auto"
              color="light-blue darken-4"
              dark
              max-width="400"
            >
            <v-card-text >
              <img src="https://img.icons8.com/wired/128/ffffff/investment-portfolio.png" height="50px">
              <h2 class="headline font-weight-bold">Are you an investor?</h2>
              <h4>Invest in student's talent</h4>
            </v-card-text>
          </v-card>
        </router-link>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>

  export default {
    
    data() {
      return {
        
      }
    },
    mounted() {
      
    },
    methods: {
      
    }
  }
</script>
