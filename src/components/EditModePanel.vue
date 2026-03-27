<template>
  <!-- Edit Mode Toggle Button (only visible when authenticated) -->
  <div 
    v-if="isAuthenticated && showEditButton"
    class="fixed top-4 left-4 z-[100]"
  >
    <button
      @click="toggleEditMode"
      :class="[
        'px-4 py-2 rounded-lg font-semibold shadow-lg transition-all flex items-center gap-2',
        isEditMode 
          ? 'bg-red-500 text-white hover:bg-red-600' 
          : 'bg-primary text-white hover:opacity-90'
      ]"
    >
      <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path v-if="!isEditMode" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
        <path v-else stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
      </svg>
      {{ isEditMode ? 'Wyłącz edycję' : 'Włącz edycję' }}
    </button>
  </div>

  <!-- Edit Mode Panel -->
  <Transition name="slide">
    <div
      v-if="isEditMode"
      class="fixed left-0 top-0 h-screen w-80 bg-white shadow-2xl z-[99] overflow-y-auto border-r-2 border-primary"
    >
      <!-- Panel Header -->
      <div class="bg-gradient-to-r from-primary to-orange-600 text-white p-4 sticky top-0 z-10">
        <div class="flex items-center justify-between mb-2">
          <h2 class="text-xl font-bold">Tryb Edycji</h2>
          <button 
            @click="disableEditMode"
            class="hover:bg-white/20 p-1 rounded transition-colors"
          >
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>
        <p class="text-sm opacity-90">
          {{ currentUser?.email }}
        </p>
      </div>

      <!-- Panel Content -->
      <div class="p-4 space-y-4">
        <!-- Info Box -->
        <div class="bg-blue-50 border border-blue-200 rounded-lg p-4">
          <div class="flex items-start gap-2">
            <svg class="w-5 h-5 text-blue-600 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            <div class="text-sm text-blue-800">
              <p class="font-semibold mb-1">Jak używać:</p>
              <ul class="space-y-1 text-xs">
                <li>• Kliknij na tekst, aby go edytować</li>
                <li>• Edytowalne elementy są podświetlone</li>
                <li>• Zmiany zapisują się automatycznie</li>
              </ul>
            </div>
          </div>
        </div>

        <!-- Current Page Info -->
        <div class="bg-gray-50 rounded-lg p-4">
          <h3 class="font-semibold text-gray-700 mb-2">Bieżąca strona:</h3>
          <p class="text-sm text-gray-600">{{ currentPageTitle }}</p>
        </div>

        <!-- Quick Actions -->
        <div class="space-y-2">
          <h3 class="font-semibold text-gray-700">Szybkie akcje:</h3>
          
          <router-link
            to="/admin/dashboard"
            class="block w-full bg-gray-100 hover:bg-gray-200 text-gray-800 px-4 py-2 rounded-lg transition-colors text-sm font-medium"
          >
            📊 Panel administracyjny
          </router-link>

          <router-link
            to="/"
            class="block w-full bg-gray-100 hover:bg-gray-200 text-gray-800 px-4 py-2 rounded-lg transition-colors text-sm font-medium"
          >
            🏠 Strona główna
          </router-link>
        </div>

        <!-- Saving Indicator -->
        <div v-if="isSaving" class="bg-yellow-50 border border-yellow-200 rounded-lg p-3">
          <div class="flex items-center gap-2 text-yellow-800">
            <svg class="animate-spin w-4 h-4" fill="none" viewBox="0 0 24 24">
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
              <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
            </svg>
            <span class="text-sm font-medium">Zapisywanie...</span>
          </div>
        </div>

        <!-- Currently Editing -->
        <div v-if="editingElement" class="bg-green-50 border border-green-200 rounded-lg p-3">
          <p class="text-sm font-semibold text-green-800 mb-1">Edytujesz:</p>
          <p class="text-xs text-green-700">{{ editingElement.label }}</p>
        </div>
      </div>

      <!-- Panel Footer -->
      <div class="border-t border-gray-200 p-4 space-y-2 bg-gray-50">
        <button
          @click="handleLogout"
          class="w-full bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded-lg transition-colors text-sm font-semibold"
        >
          Wyloguj się
        </button>
      </div>
    </div>
  </Transition>

  <!-- Overlay to show editable areas -->
  <div
    v-if="isEditMode"
    class="fixed inset-0 pointer-events-none z-[98]"
    style="margin-left: 20rem;"
  >
    <!-- This creates visual feedback for edit mode -->
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useEditMode } from '../composables/useEditMode'

const route = useRoute()
const router = useRouter()

const {
  isEditMode,
  isAuthenticated,
  currentUser,
  isSaving,
  editingElement,
  toggleEditMode,
  disableEditMode,
  logout,
} = useEditMode()

const showEditButton = computed(() => isAuthenticated.value)

const currentPageTitle = computed(() => {
  const path = route.path
  if (path === '/') return 'Strona główna'
  if (path.includes('/o-nas')) return 'O nas'
  if (path.includes('/przepisy')) return 'Przepisy ADR'
  if (path.includes('/kursy')) return 'Kursy ADR'
  return 'Strona'
})

const handleLogout = async () => {
  try {
    await logout()
    router.push('/')
  } catch (error) {
    console.error('Logout error:', error)
    window.location.href = '/#/'
  }
}
</script>

<style scoped>
.slide-enter-active,
.slide-leave-active {
  transition: transform 0.3s ease;
}

.slide-enter-from,
.slide-leave-to {
  transform: translateX(-100%);
}
</style>
