<template>
  <div id="banner">
    <div id="mobile-header-image" v-if="isMobile">
      <img src="/images/Northern-Bobwhite/489539801_ML_Andrew_Simon.jpeg" alt="">
    </div>
    <div class="left-content">
      <div class="title-container">
        <h1 id="title">PROTECT OUR GRASSLANDS</h1>
      </div>
      <p>Grasslands and their wildlife are vanishing. The North American Grasslands Conservation Act works to reverse this
        trend by protecting the homes and environments vital to a wide range of animals.</p>
      <div class="buttons">
        <!-- <v-btn class="primary-btn">Learn More</v-btn> -->
        <v-btn class="primary-btn">Act now</v-btn>
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
          The loss of America’s grasslands over the past several decades has led to alarming declines in the wildlife we
          all care about. If these iconic landscapes continue to disappear, we risk losing the animals, like pronghorn and
          bobwhite quail, that help define our communities. While devastating for hunters and birdwatchers, these declines
          also show that the places where people live are losing soil productivity and water, and are less able to
          withstand extreme heat and storms.
        </p>
        <p>
          The slow collapse of this system is underway. The North American Grasslands Conservation Act will help reverse
          the decline of America's grasslands - the prairies, savannas, glades, sage lands - in our own backyards.
        </p>
      </div>
      <div class="flex-half">
        <img src="/images/Mule-Deer/cbolt_07172017_DSC3017_Clay_Bolt.jpg" style="width: 100%" alt="">
      </div>
    </div>
  </div>
  <div class="section">
    <ScrollyLeaflet />
    <!-- <div class="section-placeholder">
      <h3 style="text-align: center; padding-top: 100px; color: white">MAP SHOWING HISTORIC CHANGE IN GRASSLANDS LOSS STILL IN DEVELOPMENT</h3>
    </div> -->
    <!-- <div id="map-msg-1">
      <h2>Here is how grasslands in the U.S. looked 30 years ago.</h2>
    </div>
    <leaflet-map mapId="leaflet-1992" :layerYear="1991" />
    <div id="map-msg-2">
      <h2>Here is what remained in 2022.</h2>
    </div>
    <leaflet-map mapId="leaflet-2022" :layerYear="2021" /> -->
  </div>
  <div style="height: 600px;"></div>
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
    <div class="flex-two-third" style="position: relative">
      <div class="region-map-titles">
        <div>
          <h2>1997</h2>
        </div>
        <div>
          <h2>2022</h2>
        </div>
      </div>
      <h3 style="margin-left: 20px">West</h3>
      <div class="flex-section-region-maps">
        <div class="region-map-item">
          <img src="/images/region-maps/west-1997.png" width="100%" alt="">
        </div>
        <div class="region-map-item">
          <img src="/images/region-maps/west-2022.png" width="100%" alt="">
        </div>
      </div>
      <h3 style="margin-left: 20px">Midwest</h3>
      <div class="flex-section-region-maps">
        <div class="region-map-item">
          <img src="/images/region-maps/mw-1997.png" width="100%" alt="">
        </div>
        <div class="region-map-item">
          <img src="/images/region-maps/mw-2022.png" width="100%" alt="">
        </div>
      </div>
      <h3 style="margin-left: 20px">Southeast</h3>
      <div class="flex-section-region-maps">
        <div class="region-map-item">
          <img src="/images/region-maps/se-1997.png" width="100%" alt="">
        </div>
        <div class="region-map-item">
          <img src="/images/region-maps/se-2022.png" width="100%" alt="">
        </div>
      </div>
      <h3 style="margin-left: 20px">Northeast</h3>
      <div class="flex-section-region-maps">
        <div class="region-map-item">
          <img src="/images/region-maps/ne-1997.png" width="100%" alt="">
        </div>
        <div class="region-map-item">
          <img src="/images/region-maps/ne-2022.png" width="100%" alt="">
        </div>
      </div>
      <!-- temporary to add overlay for focus groups -->
      <!-- <div style="background-color: rgba(0,0,0,0.5); width: 100%; height: 100%;z-index: 9; position: absolute; top: 0; left: 0">
          <h3 style="color: white; text-align: center; padding-top: 200px;">REGION MAPS STILL UNDER DEVELOPMENT</h3>
        </div> -->
    </div>
  </div>

  <div id="species-section" class="section">
    <h2 style="margin-bottom: 50px; text-align: center;">Select a species to learn how it has been impacted by grasslands
      loss</h2>
    <div class="flex-section">
      <div v-for="(species, index) in allSpecies.slice(0, 4)" :key="index">
        <div @click="selectSpecies" :style="{ backgroundImage: 'url(' + species.photoFile + ')' }"
          :id="'species-' + species.id" class="species-circle"></div>
        <div class="species-title">
          <p>{{ species.name }}</p>
        </div>
      </div>
    </div>
    <div class="flex-section">
      <div v-for="(species, index) in allSpecies.slice(4, 8)" :key="index">
        <div @click="selectSpecies" :style="{ backgroundImage: 'url(' + species.photoFile + ')' }"
          :id="'species-' + species.id" class="species-circle"></div>
        <div class="species-title">
          <p>{{ species.name }}</p>
        </div>
      </div>
    </div>
    <div class="flex-section">
      <div v-for="(species, index) in allSpecies.slice(8, 12)" :key="index">
        <div @click="selectSpecies" :style="{ backgroundImage: 'url(' + species.photoFile + ')' }"
          :id="'species-' + species.id" class="species-circle"></div>
        <div class="species-title">
          <p>{{ species.name }}</p>
        </div>
      </div>
    </div>
    <div class="flex-section">
      <div v-for="(species, index) in allSpecies.slice(12, 16)" :key="index">
        <div @click="selectSpecies" :style="{ backgroundImage: 'url(' + species.photoFile + ')' }"
          :id="'species-' + species.id" class="species-circle"></div>
        <div class="species-title">
          <p>{{ species.name }}</p>
        </div>
      </div>
    </div>
  </div>
  <div id="before-species-highlight"></div>
  <SpeciesHighlight class="section" v-if="selectedSpecies != null" :imageUrl="selectedSpecies.photoFile"
    :title="selectedSpecies.name" :description="selectedSpecies.descriptionLong" />
  <br>
  <select style="color: black" v-model="birdSelection" id="bird-dropdown">
    <option value="">Select species</option>
    <option value="Burrowing Owl">Burrowing Owl</option>
    <option value="Northern Bobwhite">Northern Bobwhite</option>
    <option value="Western Meadowlark">Western Meadowlark</option>
    <option value="Bobolink">Bobolink</option>
    <option value="Sharp-tailed Grouse">Sharp-tailed Grouse</option>
    <option value="Scaled Quail">Scaled Quail</option>
    <option value="Ring-necked Pheasant">Ring-necked Pheasant</option>
    <option value="Northern Pintail">Northern Pintail</option>
    <option value="Mallard">Mallard</option>
    <option value="American Wigeon">American Wigeon</option>
  </select>
  <div id="map-section">
    <div id="left-map-panel">
      <h3>Select a species</h3>
      <div v-for="(species, i) in allSpecies" :key="i">
        <Accordion :species="species"></Accordion>
      </div>
    </div>
    <div id="interactive-map-container">
      <div id="layer-box">
        <div class="layer-box">
          <div class="layer-box-header" @click="toggleLayerBox">
            <div class="layer-box-icon" :class="{ 'open': layerBoxIsOpen }" :style="{ transform: rotateTransform }">
              <span class="plus">&#8963;</span>
            </div>
            <div class="layer-box-title"><span>open layer</span></div>
          </div>
          <transition name="layer-box-transition">
            <div class="layer-box-content" v-show="layerBoxIsOpen">
              <div class="flex-container">
                <div class="layer-box-text" :class="{ 'fade-in': layerBoxIsOpen, 'fade-out': !layerBoxIsOpen }"
                  >
                  <select style="color: black; background-color: gray;" name="layers" v-model="selectedBaseLayer" id="layer-select">
                    <option value="pfg">Perennial forb and grassland</option>
                        <option value="afg">Annual forb and grassland</option>
                        <option value="shr">Shrubs</option>
                        <option value="tre">Tree cover</option>
                        <option value="ltr">Litter</option>
                        <option value="bgr">Bare ground</option>
                  </select>
                  
    <input type="range" min="1990" max="2022" v-model="selectedYearForMap" class="slider" id="slider">
    <span>{{ selectedYearForMap }}</span>
                </div>
              </div>
              <br>
              <div style="font-size: 12px">Source:</div>
            </div>
          </transition>
        </div>
      </div>
      <leaflet-map :layerYear="selectedYearForMap" mapId="interactive-map" :birdLayerName="birdSelection"
        :layerName="selectedBaseLayer" />
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
import ScrollyLeaflet from '../components/ScrollyLeaflet.vue'

export default {
  name: 'HomeView',
  components: {
    SpeciesHighlight,
    LeafletMap,
    Accordion,
    ScrollyLeaflet
  },
  data() {
    return {
      selectedSpecies: null,
      isMobile: false,
      selectedBaseLayer: 'pfg',
      selectedYearForMap: "2020",
      birdSelection: '',
      layerBoxIsOpen: false
    }
  },
  watch: {
    selectedBaseLayer() {
      console.log('selectedBaseLayer', this.selectedBaseLayer)
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
    toggleLayerBox() {
      this.layerBoxIsOpen = !this.layerBoxIsOpen; 
    },
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
  max-width: 400px;
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
  position: relative
}

#layer-box {
  position: absolute;
  bottom: 20px;
  left: 40px;
  z-index: 500;
  background-color: #FAFAF8;
}

/* make this div a circle using a high border radius and width of 200px */
.species-circle {
  border-radius: 50%;
  width: 180px;
  height: 180px;
  background-size: cover;
  background-position: center;
  background-color: #EFEAD4;
}

#banner {
  display: flex;
  flex-wrap: wrap;
  position: relative;
  /* Set the banner to a relative position */
  background-color: #EFEAD4;
}

.title-container {
  position: relative;
}


#title {
  font-size: 5rem;
  line-height: 80px;
  font-weight: 800;
  text-transform: uppercase;
  background: url(/images/Northern-Bobwhite/grass-background.jpeg) 0 0 / cover no-repeat;
  /* background-position: 50px; */
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}


.left-content {
  flex: 1 1 35%;
  padding: 20px;
  background-color: #EFEAD4;
  color: #475026;
  padding-top: 80px;
  border-top-right-radius: 22% 280px;
  /* Adjust the second value to control the curve */
  border-bottom-right-radius: 22% 280px;
  /* Adjust the second value to control the curve */
  position: absolute;
  /* Set the left div to an absolute position */
  z-index: 2;
  /* Ensure the left div is above the right div */
  width: 45%;
  min-height: 500px;
  /* Set the height you want for the right section */
}


.layer-box-header {
  display: flex;
  align-items: center;
  cursor: pointer;
}

.layer-box-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 24px;
  height: 24px;
  margin-right: 10px;
  transition: transform 0.3s;
}

.layer-box-icon.open {
  transform: rotate(180deg);
}

.plus {
  font-size: 24px;
  font-weight: normal;
}

.layer-box-title {
  font-weight: bold;
}

.layer-box-content {
  margin-top: 10px;
  overflow: hidden;
}

.layer-box-text {
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

.layer-box-transition-enter-active,
.layer-box-transition-leave-active {
  transition: height 0.3s, opacity 0.3s;
}

.layer-box-transition-enter,
.layer-box-transition-leave-to {
  height: 0;
  overflow: hidden;
}

.left-content h1 {
  margin: 20px 0 40px;
  font-weight: 700
}

.left-content p {
  margin: 0 0 30px;
  max-width: 550px;
  font-size: 20px;
}

.buttons {
  display: flex;
}

.buttons button {
  margin-right: 10px;
}

.right-content {
  flex: 1 1 62%;
  background-color: gray;
  margin-left: 35%;
  min-height: 500px;
  /* Set the height you want for the right section */
  background-image: url('/images/Northern-Bobwhite/489539801_ML_Andrew_Simon.jpeg');
  background-repeat: repeat-x;
  background-size: cover;
  z-index: 1;
  /* Ensure the right div is below the left div */
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
}</style>
  