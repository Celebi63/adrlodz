<template>
  <div class="min-h-screen bg-gray-100">
    <!-- Top Navigation -->
    <nav class="bg-white shadow-md">
      <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-16">
          <div class="flex items-center gap-4">
            <img src="../../assets/logo.png" alt="Logo" class="h-10" />
            <h1 class="text-xl font-bold text-text-main">Panel Administracyjny</h1>
          </div>
          <div class="flex items-center gap-4">
            <span class="text-sm text-gray-600">{{ userEmail }}</span>
            <button 
              @click="handleLogout"
              class="bg-red-500 text-white px-4 py-2 rounded-lg hover:bg-red-600 transition-colors text-sm font-semibold"
            >
              Wyloguj
            </button>
          </div>
        </div>
      </div>
    </nav>

    <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-8">
      <!-- Tab Navigation -->
      <div class="bg-white rounded-lg shadow-md mb-6">
        <div class="border-b border-gray-200">
          <nav class="flex -mb-px">
            <button
              v-for="tab in tabs"
              :key="tab.id"
              @click="activeTab = tab.id"
              :class="[
                'px-6 py-4 text-sm font-semibold border-b-2 transition-colors',
                activeTab === tab.id
                  ? 'border-primary text-primary'
                  : 'border-transparent text-gray-600 hover:text-gray-800 hover:border-gray-300'
              ]"
            >
              {{ tab.label }}
            </button>
          </nav>
        </div>
      </div>

      <!-- Tab Content -->
      <div class="bg-white rounded-lg shadow-md p-6">
        <!-- Courses Tab -->
        <div v-if="activeTab === 'courses'">
          <h2 class="text-2xl font-bold text-text-main mb-6">Zarządzanie Kursami</h2>
          <CoursesManager />
        </div>

        <!-- Settings Tab -->
        <div v-if="activeTab === 'settings'">
          <h2 class="text-2xl font-bold text-text-main mb-6">Ustawienia Strony</h2>
          <SettingsManager />
        </div>

        <!-- Registrations Tab -->
        <div v-if="activeTab === 'registrations'">
          <h2 class="text-2xl font-bold text-text-main mb-6">Zgłoszenia na Kursy</h2>
          <RegistrationsManager />
        </div>

        <!-- Hero Tab -->
        <div v-if="activeTab === 'hero'">
          <h2 class="text-2xl font-bold text-text-main mb-6">Edycja Strony Głównej</h2>
          <HeroManager />
        </div>

        <!-- Pages Tab -->
        <div v-if="activeTab === 'pages'">
          <h2 class="text-2xl font-bold text-text-main mb-6">Zarządzanie Stronami</h2>
          <PagesManager />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { supabase } from '../../lib/supabaseClient'
import CoursesManager from '../../components/admin/CoursesManager.vue'
import SettingsManager from '../../components/admin/SettingsManager.vue'
import RegistrationsManager from '../../components/admin/RegistrationsManager.vue'
import HeroManager from '../../components/admin/HeroManager.vue'
import PagesManager from '../../components/admin/PagesManager.vue'

const router = useRouter()
const activeTab = ref('courses')
const userEmail = ref('')

const tabs = [
  { id: 'courses', label: 'Kursy' },
  { id: 'hero', label: 'Strona Główna' },
  { id: 'pages', label: 'Strony' },
  { id: 'settings', label: 'Ustawienia' },
  { id: 'registrations', label: 'Zgłoszenia' },
]

onMounted(async () => {
  // Check if user is authenticated
  const { data: { user } } = await supabase.auth.getUser()
  
  if (!user) {
    router.push('/admin/login')
    return
  }
  
  userEmail.value = user.email
})

const handleLogout = async () => {
  await supabase.auth.signOut()
  router.push('/admin/login')
}
</script>
