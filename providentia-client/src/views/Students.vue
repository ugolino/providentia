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
                  class="elevation-0"
                  v-if="selectedSchoolInfo"
                  >
                      <v-card-title secondary-title class="secondary white--text">
                        <div class="subheading"><b>{{selectedSchoolInfo.name}}</b></div>
                      </v-card-title>
                    <v-divider light></v-divider>
                    <v-layout>
                      <v-flex xs4>
                        <v-img
                          :src="selectedSchoolInfo.logo"
                          height="60px"
                          contain
                          class="ma-4"
                        ></v-img>
                      </v-flex>
                      <v-flex xs8>
                          <div class="ml-4">
                            <div v-for="(term, index) in selectedSchoolInfo.terms" :key="index">
                              <p v-html="term" class="subheading py-4"></p>
                            </div>
                          </div>
                      </v-flex>
                    </v-layout>
                    <v-card-actions class="pa-3">
                      <v-spacer></v-spacer>


                      <v-dialog
                        light
                        v-model="studentIdDialog"
                        max-width="500px"
                      >
                        <template v-slot:activator="{ on }">
                          <v-btn
                            color="primary elevation-0"
                            v-on="on"
                          >
                            Apply for the financing
                          </v-btn>
                        </template>

                        <v-card>
                          <v-card-title
                            class="secondary white--text"
                            secondary-title
                          >
                            Apply for {{selectedSchool}} financing
                          </v-card-title>
                         <v-form
                              ref="form"
                              v-model="valid"
                              lazy-validation
                            >
                            <v-card-text>
    
                              <v-text-field
                                v-model="studentId"
                                :rules="studentIdRules"
                                :counter="10"
                                :label="`Enter your ${selectedSchool} student id`"
                                required
                              ></v-text-field>
                            </v-card-text>

                            <v-card-actions>
                              <v-spacer></v-spacer>
                              <v-btn
                                :disabled="!valid"
                                color="primary elevation-0"
                                @click="submitFinancing()"
                              >
                                Request the financing
                              </v-btn>
                            </v-card-actions>
                           </v-form>
                        </v-card>
                      </v-dialog>
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
              'Pay <b>2.2%</b> of your annual income only if your salary reaches the <b>$4,166 monthly threshold</b>'
            ]
          },
          {
            name: 'Purdue University Computer Science',
            logo: 'purdue-logo.png',
            terms: [
              'Pay <b>2.6%</b> of your annual income only if your salary reaches the <b>$4,166 monthly threshold</b>'
            ]
          }
        ],
        selectedSchool: '',
        selectedSchoolInfo: [],
        studentIdDialog: false,
        studentId: '',
        valid: false,
        studentIdRules: [
          v => !!v || 'Student ID is required',
        ],
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
      },
      submitFinancing(){
        if (this.$refs.form.validate()) {
          this.snackbar = true
          console.log('ok')
        }
      }
    }
  }
</script>