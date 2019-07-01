<template>
  <v-toolbar dark color="transparent elevation-0">
    <Logo />
    <v-spacer></v-spacer>
    <v-toolbar-side-icon></v-toolbar-side-icon>
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