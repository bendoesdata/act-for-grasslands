<template>
  <div>
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
    
    <!-- <leaflet-map mapId="leaflet-2022" :layerYear="2021" />  -->
  </div>
  <div style="height: 600px;"></div>
  <div class="section">
    <div class="text-pad">
      <h2>Regional collapse</h2>
      <p>
        Across the continental U.S., grasslands have seen serious declines. Here is how much they have
        disappeared over the past thirty years.
      </p>
      <p>
        The greener the map, the more grasslands are present. Vast patches of emptiness show how
        much has been lost.
      </p>
      <p style="font-weight: 600">
        Grassland animals are losing their homes.
      </p>
    </div>
    <div class="" style="position: relative">
      <div class="region-map-titles">
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
          <img src="/images/region-maps/se-1992-2.png" width="100%" alt="">
        </div>
        <div class="region-map-item">
          <img src="/images/region-maps/se-2021-2.png" width="100%" alt="">
        </div>
      </div>
      <h3 class="regional-titles">Midwest</h3>
      <div class="flex-section-region-maps">
        <div class="region-map-item">
          <img src="/images/region-maps/mw-1992.png" width="100%" alt="">
        </div>
        <div class="region-map-item">
          <img src="/images/region-maps/mw-2021-2.png" width="100%" alt="">
        </div>
      </div>
      <h3 class="regional-titles">West</h3>
      <div class="flex-section-region-maps">
        <div class="region-map-item">
          <img src="/images/region-maps/we-1992.png" width="100%" alt="">
        </div>
        <div class="region-map-item">
          <img src="/images/region-maps/we-2021-2.png" width="100%" alt="">
        </div>
      </div>
      <h3 class="regional-titles">Northeast</h3>
      <div class="flex-section-region-maps">
        <div class="region-map-item">
          <img src="/images/region-maps/ne-1992-2.png" width="100%" alt="">
        </div>
        <div class="region-map-item">
          <img src="/images/region-maps/ne-2021-2.png" width="100%" alt="">
        </div>
      </div>
  </div>
</div>

  <div id="species-section" class="section">
    <h2 style="margin-bottom: 50px; text-align: center;">Select a species to learn how it has been impacted by grasslands
      loss</h2>
    <div class="flex-section">
      <div v-for="(species, index) in immutableSpeciesList.slice(0, 4)" :key="index">
        <div @click="selectSpecies" :style="{ backgroundImage: 'url(' + species.photoFile + ')' }"
          :id="'species-' + species.id" class="species-circle"></div>
        <div class="species-title">
          <p>{{ species.name }}</p>
        </div>
        
      </div>
    </div>
    <div class="flex-section">
      <div v-for="(species, index) in immutableSpeciesList.slice(4, 8)" :key="index">
        <div @click="selectSpecies" :style="{ backgroundImage: 'url(' + species.photoFile + ')' }"
          :id="'species-' + species.id" class="species-circle"></div>
        <div class="species-title">
          <p>{{ species.name }}</p>
        </div>
      </div>
    </div>
    <div class="flex-section">
      <div v-for="(species, index) in immutableSpeciesList.slice(8, 12)" :key="index">
        <div @click="selectSpecies" :style="{ backgroundImage: 'url(' + species.photoFile + ')' }"
          :id="'species-' + species.id" class="species-circle"></div>
        <div class="species-title">
          <p>{{ species.name }}</p>
        </div>
      </div>
    </div>
    <div class="flex-section">
      <div v-for="(species, index) in immutableSpeciesList.slice(12, 16)" :key="index">
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
  <h2 style="margin: 30px">Explore the interactive map to learn more</h2>
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
                  <div style="width: 250px">
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
        :allowScrollZoom="false" @map-center-change="updateMapZoom" />
    </div>
    <div class="section">
      <h2>References</h2>
      <div class="reference-list">
        <ol>
          <li>U.S. Geological Survey. BBS trends 1966-2019. In: Eastern Ecological Science Center - Bird Population Studies [Internet]. 2019 [cited 29 Aug 2023]. Available: https://www.mbr-pwrc.usgs.gov/</li>
          <li>North American Bird Conservation Initiative. The State of the Birds, United States of America, 2022. 2022. Available: https://www.stateofthebirds.org</li>
          <li>Zornes M, Bishop RA. Western Quail Management Plan. Williamson SJ, editor. Cabot, VT: Wildlife Management Institute; 2009.</li>
          <li>Dabbert CB, Pleasant G, Schemnitz SD. Conservation and management. In: Scaled Quail (Callipepla squamata) [Internet]. 4 Mar 2020 [cited 29 Aug 2023]. Available: https://birdsoftheworld.org/bow/species/scaqua/cur/conservation</li>
          <li>McIntosh MM, Holechek JL, Spiegal SA, Cibils AF, Estell RE. Long-term declining trends in Chihuahuan desert forage production in relation to precipitation and ambient temperature. Rangeland Ecol Manage. 2019;72: 976–987.</li>
          <li>Whitmore RW, Pruess KP, Gold RE. Insect food selection by 2-week-old Ring-Necked Pheasant chicks. J Wildl Manage. 1986;50: 223–228.</li>
          <li>Clark RG, Fleskes JP, Guyn KL, Haukos DA, Austin JE, Miller MR. Conservation and management. In: Northern Pintail (Anas acuta) [Internet]. 4 Mar 2020 [cited 29 Aug 2023]. Available: https://birdsoftheworld.org/bow/species/norpin/cur/conservation</li>
          <li>U.S. Fish and Wildlife Service. Waterfowl population status, 2022. Washington, D.C. USA: U.S. Department of the Interior; 2022. Available: https://www.fws.gov/media/waterfowl-population-status-2022</li>
          <li>Johnson JA, Schroeder MA, Robb LA. Behavior. In: Greater Prairie-Chicken (Tympanuchus cupido) [Internet]. 4 Mar 2020 [cited 30 Aug 2023]. Available: https://birdsoftheworld.org/bow/species/grpchi/cur/behavior</li>
          <li>Lautenbach JM, Plumb RT, Robinson SG, Hagen CA, Haukos DA, Pitman JC. Lesser Prairie-Chicken avoidance of trees in a grassland landscape. Rangeland Ecol Manage. 2017;70: 78–86.</li>
          <li>Brennan LA, Hernández F, Williford D. Conservation and management. In: Northern Bobwhite (Colinus virginianus) [Internet]. 4 Mar 2020 [cited 30 Aug 2023]. Available: https://birdsoftheworld.org/bow/species/norbob/cur/conservation</li>
          <li>Drilling N, Titman RD, McKinney F. Habitat. In: Mallard (Anas platyrhynchos) [Internet]. 4 Mar 2020 [cited 30 Aug 2023]. Available: https://birdsoftheworld.org/bow/species/mallar3/cur/habitat</li>
          <li>Doherty KE, Ryba AJ, Stemler CL, Niemuth ND, Meeks WA. Conservation planning in an era of change: state of the U.S. Prairie Pothole region. Wildl Soc Bull. 2013. doi:10.1002/wsb.284</li>
          <li>Trout Unlimited. State of the trout: a report on the status and trends of native trout in the United States. Arlington, VA; 2015.</li>
          <li>Western Native Trout Initiative. Rio Grande Cutthroat Trout (Oncorhynchus clarkii virginalis). 2016 May.</li>
          <li>Kauffman MJ, Copeland HE, Berg J, Bergen S, Cole E, Cuzzocreo M, et al. Ungulate migrations of the western United States, Volume 1: U.S. Geological Survey Scientific Investigations Report 2020–5101. U.S. Department of the Interior, U.S. Geological Survey; 2020. doi:10.3133/sir20205101</li>
          <li>Semmens BX, Semmens DJ, Thogmartin WE, Wiederholt R, López-Hoffman L, Diffendorfer JE, et al. Quasi-extinction risk and population targets for the Eastern, migratory population of monarch butterflies (Danaus plexippus). Sci Rep. 2016;6: 23265.</li>
          <li>Schultz CB, Brown LM, Pelton E, Crone EE. Citizen science monitoring demonstrates dramatic declines of monarch butterflies in western North America. Biol Conserv. 2017;214: 343–346.</li>
          <li>Hatfield R, Colla S, Jepsen S, Richardson L, Thorp R, Jordan SF. IUCN assessments for North American Bombus spp. Xerces Society; 2015 Mar.</li>
          <li>Selby G. Regal Fritillary (Speyeria idalia Drury): a technical conservation assessment. USDA Forest Service, Rocky Mountain Region; 2007 Feb. Available: http://www.fs.fed.us/r2/projects/scp/assessments/regalfritillary.pdf</li>
          <li>NatureServe explorer 2.0. [cited 30 Aug 2023]. Available: https://explorer.natureserve.org/Taxon/ELEMENT_GLOBAL.2.114908/Argynnis_idalia</li>
        </ol>
      </div>
    </div>
  </div>
</div>
</template>

<script>
import SpeciesHighlight from "../components/SpeciesHighlight.vue";
import LeafletMap from "../components/LeafletMap.vue";
import species from "../assets/data/species.json";
import Accordion from "../components/Accordion.vue";
import ScrollyLeaflet from "../components/ScrollyLeaflet.vue";
import { mdiAccount } from "@mdi/js";

export default {
  name: "HomeView",
  components: {
    SpeciesHighlight,
    LeafletMap,
    Accordion,
    ScrollyLeaflet,
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
        document.getElementById('select-species-acc-header').style.display = 'block';
      }
    },
    selectedSpecies() {
      // console.log(this.selectedSpecies)
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
    updateMapZoom(center, zoom) {
      console.log(center, zoom);
      this.startingMapPosition.center = center;
      this.startingMapPosition.zoom = zoom;
    },
    updateSelectedSpecies(val) {
      this.speciesForInteractiveMap = val;
      console.log(this.speciesForInteractiveMap);
      this.birdSelection = this.speciesForInteractiveMap;
    },
    toggleLayerBox() {
      this.layerBoxIsOpen = !this.layerBoxIsOpen;
    },
    toggleSpeciesList() {
      console.log('toggle')
      this.mobileSpeciesListIsOpen = !this.mobileSpeciesListIsOpen;
    },
    selectSpecies(e) {
      // remove the first 8 letters from the id
      // this will leave us with the species name
      // e.g. species-bobolink becomes bobolink
      let speciesID = e.target.id.slice(8);

      console.log(speciesID, this.allSpecies);

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
  height: 30px
}

#species-section {
  background-color: #475026;
  color: #EFEAD4;
  padding-top: 30px;
  padding-bottom: 30px;
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

/* make this div a circle using a high border radius and width of 200px */
.species-circle {
  border-radius: 50%;
  width: 180px;
  height: 180px;
  background-size: cover;
  background-position: center;
  background-color: #EFEAD4;
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

/* Media query for smaller screens */
@media (max-width: 800px) {
  /* #left-map-panel {
    max-height: 400px;
    overflow-y: scroll;
  } */

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
    width: 250px;
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
    font-size: 12px
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
    transform-origin: 50% 50%;
  }

  .layer-box-plus {
    font-size: 24px;
    transform-origin: 50% 50%;
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


</style>
  