<template>
  <v-container id="home" grid-list-md text-xs-center >
    <v-layout row wrap>
      <v-flex xs12>
        <h1 class="display-2 py-4">Welcome to Providentia</h1>
      </v-flex>
      <v-flex xs12 sm6>
        <router-link to="students">
          <v-card
              light
              class="mx-auto elevation-0"
              max-width="500"
            >
            <v-img
              src="/education.png"
              height="150px"
            ></v-img>
            <v-card-text >
              <h2 class="headline font-weight-bold py-2">Are you a student?</h2>
              <h4>Apply for you student financing</h4>
            </v-card-text>
          </v-card>
        </router-link>
      </v-flex>
      <v-flex xs12 sm6>
        <router-link to="investors">
          <v-card
              light
              class="mx-auto elevation-0"
              max-width="500"
            >
            <v-img
              src="/investor.png"
              height="150px"
            ></v-img>
            <v-card-text >
              <h2 class="headline font-weight-bold py-2">Are you an investor?</h2>
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

<style lang="scss">
#home {
  .v-card:hover {
    transform: scale(1.02);
  }
}


</style>
