<template>
  <div>
  <div id="banner">
    <div id="mobile-header-image" v-if="isMobile">
      <img src="/images/Northern-Bobwhite/489539801_ML_Andrew_Simon.jpg" alt="">
    </div>
    <div class="left-content">
      <div class="title-container">
        <h1 id="title">PROTECT OUR GRASSLANDS</h1>
      </div>
      <p>Grasslands and their wildlife are vanishing. The North American Grasslands Conservation Act works to reverse this trend by protecting places vital to animals and people.</p>
      <div class="buttons">
        <!-- <v-btn class="primary-btn">Learn More</v-btn> -->
        <a href="https://actforgrasslands.org/take-action/">
        <v-btn class="primary-btn">Act now</v-btn>
        </a>
      </div>
    </div>
    <div v-if="!isMobile" class="right-content">

    </div>
  </div>
  <div class="section">
    <div class="flex-container" id="intro-section">
      <div class="flex-half">
        <img src="/images/selected/Ce5RO8kSH94_unsplash_rod_m.jpg" id="monarch-pic" alt="">
      </div>
      <div class="flex-half text-pad">
        <p>
          The loss of America’s grasslands has led to alarming declines in the wildlife we all care about. If these iconic landscapes continue to disappear, we risk losing the animals that define our communities. These losses show that the places where people live are losing soil productivity and water, and are less able to withstand extreme heat and storms.
        </p>
        <p style="font-weight: 800">
          The collapse of this system is underway.
        </p>
        <p>
          The North American Grasslands Conservation Act will help save America's prairies, savannas, glades, and sagebrush – in our own backyards.
        </p>
      </div>
    </div>
  </div>
  <div class="section" id="scrolly-section">
    <ScrollyLeaflet />
    
    <!-- <leaflet-map mapId="leaflet-2022" :layerYear="2021" />  -->
  </div>
  <div class="spacer-after-map"></div>
  <div class="section">
      <div style="margin: 0 auto; text-align: left;">
        <p style="font-size: 14px; font-style: italic; ">
          Satellite technology has been able to track the recent loss of grasslands, but over half of native grasslands were already lost decades before these images were available.
        </p>
      </div>
      
  </div>
  <div class="section">
    <div class="text-pad">
      <div style="max-width: 600px; margin: 0 auto; margin-bottom: 40px;">
        <h2>Regional collapse</h2>
        <p>
          Across the continental U.S., grasslands have seen serious declines. In the middle of the country, where most of our grasslands still exist, <b>2 million acres are lost on average each year</b>.
      </p>
      <p>
        The maps below show how much grasslands have disappeared over the past 30 years in specific regions. These data exclude areas of cropland, development, and water (for more notes on the data, see References).
      </p>
      <p style="font-weight: 800">
        Grassland animals are losing their homes.
      </p>
      </div>
    </div>
    <div style="position: relative">
      <div class="region-map-titles desktop">
        <div>
          <h2>1992</h2>
        </div>
        <div>
          <h2>2021</h2>
        </div>
      </div>
      <h3 class="regional-titles">Southeast</h3>
      <div class="flex-section-region-maps">
        <div class="region-map-item">
          <RegionalLeaflet mapId="map1" mapYear="1992" :updateSource="regionalMapPositions.se.updateSource" :center="regionalMapPositions.se.center" :zoom="regionalMapPositions.se.zoom" @map-center-change="updateRegionalMapPos" />
        </div>
        <div class="region-map-item">
          <RegionalLeaflet mapId="map2" mapYear="2021" :updateSource="regionalMapPositions.se.updateSource" :center="regionalMapPositions.se.center" :zoom="regionalMapPositions.se.zoom" @map-center-change="updateRegionalMapPos" />
        </div>
      </div>
      <h3 class="regional-titles">Midwest</h3>
      <div class="flex-section-region-maps">
        <div class="region-map-item">
          <RegionalLeaflet mapId="map3" mapYear="1992" :updateSource="regionalMapPositions.mw.updateSource" :center="regionalMapPositions.mw.center" :zoom="regionalMapPositions.mw.zoom" @map-center-change="updateRegionalMapPos" />
        </div>
        <div class="region-map-item">
          <RegionalLeaflet mapId="map4" mapYear="2021" :updateSource="regionalMapPositions.mw.updateSource" :center="regionalMapPositions.mw.center" :zoom="regionalMapPositions.mw.zoom" @map-center-change="updateRegionalMapPos" />
        </div>
      </div>
      <h3 class="regional-titles">West</h3>
      <div class="flex-section-region-maps">
        <div class="region-map-item">
          <RegionalLeaflet mapId="map5" mapYear="1992" :updateSource="regionalMapPositions.west.updateSource" :center="regionalMapPositions.west.center" :zoom="regionalMapPositions.west.zoom" @map-center-change="updateRegionalMapPos" />
        </div>
        <div class="region-map-item">
          <RegionalLeaflet mapId="map6" mapYear="2021" :updateSource="regionalMapPositions.west.updateSource" :center="regionalMapPositions.west.center" :zoom="regionalMapPositions.west.zoom" @map-center-change="updateRegionalMapPos" />
        </div>
      </div>
      <h3 class="regional-titles">Northeast</h3>
      <div class="flex-section-region-maps">
        <div class="region-map-item">
          <RegionalLeaflet mapId="map7" mapYear="1992" :updateSource="regionalMapPositions.ne.updateSource" :center="regionalMapPositions.ne.center" :zoom="regionalMapPositions.ne.zoom" @map-center-change="updateRegionalMapPos" />
        </div>
        <div class="region-map-item">
          <RegionalLeaflet mapId="map8" mapYear="2021" :updateSource="regionalMapPositions.ne.updateSource" :center="regionalMapPositions.ne.center" :zoom="regionalMapPositions.ne.zoom" @map-center-change="updateRegionalMapPos" />
        </div>
      </div>
  </div>
</div>

  <div id="species-section" class="section">
    <h2 style="margin-bottom: 50px; text-align: center;">Select a species to learn how it has been impacted by grasslands
      loss</h2>
    <div class="species-grid">
      <div v-for="(species, index) in immutableSpeciesList.slice(0, 4)" :key="index" class="species-highlight-item">
        <div @click="selectSpecies" :style="{ backgroundImage: 'url(' + species.photoFile + ')' }"
          :id="'species-' + species.id" class="species-circle"></div>
        <div class="species-title">
          <p>{{ species.name }}</p>
        </div>
        
      </div>
    </div>
    <div class="species-grid">
      <div v-for="(species, index) in immutableSpeciesList.slice(4, 8)" :key="index" class="species-highlight-item">
        <div @click="selectSpecies" :style="{ backgroundImage: 'url(' + species.photoFile + ')' }"
          :id="'species-' + species.id" class="species-circle"></div>
        <div class="species-title">
          <p>{{ species.name }}</p>
        </div>
      </div>
    </div>
    <div class="species-grid">
      <div v-for="(species, index) in immutableSpeciesList.slice(8, 12)" :key="index" class="species-highlight-item">
        <div @click="selectSpecies" :style="{ backgroundImage: 'url(' + species.photoFile + ')' }"
          :id="'species-' + species.id" class="species-circle"></div>
        <div class="species-title">
          <p>{{ species.name }}</p>
        </div>
      </div>
    </div>
    <div class="species-grid-last-row">
      <div v-for="(species, index) in immutableSpeciesList.slice(12, 15)" :key="index" class="species-highlight-item">
        <div @click="selectSpecies" :style="{ backgroundImage: 'url(' + species.photoFile + ')' }"
          :id="'species-' + species.id" class="species-circle"></div>
        <div class="species-title">
          <p>{{ species.name }}</p>
        </div>
      </div>
    </div>
    
  </div>
  <div id="before-species-highlight"></div>
  <SpeciesHighlight class="section" v-if="selectedSpecies != null" :speciesObject="selectedSpecies" />
  <br>
  <div class="section">
  <h2>Explore the interactive map</h2>
  <p>Use the map below to see how animals have been affected by the loss of grasslands and sagebrush.</p>
  </div>
  <div id="map-section">
    <div id="left-map-panel">
      <div>
        <h3>Select a species</h3>
        <div class="layer-box">
          <div class="layer-box-header" id="select-species-acc-header" @click="toggleSpeciesList">
            <div class="layer-box-icon" :class="{ 'open': mobileSpeciesListIsOpen }" :style="{ transform: rotateTransformSpecies }">
              <span class="layer-box-plus">&#8963;</span>
            </div>
            <div v-if="!mobileSpeciesListIsOpen" class="layer-box-title">Show species list</div>
            <div v-else class="layer-box-title">Hide species list</div>
          </div>
          <transition name="layer-box-transition">
            <div class="layer-box-content" id="species-list-content" v-show="mobileSpeciesListIsOpen">
              <div>
                <div class="layer-box-text" :class="{ 'fade-in': mobileSpeciesListIsOpen, 'fade-out': !mobileSpeciesListIsOpen }">
                  <div v-for="(species, i) in allSpeciesForLeftPanel" :key="i">
                    <Accordion v-if="i==0" :firstInList="true" @species-selected="updateSelectedSpecies" :species="species" :currentlySelectedSpecies="birdSelection"></Accordion>
                    <Accordion v-else @species-selected="updateSelectedSpecies" :species="species" :currentlySelectedSpecies="birdSelection"></Accordion>
                  </div>
                </div>
              </div>
            </div>
          </transition>
        </div>
      </div>
    </div>
    <div id="interactive-map-container">
      <div id="layer-box">
        <div class="layer-box">
          <div class="layer-box-header" @click="toggleLayerBox">
            <div class="layer-box-icon" :class="{ 'open': layerBoxIsOpen }" :style="{ transform: rotateTransform }">
              <span class="layer-box-plus">&#8963;</span>
            </div>
            <div class="layer-box-title"><span>VIEW MAP LAYERS</span></div>
          </div>
          <transition name="layer-box-transition">
            <div class="layer-box-content" v-show="layerBoxIsOpen">
              <div>
                <div class="layer-box-text" :class="{ 'fade-in': layerBoxIsOpen, 'fade-out': !layerBoxIsOpen }">
                  <div class="layer-box-headers flex-container">
                    <div class="layer-box-title flex-half">Select a layer</div>
                    <div class="layer-box-title flex-half" style="text-align: right;">Timespan</div>
                  </div>
                  <div class="flex-container layer-box-row">
                  <div class="map-layer-dropdown">
                    <v-select
                  v-model="selectedBaseLayer"
                  :items="grassLayers"
                  item-title="name"
                  item-value="id"
                  label="Select"
                  density="compact"
                  single-line
                ></v-select>
                  </div>
                  <v-btn-toggle
                      v-model="selectedYearForMap"
                      color="primary"
                      variant="outlined"
                      style="text-align: right; float: right; position:absolute; right: 20px"
                      class="toggle-btns"
                    >
                      <v-btn value="1992" rounded="5">1992</v-btn>
                      <v-btn value="2020" selected rounded="5">2021</v-btn>
                    </v-btn-toggle>
                  </div>
                  <div class="layer-box-row flex-container" v-if="birdSelection != '' && birdSelection != 'none'">
                    <div>{{ birdSelection }}
                      <v-btn @click="birdSelection = 'none'" text
                    class="ma-2"
                    size="small"
                  >
                  REMOVE
                </v-btn>
                    </div>
                    <div style="position: absolute; right: 20px;">2007-2020</div>
                  </div>
                </div>
              </div>
              <br>
              <div style="font-size: 12px">Vegetation layer source: <a style="text-decoration: underline;" href="https://rangelands.app/" target="_blank">Rangeland Analysis Platform (1988-2022)</a></div>
            </div>
          </transition>
        </div>
      </div>
      <leaflet-map :layerYear="selectedYearForMap" mapId="interactive-map" :speciesLayerName="birdSelection"
        :layerName="selectedBaseLayer" :center="startingMapPosition.center" :zoom="startingMapPosition.zoom" 
        :allowScrollZoom="true" @map-center-change="updateMapZoom" />
    </div>
    <div class="section" style="max-width: 700px;">
      <h2>By changing nothing, nothing changes.</h2>
      <br>
      <p>
        Click below to call on Congress to restore disappearing grasslands by supporting a North American Grasslands Conservation Act.
      </p>
      <br>
      <div class="btn-right-container">
        <a href="https://actforgrasslands.org/take-action/">
          <v-btn class="primary-btn" style="text-align: center; width: 150px">ACT NOW</v-btn>
        </a>
      </div>
      
      <ReferenceAccordion></ReferenceAccordion>
    </div>
    
  </div>
  <Footer />
</div>
</template>

<script>
import SpeciesHighlight from "../components/SpeciesHighlight.vue";
import LeafletMap from "../components/LeafletMap.vue";
import RegionalLeaflet from "../components/RegionalLeaflet.vue";
import species from "../assets/data/species-2.json";
import Accordion from "../components/Accordion.vue";
import ReferenceAccordion from "../components/ReferenceAccordion.vue";
import ScrollyLeaflet from "../components/ScrollyLeaflet.vue";
import Footer from "../components/Footer.vue"
import { mdiAccount } from "@mdi/js";

export default {
  name: "HomeView",
  components: {
    SpeciesHighlight,
    LeafletMap,
    Accordion,
    ScrollyLeaflet,
    Footer,
    ReferenceAccordion,
    RegionalLeaflet
  },
  data() {
    return {
      speciesList: [],
      selectedSpecies: null,
      isMobile: false,
      selectedBaseLayerFromUser: {
        name: "Grasslands",
        id: "pfg",
      },
      selectedBaseLayer: "pfg",
      selectedYearForMap: "2020",
      birdSelection: "none",
      layerBoxIsOpen: false,
      mobileSpeciesListIsOpen: true,
      allSpeciesForLeftPanel: null,
      speciesForInteractiveMap: null,
      yearToggle: "2020",
      startingMapPosition: {
        zoom: 4,
        center: [39.0997, -94.5786],
      },
      regionalMapPositions: {
        ne: {
          updateSource: null,
          zoom: 7,
          center: [38.350272538, -78.4204101],
        },
        se: {
          updateSource: null,
          zoom: 6,
          center: [33.0639241981, -83.7377929687],
        },
        mw: {
          updateSource: null,
          zoom: 6,
          center: [37.43997405227, -90.4614257812],
        },
        west: {
          updateSource: null,
          zoom: 7,
          center: [42.74701, -123.8269042],
        }
      },
      grassLayers: [
        { name: "Only species data (no vegetation)", id: "none" },
        { name: "Grasslands", id: "pfg" },
        { name: "Sagebrush", id: "shr" }
      ],
    };
  },
  watch: {
    selectedBaseLayerFromUser() {
      this.selectedBaseLayer = this.selectedBaseLayerFromUser.id;
    },
    isMobile(val) {
      if (val == false) {
        this.mobileSpeciesListIsOpen = true;
        document.getElementById('select-species-acc-header').style.display = 'none';
      } else {
        document.getElementById('select-species-acc-header').style.display = 'flex';
      }
    },
    selectedSpecies() {
      console.log(this.selectedSpecies)
      this.speciesForInteractiveMap = this.selectedSpecies.name;

      setTimeout(()=> {
        this.birdSelection = this.speciesForInteractiveMap;
      }, 1000)
      
      

      // take the allSpecies array and make sure that this.sepectedSpecies.name comes first in the array
      // this will make sure that the selected species is the first one in the list
      // do not manipulate the original array of this.allSpecies
      const speciesArray = this.allSpecies;

      const selectedSpecies = this.selectedSpecies.name;
      const selectedSpeciesIndex = species.findIndex(
        (species) => species.name === selectedSpecies
      );
      let selectedSpeciesObject = species.splice(selectedSpeciesIndex, 1);
      species.unshift(selectedSpeciesObject[0]);


      this.allSpeciesForLeftPanel = speciesArray;
    }
  },
  computed: {
    allSpecies() {
      this.allSpeciesForLeftPanel = species;
      return species;
    },
    rotateTransform() {
        return this.layerBoxIsOpen ? 'rotate(180deg)' : 'rotate(0)';
      },
      rotateTransformSpecies() {
        return this.mobileSpeciesListIsOpen ? 'rotate(180deg)' : 'rotate(0)';
      },
      immutableSpeciesList() {
      // Create a shallow immutable copy of the original array
      return Object.freeze([...this.allSpecies]);
    },
    speciesId() {
      // get all of the id values from the allSpecies array
      let speciesIds = this.allSpecies.map((species) => species.id);
      return speciesIds;
    },
  },
  mounted() {
    this.checkUrlAndScroll();

    this.speciesList = species;

    // initial viewport widwth check
    if (window.innerWidth < 800) {
        this.isMobile = true;
      } else {
        this.isMobile = false;
        document.getElementById('select-species-acc-header').style.display = 'none';
      }

    // setup an event listener to change the value of isMobile to true if the viewport width is less than 800px
    window.addEventListener("resize", () => {
      if (window.innerWidth < 800) {
        this.isMobile = true;
      } else {
        this.isMobile = false;
      }
    });
  },
  methods: {
    checkUrlAndScroll() {
      const hash = window.location.hash;
      // Assuming your URL might look like: http://example.com/#species-section
      if (hash === '#species-section') {
        this.scrollToSection();
      }

      const urlParams = new URLSearchParams(window.location.search);
      const species = urlParams.get('species');
      if (species) {
        console.log('species pre-select')

        this.selectSpeciesFromUrl(species)
      }
    },
    scrollToSection() {
      const section = document.getElementById('species-section');
      if (section) {
        section.scrollIntoView({ behavior: 'smooth' });
      }
    },
    updateMapZoom(center, zoom) {
      this.startingMapPosition.center = center;
      this.startingMapPosition.zoom = zoom;
    },
    updateRegionalMapPos(event) {
      if (event.id == 'map1' || event.id == 'map2') {
        this.regionalMapPositions.se.updateSource = event.id;
        this.regionalMapPositions.se.center = event.center;
        this.regionalMapPositions.se.zoom = event.zoom;
      } else if (event.id == 'map3' || event.id == 'map4') {
        this.regionalMapPositions.mw.updateSource = event.id;
        this.regionalMapPositions.mw.center = event.center;
        this.regionalMapPositions.mw.zoom = event.zoom;
      } else if (event.id == 'map5' || event.id == 'map6') {
        this.regionalMapPositions.west.updateSource = event.id;
        this.regionalMapPositions.west.center = event.center;
        this.regionalMapPositions.west.zoom = event.zoom;
      } else if (event.id == 'map7' || event.id == 'map8') {
        this.regionalMapPositions.ne.updateSource = event.id;
        this.regionalMapPositions.ne.center = event.center;
        this.regionalMapPositions.ne.zoom = event.zoom;
      } 
    },
    updateSelectedSpecies(val) {
      this.speciesForInteractiveMap = val;
      
      this.birdSelection = this.speciesForInteractiveMap;

      setTimeout(()=> {
        // update the above species highlight by changing the map and highlighting the correct circle
        this.selectSpeciesFromAccToggle(val);
      }, 1000)
    },
    toggleLayerBox() {
      this.layerBoxIsOpen = !this.layerBoxIsOpen;
    },
    toggleSpeciesList() {
      console.log('toggle')
      this.mobileSpeciesListIsOpen = !this.mobileSpeciesListIsOpen;
    },
    selectSpeciesFromAccToggle(speciesName) {
      
      // get all divs with class name "species-circle" and remove the class "highlight-circle"
      let speciesCircles = document.getElementsByClassName("species-circle");
      for (let i = 0; i < speciesCircles.length; i++) {
        speciesCircles[i].classList.remove("highlight-circle");
      }

      // convert speciesName to all lower case and insert - between spaces
      speciesName = speciesName.replace(/\s+/g, '-').toLowerCase();
      console.log(speciesName)
      // find the div with the id that matches speciesName and add the class "highlight-circle"
      document.getElementById('species-' + speciesName).classList.add("highlight-circle");

      // TODO: I think this line is causing a bug with toggle switches
      // filter the allSpecies array to find the species that matches the selectedSpecies with the id key
      // this.selectedSpecies = this.allSpecies.find(
      //   (species) => species.id === speciesName
      // );
    },
    selectSpeciesFromUrl(speciesName) {
      // filter the allSpecies array to find the species that matches the selectedSpecies with the id key
      this.selectedSpecies = this.allSpecies.find(
        (species) => species.id === speciesName
      );

      // get all divs with class name "species-circle" and remove the class "highlight-circle"
      let speciesCircles = document.getElementsByClassName("species-circle");
      for (let i = 0; i < speciesCircles.length; i++) {
        speciesCircles[i].classList.remove("highlight-circle");
      }

      // find the div with the id that matches speciesName and add the class "highlight-circle"
      document.getElementById('species-' + speciesName).classList.add("highlight-circle");

      // scroll to the div with id "before-species-highlight" with duration of 1000ms
      document
        .getElementById("before-species-highlight")
        .scrollIntoView({
          behavior: "smooth",
          block: "start",
          inline: "nearest",
        });
    },
    selectSpecies(e) {
      // remove the first 8 letters from the id
      // this will leave us with the species name
      // e.g. species-bobolink becomes bobolink
      let speciesID = e.target.id.slice(8);

      // Update the URL without reloading the page to contain species name
      const newUrl = `${window.location.pathname}?species=${encodeURIComponent(speciesID)}`;
      window.history.pushState({ path: newUrl }, '', newUrl);

      // filter the allSpecies array to find the species that matches the selectedSpecies with the id key
      this.selectedSpecies = this.allSpecies.find(
        (species) => species.id === speciesID
      );

      // select the div that was clicked and then add class "highlight-circle" to it
      document.getElementById(e.target.id).classList.add("highlight-circle");
      // get all divs with class name "species-circle" and remove the class "highlight-circle"
      let speciesCircles = document.getElementsByClassName("species-circle");
      for (let i = 0; i < speciesCircles.length; i++) {
        speciesCircles[i].classList.remove("highlight-circle");
      }

      // select the div that was clicked and then add class "highlight-circle" to it
      document.getElementById(e.target.id).classList.add("highlight-circle");

      // scroll to the div with id "before-species-highlight" with duration of 1000ms
      document
        .getElementById("before-species-highlight")
        .scrollIntoView({
          behavior: "smooth",
          block: "start",
          inline: "nearest",
        });
    },
  },
};

</script>
  
<style scoped>

.highlight-circle {
  border: 6px solid #EFEAD4;
}

#before-species-highlight {
  height: 5px
}

#species-section {
  background-color: #475026;
  color: #EFEAD4;
  padding-top: 30px;
  padding-bottom: 30px;
  margin-top: 100px;
}

.flex-container {
  display: flex;
  flex-wrap: wrap;
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
}

.species-grid {
  display: grid;
  grid-template-columns: repeat(
    4,
    1fr
  ); /* 6 columns in the first and second rows */
  gap: 20px; /* Adjust the gap as needed */
}

.species-grid-last-row {
  display: grid;
  grid-template-columns: repeat(
    3,
    1fr
  ); /* 6 columns in the first and second rows */
  gap: 20px; /* Adjust the gap as needed */
}

/* make this div a circle using a high border radius and width of 200px */
.species-circle {
  border-radius: 50%;
  width: 180px;
  height: 180px;
  background-size: cover;
  background-position: center;
  background-color: #EFEAD4;
  margin: 0 auto;
}

#monarch-pic {
  width: 85%
}

@media (max-width: 850px) {
  .species-grid {
    grid-template-columns: repeat(
      2,
      1fr
    );
    gap: 10px; /* Adjust the gap as needed */
  }

  .species-grid-last-row {
    grid-template-columns: repeat(
      2,
      1fr
    );
    gap: 10px; /* Adjust the gap as needed */
  }
}

@media (max-width: 600px) {
  /* make this div a circle using a high border radius and width of 200px */
.species-circle {
  width: 150px;
  height: 150px;
}

#monarch-pic {
  width: 100%
}
}

.species-highlight-item {
  text-align: center;
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
  margin-bottom: -40px
}

.region-map-item {
  max-width: 600px;
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
  max-height: 650px;
  overflow-y: scroll;
  padding: 1rem;
}

#interactive-map-container {
  flex: 1 1 70%;
  position: relative
}

.layer-box-row {
  height: 60px;
  margin-bottom: 10px;
}

#layer-box {
  position: absolute;
  bottom: 20px;
  left: 40px;
  width: 500px;
  z-index: 500;
  background-color: #FAFAF8;
  padding: 10px;
  border-radius: 5px;
  /* create a light drop shadow */
  box-shadow: 0 0 5px rgba(0, 0, 0, 0.3);
}


#banner {
  display: flex;
  flex-wrap: wrap;
  position: relative;
  /* Set the banner to a relative position */
  background-color: #EFEAD4;
}

#intro-section {
  margin-top: 30px;
  margin-bottom: 100px;
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
  padding-left: 40px;
  background-color: #EFEAD4;
  color: #475026;
  border-top-right-radius: 20% 200px; /* Adjust the second value to control the curve */
  border-bottom-right-radius: 22% 300px; /* Adjust the second value to control the curve */
  position: absolute; /* Set the left div to an absolute position */
    z-index: 2; /* Ensure the left div is above the right div */
    width: 50%;
    min-height: 500px; /* Set the height you want for the right section */
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

#scrolly-section {
    margin-top: 100px;
    margin-bottom: 200px;
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

.regional-titles {
  padding-left: 30px;
  margin-top: 30px;
  font-size: 24px
}

.spacer-after-map {
  height: 450px;
}

  /* media query between 800px and 1200px */
  @media (min-width: 851px) and (max-width: 1200px) {
  #title {
    font-size: 4rem;
  }

  .spacer-after-map {
    height: 200px
  }
}

/* Media query for very wide screens */
@media (min-width: 1450px) {
  #banner {
    height: 600px;
  }


  .left-content {
  flex: 1 1 35%;
  padding: 20px;
  padding-left: 40px;
  background-color: #EFEAD4;
  color: #475026;
  border-top-right-radius: 20% 200px; /* Adjust the second value to control the curve */
  border-bottom-right-radius: 22% 300px; /* Adjust the second value to control the curve */
  position: absolute; /* Set the left div to an absolute position */
    z-index: 2; /* Ensure the left div is above the right div */
    width: 50%;
    min-height: 600px; /* Set the height you want for the right section */
}
}

.map-layer-dropdown {
  width: 250px
}

/* Media query for smaller screens */
@media (max-width: 850px) {
  .toggle-btns * {
    font-size: 14px
  }
  .map-layer-dropdown {
  width: 150px
}

  .spacer-after-map {
    height: 10px
  }

  .region-map-titles.desktop {
    display: none
  }

  .region-map-item {
    padding-top: 5px;
    padding-bottom: 5px;
  }

  .left-content {
    padding-left: 20px;
  }

  /* #left-map-panel {
    max-height: 400px;
    overflow-y: scroll;
  } */

  #scrolly-section {
    padding: 0px
  }

  #species-list-content {
    max-height: 400px;
    overflow-y: scroll;
  }

  /* #left-map-panel .layer-box-header {
    position: sticky
  } */

  #map-section {
    display: block
  }

  #layer-box {
    width: 90%;
    left: 5%;
    bottom: 10%;
  }

  .regional-titles {
    margin-left: 0px
  }

  .flex-section-region-maps {
    margin-top: 10px;
    margin-bottom: 40px
  }

  h2 {
    font-size: 1.6rem;
  }

  #title {
    font-size: 42px;
    line-height: 40px;
  }
  
  #banner {
    display: block;
  }

  .layer-box-title {
    font-size: 12px;
    text-decoration: underline;
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

  .text-pad {
    padding: 5px !important;
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
.layer-box-header {
    display: flex;
    align-items: center;
    cursor: pointer;
  }
  
  .layer-box-icon {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 20px;
    height: 20px;
    margin-right: 20px;
    margin-top: 10px;
    transform-origin: 50% 50%;
    transition: transform 0.3s;
  }
  
  .layer-box-icon.open {
    transform: rotate(180deg);
    transform-origin: 50% 30%;
  }

  .layer-box-plus {
    font-size: 24px;
    transform-origin: 50% 30%;
  }

  .layer-box-title {
    font-weight: bold;
    font-size: 14px
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

  .reference-list {
    max-width: 800px;
    margin: 0 auto;
  }

  .reference-list li {
    margin-top: 10px
  }
.btn-right-container {
  /* position content in this div in the center */
  display: flex;
  justify-content: center;
  margin-bottom: 5px
}

</style>
  