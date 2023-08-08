<template>
    <span>To zoom, hold Cmd or Ctrl while scrolling.</span>
    <div id="mapContainer" class="leaflet-map" @mouseover="showMessage = true" @mouseleave="showMessage = false">
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
  },
  setup(props) {
    const mapRef = ref(null);
    let map;

    const showMessage = true;

    onMounted(() => {
      map = L.map('mapContainer',{scrollWheelZoom: false}).setView(props.center, props.zoom);

      let CartoDB_Positron = L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>',
            subdomains: 'abcd',
            maxZoom: 20
        }).addTo(map);
        console.log(showMessage)
      let tileLayer = L.tileLayer(`https://storage.googleapis.com/rap-tiles-cover-v3/unmasked/${props.layerName}/${props.layerYear}/{z}/{x}/{y}.png`, {
                maxZoom: 18,
                opacity: 0.7
            }).addTo(map);

    // Add custom event listener to handle scroll zoom when Cmd/Ctrl key is held down
    document.getElementById('mapContainer').addEventListener('mousewheel', (e) => {
        console.log(e)
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
    });

    watch(
      () => props.center,
      () => {
        if (map) {
          map.setView(props.center, props.zoom);
        }
      }
    );

    onUnmounted(() => {
      if (map) {
        map.remove();
      }
    });

    return {
      mapRef,
      showMessage
    };
  },
};
  </script>
  
  <style>
  /* Add any additional styles for your Leaflet map container here */
  .leaflet-map {
    height: 500px;
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
  