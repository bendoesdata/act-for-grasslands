<template>
  <div id="banner">
    <div id="mobile-header-image" v-if="isMobile">
      <img src="images/Northern-Bobwhite/489539801_ML_Andrew Simon.jpeg" alt="">
    </div>
    <div class="left-content">
      <h1>PROTECT OUR GRASSLANDS</h1>
      <p>Grasslands and their wildlife are vanishing. The North American Grasslands Conservation Act works to reverse this trend by protecting the homes and environments vital to a wide range of animals.</p>
      <div class="buttons">
        <!-- <v-btn class="primary-btn">Learn More</v-btn> -->
        <v-btn class="secondary-btn">Act now</v-btn>
      </div>
    </div>
    <div v-if="!isMobile" class="right-content">
      
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
        <img src="images/Mule-Deer/cbolt_07172017_DSC3017_Clay_Bolt.jpg" style="width: 100%" alt="">
      </div>
    </div>
</div>
  <div class="section">
    <div id="map-msg-1">
      <h2>Here is how grasslands in the U.S. looked 30 years ago.</h2>
    </div>
    <leaflet-map mapId="leaflet-1992" :layerYear="1991" />
    <div id="map-msg-2">
      <h2>Here is what remained in 2022.</h2>
    </div>
    <leaflet-map mapId="leaflet-2022" :layerYear="2021" />
  </div>
  <div class="section flex-container">
    <div class="flex-third text-pad">
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
    <div class="flex-two-third">
      <div class="region-map-titles">
        <div>
          <h2>1992</h2>
        </div>
        <div>
          <h2>2022</h2>
        </div>        
      </div>
      <h3 style="margin-left: 20px">West</h3>
      <div class="flex-section-region-maps">
        <div class="region-map-item">
          <img src="/images/region-maps-01.png" width="100%" alt="">
        </div>
        <div class="region-map-item">
          <img src="/images/region-maps-02.png" width="100%" alt="">
        </div>
      </div>
      <h3 style="margin-left: 20px">Midwest</h3>
      <div class="flex-section-region-maps">
        <div class="region-map-item">
          <img src="/images/region-maps-05.png" width="100%" alt="">
        </div>
        <div class="region-map-item">
          <img src="/images/region-maps-06.png" width="100%" alt="">
        </div>
      </div>
      <h3 style="margin-left: 20px">Southeast</h3>
      <div class="flex-section-region-maps">
        <div class="region-map-item">
          <img src="/images/region-maps-04.png" width="100%" alt="">
        </div>
        <div class="region-map-item">
          <img src="/images/region-maps-03.png" width="100%" alt="">
        </div>
      </div>
    </div>
  </div>

  <div id="species-section" class="section">
    <h2 style="margin-bottom: 50px; text-align: center;">Select a species to learn how it has been impacted by grasslands loss</h2>
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
    <div class="flex-section">
      <div v-for="(species, index) in allSpecies.slice(8, 12)" :key="index">
        <div @click="selectSpecies" :style="{ backgroundImage: 'url(' + species.photoFile + ')' }" :id="'species-'+species.id" class="species-circle"></div>
        <div class="species-title"><p>{{ species.name }}</p></div>
      </div>
    </div>
    <div class="flex-section">
      <div v-for="(species, index) in allSpecies.slice(12,16)" :key="index">
        <div @click="selectSpecies" :style="{ backgroundImage: 'url(' + species.photoFile + ')' }" :id="'species-'+species.id" class="species-circle"></div>
        <div class="species-title"><p>{{ species.name }}</p></div>
      </div>
    </div>
  </div>
  <div id="before-species-highlight"></div>
  <SpeciesHighlight class="section" v-if="selectedSpecies !=null"
      :imageUrl="selectedSpecies.photoFile"
      :title="selectedSpecies.name"
      :description="selectedSpecies.descriptionLong"
  />

  <div class="section-placeholder" style="height: 500px"></div>

  <div id="map-section">
    <div id="left-map-panel">
      <h3>Select a species</h3>
      <div v-for="(species, i) in allSpecies" :key="i">
        <Accordion :species="species"></Accordion>
      </div>
    </div>
    <div id="interactive-map-container">
        <leaflet-map :layerYear="2010" mapId="interactive-map" />
      </div>
  </div>
  <div>
    <p>By changing nothing, nothing changes.
      Click here [possible link: https://actforgrasslands.org/take-action/ ] to call on Congress to
      restore disappearing grasslands by supporting a North American Grasslands Conservation Act.
      </p>
  </div>
  </template>

  <script>
  import SpeciesHighlight from '../components/SpeciesHighlight.vue'
  import LeafletMap from '../components/LeafletMap.vue'
  import species from '../assets/data/species.json'
  import Accordion from '../components/Accordion.vue'
  
  export default {
    name: 'HomeView',
    components: {
      SpeciesHighlight,
      LeafletMap,
      Accordion
    },
    data() {
      return {
        selectedSpecies: null,
        isMobile: false
      }
    },
    computed: {
      allSpecies() {
        return species
      }
    },
    mounted() {
      // setup an event listener to change the value of isMobile to true if the viewport width is less than 800px
      window.addEventListener('resize', () => {
        if (window.innerWidth < 800) {
          this.isMobile = true
        } else {
          this.isMobile = false
        }
      })
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

        // scroll to the div with id "before-species-highlight" with duration of 1000ms
        document.getElementById('before-species-highlight').scrollIntoView({ behavior: 'smooth', block: 'start', inline: 'nearest' })
        

      }
    }
  }
  
  </script>
  
  <style scoped>
  .highlight-circle {
    border: 6px solid #EFEAD4;
  }

  #before-species-highlight {
    height: 30px
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

  #map-msg-1 {
    height: 250px;
    margin-top: 80px;
    margin-bottom: 20px;
  }

  #map-msg-2 {
    height: 200px;
    margin-top: 120px;
    margin-bottom: 0px;
  }

  .flex-third {
    flex: 1 1 33%;
  }

  .flex-two-third {
    flex: 1 1 66%;
  }

  /* create a flex container with 4 divs evenly spaced horizontally and centered */
  .flex-section {
    display: flex;
    justify-content: space-evenly;
    align-items: center;
    flex-wrap: wrap;
    margin-top: 30px;
  }

  .flex-section-region-maps {
    display: flex;
    justify-content: space-evenly;
    align-items: center;
    flex-wrap: wrap;
  }

  .region-map-titles {
    display: flex;
    justify-content: space-evenly;
    align-items: center;
    flex-wrap: wrap;
  }

  .region-map-item {
    max-width: 300px;
  }

  #map-section {
    display: flex;
    flex-wrap: wrap;
    background-color: #EFEAD4;
    color: #475026;
    margin-bottom: 100px;
  }

  #left-map-panel {
    flex: 1 1 30%;
    max-height: 500px;
    overflow-y: scroll;
    padding: 1rem;
  }

  #interactive-map-container {
    flex: 1 1 70%;
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

@media (max-width: 900px) {
  .flex-section {
    /* display: block */
  }
}

/* Media query for smaller screens */
@media (max-width: 800px) {
  #banner {
    display: block;
  }

  #banner .left-content {
    width: 100%;
    border-radius: 0px;
    position: relative;
  }

  #mobile-header-image {
    position: relative;
    display: block;
    height: 300px
  }

  #mobile-header-image img {
    width: 100%
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
  