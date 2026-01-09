<template>
  <div>
    <!-- Course Header -->
    <section class="bg-gradient-to-r from-primary to-orange-600 text-white py-8 px-8">
      <div class="mx-auto max-w-[1440px]">
        <h1 class="text-3xl md:text-4xl font-bold">
          Kurs ADR - Cysterny
        </h1>
      </div>
    </section>

    <!-- Course Details -->
    <section class="py-16 px-8 bg-white">
      <div class="mx-auto max-w-[1440px]">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12">
          <!-- Left Column - Info Cards -->
          <div class="space-y-6">
            <!-- Price -->
            <div class="bg-gray-50 rounded-lg p-6 border-l-4 border-primary">
              <h3 class="text-2xl font-bold text-text-main mb-2">Cena</h3>
              <p class="text-3xl font-bold text-primary">900 PLN</p>
              <p class="text-sm text-gray-600 mt-2">Cena zawiera materiały szkoleniowe i egzamin</p>
            </div>

            <!-- Duration -->
            <div class="bg-gray-50 rounded-lg p-6 border-l-4 border-primary">
              <h3 class="text-2xl font-bold text-text-main mb-2">Czas trwania</h3>
              <p class="text-xl text-gray-700">2 dni (16 godzin)</p>
              <p class="text-sm text-gray-600 mt-2">
                Szkolenie odbywa się w formie stacjonarnej<br>
                Poniedziałek - Wtorek, 8:00 - 16:00
              </p>
            </div>

            <!-- Next Date -->
            <div class="bg-gray-50 rounded-lg p-6 border-l-4 border-primary">
              <h3 class="text-2xl font-bold text-text-main mb-2">Najbliższy termin</h3>
              <p class="text-xl text-gray-700 font-semibold">1-2 Marca 2025</p>
              <p class="text-sm text-gray-600 mt-2">Egzamin: 3 Marca 2025</p>
              <p class="text-sm text-primary font-semibold mt-2">
                Zgłoszenia przyjmujemy do czwartku włącznie
              </p>
            </div>

            <!-- Requirements -->
            <div class="bg-gray-50 rounded-lg p-6 border-l-4 border-primary">
              <h3 class="text-2xl font-bold text-text-main mb-3">Wymagania</h3>
              <ul class="space-y-2">
                <li class="flex items-start">
                  <span class="text-primary mr-2 font-bold">✓</span>
                  <span class="text-gray-700">Ważne świadectwo ADR podstawowe</span>
                </li>
                <li class="flex items-start">
                  <span class="text-primary mr-2 font-bold">✓</span>
                  <span class="text-gray-700">Prawo jazdy odpowiedniej kategorii</span>
                </li>
                <li class="flex items-start">
                  <span class="text-primary mr-2 font-bold">✓</span>
                  <span class="text-gray-700">Ukończone 21 lat</span>
                </li>
                <li class="flex items-start">
                  <span class="text-primary mr-2 font-bold">✓</span>
                  <span class="text-gray-700">Ważne badania lekarskie</span>
                </li>
                <li class="flex items-start">
                  <span class="text-primary mr-2 font-bold">✓</span>
                  <span class="text-gray-700">Zdjęcie 35x45mm</span>
                </li>
                <li class="flex items-start">
                  <span class="text-primary mr-2 font-bold">✓</span>
                  <span class="text-gray-700">Kopia świadectwa ADR podstawowego</span>
                </li>
              </ul>
            </div>
          </div>

          <!-- Right Column - Course Description -->
          <div>
            <div class="bg-white rounded-lg p-8 border border-gray-200 shadow-lg sticky top-24">
              <h3 class="text-2xl font-bold text-text-main mb-4">O kursie</h3>
              <div class="space-y-4 text-gray-700">
                <p>
                  Kurs specjalistyczny ADR - Cysterny to dodatkowe uprawnienie dla kierowców 
                  posiadających certyfikat ADR podstawowy. Umożliwia przewóz towarów niebezpiecznych 
                  w cysternach o pojemności powyżej 1000 litrów.
                </p>
                
                <h4 class="font-bold text-lg text-text-main mt-6 mb-2">Program szkolenia:</h4>
                <ul class="space-y-2">
                  <li class="flex items-start">
                    <span class="text-primary mr-2">•</span>
                    <span>Przepisy dotyczące przewozu w cysternach</span>
                  </li>
                  <li class="flex items-start">
                    <span class="text-primary mr-2">•</span>
                    <span>Konstrukcja i wyposażenie cystern</span>
                  </li>
                  <li class="flex items-start">
                    <span class="text-primary mr-2">•</span>
                    <span>Oznakowanie i tablice ostrzegawcze</span>
                  </li>
                  <li class="flex items-start">
                    <span class="text-primary mr-2">•</span>
                    <span>Napełnianie i opróżnianie cystern</span>
                  </li>
                  <li class="flex items-start">
                    <span class="text-primary mr-2">•</span>
                    <span>Stopień napełnienia - obliczenia</span>
                  </li>
                  <li class="flex items-start">
                    <span class="text-primary mr-2">•</span>
                    <span>Postępowanie awaryjne specyficzne dla cystern</span>
                  </li>
                </ul>

                <div class="bg-primary/10 rounded-lg p-4 mt-6">
                  <p class="text-sm font-semibold text-primary">
                    💡 Kurs cysterny jest dodatkowym uprawnieniem do certyfikatu podstawowego ADR. 
                    Zwiększa możliwości zatrudnienia w branży transportowej.
                  </p>
                </div>

                <!-- CTA Button -->
                <div class="mt-8">
                  <button 
                    @click="scrollToRegistration"
                    class="w-full bg-primary text-white px-8 py-4 text-lg font-semibold hover:opacity-90 transition-opacity uppercase rounded-lg"
                  >
                    Zapisz się na ten kurs
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Registration Form -->
    <RegistrationForm course-type="cysterny" />

    <!-- Contact -->
    <Contact />
  </div>
</template>

<script setup>
import RegistrationForm from '../components/RegistrationForm.vue'
import Contact from '../components/Contact.vue'

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

