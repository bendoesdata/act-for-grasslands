<template>
    <div>
      <div :id="mapId" style="width: 600px; height: 500px; background-color: #252525;"></div>
    </div>
  </template>
  
  <script>
  export default {
    props: {
      mapId: {
        type: String,
        required: true
      },
      mapYear: {
        type: String,
        required: true
      },
      center: {
        type: Object,
        required: true
      },
      updateSource: {
        type: String,
        required: false
      }
    },
    data() {
      return {
        map: null,
        mapInitialized: false,
      };
    },
    watch: {
    center(newCenter) {
        console.log('received from', this.updateSource)
      // Ensure that the map is initialized
      if (this.map && this.mapInitialized) {
            if (!this.isUserInteraction) {
            // Center change was programmatic, do not trigger handleCenterChange
            return;
            }
            // Update the map's center with the new value from the prop
            this.map.setView(newCenter);
      }
    },
  },
  computed: {
    isUserInteraction() {
      return this.map ? this.map._panInProcess > 0 : false;
    },
  },
    mounted() {
        console.log(this.center)
      // Initialize the Leaflet map
      this.map = L.map(this.mapId, {
        scrollWheelZoom: false,
        center: this.center, // Specify the initial center coordinates
        zoom: 7, // Specify the initial zoom level
        layers: [], // Empty base layers
      });
      
  
      // Add an empty tile layer with an empty URL (no background)
      L.tileLayer('', { attribution: '' }).addTo(this.map);
  
      // Add a custom layer using the provided URL
      L.tileLayer(`https://storage.googleapis.com/rap-tiles-cover-v3/masked/pfg/${this.mapYear}/{z}/{x}/{y}.png`, {
        minZoom: 0, // Minimum zoom level
        maxZoom: 18, // Maximum zoom level
      }).addTo(this.map);

      // Set the flag to indicate that the map is initialized
    this.mapInitialized = true;

      this.map.on("moveend", this.handleCenterChange);
    },
    methods: {
        handleCenterChange() {
            console.log('moved by ', this.updateSource)
            let msg = {}
            msg.center = this.map.getCenter();
            msg.id = this.mapId;
            
            // avoid recursion
            // if (this.updateSource == this.mapId) {
            //     return;
            // }
            console.log(this.isUserInteraction)
            if (this.isUserInteraction) {
                this.$emit("map-center-change", msg);
            }
            
            
        }
    }
  };
  </script>
  
  <style scoped>
  /* Add any custom CSS styles here if needed */
  /* Hide Leaflet zoom in and out buttons */
.leaflet-control-zoom-in {
    display: none !important;
}
  </style>
  