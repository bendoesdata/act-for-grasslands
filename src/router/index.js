// main.js or main.ts
import { createApp } from 'vue';
import App from './App.vue';
import { createRouter, createWebHistory } from 'vue-router';

const router = createRouter({
  history: createWebHistory(),
  routes: [
    // Define your routes here
  ],
});

createApp(App).use(router).mount('#app');
