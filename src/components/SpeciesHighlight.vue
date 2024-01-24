<template>
  <div>

  
    <div class="container" id="species-highlight-description">
      <div class="left">
        <img :src="'../'+speciesObject.photoFile" alt="Left Image" :style="{ width: isMobile ? '100%' : 'auto' }">
      </div>
      <div class="right">
      <div class="right">
        <h2>{{ speciesObject.name }}</h2>
        <div class="species-description" v-html="speciesObject.descriptionLong"></div>
        <br>
        <br>
        <a href="https://actforgrasslands.org/take-action/">
        <v-btn class="primary-btn">Act now</v-btn>
      </a>
      </div>
    </div>
    <div class="species-map-container">
      <img :src="'../images/trend-maps/'+speciesObject.id+'.png'" alt="">
    </div>
  </div>
  </div>
  </template>
  
  <script>
  export default {
    props: {
      speciesObject: {
        type: Object,
        required: true
      }
    },
    computed: {
      isMobile() {
        return window.innerWidth < 900;
      },
    },
  };
  </script>
  
  <style scoped>

  .species-map-container {
    
    margin-top: 30px;
    justify-content: center;
    align-items: center;
  }
  .container {
    display: flex;
    flex-wrap: wrap;
  }
  
  .left {
    flex: 1 1 50%;
  }
  
  .right {
    flex: 1 1 50%;
    padding-left: 20px;
  }

  .species-description {
    max-width: 600px;
    font-size: 18px
  }

  .text-source {
    text-decoration: underline;
    font-size: 14px;
    margin-top: 10px
  }
  
  img {
    display: block;
    max-width: 100%;
  }

  /* .species-description {
    font-size: 21px;
  } */

  /* .species-description {
    font-size: 21px;
  } */
  
  /* Media query for smaller screens */
  @media (max-width: 800px) {
    .left,
    .right {
      flex: 1 1 100%;
      padding: 0px
    }

    .right {
      margin-top: 10px
    }
  }
  </style>
  