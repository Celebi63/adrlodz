<template>
  <div>
    <!-- Header -->
    <section class="bg-gradient-to-r from-primary to-orange-600 text-white py-8 px-8">
      <div class="mx-auto max-w-[1440px]">
        <h1 class="text-3xl md:text-4xl font-bold">Wstęp</h1>
      </div>
    </section>

    <!-- Content -->
    <section class="py-16 px-8 bg-white">
      <div class="mx-auto max-w-[1440px]">
        <div class="prose max-w-none">
          <p class="text-lg text-gray-700 mb-6">
            Umowa europejska dotycząca międzynarodowego przewozu drogowego towarów niebezpiecznych (ADR) 
            została sporządzona w Genewie dnia 30 września 1957 roku pod auspicjami Europejskiej Komisji 
            Gospodarczej ONZ.
          </p>
          <p class="text-gray-700 mb-4">
            ADR to system przepisów regulujących międzynarodowy przewóz drogowy materiałów niebezpiecznych. 
            Umowa została przyjęta w celu zapewnienia bezpieczeństwa podczas transportu substancji stwarzających 
            zagrożenie dla ludzi, mienia i środowiska.
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

