<template>
    <div @mousedown="handleMouseDown" 
    @mousemove="handleMouseMove" 
    @mouseup="handleMouseUp"
    @touchstart="handleMouseDown"
    @touchmove="handleMouseMove"
    @touchend="handleMouseUp" >
      <div :id="mapId" class="map-div" style="background-color: #252525;">
    <div class="map-year">{{ mapYear }}</div>
        
      </div>
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
      zoom: {
        type: Number,
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
        isDragging: false,
        mapInitialized: false,
      };
    },
    watch: {
    center(newCenter) {
        console.log('received from', this.updateSource, newCenter)
      // Ensure that the map is initialized
      if (this.map && this.mapInitialized) {
            // Update the map's center with the new value from the prop
            this.map.setView(newCenter);
      }
    },
    zoom(newZoom) {
        console.log(newZoom)
      // Ensure that the map is initialized
      if (this.map && this.mapInitialized) {
            // udpate the maps zoom level
            this.map.setZoom(newZoom);
      }
    }
  },
    mounted() {
      // add even listener to listen for changes to window width
      window.addEventListener('resize', this.resizeMap);

      // Initialize the Leaflet map
      this.map = L.map(this.mapId, {
        scrollWheelZoom: false,
        center: this.center, // Specify the initial center coordinates
        zoom: this.zoom, // Specify the initial zoom level
        layers: [], // Empty base layers
      });
      
  
      // Add an empty tile layer with an empty URL (no background)
      L.tileLayer('', { attribution: '' }).addTo(this.map);
  
      // Add a custom layer using the provided URL
      L.tileLayer(`https://storage.googleapis.com/rap-tiles-cover-v3/masked/pfg/${this.mapYear}/{z}/{x}/{y}.png`, {
        minZoom: 0, // Minimum zoom level
        maxZoom: 18, // Maximum zoom level
        padding: 0.8 // Padding around the map (in tiles) to retain when the map is zoomed in
      }).addTo(this.map);

      // check the width dimensions of the window, if they are greater than 800px then set the width of the map to 600px
      if (window.innerWidth > 800) {
        // get the div with map id and set style of width to 600px
        var mapDiv = document.getElementById(this.mapId);
        mapDiv.style.width = "600px";
      } else {
        // get the div with map id and set style of width to 600px
        var mapDiv = document.getElementById(this.mapId);
        mapDiv.style.width = "400px";
      }

      // Set the flag to indicate that the map is initialized
    this.mapInitialized = true;

    // create listener for when user clicks the zoom in or out button
    this.map.on('zoomend', this.handleCenterChange);

    setTimeout(()=>{
      this.map.invalidateSize();
    },200)

      // this.map.on("moveend", this.handleCenterChange);
    },
    methods: {
      resizeMap() {
        var mapDiv = document.getElementById(this.mapId);
        // check the width dimensions of the window, if they are greater than 800px then set the width of the map to 600px
      if (window.innerWidth > 1250) {
        mapDiv.style.width = "600px";
      } else if (window.innerWidth <= 1250 && window.innerWidth > 950) {
        mapDiv.style.width = "450px";
      } else  {
        mapDiv.style.width = "400px";
      }
      },
      handleMouseDown(event) {
      // User starts dragging (mouse button is pressed down)
      this.isDragging = true;
    },
    handleMouseMove(event) {
      // User is moving the mouse
      if (this.isDragging) {
        // Here, you can handle the dragging
        console.log("Dragging over the div");
      }
    },
    handleMouseUp(event) {
      // User releases the mouse button
      if (this.isDragging) {
        this.isDragging = false;
        console.log("Drag ended");
        this.handleCenterChange();
      }
    },
        handleCenterChange() {
            console.log('moved by ', this.updateSource)
            let msg = {}
            msg.center = this.map.getCenter();
            
            // get the zoom level and store it in msg
            msg.zoom = this.map.getZoom();

            msg.id = this.mapId;
            
            // avoid recursion
            // if (this.updateSource == this.mapId) {
            //     return;
            // }
            console.log(msg.center)
            
            this.$emit("map-center-change", msg);
            
            
            
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

.map-div {
  height: 400px; /* or any other height */
        width: 100%;
}

.map-year {
  display: none;
  position: absolute;
  top: 5%;
  right: 15%;
  /* transform: translate(-50%, -50%); */
  background-color: rgba(255, 255, 255, 0.9);
  color: black;
  padding: 10px;
  border-radius: 5px;
  font-size: 20px;
  font-family: 'Nunito Sans';
  z-index: 9999;
}

@media (max-width: 850px) {
  .map-year {
    display: block
  }
}
  </style>
  