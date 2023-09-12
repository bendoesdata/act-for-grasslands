<template>
  <div>

  
    <div class="container" id="species-highlight-description">
      <div class="left">
        <img :src="'../'+imageUrl" alt="Left Image" :style="{ width: isMobile ? '100%' : 'auto' }">
      </div>
      <div class="right">
        <h2>{{ title }}</h2>
        <div class="species-description" v-html="description"></div>
        <br>
        <p>By changing nothing, nothing changes.
      <a href="#" style="text-decoration: underline;">Click here</a> to call on Congress to
      restore disappearing grasslands by supporting a North American Grasslands Conservation Act.
      </p>
      </div>
    </div>
    <div class="species-map-placeholder">
      species specific map coming soon
    </div>
  </div>
  </template>
  
  <script>
  export default {
    props: {
      imageUrl: {
        type: String,
        required: true,
      },
      title: {
        type: String,
        required: true,
      },
      description: {
        type: String,
        required: true,
      },
    },
    computed: {
      isMobile() {
        return window.innerWidth < 900;
      },
    },
  };
  </script>
  
  <style scoped>

  .species-map-placeholder {
    height: 300px;
    background-color: #475026;
    color: #EFEAD4;
    display: flex;
    margin-top: 20px;
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
  
  img {
    display: block;
    max-width: 100%;
  }

  /* .species-description {
    font-size: 21px;
  } */
  
  /* Media query for smaller screens */
  @media (max-width: 900px) {
    .left,
    .right {
      flex: 1 1 100%;
    }
  }
  </style>
  