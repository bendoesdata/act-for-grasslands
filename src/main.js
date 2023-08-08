import './style.css'
import { createPinia } from 'pinia';
// Vuetify
import 'vuetify/styles'
import { createVuetify} from 'vuetify'
import * as components from 'vuetify/components'
import * as directives from 'vuetify/directives'

const vuetify = createVuetify({
  components,
  directives
})

import { createApp } from 'vue'

import App from './App.vue'
import router from './router'

const app = createApp(App)

const pinia = createPinia();
app.use(pinia);

app.use(router)

app.use(vuetify)

app.mount('#app')
