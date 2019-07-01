<template>
  <v-app dark>
    <Toolbar />
    <v-content>
      <router-view></router-view>
    </v-content>
  </v-app>
</template>

<script>
import Toolbar from '../src/components/Toolbar'
export default {
  components: {
    Toolbar
  },
  data () {
    return {
      //
    }
  }
}
</script>

<style lang="scss">
#app {
  background-color: #4844a3;
  font-family: 'Roboto', sans-serif;
  color: #fff;
}

a {
  color: #fff;
  text-decoration: none;
}

</style>