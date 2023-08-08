<template>
    <div id="mapContainer" class="leaflet-map"></div>
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

    onMounted(() => {
      map = L.map('mapContainer').setView(props.center, props.zoom);

      let CartoDB_Positron = L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>',
            subdomains: 'abcd',
            maxZoom: 20
        }).addTo(map);
        console.log(props.layerYear)
      let tileLayer = L.tileLayer(`https://storage.googleapis.com/rap-tiles-cover-v3/unmasked/${props.layerName}/${props.layerYear}/{z}/{x}/{y}.png`, {
                maxZoom: 18,
                opacity: 0.7
            }).addTo(map);
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
    };
  },
};
  </script>
  
  <style>
  /* Add any additional styles for your Leaflet map container here */
  .leaflet-map {
    height: 500px;
  }
  </style>
  