<template>
  <div>
    <section class="bg-gradient-to-r from-primary to-orange-600 text-white py-8 px-8">
      <div class="mx-auto max-w-[1440px]">
        <h1 class="text-3xl md:text-4xl font-bold">Klasa 1</h1>
      </div>
    </section>

    <section class="py-16 px-8 bg-white">
      <div class="mx-auto max-w-[1440px]">
        <div class="prose max-w-none">
          <p class="text-lg text-gray-700 mb-6">
            Klasa 1 obejmuje materiały i przedmioty wybuchowe - substancje i artykuły, które mogą eksplodować 
            pod wpływem określonych czynników.
          </p>
          <p class="text-gray-700 mb-4">
            Przewóz materiałów klasy 1 wymaga dodatkowych uprawnień i przestrzegania szczególnych przepisów 
            bezpieczeństwa.
          </p>
          <p class="text-gray-700">
            Klasa 1 jest podzielona na 6 podklas w zależności od rodzaju zagrożenia wybuchowego.
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

