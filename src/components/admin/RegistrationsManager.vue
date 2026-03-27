<template>
  <div>
    <div v-if="loading" class="text-center py-8">
      <p class="text-gray-600">Ładowanie zgłoszeń...</p>
    </div>

    <div v-else>
      <!-- Stats -->
      <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
        <div class="bg-primary/10 rounded-lg p-4">
          <p class="text-sm text-gray-600">Wszystkie zgłoszenia</p>
          <p class="text-2xl font-bold text-primary">{{ registrations.length }}</p>
        </div>
        <div class="bg-green-100 rounded-lg p-4">
          <p class="text-sm text-gray-600">Ostatnie 7 dni</p>
          <p class="text-2xl font-bold text-green-600">{{ recentRegistrations }}</p>
        </div>
        <div class="bg-blue-100 rounded-lg p-4">
          <p class="text-sm text-gray-600">Kurs podstawowy</p>
          <p class="text-2xl font-bold text-blue-600">{{ countByCourse('podstawowy') }}</p>
        </div>
      </div>

      <!-- Filters -->
      <div class="mb-4 flex gap-4">
        <select 
          v-model="filterCourse"
          class="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
        >
          <option value="">Wszystkie kursy</option>
          <option value="podstawowy">Kurs podstawowy</option>
          <option value="cysterny">Cysterny</option>
          <option value="klasa1">Klasa 1</option>
          <option value="klasa7">Klasa 7</option>
          <option value="odswiezajacy">Odświeżający</option>
        </select>
      </div>

      <!-- Table -->
      <div class="overflow-x-auto">
        <table class="w-full">
          <thead class="bg-gray-50">
            <tr>
              <th class="px-4 py-3 text-left text-sm font-semibold text-gray-700">Imię i nazwisko</th>
              <th class="px-4 py-3 text-left text-sm font-semibold text-gray-700">Email</th>
              <th class="px-4 py-3 text-left text-sm font-semibold text-gray-700">Telefon</th>
              <th class="px-4 py-3 text-left text-sm font-semibold text-gray-700">Kurs</th>
              <th class="px-4 py-3 text-left text-sm font-semibold text-gray-700">Data zgłoszenia</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-200">
            <tr v-for="reg in filteredRegistrations" :key="reg.id" class="hover:bg-gray-50">
              <td class="px-4 py-3 text-sm">{{ reg.first_name }} {{ reg.last_name }}</td>
              <td class="px-4 py-3 text-sm">{{ reg.email }}</td>
              <td class="px-4 py-3 text-sm">{{ reg.phone }}</td>
              <td class="px-4 py-3 text-sm">
                <span class="px-2 py-1 bg-primary/20 text-primary rounded text-xs font-semibold">
                  {{ getCourseLabel(reg.course_type) }}
                </span>
              </td>
              <td class="px-4 py-3 text-sm text-gray-600">
                {{ formatDate(reg.created_at) }}
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <div v-if="filteredRegistrations.length === 0" class="text-center py-8 text-gray-600">
        Brak zgłoszeń do wyświetlenia.
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { supabase } from '../../lib/supabaseClient'

const registrations = ref([])
const loading = ref(true)
const filterCourse = ref('')

const filteredRegistrations = computed(() => {
  if (!filterCourse.value) return registrations.value
  return registrations.value.filter(r => r.course_type === filterCourse.value)
})

const recentRegistrations = computed(() => {
  const sevenDaysAgo = new Date()
  sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7)
  return registrations.value.filter(r => new Date(r.created_at) >= sevenDaysAgo).length
})

const countByCourse = (courseType) => {
  return registrations.value.filter(r => r.course_type === courseType).length
}

const getCourseLabel = (courseType) => {
  const labels = {
    'podstawowy': 'Podstawowy',
    'cysterny': 'Cysterny',
    'klasa1': 'Klasa 1',
    'klasa7': 'Klasa 7',
    'odswiezajacy': 'Odświeżający'
  }
  return labels[courseType] || courseType
}

const formatDate = (dateString) => {
  const date = new Date(dateString)
  return date.toLocaleDateString('pl-PL', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  })
}

onMounted(async () => {
  await loadRegistrations()
})

const loadRegistrations = async () => {
  loading.value = true
  try {
    const { data, error } = await supabase
      .from('registrations')
      .select('*')
      .order('created_at', { ascending: false })

    if (error) throw error
    registrations.value = data
  } catch (error) {
    console.error('Error loading registrations:', error)
  } finally {
    loading.value = false
  }
}
</script>
