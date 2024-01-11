<template>
    <div :id="'accordion-'+accId" class="accordion">
      <div class="accordion-header" @click="toggleAccordion">
        <div class="accordion-icon" :class="{ 'open': isOpen }" :style="{ transform: rotateTransform }">
          <span class="plus">+</span>
        </div>
        <div class="accordion-title">{{ species.name }}</div>
      </div>
      <transition name="accordion-transition">
        <div class="accordion-content" v-show="isOpen">
          <div class="flex-container">
            <div :style="{ backgroundImage: 'url(' + species.photoFile + ')' }" class="flex-icon species-circle-small"></div>
            <div class="accordion-text flex-text" :class="{ 'fade-in': isOpen, 'fade-out': !isOpen }" v-html="species.descriptionShort"></div>
          </div>
          
          <br>
            <div style="font-size: 12px; font-style: italic;"><div class="source">Source: 
              <span v-if="species.mapSourceLink1 == null || species.mapSourceLink1 == ''">
                {{ species.mapSource }}
              </span>
              <span v-else-if="doubleSource">
                <a :href="species.mapSourceLink1" target="_blank" style="text-decoration: underline;">{{ splitSource(species.mapSource)[0] }}</a>,
                <a :href="species.mapSourceLink2" target="_blank" style="text-decoration: underline;">{{ splitSource(species.mapSource)[1] }}</a>
              </span>
              <a v-else :href="species.mapSourceLink1" target="_blank" style="text-decoration: underline;">{{ species.mapSource }}</a>
            </div>
            </div>
          <v-switch @click="sendSpeciesSelection" :model-value="switchState" label="Display on map"></v-switch>
        </div>
      </transition>
    </div>
  </template>
  
  <script>
import { map } from 'leaflet';

  export default {
    props: {
      species: {
        type: Object,
        required: true
      },
      selectedModal: {
        type: String,
        required: false
      },
      currentlySelectedSpecies: {
        type: String,
        required: false
      },
      firstInList: {
        type: Boolean,
        required: false,
        default: false
      }
    },
    data() {
      return {
        isOpen: false,
        switchState: false,
        doubleSource: false
      };
    },
    watch: {
      currentlySelectedSpecies(val) {
        
        if (val === this.species.name) {
          this.switchState = true;
        } else {
          this.switchState = false;
        }
      }
    },
    computed: {
      rotateTransform() {
        return this.isOpen ? 'rotate(45deg)' : 'rotate(0)';
      },
      accId() {
        return this.species.name.replace(/\s+/g, '-').toLowerCase();
      }
    },
    mounted() {
      // check to see if species.mapSource contains ';' and if so, set doubleSource to true
      if (this.species.mapSource.indexOf(';') !== -1) {
        this.doubleSource = true;
      }

      if (this.firstInList) {
        this.isOpen = true;
      }
      // if the selectedModal prop is equal to the current accordion title, open the accordion
      if (this.selectedModal === this.accId) {
        this.isOpen = true;

        // Find the target element
        const targetElement = document.getElementById("#accordion-" + this.accId);

        // Scroll to the target element
        // if (targetElement) {
        //   targetElement.scrollIntoView({ behavior: 'smooth' });
        // }
      }
    },
    methods: {
      splitSource(val) {
        return val.split(";");
      },
      sendSpeciesSelection(){
        this.switchState = !this.switchState;

        if (this.switchState) {
          // send the species name to the parent component
          this.$emit('species-selected', this.species.name);
        } else {
          // send the species name to the parent component
          this.$emit('species-selected', 'none');
        }
      },
      toggleAccordion() {
        this.isOpen = !this.isOpen;

        if (this.isOpen) {
          // take the description prop and remove all spaces, replacing spaces with a - and store in variable
        //   const id = this.title.replace(/\s+/g, '-').toLowerCase();

        //   // remove the current URL hash
        //   window.location.hash = '';

        //   // take this id and add it to the current URL as a hash
        //   window.location.hash = id;
        }
      }
    }
  };
  </script>
  
  <style scoped>
  .flex-container {
    display: flex;
    flex-wrap: wrap;
  }

  /* create flex class that does not grow */


  .flex-icon {
    flex: 0 1 100px;
  }

  .flex-text {
    flex: 1 1 70%;
  }

  .accordion {
    margin-top: 10px;
    margin-bottom: 30px;
    border-bottom: 0.5px solid #475026;
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
    margin-top: 10px;
    overflow: hidden;
  }
  
  .accordion-text {
    padding: 10px;
    border-bottom: 1px solid #475026;
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

  .species-circle-small {
    border-radius: 50%;
    width: 100px;
    height: 100px;
    background-size: cover;
    background-position: center;
    background-color: #EFEAD4;
  }
  </style>
  