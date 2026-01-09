<template>
  <div>
    <!-- Header -->
    <section class="bg-gradient-to-r from-primary to-orange-600 text-white py-8 px-8">
      <div class="mx-auto max-w-[1440px]">
        <h1 class="text-3xl md:text-4xl font-bold">O nas</h1>
      </div>
    </section>

    <!-- Content with Image -->
    <section class="py-16 px-8 bg-white">
      <div class="mx-auto max-w-[1440px]">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
          <!-- Text Column -->
          <div class="space-y-6">
            <h2 class="text-3xl font-bold text-text-main mb-6">
              ADR Łódź - Twój partner w szkoleniach
            </h2>
            
            <p class="text-lg text-gray-700">
              Jesteśmy doświadczonym ośrodkiem szkoleniowym specjalizującym się w kursach ADR 
              dla kierowców i przewoźników. Od wielu lat pomagamy profesjonalistom z branży 
              transportowej zdobywać kwalifikacje niezbędne do przewozu towarów niebezpiecznych.
            </p>

            <p class="text-gray-700">
              Nasze szkolenia prowadzą wykwalifikowani instruktorzy z wieloletnim doświadczeniem 
              praktycznym. Zapewniamy kompleksową wiedzę teoretyczną oraz praktyczne wskazówki, 
              które przydadzą się w codziennej pracy.
            </p>

            <p class="text-gray-700">
              Certyfikaty wydawane przez nasz ośrodek są uznawane w całej Europie zgodnie z 
              międzynarodowymi przepisami ADR.
            </p>

            <div class="bg-primary/10 rounded-lg p-6 mt-8">
              <h3 class="text-xl font-bold text-text-main mb-4">Dlaczego my?</h3>
              <ul class="space-y-3">
                <li class="flex items-start">
                  <span class="text-primary mr-2 font-bold text-xl">✓</span>
                  <span class="text-gray-700">Certyfikowane szkolenia zgodne z przepisami</span>
                </li>
                <li class="flex items-start">
                  <span class="text-primary mr-2 font-bold text-xl">✓</span>
                  <span class="text-gray-700">Doświadczeni instruktorzy-praktycy</span>
                </li>
                <li class="flex items-start">
                  <span class="text-primary mr-2 font-bold text-xl">✓</span>
                  <span class="text-gray-700">Nowoczesne materiały szkoleniowe</span>
                </li>
                <li class="flex items-start">
                  <span class="text-primary mr-2 font-bold text-xl">✓</span>
                  <span class="text-gray-700">Dogodne terminy szkoleń</span>
                </li>
                <li class="flex items-start">
                  <span class="text-primary mr-2 font-bold text-xl">✓</span>
                  <span class="text-gray-700">Konkurencyjne ceny</span>
                </li>
                <li class="flex items-start">
                  <span class="text-primary mr-2 font-bold text-xl">✓</span>
                  <span class="text-gray-700">Wsparcie po zakończeniu kursu</span>
                </li>
              </ul>
            </div>
          </div>

          <!-- Image Column -->
          <div class="lg:order-last">
            <div class="relative rounded-lg overflow-hidden shadow-2xl">
              <img 
                src="../assets/truck.png" 
                alt="Ciężarówka ADR" 
                class="w-full h-auto object-cover"
              />
              <div class="absolute inset-0 bg-gradient-to-t from-black/30 to-transparent"></div>
            </div>
            
            <!-- Stats -->
            <div class="grid grid-cols-3 gap-4 mt-8">
              <div class="bg-primary/10 rounded-lg p-4 text-center">
                <p class="text-3xl font-bold text-primary mb-1">500+</p>
                <p class="text-sm text-gray-700">Absolwentów</p>
              </div>
              <div class="bg-primary/10 rounded-lg p-4 text-center">
                <p class="text-3xl font-bold text-primary mb-1">10+</p>
                <p class="text-sm text-gray-700">Lat doświadczenia</p>
              </div>
              <div class="bg-primary/10 rounded-lg p-4 text-center">
                <p class="text-3xl font-bold text-primary mb-1">98%</p>
                <p class="text-sm text-gray-700">Zdawalność</p>
              </div>
            </div>
          </div>
        </div>

        <!-- Mission Section -->
        <div class="mt-16 bg-gray-50 rounded-lg p-8">
          <div class="max-w-3xl mx-auto text-center">
            <h3 class="text-2xl font-bold text-text-main mb-4">Nasza misja</h3>
            <p class="text-lg text-gray-700">
              Naszym celem jest zapewnienie najwyższej jakości szkoleń ADR, które nie tylko 
              przygotują Cię do zdania egzaminu, ale przede wszystkim wyposażą w praktyczną 
              wiedzę niezbędną w codziennej pracy kierowcy przewożącego towary niebezpieczne.
            </p>
          </div>
        </div>
      </div>
    </section>

    <Contact />
  </div>
</template>

<script setup>
import Contact from '../components/Contact.vue'
</script>

