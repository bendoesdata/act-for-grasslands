<template>
  <div id="banner">
    <div class="left-content">
      <h1>PROTECT OUR GRASSLANDS</h1>
      <p>Grasslands and their wildlife are vanishing. The North American Grasslands Conservation Act works to reverse this trend by conserving the habitat necessary to a wide array of wildlife species.</p>
      <div class="buttons">
        <v-btn class="primary-btn">Learn More</v-btn>
        <v-btn class="secondary-btn">Act now</v-btn>
      </div>
    </div>
    <div class="right-content">
      
    </div>
  </div>
  <br>
  <div class="section">
    <div class="flex-container">
      <div class="flex-half text-pad">
        <p>
          The loss of America’s grasslands over the past several decades has led to alarming declines in the wildlife we all care about. If these iconic landscapes continue to disappear, we risk losing the animals, like pronghorn and bobwhite quail, that help define our communities. While devastating for hunters and birdwatchers, these declines also show that the places where people live are losing soil productivity and water, and are less able to withstand extreme heat and storms. 	 
        </p>
        <p>
          The slow collapse of this system is underway. The North American Grasslands Conservation Act will help reverse the decline of America's grasslands - the prairies, savannas, glades, sage lands - in our own backyards.
        </p>
      </div>
      <div class="flex-half">
        <img src="images/Mule Deer/cbolt_07172017_DSC3017 © Clay Bolt.jpg" style="width: 100%" alt="">
      </div>
    </div>
</div>
  <div class="section-placeholder">
    <leaflet-map :layerYear="2010" />
    <div class="stickey" style="position:relative; top: 10%; left: 20%; background-color: white; z-index: 1000">
      This is what the American grasslands looked like 30 years ago.
    </div>
  </div>
  <div class="section flex-container">
    <div class="flex-half text-pad">
      <h2>Regional collapse</h2>
    <p>
      Across the continental U.S., grasslands have seen serious declines. Here is how much they have
disappeared over the past thirty years.
    </p>
    <p>
      The greener the map, the more grasslands are present. Vast patches of emptiness show how
much has been lost.
    </p>
    <p>
      Grassland animals are losing their homes.
    </p>
    <p>By changing nothing, nothing changes.
      Click here [possible link: https://actforgrasslands.org/take-action/ ] to call on Congress to
      restore disappearing grasslands by supporting a North American Grasslands Conservation Act.
      </p>
    </div>
    <div class="flex-half section-placeholder">
        <div style="color: white">maps go here</div>
    </div>
  </div>

  <div id="species-section" class="section">
    <h2>Select a species</h2>
    <div class="flex-section">
      <div v-for="(species, index) in allSpecies.slice(0, 4)" :key="index">
        <div @click="selectSpecies" :style="{ backgroundImage: 'url(' + species.photoFile + ')' }" :id="'species-'+species.id" class="species-circle"></div>
        <div class="species-title"><p>{{ species.name }}</p></div>
      </div>
    </div>
    <div class="flex-section">
      <div v-for="(species, index) in allSpecies.slice(4, 8)" :key="index">
        <div @click="selectSpecies" :style="{ backgroundImage: 'url(' + species.photoFile + ')' }" :id="'species-'+species.id" class="species-circle"></div>
        <div class="species-title"><p>{{ species.name }}</p></div>
      </div>
    </div>
  </div>

  <SpeciesHighlight class="section" v-if="selectedSpecies !=null"
      :imageUrl="selectedSpecies.photoFile"
      :title="selectedSpecies.name"
      :description="selectedSpecies.description"
  />

  <div class="map-section">
    <div class="section-placeholder">
      map
    </div>
  </div>
  </template>

  <script>
  import SpeciesHighlight from '../components/SpeciesHighlight.vue'
  import LeafletMap from '../components/LeafletMap.vue'
  import species from '../assets/data/species.json'
  
  export default {
    name: 'HomeView',
    components: {
      SpeciesHighlight,
      LeafletMap
    },
    data() {
      return {
        selectedSpecies: null
      }
    },
    computed: {
      allSpecies() {
        return species
      }
    },
    methods: {
      selectSpecies(e) {
        
        // remove the first 8 letters from the id
        // this will leave us with the species name
        // e.g. species-bobolink becomes bobolink
        let speciesID = e.target.id.slice(8)

        console.log(speciesID, this.allSpecies)

        // filter the allSpecies array to find the species that matches the selectedSpecies with the id key 
        this.selectedSpecies = this.allSpecies.find(species => species.id === speciesID)

        // get all divs with class name "species-circle" and remove the class "highlight-circle"
        let speciesCircles = document.getElementsByClassName('species-circle')
        for (let i = 0; i < speciesCircles.length; i++) {
          speciesCircles[i].classList.remove('highlight-circle')
        }
        
        // select the div that was clicked and then add class "highlight-circle" to it
        document.getElementById(e.target.id).classList.add('highlight-circle')

      }
    }
  }
  
  </script>
  
  <style scoped>
  .highlight-circle {
    border: 6px solid #EFEAD4;
  }

  #species-section {
    background-color: #475026;
    color: #EFEAD4;
    padding-top: 30px;
    padding-bottom: 30px;
  }

  .flex-container {
    display: flex;
    flex-wrap: wrap;
  }

  .flex-half {
    flex: 1 1 50%;
  }

  /* create a flex container with 4 divs evenly spaced horizontally and centered */
  .flex-section {
    display: flex;
    justify-content: space-evenly;
    align-items: center;
  }

  /* make this div a circle using a high border radius and width of 200px */
  .species-circle {
    border-radius: 50%;
    width: 200px;
    height: 200px;
    background-size: cover;
    background-position: center;
    background-color: #EFEAD4;
  }

  #banner {
  display: flex;
  flex-wrap: wrap;
  position: relative; /* Set the banner to a relative position */
  background-color: #475026;
}

.left-content {
  flex: 1 1 40%;
  padding: 20px;
  background-color: #475026;
  color: #EFEAD4;
  border-top-right-radius: 20% 200px; /* Adjust the second value to control the curve */
  border-bottom-right-radius: 22% 300px; /* Adjust the second value to control the curve */
  position: absolute; /* Set the left div to an absolute position */
    z-index: 2; /* Ensure the left div is above the right div */
    width: 50%;
    min-height: 500px; /* Set the height you want for the right section */
}

.left-content h1 {
  font-size: 3rem;
  margin: 20px 0 40px;
  font-weight: 700
}

.left-content p {
  margin: 0 0 60px;
  max-width: 500px;
  font-size: 20px;
}

.buttons {
  display: flex;
}

.buttons button {
  margin-right: 10px;
}

.right-content {
  flex: 1 1 60%;
  background-color: gray;
  margin-left: 40%;
  min-height: 500px; /* Set the height you want for the right section */
  background-image: url('images/Northern-Bobwhite/489539801_ML_Andrew Simon.jpeg');
  background-repeat: repeat-x;
  background-size: cover;
  z-index: 1; /* Ensure the right div is below the left div */
}

/* Media query for smaller screens */
@media (max-width: 800px) {
  #banner {
    flex-direction: column;
  }

  .left-content,
  .right-content {
    flex: 1 1 100%;
  }

  .flex-container {
    flex-direction: column;
  }
  .flex-half {
    flex: 1 1 100%;
  }
}

.species-title {
  text-align: center;
  margin-top: 10px;
  margin-bottom: 20px;
  font-family: 'Rufina', serif;
  font-weight: 600;
  font-size: 1.2rem;
}

.text-pad {
  padding: 20px
}

  </style>
  