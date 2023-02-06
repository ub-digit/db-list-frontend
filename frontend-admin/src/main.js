import { createApp } from "vue";
import { createPinia } from "pinia";
import App from "./App.vue";
import router from "./router";
import axios from 'axios';
import { plugin, defaultConfig } from '@formkit/vue';
import {useFontawesome} from '@/plugins/fontawesome.js';
import Toast from 'vue-toastification';
import "@/scss/custom.scss";
import 'nprogress/nprogress.css';
import { i18n } from "./locales";
import auth from '@/plugins/auth.js'
import http from '@/plugins/http.js'

const local_url = '/cgi-bin/backend.cgi'
const {FontAwesomeIcon} = useFontawesome();

axios.get(local_url).then((result) => {
  return result.data
},() => {
  return {
    backend_url: /* process.env["VUE_APP_API_BASE_URL"] ||*/ "https://databaser-admin-server-staging.ub.gu.se/",
  }
}).then((data) => {
  let app = createApp(App)
  app.baseURL = data.backend_url
  app
  .provide('baseURL', data.backend_url)
  //.provide('alertURL', data.alert_url)
  .component("font-awesome-icon", FontAwesomeIcon)
  .use(router)
  .use(createPinia())
  .use(i18n)
  .use(http)
  .use(auth)
  .use(plugin, defaultConfig)
  .use(Toast, { timeout: 3000, position: 'top-center', transition: 'Vue-Toastification__fade', hideProgressBar: true })

  .mount("#app");
})

