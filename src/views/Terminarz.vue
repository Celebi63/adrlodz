<template>
  <div>
    <!-- Header -->
    <section class="bg-gradient-to-r from-primary to-orange-600 text-white py-8 px-8">
      <div class="mx-auto max-w-[1440px]">
        <h1 class="text-3xl md:text-4xl font-bold mb-2">Terminarz Kursów ADR</h1>
        <p class="text-lg opacity-90">Sprawdź najbliższe terminy szkoleń i zapisz się na kurs</p>
      </div>
    </section>

    <!-- Loading State -->
    <section v-if="loading" class="py-16 px-8 bg-white">
      <div class="mx-auto max-w-[1440px] text-center">
        <p class="text-gray-600 text-lg">Ładowanie terminów kursów...</p>
      </div>
    </section>

    <!-- Courses Schedule -->
    <section v-else-if="courses.length > 0" class="py-16 px-8 bg-white">
      <div class="mx-auto max-w-[1440px]">
        <!-- Desktop Table -->
        <div class="hidden lg:block overflow-x-auto">
          <table class="w-full border-collapse">
            <thead>
              <tr class="bg-gray-100">
                <th class="text-left p-4 font-bold text-text-main border-b-2 border-primary">Kurs</th>
                <th class="text-left p-4 font-bold text-text-main border-b-2 border-primary">Czas trwania</th>
                <th class="text-left p-4 font-bold text-text-main border-b-2 border-primary">Termin kursu</th>
                <th class="text-left p-4 font-bold text-text-main border-b-2 border-primary">Egzamin</th>
                <th class="text-center p-4 font-bold text-text-main border-b-2 border-primary">Cena</th>
                <th class="text-center p-4 font-bold text-text-main border-b-2 border-primary">Zapis</th>
              </tr>
            </thead>
            <tbody>
              <tr 
                v-for="course in courses" 
                :key="course.id"
                class="border-b border-gray-200 hover:bg-gray-50 transition-colors"
              >
                <td class="p-4">
                  <div class="font-semibold text-text-main">{{ course.title }}</div>
                </td>
                <td class="p-4 text-gray-700">
                  {{ course.duration }}
                </td>
                <td class="p-4">
                  <div class="font-semibold text-primary">{{ course.next_date }}</div>
                </td>
                <td class="p-4 text-gray-700">
                  {{ course.exam_date }}
                </td>
                <td class="p-4 text-center">
                  <div class="font-bold text-primary text-lg">{{ course.price }} PLN</div>
                </td>
                <td class="p-4 text-center">
                  <button 
                    @click="goToCourse(course.course_type)"
                    class="bg-primary text-white px-6 py-3 rounded-lg font-semibold hover:opacity-90 transition-opacity uppercase text-sm"
                  >
                    Zapisz się
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- Mobile Cards -->
        <div class="lg:hidden space-y-6">
          <div 
            v-for="course in courses" 
            :key="course.id"
            class="bg-white border border-gray-200 rounded-lg shadow-md overflow-hidden"
          >
            <div class="bg-primary/10 px-6 py-4 border-b border-gray-200">
              <h3 class="text-xl font-bold text-text-main">{{ course.title }}</h3>
            </div>
            
            <div class="p-6 space-y-4">
              <div class="grid grid-cols-2 gap-4">
                <div>
                  <p class="text-sm text-gray-600 mb-1">Czas trwania</p>
                  <p class="font-semibold text-gray-800">{{ course.duration }}</p>
                </div>
                <div>
                  <p class="text-sm text-gray-600 mb-1">Cena</p>
                  <p class="font-bold text-primary text-lg">{{ course.price }} PLN</p>
                </div>
              </div>

              <div>
                <p class="text-sm text-gray-600 mb-1">Termin kursu</p>
                <p class="font-semibold text-primary">{{ course.next_date }}</p>
              </div>

              <div>
                <p class="text-sm text-gray-600 mb-1">Egzamin</p>
                <p class="font-semibold text-gray-800">{{ course.exam_date }}</p>
              </div>

              <button 
                @click="goToCourse(course.course_type)"
                class="w-full bg-primary text-white px-6 py-3 rounded-lg font-semibold hover:opacity-90 transition-opacity uppercase mt-2"
              >
                Zapisz się
              </button>
            </div>
          </div>
        </div>

        <!-- Info Box -->
        <div class="mt-12 bg-primary/10 rounded-lg p-6 border-l-4 border-primary">
          <div class="flex items-start gap-4">
            <div>
              <h3 class="font-bold text-text-main text-lg mb-2">Informacje o zapisach</h3>
              <ul class="space-y-2 text-gray-700">
                <li class="flex items-start">
                  <span class="text-primary mr-2">•</span>
                  <span>Zgłoszenia przyjmujemy do czwartku włącznie przed rozpoczęciem kursu</span>
                </li>
                <li class="flex items-start">
                  <span class="text-primary mr-2">•</span>
                  <span>Liczba miejsc ograniczona - zapisy w kolejności zgłoszeń</span>
                </li>
                <li class="flex items-start">
                  <span class="text-primary mr-2">•</span>
                  <span>Po wysłaniu formularza skontaktujemy się z Tobą w celu potwierdzenia zapisu</span>
                </li>
                <li class="flex items-start">
                  <span class="text-primary mr-2">•</span>
                  <span>W razie pytań zadzwoń: <a href="tel:+48123456789" class="text-primary font-semibold hover:underline">+48 123 456 789</a></span>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Empty State -->
    <section v-else class="py-16 px-8 bg-white">
      <div class="mx-auto max-w-[1440px] text-center">
        <p class="text-gray-600 text-lg">Brak dostępnych terminów kursów.</p>
      </div>
    </section>

    <!-- Registration Form -->
    <RegistrationForm :course-type="selectedCourseType" />

    <!-- Contact -->
    <Contact />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { supabase } from '../lib/supabaseClient'
import RegistrationForm from '../components/RegistrationForm.vue'
import Contact from '../components/Contact.vue'

const courses = ref([])
const loading = ref(true)
const selectedCourseType = ref('podstawowy')

onMounted(async () => {
  await loadCourses()
})

const loadCourses = async () => {
  try {
    const { data, error } = await supabase
      .from('courses')
      .select('*')
      .order('next_date', { ascending: true })

    if (error) throw error
    courses.value = data || []
  } catch (error) {
    console.error('Error loading courses:', error)
  } finally {
    loading.value = false
  }
}

const goToCourse = (courseType) => {
  // Set selected course type for the form
  selectedCourseType.value = courseType
  
  // Scroll to registration form
  setTimeout(() => {
    const registrationSection = document.getElementById('registration')
    if (registrationSection) {
      registrationSection.scrollIntoView({ 
        behavior: 'smooth',
        block: 'start'
      })
    }
  }, 100)
}
</script>
