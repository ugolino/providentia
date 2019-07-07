<template>
  <v-container grid-list-md text-xs-center>
    <v-layout row wrap>
      <v-flex xs12>
        <h1 class="text-xs-center py-2">Are you an investor?</h1>
        <p class="headline text-xs-center">Make your investment</p>
      </v-flex>
      <v-flex xs12           
        v-for="(school, index) in schools"
        :key="index"
        >
        <v-card
          light
          class="elevation-0 my-2 text-sm-left"
          >
          <v-divider light></v-divider>
          <v-layout align-center justify-space-around>
            <v-flex xs6 md1>
              <v-img
                :src="school.logo"
                contain
                class="ma-2"
              ></v-img>
            </v-flex>
            <v-flex xs6 md2>
              <h4>{{school.name}}</h4>
            </v-flex>
            <v-flex xs4 md2 class="text-sm-center">
              <h4 class="headline">{{school.stats.rate}}</h4>
              <p>expected interest rate</p>
            </v-flex>
            <v-flex xs4 md2 class="text-sm-center">
              <h4 class="headline">{{school.stats.employment_rate}}</h4>
              <p>current employment rate</p>
            </v-flex>
            <v-flex xs4 md2 class="text-sm-center">
              <h4 class="headline">{{school.stats.months_to_repay}}</h4>
              <p>avg months to repay</p>
            </v-flex>
            <v-flex xs4 md3 class="text-sm-center">
              <v-btn
                color="primary elevation-0"
                @click="selectedSchool === index ? selectAllStudents(school) : selectedSchool = index"
                >
                {{ selectedSchool === index ? 'Invest in all students' : 'Select Investment' }}
              </v-btn>
              
            </v-flex>
          </v-layout>
          <div
            row 
            wrap
            v-if="selectedSchool === index"
          >
            <v-divider light></v-divider>
            <v-layout v-for="student in school.students" :key="student.id">
              <v-flex xs6 md3 pl-3>
                <h4 >{{student.name}}</h4>
              </v-flex>
              <v-flex xs4 md2 class="text-sm-center">
                <h4 class="subtitle">{{student.enrolled}}</h4>
                <p>enroll days</p>
              </v-flex>
              <v-flex xs4 md2 class="text-sm-center">
                <h4 class="subtitle">{{student.internship}}</h4>
                <p>internship</p>
              </v-flex>
              <v-flex xs4 md2 class="text-sm-center">
                <h4 class="subtitle">
                  <a :href="student.github" v-if="student.github != ''">
                    <img src="https://img.icons8.com/material-sharp/128/454545/github.png" height="30px" />
                  </a>
                </h4>
              </v-flex>
                <v-flex xs4 md3 class="text-sm-center">
                <v-btn
                  color="primary elevation-0"
                  @click="addStudent(student)"
                  >
                  {{ selectedStudents.includes(student) ? 'remove' : "select" }}
                </v-btn>
              </v-flex>
            </v-layout>
          </div>
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
        selectedSchool: null,
        selectedStudents: []
      }
    },

    computed:{
      ...mapState(['schools'])
    },

    mounted() {
      
    },
    methods: {
      addStudent(student){
        console.log(student)
        console.log(this.selectedStudents.includes(student))
        if (!this.selectedStudents.includes(student)) {
          console.log('not included')
          this.selectedStudents.push(student)
        } else {
          this.selectedStudents.shift(student)
        }
      },
      selectAllStudents(school){
        school.students.map((student, index) => {
          if (!this.selectedStudents.includes(student)) {
            console.log('not included')
            this.selectedStudents.push(student)
          } else {
            this.selectedStudents.shift(student)
          }
        });
      }
    }
  }
</script>