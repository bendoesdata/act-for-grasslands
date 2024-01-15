<template>
   <div>
    <div class="map-container">
        <div ref="map1" id="scroll-map-1" class="leaflet-map">
          <div class="map-credit">Source: Rangeland Analysis Platform</div>
        </div>
        <div ref="map2" id="scroll-map-2" class="leaflet-map"></div>
    </div>
    <div class="scroll-box"  v-for="(box, index) in textBoxes" :key="index" :ref="el => textBoxRefs[index] = el">
        <div v-if="index == 0" class="text-box invisible">
          <h2></h2>
        </div>
        <div v-else class="text-box">
            <h2>{{ box.content }}</h2>
        </div>
    </div>
    </div>
</template>

<script>
import { ref, onMounted } from 'vue';
import L from 'leaflet';
import { zoom } from 'd3';

export default {
  setup() {
    const map1 = ref(null);
    const map2 = ref(null);
    const textBoxes = ref([
      { content: '' },
      { content: 'Here is how grasslands in the U.S. looked in 1992.' },
      { content: 'Here is what remained in 2021.' }
    ]);
    const textBoxRefs = ref([]);

    onMounted(() => {
      let zoomlevel;
      if (window.innerWidth > 1250) {
        zoomlevel = 5;
      } else if (window.innerWidth > 800 && window.innerWidth <= 1250) {
        zoomlevel = 4;
      } else {
        zoomlevel = 3;
      } 
        const leafletMap1 = L.map(map1.value,{scrollWheelZoom: false}).setView([38.0997, -96.1786], zoomlevel);
        const leafletMap2 = L.map(map2.value,{scrollWheelZoom: false}).setView([38.0997, -96.1786], zoomlevel);

      let CartoDB_Positron = L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>',
            subdomains: 'abcd',
            maxZoom: 20
        }).addTo(leafletMap1);
        
      let tileLayer = L.tileLayer(`https://storage.googleapis.com/rap-tiles-cover-v3/masked/${'pfg'}/${'1992'}/{z}/{x}/{y}.png`, {
                maxZoom: 18,
                opacity: 1
            }).addTo(leafletMap1);

      var CartoDB_VoyagerOnlyLabels = L.tileLayer('https://{s}.basemaps.cartocdn.com/rastertiles/voyager_only_labels/{z}/{x}/{y}{r}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>',
            subdomains: 'abcd',
            maxZoom: 20
          }).addTo(leafletMap1);

          

          let CartoDB_Positron2 = L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>',
            subdomains: 'abcd',
            maxZoom: 20
        }).addTo(leafletMap2);
        
        // rap tiles won't let me get year 2022 for some reason
      let tileLayer2 = L.tileLayer(`https://storage.googleapis.com/rap-tiles-cover-v3/masked/${'pfg'}/${'2021'}/{z}/{x}/{y}.png`, {
                maxZoom: 18,
                opacity: 1
            }).addTo(leafletMap2);

      var CartoDB_VoyagerOnlyLabels2 = L.tileLayer('https://{s}.basemaps.cartocdn.com/rastertiles/voyager_only_labels/{z}/{x}/{y}{r}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>',
            subdomains: 'abcd',
            maxZoom: 20
          }).addTo(leafletMap2);



    //   const leafletMap1 = L.map(map1.value).setView([51.505, -0.09], 13);
    //   L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(leafletMap1);

    //   const leafletMap2 = L.map(map2.value).setView([51.505, -0.09], 10);
    //   L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(leafletMap2);

      // Initially, hide the second map
      map2.value.classList.add('map2-inactive');

      leafletMap1.zoomControl.remove();
      leafletMap2.zoomControl.remove();

      var customControl = L.Control.extend({
    options: {
        position: 'bottomleft' // You can position it top|bottom - left|right
    },

    onAdd: function (map) {
        var container = L.DomUtil.create('div', 'leaflet-bar leaflet-control leaflet-control-custom');
        container.style.backgroundColor = 'white';
        container.style.padding = '5px';
        container.innerText = 'Data source: Rangeland Analysis Platform';
        return container;
    }
});

  leafletMap1.addControl(new customControl());
  leafletMap2.addControl(new customControl());

      // Add scroll event listener
      window.addEventListener('scroll', () => {
        const secondTextBoxTop = textBoxRefs.value[1].getBoundingClientRect().top + 400;
        if (secondTextBoxTop <= 1) {
            map2.value.classList.remove('map-inactive');
            map2.value.classList.add('map2-active');
            map1.value.classList.add('map-inactive');

        } else {
            console.log('show first map')
            map2.value.classList.remove('map2-active');
            map2.value.classList.add('map-inactive');
            map1.value.classList.remove('map-inactive');
        }
      });
    });

    return {
      map1,
      map2,
      textBoxes,
      textBoxRefs
    };
  }
};


</script>

<style scoped>
.invisible {
  opacity: 0;
}
.map-container {
  position: sticky;
  top: 10%; /* This will make the map stick to the center of the viewport */
  z-index: 0;
  margin-bottom: 0px;
  filter: hue-rotate(0deg) saturate(0.8) contrast(110%);
}

.leaflet-map {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 700px; /* Adjust as needed */
  transition: opacity 0s;/*  Adjust the duration as needed */
}

.map2-active {
  opacity: 1;
  z-index: 0; /* Ensure the second map is on top during the transition */
}

.map-inactive {
    opacity: 0
}

.scroll-box {
    height: 800px; /* Adjust as needed */
    position:relative;
    z-index: 100;
    background: rgba(255,255,255,0);
    text-align: center;
    padding: 20px;
    margin: auto 0;
    margin-top: 100px;
    /* border: 1px solid red; */
    /* center vertically */
    display: flex;
    justify-content: center;
    align-items: center;
}

.text-box {
  height: 100px; /* Adjust as needed */
  position:relative;
  background: rgba(255,255,255,0.9);
  text-align: center;
  padding: 20px;
  margin: auto 0;
}


/* Media query for smaller screens */
@media (max-width: 800px) {
  .text-box {
    height: 180px; /* Adjust as needed */
    background: rgba(255,255,255,0.8);
    /* center text vertically */
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .text-box h2 {
    font-size: 1.6rem
  }
}
</style>