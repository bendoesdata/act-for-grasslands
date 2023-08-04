<script setup>
import HelloWorld from './components/HelloWorld.vue'
</script>

<template>
  <header>
    <div class="wrapper">

      <nav>
        <div class="flex-container">
          <div id="site-title">
            <img id="nav-logo" src="./assets/minerva-logo-1.png" width="40" alt="minerva logo">
            <span id="nav-title">M I N E R V A</span>
          </div>
          <div class="nav-links">
            <RouterLink class="hover-highlight" to="/">Home</RouterLink>
            <RouterLink class="hover-highlight" to="/about">About</RouterLink>
          </div>
          <v-btn>
  Button
</v-btn>
        </div>
      </nav>
    </div>
  </header>

  <RouterView />
</template>
<!-- <HelloWorld msg="Vite + Vue" /> -->

<style scoped>

#site-title {
  display: inline;
  color: #475026;
  font-size: 1.5rem;
  margin-left: 10px
}

/* make #nav-logo and #nav-title centered vertically */
#nav-logo {
  vertical-align: middle;
  margin-right: 10px;
  margin-top: -3px
}

/* inside of flex-container make #site-title stay on the left and nav-links stay on the right */
.flex-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 10px
}

</style>
