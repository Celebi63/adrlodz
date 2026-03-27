<template>
  <!-- Nasz Ośrodek Section -->
  <section class="py-16 px-8 bg-white">
    <div class="mx-auto max-w-[1440px]">
      <!-- Header -->
      <div class="text-center mb-12">
        <h2 
          class="text-4xl font-bold text-text-main mb-4"
          v-editable="{ 
            label: 'Tytuł sekcji',
            save: (v) => saveSetting('about_title', v)
          }"
        >
          Nasz ośrodek
        </h2>
        <p 
          class="text-lg text-gray-600 max-w-3xl mx-auto"
          v-editable="{ 
            label: 'Podtytuł',
            save: (v) => saveSetting('about_subtitle', v)
          }"
        >
          Nowoczesne zaplecze szkoleniowe i profesjonalna kadra instruktorska
        </p>
      </div>

      <!-- Stats -->
      <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-16 max-w-4xl mx-auto">
        <div class="bg-primary/10 rounded-lg p-6 text-center">
          <p 
            class="text-4xl font-bold text-primary mb-2"
            v-editable="{ 
              label: 'Liczba absolwentów',
              save: (v) => saveSetting('stats_graduates', v)
            }"
          >
            500+
          </p>
          <p 
            class="text-gray-700"
            v-editable="{ label: 'Label absolwentów' }"
          >
            Absolwentów rocznie
          </p>
        </div>
        <div class="bg-primary/10 rounded-lg p-6 text-center">
          <p 
            class="text-4xl font-bold text-primary mb-2"
            v-editable="{ 
              label: 'Lata doświadczenia',
              save: (v) => saveSetting('stats_experience', v)
            }"
          >
            10+
          </p>
          <p 
            class="text-gray-700"
            v-editable="{ label: 'Label doświadczenia' }"
          >
            Lat doświadczenia
          </p>
        </div>
        <div class="bg-primary/10 rounded-lg p-6 text-center">
          <p 
            class="text-4xl font-bold text-primary mb-2"
            v-editable="{ 
              label: 'Procent zdawalności',
              save: (v) => saveSetting('stats_pass_rate', v)
            }"
          >
            98%
          </p>
          <p 
            class="text-gray-700"
            v-editable="{ label: 'Label zdawalności' }"
          >
            Zdawalność egzaminów
          </p>
        </div>
      </div>

      <!-- Carousel Placeholder -->
      <div class="mt-12">
        <h3 
          class="text-2xl font-bold text-text-main text-center mb-8"
          v-editable="{ label: 'Tytuł galerii' }"
        >
          Galeria naszego ośrodka
        </h3>
        
        <!-- TODO: Carousel will be implemented here -->
        <div class="bg-gray-100 rounded-lg p-12 text-center">
          <div class="max-w-2xl mx-auto">
            <svg class="w-24 h-24 mx-auto mb-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
            </svg>
            <p 
              class="text-gray-500 text-lg"
              v-editable="{ label: 'Tekst placeholder galerii' }"
            >
              Miejsce na karuzelę zdjęć ośrodka
            </p>
            <p 
              class="text-gray-400 text-sm mt-2"
              v-editable="{ label: 'Opis galerii' }"
            >
              Tutaj pojawią się zdjęcia sal szkoleniowych, budynku i kadry instruktorskiej
            </p>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { useEditMode } from '../composables/useEditMode'

// Nasz Ośrodek section component for home page
const { saveSetting } = useEditMode()
</script>
