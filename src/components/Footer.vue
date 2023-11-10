<template>
    <footer class="footer">
      <div class="footer-content">
        <p class="footer-text">Map for Grasslands was co-created by the <a href="https://www.birds.cornell.edu/conservation-media/" target="_blank">Center for Conservation Media</a> at the Cornell Lab of Ornithology and the coalition members of <a href="https://actforgrasslands.org/" target="_blank">Act for Grasslands</a>. ©2023</p>
      </div>
    </footer>
  </template>
  
  <script>
  export default {
    name: "Footer",
  };
  </script>
  
  <style scoped>
  .footer {
    background-color: #475026;
    color: #efead4;
    height: 180px;
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .footer a {
    color: #efead4;
    text-decoration: underline;
  }
  
  .footer-content {
    max-width: 600px
  }
  
  .footer-text {
    text-align: center;
    padding: 20px;
  }
  </style>
  