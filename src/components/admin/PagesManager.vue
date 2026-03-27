<template>
  <div>
    <div v-if="loading" class="text-center py-8">
      <p class="text-gray-600">Ładowanie stron...</p>
    </div>

    <div v-else>
      <!-- Filters -->
      <div class="mb-6 flex gap-4 items-center">
        <div>
          <label class="block text-sm font-semibold text-text-main mb-2">Kategoria</label>
          <select 
            v-model="filterCategory"
            class="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
          >
            <option value="">Wszystkie</option>
            <option value="main">Główne</option>
            <option value="przepisy">Przepisy</option>
            <option value="kursy">Kursy</option>
            <option value="quizy">Quizy</option>
          </select>
        </div>
        <div>
          <label class="block text-sm font-semibold text-text-main mb-2">Status</label>
          <select 
            v-model="filterPublished"
            class="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
          >
            <option value="">Wszystkie</option>
            <option value="true">Opublikowane</option>
            <option value="false">Ukryte</option>
          </select>
        </div>
      </div>

      <!-- Pages List -->
      <div class="space-y-4">
        <div 
          v-for="page in filteredPages" 
          :key="page.id"
          class="border border-gray-200 rounded-lg p-4 hover:shadow-md transition-shadow"
        >
          <div class="flex justify-between items-start">
            <div class="flex-1">
              <div class="flex items-center gap-3 mb-2">
                <h3 class="text-lg font-bold text-text-main">{{ page.page_title }}</h3>
                <span 
                  :class="[
                    'px-2 py-1 rounded text-xs font-semibold',
                    page.is_published ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-700'
                  ]"
                >
                  {{ page.is_published ? 'Opublikowane' : 'Ukryte' }}
                </span>
                <span class="px-2 py-1 bg-blue-100 text-blue-700 rounded text-xs font-semibold">
                  {{ getCategoryLabel(page.page_category) }}
                </span>
              </div>
              <p class="text-sm text-gray-600">Slug: {{ page.page_slug }}</p>
              <p class="text-sm text-gray-600 mt-1">
                Sekcji: {{ page.content_sections?.length || 0 }} | 
                Ostatnia aktualizacja: {{ formatDate(page.updated_at) }}
              </p>
            </div>
            <button
              @click="editPage(page)"
              class="bg-primary text-white px-4 py-2 rounded-lg hover:opacity-90 transition-opacity text-sm font-semibold"
            >
              Edytuj
            </button>
          </div>
        </div>
      </div>

      <div v-if="filteredPages.length === 0" class="text-center py-8 text-gray-600">
        Nie znaleziono stron pasujących do filtrów.
      </div>
    </div>

    <!-- Edit Modal -->
    <div v-if="editingPage" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50 overflow-y-auto">
      <div class="bg-white rounded-lg max-w-4xl w-full my-8">
        <div class="p-6 max-h-[80vh] overflow-y-auto">
          <div class="flex justify-between items-start mb-6">
            <h3 class="text-2xl font-bold text-text-main">Edytuj: {{ editingPage.page_title }}</h3>
            <button @click="closeEdit" class="text-gray-500 hover:text-gray-700">
              <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>

          <form @submit.prevent="savePage" class="space-y-6">
            <!-- Page Title -->
            <div>
              <label class="block text-sm font-semibold text-text-main mb-2">Tytuł strony</label>
              <input
                v-model="editingPage.page_title"
                type="text"
                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
              />
            </div>

            <!-- Published Status -->
            <div class="flex items-center gap-3">
              <input
                type="checkbox"
                id="is_published"
                v-model="editingPage.is_published"
                class="w-5 h-5 text-primary border-gray-300 rounded focus:ring-primary"
              />
              <label for="is_published" class="text-sm font-semibold text-text-main">
                Strona opublikowana (widoczna na stronie)
              </label>
            </div>

            <!-- Content Sections -->
            <div class="border-t pt-6">
              <div class="flex justify-between items-center mb-4">
                <h4 class="text-lg font-bold text-text-main">Sekcje treści</h4>
                <button
                  type="button"
                  @click="addSection"
                  class="bg-green-500 text-white px-4 py-2 rounded-lg hover:bg-green-600 transition-colors text-sm font-semibold"
                >
                  + Dodaj sekcję
                </button>
              </div>

              <div class="space-y-6">
                <div 
                  v-for="(section, index) in editingPage.content_sections" 
                  :key="section.id"
                  class="border border-gray-200 rounded-lg p-4 bg-gray-50"
                >
                  <div class="flex justify-between items-start mb-4">
                    <h5 class="font-semibold text-gray-700">Sekcja {{ index + 1 }}</h5>
                    <button
                      type="button"
                      @click="removeSection(index)"
                      class="text-red-500 hover:text-red-700 text-sm font-semibold"
                    >
                      Usuń
                    </button>
                  </div>

                  <div class="space-y-3">
                    <div>
                      <label class="block text-sm font-semibold text-gray-700 mb-1">Tytuł sekcji</label>
                      <input
                        v-model="section.title"
                        type="text"
                        class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
                        placeholder="np. Wprowadzenie"
                      />
                    </div>

                    <div>
                      <label class="block text-sm font-semibold text-gray-700 mb-1">Treść</label>
                      <textarea
                        v-model="section.content"
                        rows="8"
                        class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary font-mono text-sm"
                        placeholder="Treść sekcji. Możesz używać formatowania:\n• Nowe linie\n• Listy z •\n• **pogrubienie** (opcjonalne w przyszłości)\n\nPo prostu pisz normalnie - formatowanie zostanie zachowane."
                      ></textarea>
                      <p class="text-xs text-gray-500 mt-1">
                        Tip: Używaj Enter dla nowych linii. Formatowanie będzie wyświetlone na stronie.
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Success/Error Messages -->
            <div v-if="successMessage" class="p-4 bg-green-100 border border-green-400 rounded-lg text-green-700 text-sm">
              {{ successMessage }}
            </div>
            <div v-if="errorMessage" class="p-4 bg-red-100 border border-red-400 rounded-lg text-red-700 text-sm">
              {{ errorMessage }}
            </div>

            <!-- Buttons -->
            <div class="flex gap-3 pt-4 border-t">
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
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { supabase } from '../../lib/supabaseClient'

const pages = ref([])
const loading = ref(true)
const editingPage = ref(null)
const saving = ref(false)
const successMessage = ref('')
const errorMessage = ref('')
const filterCategory = ref('')
const filterPublished = ref('')

const filteredPages = computed(() => {
  let filtered = pages.value

  if (filterCategory.value) {
    filtered = filtered.filter(p => p.page_category === filterCategory.value)
  }

  if (filterPublished.value) {
    filtered = filtered.filter(p => p.is_published === (filterPublished.value === 'true'))
  }

  return filtered
})

const getCategoryLabel = (category) => {
  const labels = {
    'main': 'Główne',
    'przepisy': 'Przepisy',
    'kursy': 'Kursy',
    'quizy': 'Quizy'
  }
  return labels[category] || category
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
  await loadPages()
})

const loadPages = async () => {
  loading.value = true
  try {
    const { data, error } = await supabase
      .from('page_contents')
      .select('*')
      .order('page_category')
      .order('page_title')

    if (error) throw error
    pages.value = data
  } catch (error) {
    console.error('Error loading pages:', error)
  } finally {
    loading.value = false
  }
}

const editPage = (page) => {
  editingPage.value = JSON.parse(JSON.stringify(page)) // Deep copy
  successMessage.value = ''
  errorMessage.value = ''
}

const closeEdit = () => {
  editingPage.value = null
  successMessage.value = ''
  errorMessage.value = ''
}

const addSection = () => {
  if (!editingPage.value.content_sections) {
    editingPage.value.content_sections = []
  }
  editingPage.value.content_sections.push({
    id: `section-${Date.now()}`,
    title: '',
    content: ''
  })
}

const removeSection = (index) => {
  if (confirm('Czy na pewno chcesz usunąć tę sekcję?')) {
    editingPage.value.content_sections.splice(index, 1)
  }
}

const savePage = async () => {
  saving.value = true
  successMessage.value = ''
  errorMessage.value = ''

  try {
    const { error } = await supabase
      .from('page_contents')
      .update({
        page_title: editingPage.value.page_title,
        is_published: editingPage.value.is_published,
        content_sections: editingPage.value.content_sections,
      })
      .eq('id', editingPage.value.id)

    if (error) throw error

    successMessage.value = 'Strona została zaktualizowana pomyślnie!'
    await loadPages()
    
    setTimeout(() => {
      closeEdit()
    }, 1500)
  } catch (error) {
    console.error('Error saving page:', error)
    errorMessage.value = 'Wystąpił błąd podczas zapisywania. Spróbuj ponownie.'
  } finally {
    saving.value = false
  }
}
</script>
