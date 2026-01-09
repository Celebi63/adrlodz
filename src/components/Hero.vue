<template>
  <section class="relative w-full h-[600px] overflow-hidden">
    <!-- Background Image -->
    <div class="absolute inset-0">
      <img 
        src="../assets/truck.png" 
        alt="Ciężarówka ADR" 
        class="w-full h-full object-cover"
      />
      <!-- Overlay for better text readability -->
      <div class="absolute inset-0 bg-black/30"></div>
    </div>

    <!-- Content -->
    <div class="relative h-full mx-auto max-w-[1440px] px-8 flex items-center">
      <div class="text-white max-w-2xl">
        <h1 class="text-5xl md:text-6xl font-bold mb-6 leading-tight">
          Kursy ADR Łódź
        </h1>
        <div class="text-lg md:text-xl mb-6 space-y-2">
          <p>Najbliższy kurs podstawowy:</p>
          <p>Egzamin:</p>
          <p>Zgłoszenia do czwartku włącznie.</p>
        </div>
        <div>
          <button 
            @click="scrollToRegistration"
            class="bg-primary text-white px-8 py-4 text-lg font-semibold hover:opacity-90 transition-opacity uppercase rounded-lg"
          >
            Zapisz się na ten kurs
          </button>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
// Hero section with truck background image

const scrollToRegistration = () => {
  const registrationSection = document.getElementById('registration')
  if (registrationSection) {
    registrationSection.scrollIntoView({ 
      behavior: 'smooth',
      block: 'start'
    })
  }
}
</script>

<style scoped>
/* Additional custom styles if needed */
</style>

