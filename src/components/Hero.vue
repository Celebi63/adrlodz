<template>
  <section class="relative w-full h-[600px] overflow-hidden">
    <!-- Background Image -->
    <div class="absolute inset-0">
      <img 
        src="../assets/truck.png" 
        alt="Ciężarówka ADR" 
        class="w-full h-full object-cover object-center"
      />
      <!-- Overlay for better text readability -->
      <div class="absolute inset-0 bg-black/30"></div>
    </div>

    <!-- Content -->
    <div class="relative h-full mx-auto max-w-[1440px] px-8 flex items-center">
      <div class="text-white max-w-2xl">
        <EditableElement
          tag="h1"
          original-class="text-5xl md:text-6xl font-bold mb-6 leading-tight"
          :model-value="heroContent.title"
          :save-callback="(value) => saveHeroField('title', value)"
          label="Tytuł główny"
        >
          {{ heroContent.title }}
        </EditableElement>
        
        <div class="text-lg md:text-xl mb-6 space-y-2">
          <p>
            Najbliższy kurs podstawowy: 
            <EditableElement
              tag="span"
              original-class="font-semibold"
              :model-value="heroContent.next_course_date"
              :save-callback="(value) => saveHeroField('next_course_date', value)"
              label="Data najbliższego kursu"
            >
              {{ heroContent.next_course_date }}
            </EditableElement>
          </p>
          <p>
            Egzamin: 
            <EditableElement
              tag="span"
              original-class="font-semibold"
              :model-value="heroContent.exam_date"
              :save-callback="(value) => saveHeroField('exam_date', value)"
              label="Data egzaminu"
            >
              {{ heroContent.exam_date }}
            </EditableElement>
          </p>
          <EditableElement
            tag="p"
            :model-value="heroContent.registration_deadline"
            :save-callback="(value) => saveHeroField('registration_deadline', value)"
            label="Termin zgłoszeń"
          >
            {{ heroContent.registration_deadline }}
          </EditableElement>
        </div>
        
        <div>
          <button 
            @click="scrollToRegistration"
            class="bg-primary text-white px-8 py-4 text-lg font-semibold hover:opacity-90 hover:scale-105 transition-all uppercase rounded-lg"
          >
            Zapisz się na ten kurs
          </button>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { supabase } from '../lib/supabaseClient'
import EditableElement from './EditableElement.vue'
import { useEditMode } from '../composables/useEditMode'

// Hero section with truck background image
const heroContent = ref({
  id: null,
  title: 'Kursy ADR Łódź',
  next_course_date: '15-17 Lutego 2025',
  exam_date: '18 Lutego 2025',
  registration_deadline: 'Zgłoszenia do czwartku włącznie.'
})

const { saveHeroContent } = useEditMode()

onMounted(async () => {
  // Load hero content from database
  await loadHeroContent()
})

const loadHeroContent = async () => {
  try {
    const { data, error } = await supabase
      .from('hero_content')
      .select('*')
      .eq('is_active', true)
      .single()

    if (error) throw error
    if (data) {
      heroContent.value = data
    }
  } catch (error) {
    console.error('Error loading hero content:', error)
  }
}

const saveHeroField = async (field, value) => {
  heroContent.value[field] = value
  await saveHeroContent(heroContent.value.id, { [field]: value })
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

<style scoped>
/* Additional custom styles if needed */
</style>

