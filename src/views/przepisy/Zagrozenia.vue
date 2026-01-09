<template>
  <div>
    <section class="bg-gradient-to-r from-primary to-orange-600 text-white py-8 px-8">
      <div class="mx-auto max-w-[1440px]">
        <h1 class="text-3xl md:text-4xl font-bold">Zagrożenia</h1>
      </div>
    </section>

    <section class="py-16 px-8 bg-white">
      <div class="mx-auto max-w-[1440px]">
        <div class="prose max-w-none">
          <p class="text-lg text-gray-700 mb-6">
            Towary niebezpieczne stwarzają różnorodne zagrożenia podczas przewozu, przechowywania i przeładunku.
          </p>
          <p class="text-gray-700">
            Znajomość rodzajów zagrożeń jest kluczowa dla bezpiecznego transportu.
          </p>
        </div>
      </div>
    </section>

    <Contact />
  </div>
</template>

<script setup>
import Contact from '../../components/Contact.vue'
</script>

