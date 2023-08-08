<template>
    <div class="container">
      <div class="left" :style="{ flexBasis: isMobile ? '100%' : '50%' }">
        <img :src="'../'+imageUrl" alt="Left Image" :style="{ width: isMobile ? '100%' : 'auto' }">
      </div>
      <div class="right" :style="{ flexBasis: isMobile ? '100%' : '50%' }">
        <h2>{{ title }}</h2>
        <p>{{ description }}</p>
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
  
  img {
    display: block;
    max-width: 100%;
  }
  
  /* Media query for smaller screens */
  @media (max-width: 900px) {
    .left,
    .right {
      flex: 1 1 100%;
    }
  }
  </style>
  