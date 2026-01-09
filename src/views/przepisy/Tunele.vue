<template>
  <div>
    <section class="bg-gradient-to-r from-primary to-orange-600 text-white py-8 px-8">
      <div class="mx-auto max-w-[1440px]">
        <h1 class="text-3xl md:text-4xl font-bold">Tunele</h1>
      </div>
    </section>

    <section class="py-16 px-8 bg-white">
      <div class="mx-auto max-w-[1440px]">
        <div class="prose max-w-none">
          <p class="text-lg text-gray-700 mb-6">
            Przepisy dotyczące przejazdu przez tunele z towarami niebezpiecznymi są szczególnie restrykcyjne 
            ze względu na ograniczone możliwości ewakuacji.
          </p>
          <p class="text-gray-700">
            Tunele są klasyfikowane według kategorii ograniczeń przejazdu.
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

