<template>
    <div :id="'accordion-'+accId" class="accordion">
      <div class="accordion-header" @click="toggleAccordion">
        <div class="accordion-icon" :class="{ 'open': isOpen }" :style="{ transform: rotateTransform }">
          <span class="plus">+</span>
        </div>
        <div class="accordion-title">{{ title }}</div>
      </div>
      <transition name="accordion-transition">
        <div class="accordion-content" v-show="isOpen">
          <div class="accordion-text" :class="{ 'fade-in': isOpen, 'fade-out': !isOpen }" v-html="description">
          </div>
        </div>
      </transition>
    </div>
  </template>
  
  <script>
  export default {
    props: {
      title: {
        type: String,
        required: true
      },
      description: {
        type: String,
        required: true
      },
      selectedModal: {
        type: String,
        required: false
      }
    },
    data() {
      return {
        isOpen: false
      };
    },
    computed: {
      rotateTransform() {
        return this.isOpen ? 'rotate(45deg)' : 'rotate(0)';
      },
      accId() {
        return this.title.replace(/\s+/g, '-').toLowerCase();
      }
    },
    mounted() {
      console.log(this.selectedModal)
      // if the selectedModal prop is equal to the current accordion title, open the accordion
      if (this.selectedModal === this.accId) {
        this.isOpen = true;

        // Find the target element
        const targetElement = document.getElementById("#accordion-" + this.accId);

        // Scroll to the target element
        if (targetElement) {
          targetElement.scrollIntoView({ behavior: 'smooth' });
        }
      }
    },
    methods: {
      toggleAccordion() {
        this.isOpen = !this.isOpen;

        if (this.isOpen) {
          // take the description prop and remove all spaces, replacing spaces with a - and store in variable
          const id = this.title.replace(/\s+/g, '-').toLowerCase();

          // remove the current URL hash
          window.location.hash = '';

          // take this id and add it to the current URL as a hash
          window.location.hash = id;
        }
      }
    }
  };
  </script>
  
  <style>
  .accordion {
    margin-top: 30px;
    margin-bottom: 30px;
    border-bottom: 2px solid #E3E3E3;
  }
  
  .accordion-header {
    display: flex;
    align-items: center;
    cursor: pointer;
  }
  
  .accordion-icon {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 24px;
    height: 24px;
    margin-right: 10px;
    transition: transform 0.3s;
  }
  
  .accordion-icon.open {
    transform: rotate(45deg);
  }
  
  .plus {
    font-size: 32px;
    font-weight: normal;
  }
  
  .accordion-title {
    font-weight: bold;
  }
  
  .accordion-content {
    overflow: hidden;
  }
  
  .accordion-text {
    padding: 10px;
    
    border-top: 1px solid #E3E3E3;
    border-bottom: 1px solid #E3E3E3;
    opacity: 0;
    transition: opacity 0.3s;
  }
  
  .fade-in {
    opacity: 1;
  }
  
  .fade-out {
    opacity: 0;
  }
  
  .accordion-transition-enter-active,
  .accordion-transition-leave-active {
    transition: height 0.3s, opacity 0.3s;
  }
  
  .accordion-transition-enter,
  .accordion-transition-leave-to {
    height: 0;
    overflow: hidden;
  }
  </style>
  