<template>
  <div>
    <!-- Course Header -->
    <section class="bg-gradient-to-r from-primary to-orange-600 text-white py-8 px-8">
      <div class="mx-auto max-w-[1440px]">
        <h1 class="text-3xl md:text-4xl font-bold">
          Kurs ADR Podstawowy
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
              <p class="text-3xl font-bold text-primary">1200 PLN</p>
              <p class="text-sm text-gray-600 mt-2">Cena zawiera materiały szkoleniowe i egzamin</p>
            </div>

            <!-- Duration -->
            <div class="bg-gray-50 rounded-lg p-6 border-l-4 border-primary">
              <h3 class="text-2xl font-bold text-text-main mb-2">Czas trwania</h3>
              <p class="text-xl text-gray-700">3 dni (24 godziny)</p>
              <p class="text-sm text-gray-600 mt-2">
                Szkolenie odbywa się w formie stacjonarnej<br>
                Poniedziałek - Środa, 8:00 - 16:00
              </p>
            </div>

            <!-- Next Date -->
            <div class="bg-gray-50 rounded-lg p-6 border-l-4 border-primary">
              <h3 class="text-2xl font-bold text-text-main mb-2">Najbliższy termin</h3>
              <p class="text-xl text-gray-700 font-semibold">15-17 Lutego 2025</p>
              <p class="text-sm text-gray-600 mt-2">Egzamin: 18 Lutego 2025</p>
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
                  <span class="text-gray-700">Prawo jazdy kategorii B lub wyższej</span>
                </li>
                <li class="flex items-start">
                  <span class="text-primary mr-2 font-bold">✓</span>
                  <span class="text-gray-700">Ukończone 21 lat (18 lat dla przewozu krajowego)</span>
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
                  <span class="text-gray-700">Kopia prawa jazdy i dowodu osobistego</span>
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
                  Kurs podstawowy ADR to szkolenie wymagane dla kierowców przewożących towary 
                  niebezpieczne. Po ukończeniu kursu i zdaniu egzaminu otrzymasz świadectwo ADR 
                  ważne przez 5 lat.
                </p>
                
                <h4 class="font-bold text-lg text-text-main mt-6 mb-2">Program szkolenia:</h4>
                <ul class="space-y-2">
                  <li class="flex items-start">
                    <span class="text-primary mr-2">•</span>
                    <span>Przepisy krajowe i międzynarodowe dotyczące przewozu towarów niebezpiecznych</span>
                  </li>
                  <li class="flex items-start">
                    <span class="text-primary mr-2">•</span>
                    <span>Klasyfikacja towarów niebezpiecznych</span>
                  </li>
                  <li class="flex items-start">
                    <span class="text-primary mr-2">•</span>
                    <span>Oznakowanie pojazdów i opakowań</span>
                  </li>
                  <li class="flex items-start">
                    <span class="text-primary mr-2">•</span>
                    <span>Dokumenty przewozowe</span>
                  </li>
                  <li class="flex items-start">
                    <span class="text-primary mr-2">•</span>
                    <span>Postępowanie w sytuacjach awaryjnych</span>
                  </li>
                  <li class="flex items-start">
                    <span class="text-primary mr-2">•</span>
                    <span>Bezpieczeństwo podczas załadunku i rozładunku</span>
                  </li>
                </ul>

                <div class="bg-primary/10 rounded-lg p-4 mt-6">
                  <p class="text-sm font-semibold text-primary">
                    💡 Po ukończeniu kursu podstawowego możesz rozszerzyć uprawnienia o kursy 
                    specjalistyczne (cysterny, klasa 1, klasa 7).
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
    <RegistrationForm course-type="podstawowy" />

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

