<template>
  <div v-if="loading" class="min-h-screen flex items-center justify-center">
    <p class="text-gray-600">Ładowanie...</p>
  </div>

  <div v-else-if="pageData">
    <section class="bg-gradient-to-r from-primary to-orange-600 text-white py-8 px-8">
      <div class="mx-auto max-w-[1440px]">
        <h1 
          class="text-3xl md:text-4xl font-bold"
          v-editable="{ 
            label: 'Tytuł strony',
            save: (v) => savePageTitle(v)
          }"
        >
          {{ pageData.page_title }}
        </h1>
      </div>
    </section>

    <section class="py-16 px-8 bg-white">
      <div class="mx-auto max-w-[1440px]">
        <div 
          v-for="(section, index) in pageData.content_sections" 
          :key="section.id" 
          class="mb-12 last:mb-0"
        >
          <h2 
            v-if="section.title"
            class="text-2xl font-bold text-text-main mb-4"
            v-editable="{ 
              label: 'Tytuł sekcji ' + (index + 1),
              save: (v) => saveSectionTitle(index, v)
            }"
          >
            {{ section.title }}
          </h2>
          <div 
            class="text-gray-700 whitespace-pre-line leading-relaxed prose max-w-none"
            v-editable="{ 
              label: 'Treść sekcji ' + (index + 1),
              save: (v) => saveSectionContent(index, v)
            }"
          >{{ section.content }}</div>
        </div>
      </div>
    </section>

    <Contact />
  </div>

  <div v-else class="min-h-screen flex items-center justify-center">
    <p class="text-gray-600">Strona nie została znaleziona.</p>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { supabase } from '../../lib/supabaseClient'
import Contact from '../../components/Contact.vue'

const PAGE_SLUG = 'przepisy-zagrozenia'

const pageData = ref(null)
const loading = ref(true)

onMounted(async () => {
  await loadPageContent()
})

const loadPageContent = async () => {
  try {
    const { data, error } = await supabase
      .from('page_contents')
      .select('*')
      .eq('page_slug', PAGE_SLUG)
      .eq('is_published', true)
      .single()

    if (error) throw error
    pageData.value = data
  } catch (error) {
    console.error('Error loading page:', error)
  } finally {
    loading.value = false
  }
}

const savePageTitle = async (newValue) => {
  pageData.value.page_title = newValue
  await supabase
    .from('page_contents')
    .update({ page_title: newValue })
    .eq('id', pageData.value.id)
}

const saveSectionTitle = async (index, newValue) => {
  pageData.value.content_sections[index].title = newValue
  await supabase
    .from('page_contents')
    .update({ content_sections: pageData.value.content_sections })
    .eq('id', pageData.value.id)
}

const saveSectionContent = async (index, newValue) => {
  pageData.value.content_sections[index].content = newValue
  await supabase
    .from('page_contents')
    .update({ content_sections: pageData.value.content_sections })
    .eq('id', pageData.value.id)
}
</script>
