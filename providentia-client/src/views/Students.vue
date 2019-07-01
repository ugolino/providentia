<template>
  <v-container grid-list-md >
    <v-layout row wrap >
      <v-flex xs12>
        <h1 class="text-xs-center py-2">Are you a student?</h1>
        <p class="headline text-xs-center">Select your school to apply for the student financing.</p>
        <v-flex md12>
          <v-select
            :items="schoolsList"
            label="Select the school you are joining"
            v-model="selectedSchool"
            :change="getSchoolInfo()"
          ></v-select>
          <v-flex md12>
                <v-flex xs12>
                  <v-card
                  light
                  v-if="selectedSchoolInfo"
                  >
                      <v-card-title primary-title class="primary white--text">
                      <div class="headline">{{selectedSchoolInfo.name}}</div>
                      </v-card-title>
                    <v-divider light></v-divider>
                    <v-layout>
                      <v-flex xs4>
                        <v-img
                          :src="selectedSchoolInfo.logo"
                          height="125px"
                          contain
                          class="ma-4"
                        ></v-img>
                      </v-flex>
                      <v-flex xs8>
                        <v-card-title primary-title>
                          <div>
                            <v-list>
                              <v-list-tile v-for="(term, index) in selectedSchoolInfo.terms" :key="index">
                                <v-list-tile-action>
                                  <v-icon color="green">check</v-icon>
                                </v-list-tile-action>
                                <v-list-tile-content>
                                  <v-list-tile-title v-html="term"></v-list-tile-title>
                                </v-list-tile-content>
                              </v-list-tile>
                            </v-list>
                          </div>
                        </v-card-title>
                      </v-flex>
                    </v-layout>
                    <v-card-actions class="pa-3">
                      <v-spacer></v-spacer>
                      <v-btn
                        color="primary"
                      >
                        Apply for the financing
                      </v-btn>
                    </v-card-actions>
                  </v-card>
                </v-flex>

              
          </v-flex>

        </v-flex>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
  export default {
    
    data() {
      return {
        schools: [
          {
            name: 'Lambda School',
            logo: 'lambda-logo.png',
            terms: [
              'If your income never reaches the <b>$4,166 monthly</b> threshold, you’ll pay nothing.',
              'If you’re making really good money (congratulations!), you could pay up to the <b>$30k cap</b>.',
              'You’ll never pay more than $30k.'
            ]
          },
          {
            name: 'Purdue University Computer Science',
            logo: 'purdue-logo.png',
            terms: [
              'Pay <b>2.6%</b> of your annual income only if your salary reaches the $4,166 monthly threshold'
            ]
          }
        ],
        selectedSchool: '',
        selectedSchoolInfo: []
      }
    },
    computed: {
      schoolsList() {
        return this.schools.map(school => school.name)
      },
    },
    mounted() {
      
    },
    methods: {
      getSchoolInfo(){
        this.selectedSchoolInfo = this.schools.filter(school => school.name === this.selectedSchool)[0]
      }
    }
  }
</script>