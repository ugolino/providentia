<template>
  <v-toolbar dark color="transparent elevation-0">
    <Logo />
    <v-spacer></v-spacer>
    
    <v-menu offset-y>
      <template v-slot:activator="{ on }">
        <v-toolbar-side-icon v-on="on"></v-toolbar-side-icon>
      </template>
      <v-list>
        <router-link to="/students" >
          <v-list-tile>
            <v-list-tile-title>Students</v-list-tile-title>
          </v-list-tile>
        </router-link>
        <router-link to="/investors">
          <v-list-tile>
            <v-list-tile-title>Invenstors</v-list-tile-title>
          </v-list-tile>
        </router-link>
      </v-list>
    </v-menu>
  </v-toolbar>
</template>

<script>
import Logo from '../components/Logo'
export default {
  components: {
    Logo
  },
  data () {
    return {
      //
    }
  }
}
</script>