import { createRouter, createWebHashHistory } from 'vue-router'
import Home from '../views/Home.vue'
import KursPodstawowy from '../views/KursPodstawowy.vue'
import KursCysterny from '../views/KursCysterny.vue'

// Przepisy imports
import PrzepisyWstep from '../views/przepisy/Wstep.vue'
import PrzepisyKlasyfikacja from '../views/przepisy/Klasyfikacja.vue'
import PrzepisyZwolnienia from '../views/przepisy/Zwolnienia.vue'
import PrzepisyOznakowanie from '../views/przepisy/Oznakowanie.vue'
import PrzepisyZagrozenia from '../views/przepisy/Zagrozenia.vue'
import PrzepisyTunele from '../views/przepisy/Tunele.vue'
import PrzepisyDokument from '../views/przepisy/DokumentPrzewozowy.vue'
import PrzepisyInstrukcja from '../views/przepisy/Instrukcja.vue'
import PrzepisyCysterny from '../views/przepisy/Cysterny.vue'
import PrzepisyHierarchizacja from '../views/przepisy/Hierarchizacja.vue'
import PrzepisyKlasa1 from '../views/przepisy/Klasa1.vue'
import PrzepisyKlasa7 from '../views/przepisy/Klasa7.vue'

// Quizy imports
import QuizPodstawowy from '../views/quizy/QuizPodstawowy.vue'
import QuizCysterny from '../views/quizy/QuizCysterny.vue'

// O nas import
import ONas from '../views/ONas.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/o-nas',
    name: 'ONas',
    component: ONas
  },
  {
    path: '/kursy/podstawowy',
    name: 'KursPodstawowy',
    component: KursPodstawowy
  },
  {
    path: '/kursy/cysterny',
    name: 'KursCysterny',
    component: KursCysterny
  },
  // Przepisy routes
  {
    path: '/przepisy/wstep',
    name: 'PrzepisyWstep',
    component: PrzepisyWstep
  },
  {
    path: '/przepisy/klasyfikacja',
    name: 'PrzepisyKlasyfikacja',
    component: PrzepisyKlasyfikacja
  },
  {
    path: '/przepisy/zwolnienia',
    name: 'PrzepisyZwolnienia',
    component: PrzepisyZwolnienia
  },
  {
    path: '/przepisy/oznakowanie',
    name: 'PrzepisyOznakowanie',
    component: PrzepisyOznakowanie
  },
  {
    path: '/przepisy/zagrozenia',
    name: 'PrzepisyZagrozenia',
    component: PrzepisyZagrozenia
  },
  {
    path: '/przepisy/tunele',
    name: 'PrzepisyTunele',
    component: PrzepisyTunele
  },
  {
    path: '/przepisy/dokument-przewozowy',
    name: 'PrzepisyDokument',
    component: PrzepisyDokument
  },
  {
    path: '/przepisy/instrukcja',
    name: 'PrzepisyInstrukcja',
    component: PrzepisyInstrukcja
  },
  {
    path: '/przepisy/cysterny',
    name: 'PrzepisyCysterny',
    component: PrzepisyCysterny
  },
  {
    path: '/przepisy/hierarchizacja',
    name: 'PrzepisyHierarchizacja',
    component: PrzepisyHierarchizacja
  },
  {
    path: '/przepisy/klasa-1',
    name: 'PrzepisyKlasa1',
    component: PrzepisyKlasa1
  },
  {
    path: '/przepisy/klasa-7',
    name: 'PrzepisyKlasa7',
    component: PrzepisyKlasa7
  },
  // Quizy routes
  {
    path: '/quizy/podstawowy',
    name: 'QuizPodstawowy',
    component: QuizPodstawowy
  },
  {
    path: '/quizy/cysterny',
    name: 'QuizCysterny',
    component: QuizCysterny
  }
]

const router = createRouter({
  history: createWebHashHistory(import.meta.env.BASE_URL),
  routes,
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else if (to.hash) {
      return {
        el: to.hash,
        behavior: 'smooth'
      }
    } else {
      return { top: 0 }
    }
  }
})

export default router

