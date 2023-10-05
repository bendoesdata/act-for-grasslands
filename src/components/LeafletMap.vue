<template>
    <div :id="mapId" class="leaflet-map" @mouseover="showMessage = true" @mouseleave="showMessage = false">
        <div v-if="showMessage" class="message-overlay">
        Hold Ctrl/Cmd and scroll to zoom
        </div>
    </div>
  </template>
  
  <script>
  import { ref, onMounted, onUnmounted, watch } from 'vue';
  import L from 'leaflet';
  import 'leaflet/dist/leaflet.css';
  
  export default {
  props: {
    center: {
      type: Array,
      required: false,
      default: [39.0997, -94.5786],
    },
    zoom: {
      type: Number,
      required: false,
      default: 4
    },
    layerName: {
      type: String,
      required: false,
      default: 'pfg'
    },
    layerYear: {
      type: Number,
      required: false,
      default: 2020
    },
    birdLayerName: {
      type: String,
      required: false,
      default: null
    },
    mapId: {
      type: String,
      required: false,
      default: 'mapContainer'
    }
  },
  data() {
    return {
      showMessage: false,
      map: null,
      mapRef: ref(null),
      // species dictionary
      speciesDictionary: {
            'Burrowing Owl': 'burowl3',
            'Northern Bobwhite': 'norbob',
            'Western Meadowlark': 'wesmead',
            'Bobolink': 'bobo',
            'Sharp-tailed Grouse': 'shtgro',
            'Scaled Quail': 'scaqua',
            'Ring-necked Pheasant': 'rinphe',
            'Northern Pintail': 'norpin',
            'Mallard': 'mal',
            'American Wigeon': 'amewig',
        }
    }
  },
  watch: {
    center() {
      this.map.setView(this.center, this.zoom);
    },
    layerName() {
      this.map.remove();
      this.drawMap()
    },
    layerYear() {
      this.map.remove();
      this.drawMap()
    },
    birdLayerName(){
      this.map.remove();
      this.drawMap()
      this.addBirdLayer(this.birdLayerName)
    }
  },
  methods: {
    drawMap() {
      
      this.map = L.map(this.mapId,{scrollWheelZoom: false}).setView(this.center, this.zoom);

      let CartoDB_Positron = L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>',
            subdomains: 'abcd',
            maxZoom: 20
        }).addTo(this.map);
        
      let tileLayer = L.tileLayer(`https://storage.googleapis.com/rap-tiles-cover-v3/unmasked/${this.layerName}/${this.layerYear}/{z}/{x}/{y}.png`, {
                maxZoom: 18,
                opacity: 1
            }).addTo(this.map);

      var CartoDB_VoyagerOnlyLabels = L.tileLayer('https://{s}.basemaps.cartocdn.com/rastertiles/voyager_only_labels/{z}/{x}/{y}{r}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>',
            subdomains: 'abcd',
            maxZoom: 20
          }).addTo(this.map);

    // Add custom event listener to handle scroll zoom when Cmd/Ctrl key is held down
    document.getElementById(this.mapId).addEventListener('mousewheel', (e) => {
        
        if (e.ctrlKey || e.metaKey) {
          // Zoom when Cmd/Ctrl key is held down
          const delta = e.wheelDeltaY || e.deltaY;
          if (delta > 0) {
            map.zoomIn();
          } else {
            map.zoomOut();
          }
          e.preventDefault();
        }
      });
    },
    addBirdLayer(species) {
      // Define a custom style function for the polygon
      function customPolygonStyle(feature) {
            var abd_trend = feature.properties.abd_trend;
            var fillColor;

            if (abd_trend <= -20) {
            fillColor = '#CB181D';
            } else if (abd_trend > -20 && abd_trend <= 0) {
            fillColor = '#FD9272';
            } else if (abd_trend > 0 && abd_trend <= 20) {
            fillColor = '#7ece61';
            } else if (abd_trend > 20) {
            fillColor = '#1B6900';
            }

        return {
            fillColor: fillColor,
            weight: 1,
            opacity: 1,
            color: 'black',
            fillOpacity: 0.6
        };
        }

        let speciesLayer;

        let map = this.map;
        let currentSpecies = this.speciesDictionary[species];
    
        // Fetch the GeoJSON file
        function getData() {

            // create fp variable and store filepath for burowl3.geojson in the public folder under data
            let fp = `public/data/${currentSpecies}.geojson`;
            
            fetch(fp)
            .then(function (response) {
                return response.json();
            })
            .then(function (data) {
                console.log(data)
                data.features.forEach(function(state) {
                    state.active = true;
                    
                    // Create a GeoJSON layer with the custom polygon style
                    speciesLayer = L.geoJSON(state, {
                    style: customPolygonStyle,
                    // add a popup for this polygon
                    onEachFeature: function( feature, layer){
                        layer.on('click', function (event) {
                            console.log(feature,layer,event)
                        var popupContent = feature.properties.abd_trend; // Replace with the appropriate property for your popup content
                        console.log(popupContent)
                        layer.bindPopup(popupContent).openPopup();
                        });
                    }
                    }).addTo(map);
                    
                });

                // turn the display of #loading-msg to block
            // document.getElementById('loading-msg').style.display = 'none';
            });
        }

        getData('Burrowing Owl');
        
    }
  },
  mounted() {
    this.drawMap();
    
    this.addBirdLayer()
  },
  unmounted() {
    this.map.remove();
  }
  
};
  </script>
  
  <style>
  /* Add any additional styles for your Leaflet map container here */
  .leaflet-map {
    height: 550px;
  }

  .message-overlay {
  position: absolute;
  top: 10%;
  left: 15%;
  transform: translate(-50%, -50%);
  background-color: rgba(0, 0, 0, 0.6);
  color: white;
  padding: 10px;
  border-radius: 5px;
  font-size: 14px;
  z-index: 9999;
}
  </style>
  