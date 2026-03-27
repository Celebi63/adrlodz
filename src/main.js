import { createApp } from 'vue'
import './style.css'
import App from './App.vue'
import router from './router'
import { editableDirective } from './directives/editable'

const app = createApp(App)
app.use(router)
app.directive('editable', editableDirective)
app.mount('#app')
