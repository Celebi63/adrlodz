<template>
  <section id="registration" class="py-16 px-8 bg-white">
    <div class="mx-auto max-w-[800px]">
      <!-- Header -->
      <div class="text-center mb-12">
        <h2 class="text-4xl font-bold text-text-main mb-4">
          Zapisz się na kurs ADR
        </h2>
        <p class="text-lg text-gray-600">
          Wypełnij formularz, aby zapisać się na wybrany kurs
        </p>
      </div>

      <!-- Loading State -->
      <div v-if="loadingCourses" class="text-center py-8">
        <p class="text-gray-600">Ładowanie dostępnych kursów...</p>
      </div>

      <!-- Form -->
      <form v-else @submit.prevent="handleSubmit" class="space-y-6">
        <!-- Wybór kursu -->
        <div>
          <label for="courseSelect" class="block text-sm font-semibold text-text-main mb-2">
            Wybierz kurs *
          </label>
          <select
            id="courseSelect"
            v-model="formData.selectedCourse"
            required
            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent bg-white"
          >
            <option value="" disabled>-- Wybierz kurs --</option>
            <option 
              v-for="course in availableCourses" 
              :key="course.id"
              :value="course.course_type"
            >
              {{ course.title }} - {{ course.next_date }}
            </option>
          </select>
        </div>

        <!-- Imię -->
        <div>
          <label for="firstName" class="block text-sm font-semibold text-text-main mb-2">
            Imię *
          </label>
          <input
            type="text"
            id="firstName"
            v-model="formData.firstName"
            required
            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
            placeholder="Wprowadź swoje imię"
          />
        </div>

        <!-- Nazwisko -->
        <div>
          <label for="lastName" class="block text-sm font-semibold text-text-main mb-2">
            Nazwisko *
          </label>
          <input
            type="text"
            id="lastName"
            v-model="formData.lastName"
            required
            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
            placeholder="Wprowadź swoje nazwisko"
          />
        </div>

        <!-- Email -->
        <div>
          <label for="email" class="block text-sm font-semibold text-text-main mb-2">
            Email *
          </label>
          <input
            type="email"
            id="email"
            v-model="formData.email"
            required
            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
            placeholder="twoj.email@example.com"
          />
        </div>

        <!-- Telefon -->
        <div>
          <label for="phone" class="block text-sm font-semibold text-text-main mb-2">
            Numer telefonu *
          </label>
          <input
            type="tel"
            id="phone"
            v-model="formData.phone"
            required
            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
            placeholder="+48 123 456 789"
          />
        </div>

        <!-- PESEL -->
        <div>
          <label for="pesel" class="block text-sm font-semibold text-text-main mb-2">
            PESEL *
          </label>
          <input
            type="text"
            id="pesel"
            v-model="formData.pesel"
            required
            pattern="[0-9]{11}"
            maxlength="11"
            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
            placeholder="12345678901"
          />
        </div>

        <!-- Miejsce urodzenia -->
        <div>
          <label for="birthPlace" class="block text-sm font-semibold text-text-main mb-2">
            Miejsce urodzenia *
          </label>
          <input
            type="text"
            id="birthPlace"
            v-model="formData.birthPlace"
            required
            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
            placeholder="Wprowadź miejsce urodzenia"
          />
        </div>

        <!-- Checkbox zgody -->
        <div class="flex items-start gap-3">
          <input
            type="checkbox"
            id="consent"
            v-model="formData.consent"
            required
            class="mt-1 w-5 h-5 text-primary border-gray-300 rounded focus:ring-primary"
          />
          <label for="consent" class="text-sm text-gray-700">
            Wyrażam zgodę na przetwarzanie moich danych osobowych zgodnie z przepisami RODO w celu realizacji zapisu na kurs ADR. *
          </label>
        </div>

        <!-- Info Note -->
        <div class="pt-2 pb-2">
          <p class="text-sm text-gray-600 text-center">
            Po prawidłowym wypełnieniu dostanie Pan/Pani w ciągu 24h SMS potwierdzający przyjęcie na kurs
          </p>
        </div>

        <!-- Submit Button -->
        <div>
          <button
            type="submit"
            :disabled="isSubmitting"
            class="w-full bg-primary text-white px-8 py-4 text-lg font-semibold rounded-lg hover:opacity-90 transition-opacity uppercase disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {{ isSubmitting ? 'Wysyłanie...' : 'Wyślij zgłoszenie' }}
          </button>
        </div>

        <!-- Success Message -->
        <div v-if="showSuccess" class="p-4 bg-green-100 border border-green-400 rounded-lg text-green-700">
          ✓ Dziękujemy za zgłoszenie! Skontaktujemy się z Tobą wkrótce.
        </div>

        <!-- Error Message -->
        <div v-if="showError" class="p-4 bg-red-100 border border-red-400 rounded-lg text-red-700">
          ✗ Wystąpił błąd. Spróbuj ponownie lub skontaktuj się telefonicznie.
        </div>
      </form>
    </div>
  </section>
</template>

<script setup>
import { ref, reactive, onMounted, watch } from 'vue'
import { supabase } from '../lib/supabaseClient'

const props = defineProps({
  courseType: {
    type: String,
    default: ''
  }
})

const availableCourses = ref([])
const loadingCourses = ref(true)

const formData = reactive({
  selectedCourse: '',
  firstName: '',
  lastName: '',
  email: '',
  phone: '',
  pesel: '',
  birthPlace: '',
  consent: false
})

const isSubmitting = ref(false)
const showSuccess = ref(false)
const showError = ref(false)

onMounted(async () => {
  await loadCourses()
  
  // If courseType prop is provided, set it as default
  if (props.courseType) {
    formData.selectedCourse = props.courseType
  }
})

// Watch for courseType changes (e.g., from Terminarz page)
watch(() => props.courseType, (newType) => {
  if (newType) {
    formData.selectedCourse = newType
  }
})

const loadCourses = async () => {
  try {
    const { data, error } = await supabase
      .from('courses')
      .select('*')
      .order('next_date', { ascending: true })

    if (error) throw error
    availableCourses.value = data || []
  } catch (error) {
    console.error('Error loading courses:', error)
  } finally {
    loadingCourses.value = false
  }
}

const handleSubmit = async () => {
  isSubmitting.value = true
  showSuccess.value = false
  showError.value = false

  try {
    const { error } = await supabase
      .from('registrations')
      .insert([
        {
          first_name: formData.firstName,
          last_name: formData.lastName,
          email: formData.email,
          phone: formData.phone,
          pesel: formData.pesel,
          birth_place: formData.birthPlace,
          course_type: formData.selectedCourse,
          consent: formData.consent,
          created_at: new Date().toISOString()
        }
      ])

    if (error) throw error

    // Success
    showSuccess.value = true
    
    // Reset form
    Object.keys(formData).forEach(key => {
      if (key === 'consent') {
        formData[key] = false
      } else if (key === 'selectedCourse') {
        formData[key] = props.courseType || ''
      } else {
        formData[key] = ''
      }
    })

  } catch (error) {
    console.error('Error submitting registration:', error)
    showError.value = true
  } finally {
    isSubmitting.value = false
  }
}
</script>

<style scoped>
/* Additional custom styles if needed */
</style>

