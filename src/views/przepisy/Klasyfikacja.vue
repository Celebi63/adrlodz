<template>
  <div>
    <section class="bg-gradient-to-r from-primary to-orange-600 text-white py-8 px-8">
      <div class="mx-auto max-w-[1440px]">
        <h1 class="text-3xl md:text-4xl font-bold">Klasyfikacja</h1>
      </div>
    </section>

    <section class="py-16 px-8 bg-white">
      <div class="mx-auto max-w-[1440px]">
        <div class="prose max-w-none">
          <p class="text-lg text-gray-700 mb-6">
            Towary niebezpieczne są podzielone na 9 klas według rodzaju zagrożenia, które stwarzają.
          </p>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="bg-gray-50 p-4 rounded-lg">
              <h3 class="font-bold text-primary mb-2">Klasa 1</h3>
              <p class="text-gray-700">Materiały i przedmioty wybuchowe</p>
            </div>
            <div class="bg-gray-50 p-4 rounded-lg">
              <h3 class="font-bold text-primary mb-2">Klasa 2</h3>
              <p class="text-gray-700">Gazy</p>
            </div>
            <div class="bg-gray-50 p-4 rounded-lg">
              <h3 class="font-bold text-primary mb-2">Klasa 3</h3>
              <p class="text-gray-700">Ciecze łatwopalne</p>
            </div>
            <div class="bg-gray-50 p-4 rounded-lg">
              <h3 class="font-bold text-primary mb-2">Klasa 4.1</h3>
              <p class="text-gray-700">Ciała stałe łatwopalne</p>
            </div>
            <div class="bg-gray-50 p-4 rounded-lg">
              <h3 class="font-bold text-primary mb-2">Klasa 4.2</h3>
              <p class="text-gray-700">Materiały samozapalne</p>
            </div>
            <div class="bg-gray-50 p-4 rounded-lg">
              <h3 class="font-bold text-primary mb-2">Klasa 4.3</h3>
              <p class="text-gray-700">Materiały wydzielające gazy palne</p>
            </div>
            <div class="bg-gray-50 p-4 rounded-lg">
              <h3 class="font-bold text-primary mb-2">Klasa 5.1</h3>
              <p class="text-gray-700">Materiały utleniające</p>
            </div>
            <div class="bg-gray-50 p-4 rounded-lg">
              <h3 class="font-bold text-primary mb-2">Klasa 5.2</h3>
              <p class="text-gray-700">Nadtlenki organiczne</p>
            </div>
            <div class="bg-gray-50 p-4 rounded-lg">
              <h3 class="font-bold text-primary mb-2">Klasa 6.1</h3>
              <p class="text-gray-700">Materiały trujące</p>
            </div>
            <div class="bg-gray-50 p-4 rounded-lg">
              <h3 class="font-bold text-primary mb-2">Klasa 6.2</h3>
              <p class="text-gray-700">Materiały zakaźne</p>
            </div>
            <div class="bg-gray-50 p-4 rounded-lg">
              <h3 class="font-bold text-primary mb-2">Klasa 7</h3>
              <p class="text-gray-700">Materiały radioaktywne</p>
            </div>
            <div class="bg-gray-50 p-4 rounded-lg">
              <h3 class="font-bold text-primary mb-2">Klasa 8</h3>
              <p class="text-gray-700">Materiały żrące</p>
            </div>
            <div class="bg-gray-50 p-4 rounded-lg">
              <h3 class="font-bold text-primary mb-2">Klasa 9</h3>
              <p class="text-gray-700">Różne materiały i przedmioty niebezpieczne</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <Contact />
  </div>
</template>

<script setup>
import Contact from '../../components/Contact.vue'
</script>

