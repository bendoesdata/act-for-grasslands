<template>
  <div
    :id="mapId"
    class="leaflet-map"
    @mouseover="showMessage = true"
    @mouseleave="showMessage = false"
  >
  <div id="zoom-msg">
    Hold Cmd or Ctrl to zoom by scroll
  </div>
    <div id="legend-container">
      <div>
        <div @click="toggleLegendBox" id="toggle-legend">&minus; Minimize legend</div>
        <div id="legend-contents">
        <div v-if="layerName == 'pfg'">
          <div class="legend-title">Grasslands</div>
          <img
            src="/images/legends/map-legends-03.png"
            style="width: 100%"
            alt=""
          />
        </div>
        <div v-else-if="layerName == 'shr'">
          <div class="legend-title">Sagebrush</div>
          <img
            src="/images/legends/map-legends-04.png"
            style="width: 100%"
            alt=""
          />
        </div>
        <div v-if="speciesLayerName != 'none'">
          <div v-if="layerType == 'trend'">
            <div class="legend-title">Relative abundance</div>
            <div class="legend-subtitle">Middle year of range, 2014</div>
            <img
              src="/images/legends/map-legends-02.png"
              style="width: 100%"
              alt=""
            />
            <div class="legend-title">Abundance trend</div>
            <div class="legend-subtitle">Pct. change, 2007-2021</div>
            <img
              src="/images/legends/map-legends-01.png"
              style="width: 100%"
              alt=""
            />
            <div class="ebird-note">Circles reflect modeled trends and not actual bird locations.</div>
          </div>
          <div v-else-if="layerType == 'range'">
            <div class="legend-title">Species range</div>
            <div style="margin-top: 5px">
              <span class="circle-legend-before"></span> Maximum historical range
            </div>
            <div><span class="circle-legend-after"></span> Current</div>
          </div>
          <div v-else-if="layerType == 'abundance'">
            <div v-if="speciesLayerName == 'Monarch Butterfly'">
            <div class="legend-title">Estimated abundance</div>
            <div style="height: 100px">
              <v-btn-toggle
                v-model="beforeAfterToggle"
                color="primary"
                variant="outlined"
                small
                style="height: 30px"
              >
                <v-btn value="before" rounded="5">Before</v-btn>
                <v-btn value="after" selected rounded="5">After</v-btn>
              </v-btn-toggle>
              
                <div style="font-style: italic; margin-bottom: 0px">
                Butterflies show relative loss at scale, and do not represent
                actual butterfly locations.
              </div>
              <div>
                <div style="margin-top: 5px">
                  <span class="circle-legend-before"></span> Western population
                  range
                </div>
                <div>
                  <span class="circle-legend-after"></span> Eastern population
                  range
                </div>
              </div>
            </div>
          </div>
          <div v-else>
                <br>
                <div><span class="circle-legend-before"></span> Before: pre 2000</div>
                <div><span class="circle-legend-after"></span> After: 2000-2020</div>
                <div style="font-style: italic; margin-bottom: 0px">
                  Range maps created based on polygon detection maps using the Bumble Bees of North America database.
              </div>
              </div>
          </div>
        </div>
        </div>
      </div>
    </div>
    <div id="loading-msg">
      <v-progress-circular indeterminate></v-progress-circular>
      Data layers loading...
    </div>
  </div>
</template>
  
  <script>
import { ref, onMounted, onUnmounted, watch } from "vue";
import L from "leaflet";
import "leaflet/dist/leaflet.css";

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
      default: 6,
    },
    layerName: {
      type: String,
      required: false,
      default: "pfg",
    },
    layerYear: {
      type: String,
      required: false,
      default: 2020,
    },
    speciesLayerName: {
      type: String,
      required: false,
      default: null,
    },
    mapId: {
      type: String,
      required: false,
      default: "mapContainer",
    },
    allowScrollZoom: {
      type: Boolean,
      required: false,
      default: false,
    },
  },
  data() {
    return {
      legendOpen: true,
      showMessage: false,
      beforeAfterToggle: "before",
      map: null,
      mapRef: ref(null),
      localZoomLevel: null,
      localCenter: null,
      layerType: null,
      // species dictionary
      speciesDictionary: {
        "Burrowing Owl": "burowl3",
        "Northern Bobwhite": "norbob",
        "Western Meadowlark": "wesmead",
        "Bobolink": "bobo",
        "Sharp-tailed Grouse": "shtgro",
        "Scaled Quail": "scaqua",
        "Ring-necked Pheasant": "rinphe",
        "Northern Pintail": "norpin",
        "Mallard": "mal-reduced",
        "American Wigeon": "amewig",
      },
    };
  },
  watch: {
    layerName() {
      this.map.remove();
      this.drawMap();
      if (this.speciesLayerName !== "none") {
        this.checkLayerTypeAndDraw();
      }
    },
    layerYear() {
      this.map.remove();
      this.drawMap();
      if (this.speciesLayerName !== "none") {
        this.checkLayerTypeAndDraw();
      }
    },
    beforeAfterToggle() {
      this.map.remove();
      this.drawMap();
      
      if (this.speciesLayerName == "Southern Plains Bumble Bee") {
        console.log('switch on')
        // turn the display of #loading-msg to block
        document.getElementById("loading-msg").style.display = "block";

        setTimeout(()=> {
          this.drawBumbleBee();  
        }, 1500)

        
      } else if (this.speciesLayerName == "Monarch Butterfly") {
        this.drawMonarch();
      }
    },
    speciesLayerName() {
      this.map.remove();

      this.drawMap();

      this.checkLayerTypeAndDraw();
    },
  },
  methods: {
    toggleLegendBox() {
      this.legendOpen = !this.legendOpen;
      if (this.legendOpen) {
        document.getElementById("legend-container").style.height = "auto";

        document.getElementById("legend-contents").classList.remove("hide-content")

        document.getElementById("toggle-legend").innerHTML = "&minus; Minimize legend";
      } else {
        document.getElementById("legend-container").style.height = "40px";

        document.getElementById("legend-contents").classList.add("hide-content")

        document.getElementById("toggle-legend").innerHTML = "&plus; Expand legend";
      }
      
    },
    checkLayerTypeAndDraw() {
      if (this.speciesLayerName == "Monarch Butterfly") {
        this.layerType = "abundance";
        this.drawMonarch();
      } else if (this.speciesLayerName == "Pronghorn") {
        this.layerType = "range";
        this.drawPronghorn();
      } else if (this.speciesLayerName == "Elk") {
        this.layerType = "range";
        this.drawElk();
      } else if (this.speciesLayerName == "Greater Prairie-Chicken") {
        this.layerType = "range";
        this.drawGPC();
      } else if (this.speciesLayerName == "Greater Sage-Grouse") {
        this.layerType = "range";
        this.drawSagGro();
      } else if (this.speciesLayerName == "Rio Grande Cutthroat Trout") {
        this.layerType = "range"
        this.drawTrout();
      } else if (this.speciesLayerName == "Mule Deer") {
        this.layerType = "migration";
        this.drawMuleDeer();
      } else if (this.speciesLayerName == "Regal Fritillary") {
        this.layerType = "range";
        this.drawRegalFrit(this.speciesLayerName);
      } else if (this.speciesLayerName == "Southern Plains Bumble Bee") {
        this.layerType = "abundance";
        // turn the display of #loading-msg to block
        document.getElementById("loading-msg").style.display = "block";

        setTimeout(()=> {
          this.drawBumbleBee();  
        }, 1500)
      } else if (this.speciesLayerName !== "none") {
        this.layerType = "trend";
        this.addBirdLayer(this.speciesLayerName);
      }
    },
    drawMap() {
      this.map = L.map(this.mapId, {
        scrollWheelZoom: this.allowScrollZoom,
      }).setView(this.center, this.zoom);

      let CartoDB_Positron = L.tileLayer(
        "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png",
        {
          attribution:
            '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>',
          subdomains: "abcd",
          minZoom: 4,
          maxZoom: 20,
        }
      ).addTo(this.map);

      if (!this.layerName != "none") {
        let tileLayer = L.tileLayer(
          `https://storage.googleapis.com/rap-tiles-cover-v3/masked/${this.layerName}/${this.layerYear}/{z}/{x}/{y}.png`,
          {
            minZoom: 4,
            maxZoom: 20,
            opacity: 1,
          }
        ).addTo(this.map);
      }

      var CartoDB_VoyagerOnlyLabels = L.tileLayer(
        "https://{s}.basemaps.cartocdn.com/rastertiles/voyager_only_labels/{z}/{x}/{y}{r}.png",
        {
          attribution:
            '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>',
          subdomains: "abcd",
          minZoom: 4,
          maxZoom: 20,
        }
      ).addTo(this.map);

      // Add event listeners
      this.map.on("zoomend", this.handleZoomChange);
      this.map.on("moveend", this.handleCenterChange);

      if (!this.allowScrollZoom) {
        // Add custom event listener to handle scroll zoom when Cmd/Ctrl key is held down
        document
          .getElementById(this.mapId)
          .addEventListener("mousewheel", (e) => {
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
    drawBumbleBee() {
      fetch("/data/bees-pre-2000-range.geojson")
        .then((response) => response.json())
        .then((data) => {
          
          // Add GeoJSON layer for historic range
          L.geoJSON(data, {
            style: function (feature) {
              return {
                color: "#7f9694", // Example color
                weight: 2,
              };
            },
          }).addTo(this.map);
        });

      // Load range GeoJSON for the current range
      fetch("/data/bees-post-2000-range.geojson")
        .then((response) => response.json())
        .then((data) => {
          
          // Add GeoJSON layer to the map once the file is loaded
          L.geoJSON(data, {
            style: function (feature) {
              return {
                color: "#BBA38E", // Example color
                weight: 2,
                fillOpacity: 0.7,
              };
            },
          }).addTo(this.map);
        });

        // Create a popup
        var popup = L.popup()
            .setLatLng([36.1627, -86.7816])
            .setContent("Southern Plain Bumblebees are 85% less common than they were before 2000.")
            .openOn(this.map);

      // turn the display of #loading-msg to none
      document.getElementById("loading-msg").style.display = "none";
    },
    drawMonarch() {
      // Define the custom icon
      var butterflyIcon = L.icon({
        iconUrl: "/images/icons/noun-monarch-butterfly-3564833.svg", // Adjust the path as needed
        iconSize: [28, 75], // Size of the icon; adjust based on your SVG's dimensions
        iconAnchor: [19, 47], // Point of the icon which corresponds to marker's location
        popupAnchor: [0, -47], // Point where the popup will open relative to the iconAnchor
      });

      // load east range
      fetch("/data/monarch-east-range.geojson")
        .then((response) => response.json())
        .then((data) => {
          
          // Add GeoJSON layer for historic range
          L.geoJSON(data, {
            style: function (feature) {
              return {
                color: "#607C78",
                weight: 2,
              };
            },
          }).addTo(this.map);
        });

      // load west range
      fetch("/data/monarch-west-range.geojson")
        .then((response) => response.json())
        .then((data) => {
          
          // Add GeoJSON layer for historic range
          L.geoJSON(data, {
            style: function (feature) {
              return {
                color: "#C08440", // Example color
                weight: 2,
              };
            },
          }).addTo(this.map);
        });
      
      if (this.beforeAfterToggle == "after") {
        fetch("/data/monarch-east-after-double.geojson")
          .then((response) => response.json())
          .then((data) => {
            L.geoJSON(data, {
              pointToLayer: function (feature, latlng) {
                // Use a custom icon if desired
                return L.marker(latlng, { icon: butterflyIcon });
              },
            }).addTo(this.map);
          });
        // Load the GeoJSON
        fetch("/data/monarch-west-after.geojson")
          .then((response) => response.json())
          .then((data) => {
            L.geoJSON(data, {
              pointToLayer: function (feature, latlng) {
                // Use a custom icon if desired
                return L.marker(latlng, { icon: butterflyIcon });
              },
            }).addTo(this.map);
          });
      } else {
        fetch("/data/monarch-east-before-double.geojson")
          .then((response) => response.json())
          .then((data) => {
            L.geoJSON(data, {
              pointToLayer: function (feature, latlng) {
                // Use a custom icon if desired
                return L.marker(latlng, { icon: butterflyIcon });
              },
            }).addTo(this.map);
          });
        // Load the GeoJSON
        fetch("/data/monarch-west-before.geojson")
          .then((response) => response.json())
          .then((data) => {
            L.geoJSON(data, {
              pointToLayer: function (feature, latlng) {
                // Use a custom icon if desired
                return L.marker(latlng, { icon: butterflyIcon });
              },
            }).addTo(this.map);
          });
      }
    },
    drawMuleDeer() {
      // Load range GeoJSON from an external file
      fetch("/data/mule-deer-migration.geojson")
        .then((response) => response.json())
        .then((data) => {

          // filter the data object to only include records where the id includes "255_"
          // this is because the data file includes both the migration route and the winter range
          // and we only want to plot the migration route
          var filteredData = data.features.filter(function (item) {
            return item.properties.mig.includes("255_");
          });
          
          // Add GeoJSON layer to the map once the file is loaded
          L.geoJSON(data, {
            style: function (feature) {
              return {
                color: "#a8a8a8", // Example color
                weight: 1,
                opacity: 0.4,
              };
            },
          }).addTo(this.map);

          // Add GeoJSON layer to the map once the file is loaded
          L.geoJSON(filteredData, {
            style: function (feature) {
              return {
                color: "#BBA38E", // Example color
                weight: 2,
                opacity: 1,
              };
            },
          }).addTo(this.map);

          // Create a popup
        var popup = L.popup()
            .setLatLng([44.5123, -111.2998]) // Approximate coordinates for Last Chance, Idaho
            .setContent("<p style='font-size: 14px'>This doe, known as 255, has made the longest recorded Mule Deer migration. Each year, she <b>negotiated an average of 171 fences</b>, along with roads, rivers, and mountains, as she journeyed between her summer range in the meadows of Greater Yellowstone and her winter home in the sagebrush steppe of the Red Desert of Wyoming.</p>")
            .openOn(this.map);

        });
    },
    drawRegalFrit() {
      // NOTE: add "states of historical occurrence" to legend instead of Max known range

      // for this one i need to load the current and historic in sep files
      // because there is no way to delineate diff sources for each

      // Load range GeoJSON from an external file
      // NOTE: the cornell-saggro-layer file has both historic and current range
      // but we use a more up to date current range on top of it instead of changing the color of this one dynamically
      fetch("/data/regal-frit-historic.geojson")
        .then((response) => response.json())
        .then((data) => {
          
          // Add GeoJSON layer for historic range
          L.geoJSON(data, {
            style: function (feature) {
              return {
                color: "#7f9694", // Example color
                weight: 0,
              };
            },
          }).addTo(this.map);
        });

      // Load range GeoJSON for the current range
      fetch("/data/regal-frit-reduced-current.geojson")
        .then((response) => response.json())
        .then((data) => {
          
          // Add GeoJSON layer to the map once the file is loaded
          L.geoJSON(data, {
            style: function (feature) {
              return {
                color: "#BBA38E", // Example color
                weight: 2,
                fillOpacity: 0.7,
              };
            },
          }).addTo(this.map);
        });
    },
    drawSagGro() {
      // for this one i need to load the current and historic in sep files
      // because there is no way to delineate diff sources for each

      // Load range GeoJSON from an external file
      // NOTE: the cornell-saggro-layer file has both historic and current range
      // but we use a more up to date current range on top of it instead of changing the color of this one dynamically
      fetch("/data/cornell-saggro-layer.geojson")
        .then((response) => response.json())
        .then((data) => {
          
          // Add GeoJSON layer for historic range
          L.geoJSON(data, {
            style: function (feature) {
              return {
                color: "#7f9694", // Example color
                weight: 2,
              };
            },
          }).addTo(this.map);
        });

      // Load range GeoJSON for the current range
      fetch("/data/saggro-current.geojson")
        .then((response) => response.json())
        .then((data) => {
          
          // Add GeoJSON layer to the map once the file is loaded
          L.geoJSON(data, {
            style: function (feature) {
              return {
                color: "#BBA38E", // Example color
                weight: 2,
                fillOpacity: 0.7,
              };
            },
          }).addTo(this.map);
        });
    },
    drawGPC() {
      // for this one i need to load the current and historic in sep files
      // because there is no way to delineate diff sources for each

      // Load range GeoJSON for the current range
      fetch("/data/gpc-current.geojson")
        .then((response) => response.json())
        .then((data) => {
          
          // Add GeoJSON layer to the map once the file is loaded
          L.geoJSON(data, {
            style: function (feature) {
              return {
                color: "#BBA38E", // Example color
                weight: 2,
                fillOpacity: 0.7,
              };
            },
          }).addTo(this.map);
        });

        // Load range GeoJSON from an external file
      fetch("/data/gpc-historic-only-tympanuchus-cupido.geojson")
        .then((response) => response.json())
        .then((data) => {
          
          // Add GeoJSON layer for historic range
          L.geoJSON(data, {
            style: function (feature) {
              return {
                color: "#7f9694", // Example color
                weight: 2,
              };
            },
          }).addTo(this.map);
        });
    },
    drawTrout() {
      // Load range GeoJSON from an external file
      fetch("/data/trout-combined.geojson")
        .then((response) => response.json())
        .then((data) => {
          // Add GeoJSON layer to the map once the file is loaded
          L.geoJSON(data, {
            style: function (feature) {
              if (feature.properties.status == "Historical range") {
                return {
                  color: "#7f9694", // Example color
                  weight: 2,
                };
              } else {
                return {
                  color: "#BBA38E", // Example color
                  weight: 2,
                  fillOpacity: 0.7,
                };
              }
            },
          }).addTo(this.map);
        });
    },
    drawElk() {
      // Load range GeoJSON from an external file
      fetch("/data/elk-historic-current.geojson")
        .then((response) => response.json())
        .then((data) => {
          // Add GeoJSON layer to the map once the file is loaded
          L.geoJSON(data, {
            style: function (feature) {
              if (feature.properties.Time == null) {
                return {
                  color: "#7f9694", // Example color
                  weight: 2,
                };
              } else {
                return {
                  color: "#BBA38E", // Example color
                  weight: 2,
                  fillOpacity: 0.7,
                };
              }
            },
          }).addTo(this.map);
        });
    },
    drawPronghorn() {
      // Load range GeoJSON from an external file
      fetch("/data/final-prong.geojson")
        .then((response) => response.json())
        .then((data) => {
          
          // Add GeoJSON layer to the map once the file is loaded
          L.geoJSON(data, {
            style: function (feature) {
              if (feature.properties.Time == "Original") {
                return {
                  color: "#7f9694", // Example color
                  weight: 2,
                  // dashArray: '5, 5'
                };
              } else {
                return {
                  color: "#BBA38E", // Example color
                  weight: 2,
                  fillOpacity: 0.7,
                };
              }
            },
          }).addTo(this.map);
        });
    },
    clearLoadingMsg() {
      // turn the display of #loading-msg to none
      document.getElementById("loading-msg").style.display = "none";
    },
    handleCenterChange() {
      this.localCenter = this.map.getCenter();
      this.$emit("map-center-change", this.localCenter, this.localZoomLevel);
    },
    handleZoomChange() {
      this.localZoomLevel = this.map.getZoom();
      this.$emit("map-center-change", this.localCenter, this.localZoomLevel);
    },
    addBirdLayer(species) {
      console.log("GET SPECIES");
      // Define a custom style function for the polygon

      // turn the display of #loading-msg to block
      document.getElementById("loading-msg").style.display = "block";

      function customPolygonStyle(feature) {
        var abd_trend = feature.properties.abd_trend;
        var fillColor;

        if (abd_trend <= -20) {
          fillColor = "#C1197A";
        } else if (abd_trend > -20 && abd_trend <= 0) {
          fillColor = "#DF85B8";
        } else if (abd_trend > 0 && abd_trend <= 20) {
          fillColor = "#7CA96E";
        } else if (abd_trend > 20) {
          fillColor = "#40812C";
        }

        return {
          fillColor: fillColor,
          strokeColor: fillColor,
          weight: 1,
          opacity: 1,
          color: fillColor,
          fillOpacity: 0.8,
        };
      }

      let map = this.map;
      let currentSpecies = this.speciesDictionary[species];

      // Fetch the GeoJSON file
      function getData() {
        console.log("GET DATA");
        // create fp variable and store filepath for burowl3.geojson in the public folder under data
        let fp = `/data/${currentSpecies}.geojson`;

        fetch(fp)
          .then(function (response) {
            console.log("DATA GOT");
            return response.json();
          })
          .then(function (data) {
            console.log("DATA READY");
            data.features.forEach(function (state) {
              state.active = true;

              // Create a GeoJSON layer with the custom polygon style
              let speciesLayer = L.geoJSON(state, {
                // renderer: L.canvas(),
                style: customPolygonStyle,
                // add a popup for this polygon
                onEachFeature: function (feature, layer) {
                  layer.on("click", function (event) {
                    
                    var popupContent = feature.properties.abd_trend; // Replace with the appropriate property for your popup content
                    
                    layer.bindPopup(popupContent).openPopup();
                  });
                },
              }).addTo(map);
            });
            console.log("data plotted");

            // turn the display of #loading-msg to none
            document.getElementById("loading-msg").style.display = "none";
          });
      }

      getData("Burrowing Owl");
    },
  },
  mounted() {
    this.drawMap();
  },

  unmounted() {
    this.map.remove();
  },
};
</script>
  
  <style>
/* Add any additional styles for your Leaflet map container here */
.leaflet-map {
  height: 650px;
}

.hide-content {
  display: none;
}

#legend-container {
  display: block;
  max-width: 250px;
  position: absolute;
  top: 5%;
  right: 5%;
  background-color: rgba(255, 255, 255, 0.8);
  color: rgb(33, 33, 33);
  padding: 10px;
  border-radius: 5px;
  font-size: 12px;
  z-index: 9999;
  border-radius: 5px;
  box-shadow: 0 0 5px rgba(0, 0, 0, 0.3);
}

.legend-title {
  font-weight: 500;
}

.legend-subtitle {
  font-style: italic;
  margin-top: -5px;
}

.source {
  color: rgb(85, 85, 85);
}

#zoom-msg {
  position: absolute;
  top: 5%;
  left: 5%;
  /* transform: translate(-50%, -50%); */
  background-color: rgba(0, 0, 0, 0.6);
  color: white;
  padding: 10px;
  border-radius: 5px;
  font-size: 12px;
  z-index: 9999;
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

/* create a class for spans that are perfect circles to be displayed inline with text */
.circle-legend-before {
  display: inline-block;
  border-radius: 50%;
  width: 10px;
  height: 10px;
  margin-right: 5px;
  background-color: #7f9694;
}

.circle-legend-after {
  display: inline-block;
  border-radius: 50%;
  width: 10px;
  height: 10px;
  margin-right: 5px;
  background-color: #bba38e;
}

.ebird-note {
  font-style: italic;
}

#toggle-legend {
  display: block;
  text-decoration: underline;
  text-align: right;
  cursor: pointer;
}

@media (max-width: 800px) {
  #zoom-msg {
    display: none;
  }

  #toggle-legend {
    display: block;
    text-align: right;
    text-decoration: underline;
  }

  #legend-container {
    display: block;
    position: absolute;
    top: 5%;
    right: 5%;
    background-color: rgba(255, 255, 255, 0.8);
    color: rgb(33, 33, 33);
    padding: 5px;
    border-radius: 5px;
    font-size: 12px;
    z-index: 9999;
    border-radius: 5px;
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.3);
  }
}
</style>
  