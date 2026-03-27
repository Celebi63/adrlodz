<template>
  <div>
    <div v-if="loading" class="text-center py-8">
      <p class="text-gray-600">Ładowanie ustawień...</p>
    </div>

    <form v-else @submit.prevent="saveSettings" class="space-y-6">
      <!-- Contact Settings -->
      <div class="border border-gray-200 rounded-lg p-6">
        <h3 class="text-lg font-bold text-text-main mb-4">Dane Kontaktowe</h3>
        <div class="space-y-4">
          <div v-for="setting in contactSettings" :key="setting.setting_key">
            <label class="block text-sm font-semibold text-text-main mb-2">
              {{ setting.label }}
            </label>
            <input
              v-model="setting.setting_value"
              :type="setting.setting_type"
              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
            />
          </div>
        </div>
      </div>

      <!-- Company Settings -->
      <div class="border border-gray-200 rounded-lg p-6">
        <h3 class="text-lg font-bold text-text-main mb-4">Dane Firmy</h3>
        <div class="space-y-4">
          <div v-for="setting in companySettings" :key="setting.setting_key">
            <label class="block text-sm font-semibold text-text-main mb-2">
              {{ setting.label }}
            </label>
            <input
              v-model="setting.setting_value"
              :type="setting.setting_type"
              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
            />
          </div>
        </div>
      </div>

      <!-- Stats Settings -->
      <div class="border border-gray-200 rounded-lg p-6">
        <h3 class="text-lg font-bold text-text-main mb-4">Statystyki</h3>
        <div class="space-y-4">
          <div v-for="setting in statsSettings" :key="setting.setting_key">
            <label class="block text-sm font-semibold text-text-main mb-2">
              {{ setting.label }}
            </label>
            <input
              v-model="setting.setting_value"
              type="text"
              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
            />
          </div>
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
        {{ saving ? 'Zapisywanie...' : 'Zapisz wszystkie ustawienia' }}
      </button>
    </form>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { supabase } from '../../lib/supabaseClient'

const settings = ref([])
const loading = ref(true)
const saving = ref(false)
const successMessage = ref('')
const errorMessage = ref('')

const contactSettings = computed(() => 
  settings.value.filter(s => s.category === 'contact')
)

const companySettings = computed(() => 
  settings.value.filter(s => s.category === 'company')
)

const statsSettings = computed(() => 
  settings.value.filter(s => s.category === 'stats')
)

onMounted(async () => {
  await loadSettings()
})

const loadSettings = async () => {
  loading.value = true
  try {
    const { data, error } = await supabase
      .from('site_settings')
      .select('*')
      .order('category')

    if (error) throw error
    settings.value = data
  } catch (error) {
    console.error('Error loading settings:', error)
  } finally {
    loading.value = false
  }
}

const saveSettings = async () => {
  saving.value = true
  successMessage.value = ''
  errorMessage.value = ''

  try {
    // Update each setting
    for (const setting of settings.value) {
      const { error } = await supabase
        .from('site_settings')
        .update({ setting_value: setting.setting_value })
        .eq('setting_key', setting.setting_key)

      if (error) throw error
    }

    successMessage.value = 'Wszystkie ustawienia zostały zapisane pomyślnie!'
    
    setTimeout(() => {
      successMessage.value = ''
    }, 3000)
  } catch (error) {
    console.error('Error saving settings:', error)
    errorMessage.value = 'Wystąpił błąd podczas zapisywania. Spróbuj ponownie.'
  } finally {
    saving.value = false
  }
}
</script>
