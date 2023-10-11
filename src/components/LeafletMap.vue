<template>
    <div :id="mapId" class="leaflet-map" @mouseover="showMessage = true" @mouseleave="showMessage = false">
      <div id="loading-msg" v-if="birdLayerName != 'none'">
        <v-progress-circular indeterminate></v-progress-circular>
        Data layer loading...
      </div>
        <div v-if="showMessage && !allowScrollZoom" class="message-overlay">
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
      type: Object,
      required: false,
      default: [39.0997, -94.5786],
    },
    zoom: {
      type: Number,
      required: false,
      default: 6
    },
    layerName: {
      type: String,
      required: false,
      default: 'pfg'
    },
    layerYear: {
      type: String,
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
    },
    allowScrollZoom: {
      type: Boolean,
      required: false,
      default: false
    }
  },
  data() {
    return {
      showMessage: false,
      map: null,
      mapRef: ref(null),
      localZoomLevel: null,
      localCenter: null,
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
    layerName() {
      this.map.remove();
      this.drawMap()
      if (this.birdLayerName !== 'none') {
        this.addBirdLayer(this.birdLayerName)
      }
    },
    layerYear() {
      this.map.remove();
      this.drawMap();
      if (this.birdLayerName !== 'none') {
        this.addBirdLayer(this.birdLayerName)
      }
    },
    birdLayerName(){

      this.map.remove();
      
      this.drawMap();
      if (this.birdLayerName == 'Monarch Butterfly') {
        this.drawMonarch();
      } else if (this.birdLayerName == 'Pronghorn') {
        this.drawPronghorn();
      } else if (this.birdLayerName !== 'none') {
        this.addBirdLayer(this.birdLayerName)
      }
    }
  },
  methods: {
    drawMap() {
      
      this.map = L.map(this.mapId,{scrollWheelZoom: this.allowScrollZoom}).setView(this.center, this.zoom);

      let CartoDB_Positron = L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>',
            subdomains: 'abcd',
            maxZoom: 20
        }).addTo(this.map);

      if (!this.layerName != 'none') {
        let tileLayer = L.tileLayer(`https://storage.googleapis.com/rap-tiles-cover-v3/masked/${this.layerName}/${this.layerYear}/{z}/{x}/{y}.png`, {
                maxZoom: 18,
                opacity: 1
            }).addTo(this.map);
      }

      var CartoDB_VoyagerOnlyLabels = L.tileLayer('https://{s}.basemaps.cartocdn.com/rastertiles/voyager_only_labels/{z}/{x}/{y}{r}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>',
            subdomains: 'abcd',
            maxZoom: 20
          }).addTo(this.map);
    

     // Add event listeners
     this.map.on('zoomend', this.handleZoomChange);
    this.map.on('moveend', this.handleCenterChange);

    if (!this.allowScrollZoom) {
      // Add custom event listener to handle scroll zoom when Cmd/Ctrl key is held down
    document.getElementById(this.mapId).addEventListener('mousewheel', (e) => {
        
        if (e.ctrlKey || e.metaKey) {
          // Zoom when Cmd/Ctrl key is held down
          const delta = e.wheelDeltaY || e.deltaY;
          if (delta > 0) {
            this.map.zoomIn();
          } else {
            this.map.zoomOut();
          }
          e.preventDefault();
        }
      });
    }
    },
    drawMonarch() {
      // Define the custom icon
var butterflyIconBefore = L.icon({
    iconUrl: '/images/icons/butterfly-before.svg',  // Adjust the path as needed
    iconSize: [28, 75],  // Size of the icon; adjust based on your SVG's dimensions
    iconAnchor: [19, 47],  // Point of the icon which corresponds to marker's location
    popupAnchor: [0, -47]  // Point where the popup will open relative to the iconAnchor
});

var butterflyIconAfter = L.icon({
    iconUrl: '/images/icons/butterfly-after.svg',  // Adjust the path as needed
    iconSize: [28, 75],  // Size of the icon; adjust based on your SVG's dimensions
    iconAnchor: [19, 47],  // Point of the icon which corresponds to marker's location
    popupAnchor: [0, -47]  // Point where the popup will open relative to the iconAnchor
});



  fetch('/data/monarch-east-after.geojson')
    .then(response => response.json())
    .then(data => {
        L.geoJSON(data, {
            pointToLayer: function (feature, latlng) {
                // Use a custom icon if desired
                return L.marker(latlng,  { icon: butterflyIconAfter });
            }
        }).addTo(this.map);
    });
      // Load the GeoJSON
fetch('/data/monarch-east-before.geojson')
    .then(response => response.json())
    .then(data => {
        L.geoJSON(data, {
            pointToLayer: function (feature, latlng) {
                // Use a custom icon if desired
                return L.marker(latlng,  { icon: butterflyIconBefore });
            }
        }).addTo(this.map);
    });
    },
    drawPronghorn() {
      // Load range GeoJSON from an external file
fetch('/data/final-prong.geojson')
  .then(response => response.json())
  .then(data => {
    console.log(data)
    // Add GeoJSON layer to the map once the file is loaded
    L.geoJSON(data, {
  style: function(feature) {
    if (feature.properties.Time == 'Original') {
      return {
        color: "#7f9694", // Example color
        weight: 2,
        // dashArray: '5, 5'
      };
    } else {
      return {
        color: "#BBA38E", // Example color
        weight: 2,
        fillOpacity: 0.7
      };
    }
  },
  onEachFeature: function(feature, layer) {
    // layer.bindPopup(feature.properties.name); // Assuming 'name' is a property in your GeoJSON
  }
}).addTo(this.map);

  });
    },
    handleCenterChange() {
      this.localCenter = this.map.getCenter();
      this.$emit('map-center-change', this.localCenter, this.localZoomLevel);
    },
    handleZoomChange() {
      this.localZoomLevel = this.map.getZoom();
      this.$emit('map-center-change', this.localCenter, this.localZoomLevel);
    },
    addBirdLayer(species) {
      // Define a custom style function for the polygon
      
      // turn the display of #loading-msg to block
      // document.getElementById('loading-msg').style.display = 'block';

      function customPolygonStyle(feature) {
            var abd_trend = feature.properties.abd_trend;
            var fillColor;

            if (abd_trend <= -20) {
            fillColor = '#750036';
            } else if (abd_trend > -20 && abd_trend <= 0) {
            fillColor = '#C97FAA';
            } else if (abd_trend > 0 && abd_trend <= 20) {
            fillColor = '#92BC5D';
            } else if (abd_trend > 20) {
            fillColor = '#0D5300';
            }

        return {
            fillColor: fillColor,
            weight: 0,
            opacity: 1,
            color: 'black',
            fillOpacity: 0.8
        };
        }

        let speciesLayer;

        let map = this.map;
        let currentSpecies = this.speciesDictionary[species];
    
        // Fetch the GeoJSON file
        function getData() {

            // create fp variable and store filepath for burowl3.geojson in the public folder under data
            let fp = `/data/${currentSpecies}.geojson`;
            
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
            document.getElementById('loading-msg').style.display = 'none';
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

  #loading-msg {
    display: none;
    position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: rgba(0, 0, 0, 0.6);
  color: white;
  padding: 10px;
  border-radius: 5px;
  font-size: 14px;
  z-index: 9999;
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
  