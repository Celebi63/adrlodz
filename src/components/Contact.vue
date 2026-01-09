<template>
  <section id="kontakt" class="py-16 px-8 bg-gray-50">
    <div class="mx-auto max-w-[1440px]">
      <!-- Header -->
      <div class="text-center mb-12">
        <h2 class="text-4xl font-bold text-text-main mb-4">
          Kontakt
        </h2>
        <p class="text-lg text-gray-600">
          Skontaktuj się z nami lub odwiedź nasze biuro
        </p>
      </div>

      <!-- Content Grid -->
      <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
        <!-- Contact Information -->
        <div class="space-y-8">
          <!-- Address -->
          <div class="bg-white p-6 rounded-lg shadow-md">
            <div class="flex items-start gap-4">
              <div class="bg-primary/10 p-3 rounded-lg">
                <svg class="w-6 h-6 text-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                </svg>
              </div>
              <div>
                <h3 class="text-xl font-semibold text-text-main mb-2">Adres</h3>
                <p class="text-gray-700">ul. Wersalska 47</p>
                <p class="text-gray-700">91-212 Łódź</p>
              </div>
            </div>
          </div>

          <!-- Phone -->
          <div class="bg-white p-6 rounded-lg shadow-md">
            <div class="flex items-start gap-4">
              <div class="bg-primary/10 p-3 rounded-lg">
                <svg class="w-6 h-6 text-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                </svg>
              </div>
              <div>
                <h3 class="text-xl font-semibold text-text-main mb-2">Telefon</h3>
                <p class="text-gray-700">+48 123 456 789</p>
                <p class="text-gray-700">+48 987 654 321</p>
              </div>
            </div>
          </div>

          <!-- NIP -->
          <div class="bg-white p-6 rounded-lg shadow-md">
            <div class="flex items-start gap-4">
              <div class="bg-primary/10 p-3 rounded-lg">
                <svg class="w-6 h-6 text-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                </svg>
              </div>
              <div>
                <h3 class="text-xl font-semibold text-text-main mb-2">NIP</h3>
                <p class="text-gray-700">123-456-78-90</p>
              </div>
            </div>
          </div>

          <!-- Numer konta -->
          <div class="bg-white p-6 rounded-lg shadow-md">
            <div class="flex items-start gap-4">
              <div class="bg-primary/10 p-3 rounded-lg">
                <svg class="w-6 h-6 text-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z" />
                </svg>
              </div>
              <div>
                <h3 class="text-xl font-semibold text-text-main mb-2">Numer konta</h3>
                <p class="text-gray-700 text-sm">12 3456 7890 1234 5678 9012 3456</p>
              </div>
            </div>
          </div>
        </div>

        <!-- Google Maps -->
        <div class="bg-white rounded-lg shadow-md overflow-hidden h-[600px]">
          <iframe
            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2468.830076875234!2d19.462738615746784!3d51.77008197968113!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x471a34f8b4b8f8d1%3A0x8f5f5f5f5f5f5f5f!2sWersalska%2047%2C%2091-212%20%C5%81%C3%B3d%C5%BA!5e0!3m2!1spl!2spl!4v1234567890123!5m2!1spl!2spl"
            width="100%"
            height="100%"
            style="border:0;"
            allowfullscreen=""
            loading="lazy"
            referrerpolicy="no-referrer-when-downgrade"
            class="w-full h-full"
          ></iframe>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
// Contact section with Google Maps
</script>

<style scoped>
/* Additional custom styles if needed */
</style>

