<template>
  <footer class="bg-text-main text-white py-6 px-8">
    <div class="mx-auto max-w-[1440px]">
      <div class="text-center">
        <p class="text-sm">
          © {{ currentYear }} ADR Łódź. Wszelkie prawa zastrzeżone.
        </p>
      </div>
    </div>
  </footer>
</template>

<script setup>
import { computed } from 'vue'

const currentYear = computed(() => new Date().getFullYear())
</script>

<style scoped>
/* Additional custom styles if needed */
</style>

