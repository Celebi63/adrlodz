<template>
  <div>
    <div v-if="loading" class="text-center py-8">
      <p class="text-gray-600">Ładowanie kursów...</p>
    </div>

    <div v-else class="space-y-6">
      <div v-for="course in courses" :key="course.id" class="border border-gray-200 rounded-lg p-6">
        <div class="flex justify-between items-start mb-4">
          <h3 class="text-xl font-bold text-text-main">{{ course.title }}</h3>
          <button
            @click="editCourse(course)"
            class="bg-primary text-white px-4 py-2 rounded-lg hover:opacity-90 transition-opacity text-sm font-semibold"
          >
            Edytuj
          </button>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm">
          <div>
            <span class="font-semibold">Cena:</span> {{ course.price }} PLN
          </div>
          <div>
            <span class="font-semibold">Czas trwania:</span> {{ course.duration }}
          </div>
          <div>
            <span class="font-semibold">Najbliższy termin:</span> {{ course.next_date }}
          </div>
          <div>
            <span class="font-semibold">Egzamin:</span> {{ course.exam_date }}
          </div>
        </div>
      </div>
    </div>

    <!-- Edit Modal -->
    <div v-if="editingCourse" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
      <div class="bg-white rounded-lg max-w-2xl w-full max-h-[90vh] overflow-y-auto p-6">
        <h3 class="text-2xl font-bold text-text-main mb-6">Edytuj: {{ editingCourse.title }}</h3>

        <form @submit.prevent="saveCourse" class="space-y-4">
          <!-- Price -->
          <div>
            <label class="block text-sm font-semibold text-text-main mb-2">Cena (PLN)</label>
            <input
              v-model.number="editingCourse.price"
              type="number"
              step="0.01"
              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
            />
          </div>

          <!-- Duration -->
          <div>
            <label class="block text-sm font-semibold text-text-main mb-2">Czas trwania</label>
            <input
              v-model="editingCourse.duration"
              type="text"
              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
            />
          </div>

          <!-- Next Date -->
          <div>
            <label class="block text-sm font-semibold text-text-main mb-2">Najbliższy termin</label>
            <input
              v-model="editingCourse.next_date"
              type="text"
              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
              placeholder="np. 15-17 Lutego 2025"
            />
          </div>

          <!-- Exam Date -->
          <div>
            <label class="block text-sm font-semibold text-text-main mb-2">Data egzaminu</label>
            <input
              v-model="editingCourse.exam_date"
              type="text"
              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
              placeholder="np. 18 Lutego 2025"
            />
          </div>

          <!-- Description -->
          <div>
            <label class="block text-sm font-semibold text-text-main mb-2">Opis</label>
            <textarea
              v-model="editingCourse.description"
              rows="4"
              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
            ></textarea>
          </div>

          <!-- Success/Error Messages -->
          <div v-if="successMessage" class="p-4 bg-green-100 border border-green-400 rounded-lg text-green-700 text-sm">
            {{ successMessage }}
          </div>
          <div v-if="errorMessage" class="p-4 bg-red-100 border border-red-400 rounded-lg text-red-700 text-sm">
            {{ errorMessage }}
          </div>

          <!-- Buttons -->
          <div class="flex gap-3 pt-4">
            <button
              type="submit"
              :disabled="saving"
              class="flex-1 bg-primary text-white px-6 py-3 rounded-lg hover:opacity-90 transition-opacity font-semibold disabled:opacity-50"
            >
              {{ saving ? 'Zapisywanie...' : 'Zapisz zmiany' }}
            </button>
            <button
              type="button"
              @click="closeEdit"
              class="px-6 py-3 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors font-semibold"
            >
              Anuluj
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { supabase } from '../../lib/supabaseClient'

const courses = ref([])
const loading = ref(true)
const editingCourse = ref(null)
const saving = ref(false)
const successMessage = ref('')
const errorMessage = ref('')

onMounted(async () => {
  await loadCourses()
})

const loadCourses = async () => {
  loading.value = true
  try {
    const { data, error } = await supabase
      .from('courses')
      .select('*')
      .order('course_type')

    if (error) throw error
    courses.value = data
  } catch (error) {
    console.error('Error loading courses:', error)
  } finally {
    loading.value = false
  }
}

const editCourse = (course) => {
  editingCourse.value = { ...course }
  successMessage.value = ''
  errorMessage.value = ''
}

const closeEdit = () => {
  editingCourse.value = null
  successMessage.value = ''
  errorMessage.value = ''
}

const saveCourse = async () => {
  saving.value = true
  successMessage.value = ''
  errorMessage.value = ''

  try {
    const { error } = await supabase
      .from('courses')
      .update({
        price: editingCourse.value.price,
        duration: editingCourse.value.duration,
        next_date: editingCourse.value.next_date,
        exam_date: editingCourse.value.exam_date,
        description: editingCourse.value.description,
      })
      .eq('id', editingCourse.value.id)

    if (error) throw error

    successMessage.value = 'Kurs został zaktualizowany pomyślnie!'
    await loadCourses()
    
    setTimeout(() => {
      closeEdit()
    }, 1500)
  } catch (error) {
    console.error('Error saving course:', error)
    errorMessage.value = 'Wystąpił błąd podczas zapisywania. Spróbuj ponownie.'
  } finally {
    saving.value = false
  }
}
</script>
