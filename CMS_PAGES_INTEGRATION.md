# Integracja CMS ze stronami - Instrukcja

## 🎯 Co zostało dodane?

### Nowa funkcjonalność:
✅ Tabela `page_contents` w bazie danych  
✅ Komponent `PagesManager` w panelu admina  
✅ Możliwość edycji wszystkich podstron  
✅ System sekcji - każda strona może mieć wiele sekcji z tytułami i treścią  
✅ Publikowanie/ukrywanie stron  
✅ Filtrowanie po kategorii  

---

## 📋 Krok po kroku - Instalacja

### 1. Uruchom nowy skrypt SQL
```sql
-- W Supabase SQL Editor wykonaj:
```
Otwórz plik `supabase_cms_pages_extension.sql` i uruchom go w Supabase.

### 2. Zweryfikuj instalację
Sprawdź czy w Supabase → Table Editor pojawiła się tabela `page_contents`

### 3. Przetestuj panel
1. Zaloguj się do `/admin/dashboard`
2. Kliknij zakładkę **"Strony"**
3. Powinieneś zobaczyć listę stron do edycji

---

## 🔧 Jak używać w panelu admina?

### Edycja strony:
1. Kliknij **"Edytuj"** przy wybranej stronie
2. Możesz zmienić:
   - **Tytuł strony**
   - **Status publikacji** (widoczna/ukryta)
   - **Sekcje treści** - każda sekcja ma:
     - Tytuł sekcji
     - Treść (wielolinijkowa)

### Zarządzanie sekcjami:
- **Dodaj sekcję**: Kliknij "+ Dodaj sekcję"
- **Usuń sekcję**: Kliknij "Usuń" przy sekcji
- **Edytuj treść**: Po prostu wpisz tekst w pole tekstowe

### Formatowanie treści:
```
• Używaj Enter dla nowych linii
• Używaj • dla list
• Akapity są automatycznie rozdzielane

Przykład:
To jest pierwszy akapit.

To jest drugi akapit po pustej linii.

• Punkt pierwszy
• Punkt drugi
• Punkt trzeci
```

---

## 🔌 Integracja z frontendem - TODO

Aby strony zaczęły pobierać dane z CMS, musisz zaktualizować komponenty Vue:

### Przykład: Strona "O nas" (ONas.vue)

**PRZED (hardcoded):**
```vue
<template>
  <div>
    <section class="bg-gradient-to-r from-primary to-orange-600 text-white py-8 px-8">
      <div class="mx-auto max-w-[1440px]">
        <h1 class="text-3xl md:text-4xl font-bold">O nas</h1>
      </div>
    </section>

    <section class="py-16 px-8 bg-white">
      <div class="mx-auto max-w-[1440px]">
        <h2 class="text-3xl font-bold text-text-main mb-6">
          ADR Łódź - Twój partner w szkoleniach
        </h2>
        <p class="text-lg text-gray-700">
          Jesteśmy doświadczonym ośrodkiem...
        </p>
      </div>
    </section>
  </div>
</template>
```

**PO (z CMS):**
```vue
<template>
  <div>
    <section class="bg-gradient-to-r from-primary to-orange-600 text-white py-8 px-8">
      <div class="mx-auto max-w-[1440px]">
        <h1 class="text-3xl md:text-4xl font-bold">{{ pageData?.page_title }}</h1>
      </div>
    </section>

    <section class="py-16 px-8 bg-white">
      <div class="mx-auto max-w-[1440px]">
        <div v-for="section in pageData?.content_sections" :key="section.id" class="mb-12">
          <h2 class="text-3xl font-bold text-text-main mb-6">
            {{ section.title }}
          </h2>
          <div class="text-lg text-gray-700 whitespace-pre-line">
            {{ section.content }}
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { supabase } from '../lib/supabaseClient'

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
      .eq('page_slug', 'o-nas')
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
</script>
```

### Szablon dla stron przepisów:

```vue
<template>
  <div v-if="loading" class="min-h-screen flex items-center justify-center">
    <p class="text-gray-600">Ładowanie...</p>
  </div>

  <div v-else-if="pageData">
    <!-- Header -->
    <section class="bg-gradient-to-r from-primary to-orange-600 text-white py-8 px-8">
      <div class="mx-auto max-w-[1440px]">
        <h1 class="text-3xl md:text-4xl font-bold">{{ pageData.page_title }}</h1>
      </div>
    </section>

    <!-- Content -->
    <section class="py-16 px-8 bg-white">
      <div class="mx-auto max-w-[1440px]">
        <div 
          v-for="section in pageData.content_sections" 
          :key="section.id" 
          class="mb-12 last:mb-0"
        >
          <h2 v-if="section.title" class="text-2xl font-bold text-text-main mb-4">
            {{ section.title }}
          </h2>
          <div class="text-gray-700 whitespace-pre-line leading-relaxed">
            {{ section.content }}
          </div>
        </div>
      </div>
    </section>

    <Contact />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { supabase } from '../../lib/supabaseClient'
import Contact from '../../components/Contact.vue'

// Zmień slug na odpowiedni dla każdej strony
const PAGE_SLUG = 'przepisy-zwolnienia' // lub 'przepisy-wstep', 'przepisy-klasyfikacja', etc.

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
</script>
```

---

## 📊 Mapowanie slug → strona

| Slug | Plik | Route |
|------|------|-------|
| `o-nas` | ONas.vue | /o-nas |
| `przepisy-wstep` | przepisy/Wstep.vue | /przepisy/wstep |
| `przepisy-klasyfikacja` | przepisy/Klasyfikacja.vue | /przepisy/klasyfikacja |
| `przepisy-zwolnienia` | przepisy/Zwolnienia.vue | /przepisy/zwolnienia |
| `przepisy-oznakowanie` | przepisy/Oznakowanie.vue | /przepisy/oznakowanie |
| `przepisy-zagrozenia` | przepisy/Zagrozenia.vue | /przepisy/zagrozenia |
| `przepisy-tunele` | przepisy/Tunele.vue | /przepisy/tunele |
| `przepisy-dokument-przewozowy` | przepisy/DokumentPrzewozowy.vue | /przepisy/dokument-przewozowy |
| `przepisy-instrukcja` | przepisy/Instrukcja.vue | /przepisy/instrukcja |
| `przepisy-cysterny` | przepisy/Cysterny.vue | /przepisy/cysterny |
| `przepisy-hierarchizacja` | przepisy/Hierarchizacja.vue | /przepisy/hierarchizacja |
| `przepisy-klasa-1` | przepisy/Klasa1.vue | /przepisy/klasa-1 |
| `przepisy-klasa-7` | przepisy/Klasa7.vue | /przepisy/klasa-7 |

---

## ✨ Funkcje CMS dla stron

### Co możesz edytować:
✅ Tytuły stron  
✅ Pełną treść każdej podstrony  
✅ Wiele sekcji na jednej stronie  
✅ Status publikacji (ukryj stronę tymczasowo)  

### Formatowanie:
- ✅ Wieloliniowe teksty
- ✅ Listy punktowane (użyj •)
- ✅ Akapity (puste linie)
- 🔄 W przyszłości: Markdown, pogrubienia, linki

---

## 🎨 Style CSS dla treści

Aby treść wyglądała dobrze, dodaj klasę `whitespace-pre-line` do elementu z treścią:

```vue
<div class="whitespace-pre-line">
  {{ section.content }}
</div>
```

To zachowuje znaki nowej linii i formatowanie.

---

## 🚀 Kolejne kroki

1. ✅ Uruchom `supabase_cms_pages_extension.sql`
2. ✅ Przetestuj panel admina - zakładka "Strony"
3. ⏳ Zaktualizuj komponenty Vue aby pobierały dane z CMS
4. ⏳ Wypełnij treść stron przez panel admina
5. ⏳ Przetestuj na produkcji

---

## 💡 Wskazówki

- **Backup**: Przed migracją zrób kopię obecnej treści stron
- **Stopniowo**: Możesz migrować strony po kolei, nie wszystkie naraz
- **Testuj**: Po każdej zmianie sprawdź czy strona wyświetla się poprawnie
- **Formatowanie**: Używaj Enter dla nowych linii - będą zachowane na stronie

---

**Gotowe!** Teraz masz pełną kontrolę nad treścią wszystkich stron przez panel admina! 🎉
