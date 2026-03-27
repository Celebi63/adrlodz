<template>
  <div>
    <!-- Edit Mode Panel -->
    <EditModePanel />
    
    <!-- Main Content with margin when edit mode is active -->
    <div :class="{ 'ml-80': isEditMode }">
      <Navbar />
      <router-view />
      <Footer />
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import Navbar from './components/Navbar.vue'
import Footer from './components/Footer.vue'
import EditModePanel from './components/EditModePanel.vue'
import { useEditMode } from './composables/useEditMode'

const { isEditMode } = useEditMode()
</script>

<style>
/* Global styles are handled by Tailwind */
</style>
