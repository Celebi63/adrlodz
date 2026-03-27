<template>
  <div v-if="loading" class="min-h-screen flex items-center justify-center">
    <p class="text-gray-600">Ładowanie...</p>
  </div>

  <div v-else-if="courseData">
    <!-- Course Header -->
    <section class="bg-gradient-to-r from-primary to-orange-600 text-white py-8 px-8">
      <div class="mx-auto max-w-[1440px]">
        <h1 class="text-3xl md:text-4xl font-bold">
          {{ courseData.title }}
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
              <p class="text-3xl font-bold text-primary">{{ courseData.price }} PLN</p>
              <p class="text-sm text-gray-600 mt-2">Cena zawiera materiały szkoleniowe i egzamin</p>
            </div>

            <!-- Duration -->
            <div class="bg-gray-50 rounded-lg p-6 border-l-4 border-primary">
              <h3 class="text-2xl font-bold text-text-main mb-2">Czas trwania</h3>
              <p class="text-xl text-gray-700">{{ courseData.duration }}</p>
              <p class="text-sm text-gray-600 mt-2">
                Szkolenie odbywa się w formie stacjonarnej<br>
                Poniedziałek - Wtorek, 8:00 - 16:00
              </p>
            </div>

            <!-- Next Date -->
            <div class="bg-gray-50 rounded-lg p-6 border-l-4 border-primary">
              <h3 class="text-2xl font-bold text-text-main mb-2">Najbliższy termin</h3>
              <p class="text-xl text-gray-700 font-semibold">{{ courseData.next_date }}</p>
              <p class="text-sm text-gray-600 mt-2">Egzamin: {{ courseData.exam_date }}</p>
              <p class="text-sm text-primary font-semibold mt-2">
                Zgłoszenia przyjmujemy do czwartku włącznie
              </p>
            </div>

            <!-- Requirements -->
            <div class="bg-gray-50 rounded-lg p-6 border-l-4 border-primary">
              <h3 class="text-2xl font-bold text-text-main mb-3">Wymagania</h3>
              <ul class="space-y-2">
                <li v-for="(req, index) in courseData.requirements" :key="index" class="flex items-start">
                  <span class="text-primary mr-2 font-bold">✓</span>
                  <span class="text-gray-700">{{ req }}</span>
                </li>
              </ul>
            </div>
          </div>

          <!-- Right Column - Course Description -->
          <div>
            <div class="bg-white rounded-lg p-8 border border-gray-200 shadow-lg sticky top-24">
              <h3 class="text-2xl font-bold text-text-main mb-4">O kursie</h3>
              <div class="space-y-4 text-gray-700">
                <p class="whitespace-pre-line">{{ courseData.description }}</p>
                
                <h4 class="font-bold text-lg text-text-main mt-6 mb-2">Program szkolenia:</h4>
                <ul class="space-y-2">
                  <li v-for="(item, index) in courseData.program" :key="index" class="flex items-start">
                    <span class="text-primary mr-2">•</span>
                    <span>{{ item }}</span>
                  </li>
                </ul>

                <div class="bg-primary/10 rounded-lg p-4 mt-6">
                  <p class="text-sm font-semibold text-primary">
                    ⚠️ WAŻNE: Kurs odświeżający należy ukończyć przed upływem roku od daty 
                    wygaśnięcia świadectwa. Po tym terminie konieczne jest ponowne przejście 
                    kursu podstawowego.
                  </p>
                </div>

                <!-- CTA Button -->
                <div class="mt-8">
                  <button 
                    @click="scrollToRegistration"
                    class="w-full bg-primary text-white px-8 py-4 text-lg font-semibold hover:opacity-90 transition-opacity uppercase rounded-lg"
                  >
                    Zapisz się na kurs odświeżający
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Registration Form -->
    <RegistrationForm course-type="odswiezajacy" />

    <!-- Contact -->
    <Contact />
  </div>

  <div v-else class="min-h-screen flex items-center justify-center">
    <p class="text-gray-600">Nie znaleziono kursu.</p>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { supabase } from '../lib/supabaseClient'
import RegistrationForm from '../components/RegistrationForm.vue'
import Contact from '../components/Contact.vue'

const COURSE_TYPE = 'odswiezajacy'

const courseData = ref(null)
const loading = ref(true)

onMounted(async () => {
  await loadCourseData()
})

const loadCourseData = async () => {
  try {
    const { data, error } = await supabase
      .from('courses')
      .select('*')
      .eq('course_type', COURSE_TYPE)
      .single()

    if (error) throw error
    courseData.value = data
  } catch (error) {
    console.error('Error loading course:', error)
  } finally {
    loading.value = false
  }
}

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
