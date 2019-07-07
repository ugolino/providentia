<template>
  <v-container grid-list-md text-xs-center>
    <v-layout row wrap class="investments">
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
          <v-layout row wrap align-center justify-space-around>
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
              <p>current empl. rate</p>
            </v-flex>
            <v-flex xs4 md2 class="text-sm-center">
              <h4 class="headline">{{school.stats.months_to_repay}}</h4>
              <p>avg months to repay</p>
            </v-flex>
            <v-flex xs12 md3 class="text-sm-center">
              <v-btn
                color="primary elevation-0"
                @click="selectedSchool === index ? selectedSchool = null : selectedSchool = index"
                >
                {{ selectedSchool === index ? 'close' : 'Select Students' }}
              </v-btn>
              <br>
              <v-btn
                v-if="selectedSchool === index"
                flat
                color="primary elevation-0"
                @click="school.students.every(elem => selectedStudents.indexOf(elem) > -1) ? deselectAllStudents(school) : selectAllStudents(school) "
                >
                {{ school.students.every(elem => selectedStudents.indexOf(elem) > -1) ? 'Deselect All' : 'Select All' }}
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
                  <a :href="student.github" target="_blank" v-if="student.github != ''">
                    <img src="https://img.icons8.com/material-sharp/128/454545/github.png" height="30px" />
                  </a>
                </h4>
              </v-flex>
                <v-flex xs4 md3 class="text-sm-center">
                  <v-icon v-if="selectedStudents.includes(student)" @click="addStudent(student)">check</v-icon>
                  <v-icon v-else @click="addStudent(student)">check_box_outline_blank</v-icon>
              </v-flex>
            </v-layout>
          </div>
        </v-card>
      </v-flex>
    </v-layout>
    <v-footer fixed class="pa-5" color="secondary">
      <v-layout align-center justify-space-between row wrap>
        <v-flex xs-12>

          <v-btn
            flat
            color="red darken-3"
            @click.stop="selectedStudentsDialog = true"
          >
            You selected {{selectedStudents.length}} students
          </v-btn>

          <v-dialog
            v-model="selectedStudentsDialog"
            max-width="800"
          >
            <v-card light>
              <v-card-title class="title secondary white--text" >Review Students</v-card-title>
              <v-card-text>
                <v-layout v-if="selectedStudents.length === 0">
                  No students selected
                </v-layout>
                <v-layout v-else v-for="student in selectedStudents" :key="student.id">
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
                      <a :href="student.github" target="_blank" v-if="student.github != ''">
                        <img src="https://img.icons8.com/material-sharp/128/454545/github.png" height="30px" />
                      </a>
                    </h4>
                  </v-flex>
                    <v-flex xs4 md3 class="text-sm-center">
                      <v-icon v-if="selectedStudents.includes(student)" @click="addStudent(student)">check</v-icon>
                      <v-icon v-else @click="addStudent(student)">check_box_outline_blank</v-icon>
                  </v-flex>
                </v-layout>
              </v-card-text>

              <v-card-actions>
                <v-spacer></v-spacer>
              </v-card-actions>
            </v-card>
          </v-dialog>

        </v-flex>
        <v-spacer></v-spacer>
        <v-flex xs-12>
          <v-btn
            class="primary"
            large
            @click="confirmInvestment"
          >
            Confirm Investment
          </v-btn>
        </v-flex>



      </v-layout>

    </v-footer>
  </v-container>
</template>

<script>
import { mapState } from 'vuex'
import Portis from '@portis/web3';
import Web3 from 'web3';
import { ABI } from './abi.js';


  export default {

    data() {
      return {
        selectedSchool: null,
        selectedStudents: [],
        selectedStudentsDialog: false
      }
    },

    computed:{
      ...mapState(['schools'])
    },

    mounted() {

    },
    methods: {
      addStudent(student){
        if (!this.selectedStudents.includes(student)) {
          this.selectedStudents.push(student)
        } else {
          var index = this.selectedStudents.indexOf(student);
          if (index > -1) {
            this.selectedStudents.splice(index, 1);
          }
        }
      },
      selectAllStudents(school){
        school.students.map((student, index) => {
          if (!this.selectedStudents.includes(student)) {
            this.selectedStudents.push(student)
          }
        });
      },
      deselectAllStudents(school){
        school.students.map((student, index) => {
          if (this.selectedStudents.includes(student)) {
           var index = this.selectedStudents.indexOf(student);
            if (index > -1) {
              this.selectedStudents.splice(index, 1);
            }
          }
        });
      },
      confirmInvestment(){
        const portis = new Portis('5085594f-63c8-4e21-9b8c-94e30a82f111', 'ropsten');
        const web3 = new Web3(portis.provider);
        var abi = require('human-standard-token-abi')

        const providentia = new web3.eth.Contract(ABI,'0xdee5E2bA6065E07B534053B832D24094B6a6bBAA');
        const daiToken = new web3.eth.Contract(abi, '0x85e94abdb3f729af159733548283b9fc78b688f5');
        var amountSend = 10000
        const tokenAmountHex =  web3.utils.toHex(1000 * 10**16)

        portis.onLogin((walletAddress, email, reputation) => {
          console.log(walletAddress);
          var i =0;
          for(i=0; i<this.selectedStudents.length; i++){
            providentia.methods.Students(i).call({from: walletAddress}, (error, result) => {
              if(result){
              try{
                var firstName = this.selectedStudents[i -1].name.substr(0,this.selectedStudents[i -1].name.indexOf(' '))
              } catch(err){}
              console.log(result)

                if(firstName == result[2] ){
                  const batch = new web3.BatchRequest();
                  batch.add(daiToken.methods.approve(providentia.address, tokenAmountHex).send({
                    from: walletAddress
                  }))
                  batch.add(providentia.methods.addMoneyPool(result[0]).send({from:walletAddress}))
                }
}
          })
        }
})

    portis.showPortis();
      }
    }
  }
</script>

<style>
.investments {
  padding-bottom: 100px;
}
</style>
