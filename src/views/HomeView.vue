<template>
  <div id="banner">
    <div class="left-content">
      <h1>PROTECT OUR GRASSLANDS</h1>
      <p>Grasslands and their wildlife are vanishing. The North American Grasslands Conservation Act
works to reverse this trend and save the animals we care about.</p>
      <div class="buttons">
        <v-btn class="primary-btn">Learn More</v-btn>
        <v-btn class="secondary-btn">Act now</v-btn>
      </div>
    </div>
    <div class="right-content"></div>
  </div>
  <br>
  <div class="section">
  <p>
    The loss of America’s grasslands and sagebrush over the past several decades has led to serious
declines in the wildlife we all care about. If these iconic landscapes continue to disappear, we
risk losing the creatures, like pronghorn and bobwhite, that help define our communities. While
devastating for hunters and birdwatchers, these declines also show that places where people
live are losing water, losing soil productivity, and less able to withstand extreme heat and
storms.
  </p>
  <p>
    The slow collapse of this system is underway. The North American Grasslands Conservation Act,
[a bill that ... / bill that is up before Congress], can help us stop this trajectory.
  </p>
</div>
  <div class="section-placeholder section">
    <leaflet-map :layerYear="2010" />
  </div>
  <div class="section">
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
  </div>

  <div class="section">
    <p>By changing nothing, nothing changes.
Click here [possible link: https://actforgrasslands.org/take-action/ ] to call on Congress to
restore disappearing grasslands by supporting a North American Grasslands Conservation Act.</p>
  </div>

  <div id="species-section" class="section">
    <h2>Select a species</h2>
    <div class="flex-section">
      <div @click="selectSpecies" id="species-bobolink" class="species-circle"></div>
      <div @click="selectSpecies" id="species-greater-sage-grouse" class="species-circle"></div>
      <div @click="selectSpecies" id="species-scaled-quail" class="species-circle"></div>
      <div @click="selectSpecies" id="species-ring-necked-pheasant" class="species-circle"></div>
    </div>
    <div class="flex-section">
      <div @click="selectSpecies" id="species-northern-pintail" class="species-circle"></div>
      <div @click="selectSpecies" id="species-greater-prairie-chicken" class="species-circle"></div>
      <div @click="selectSpecies" id="species-northern-bobwhite" class="species-circle"></div>
      <div @click="selectSpecies" id="species-mallard" class="species-circle"></div>
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
        console.log(this.selectedSpecies)

      }
    }
  }
  
  </script>
  
  <style scoped>
  #species-section {
    background-color: #475026;
    color: #EFEAD4;
    padding-top: 30px;
    padding-bottom: 30px;
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
    background-color: #EFEAD4;
  }

  #banner {
  display: flex;
  flex-wrap: wrap;
}

.left-content {
  flex: 1 1 40%;
  padding: 20px;
  background-color: #475026;
  color: #EFEAD4
}

.left-content h1 {
  font-size: 36px;
  margin: 0 0 10px;
}

.left-content p {
  margin: 0 0 20px;
}

.buttons {
  display: flex;
}

.buttons button {
  margin-right: 10px;
}

.right-content {
  flex: 1 1 60%;
  background-image: url('path/to/your/image.jpg');
  background-size: cover;
  background-position: center;
  background-color: gray;
  min-height: 300px; /* Set the height you want for the right section */
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
}

  </style>
  