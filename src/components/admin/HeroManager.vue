<template>
  <div>
    <div v-if="loading" class="text-center py-8">
      <p class="text-gray-600">Ładowanie...</p>
    </div>

    <form v-else @submit.prevent="saveHero" class="space-y-6">
      <div class="border border-gray-200 rounded-lg p-6">
        <h3 class="text-lg font-bold text-text-main mb-4">Hero Section - Strona Główna</h3>
        
        <div class="space-y-4">
          <!-- Title -->
          <div>
            <label class="block text-sm font-semibold text-text-main mb-2">
              Tytuł główny
            </label>
            <input
              v-model="heroData.title"
              type="text"
              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
              placeholder="np. Kursy ADR Łódź"
            />
          </div>

          <!-- Next Course Date -->
          <div>
            <label class="block text-sm font-semibold text-text-main mb-2">
              Najbliższy kurs podstawowy:
            </label>
            <input
              v-model="heroData.next_course_date"
              type="text"
              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
              placeholder="np. 15-17 Lutego 2025"
            />
          </div>

          <!-- Exam Date -->
          <div>
            <label class="block text-sm font-semibold text-text-main mb-2">
              Egzamin:
            </label>
            <input
              v-model="heroData.exam_date"
              type="text"
              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
              placeholder="np. 18 Lutego 2025"
            />
          </div>

          <!-- Registration Deadline -->
          <div>
            <label class="block text-sm font-semibold text-text-main mb-2">
              Termin zgłoszeń
            </label>
            <input
              v-model="heroData.registration_deadline"
              type="text"
              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
              placeholder="np. Zgłoszenia do czwartku włącznie."
            />
          </div>
        </div>
      </div>

      <!-- Preview -->
      <div class="border border-gray-200 rounded-lg p-6 bg-gray-50">
        <h3 class="text-lg font-bold text-text-main mb-4">Podgląd</h3>
        <div class="space-y-2 text-gray-700">
          <p class="text-2xl font-bold">{{ heroData.title }}</p>
          <p>Najbliższy kurs podstawowy: {{ heroData.next_course_date }}</p>
          <p>Egzamin: {{ heroData.exam_date }}</p>
          <p>{{ heroData.registration_deadline }}</p>
        </div>
      </div>

      <!-- Success/Error Messages -->
      <div v-if="successMessage" class="p-4 bg-green-100 border border-green-400 rounded-lg text-green-700">
        {{ successMessage }}
      </div>
      <div v-if="errorMessage" class="p-4 bg-red-100 border border-red-400 rounded-lg text-red-700">
        {{ errorMessage }}
      </div>

      <!-- Save Button -->
      <button
        type="submit"
        :disabled="saving"
        class="w-full bg-primary text-white px-6 py-3 rounded-lg hover:opacity-90 transition-opacity font-semibold disabled:opacity-50"
      >
        {{ saving ? 'Zapisywanie...' : 'Zapisz zmiany' }}
      </button>
    </form>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { supabase } from '../../lib/supabaseClient'

const heroData = ref({
  id: null,
  title: '',
  next_course_date: '',
  exam_date: '',
  registration_deadline: ''
})

const loading = ref(true)
const saving = ref(false)
const successMessage = ref('')
const errorMessage = ref('')

onMounted(async () => {
  await loadHeroContent()
})

const loadHeroContent = async () => {
  loading.value = true
  try {
    const { data, error } = await supabase
      .from('hero_content')
      .select('*')
      .eq('is_active', true)
      .single()

    if (error) throw error
    if (data) {
      heroData.value = data
    }
  } catch (error) {
    console.error('Error loading hero content:', error)
  } finally {
    loading.value = false
  }
}

const saveHero = async () => {
  saving.value = true
  successMessage.value = ''
  errorMessage.value = ''

  try {
    const { error } = await supabase
      .from('hero_content')
      .update({
        title: heroData.value.title,
        next_course_date: heroData.value.next_course_date,
        exam_date: heroData.value.exam_date,
        registration_deadline: heroData.value.registration_deadline
      })
      .eq('id', heroData.value.id)

    if (error) throw error

    successMessage.value = 'Strona główna została zaktualizowana pomyślnie!'
    
    setTimeout(() => {
      successMessage.value = ''
    }, 3000)
  } catch (error) {
    console.error('Error saving hero content:', error)
    errorMessage.value = 'Wystąpił błąd podczas zapisywania. Spróbuj ponownie.'
  } finally {
    saving.value = false
  }
}
</script>
