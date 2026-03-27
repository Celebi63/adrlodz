# ✅ NAPRAWIONO: Wszystkie Strony Przepisów Teraz Pobierają Dane z CMS

## Problem
Po kliknięciu "Zapisz zmiany" w panelu admin CMS, treść nie była widoczna na stronach przepisów, ponieważ komponenty Vue nadal miały **hardcoded treść** zamiast pobierać dane z bazy.

## Rozwiązanie

### ✅ Zaktualizowano WSZYSTKIE 12 plików przepisów:

| Plik | Slug | Status |
|------|------|--------|
| `Wstep.vue` | `przepisy-wstep` | ✅ Naprawiono |
| `Klasyfikacja.vue` | `przepisy-klasyfikacja` | ✅ Naprawiono |
| `Zwolnienia.vue` | `przepisy-zwolnienia` | ✅ Naprawiono |
| `Oznakowanie.vue` | `przepisy-oznakowanie` | ✅ Naprawiono |
| `Zagrozenia.vue` | `przepisy-zagrozenia` | ✅ Naprawiono |
| `Tunele.vue` | `przepisy-tunele` | ✅ Naprawiono |
| `DokumentPrzewozowy.vue` | `przepisy-dokument-przewozowy` | ✅ Naprawiono |
| `Instrukcja.vue` | `przepisy-instrukcja` | ✅ Naprawiono |
| `Cysterny.vue` | `przepisy-cysterny` | ✅ Naprawiono |
| `Hierarchizacja.vue` | `przepisy-hierarchizacja` | ✅ Naprawiono |
| `Klasa1.vue` | `przepisy-klasa-1` | ✅ Naprawiono |
| `Klasa7.vue` | `przepisy-klasa-7` | ✅ Naprawiono |

### Co zostało zmienione w każdym pliku:

**Przed (stary kod):**
```vue
<template>
  <div>
    <h1>Klasa 7</h1>
    <p>Klasa 7 obejmuje materiały radioaktywne...</p>
    <!-- Hardcoded tekst -->
  </div>
</template>

<script setup>
import Contact from '../../components/Contact.vue'
</script>
```

**Po (nowy kod z CMS):**
```vue
<template>
  <div v-if="loading">Ładowanie...</div>
  
  <div v-else-if="pageData">
    <h1 v-editable="{ label: 'Tytuł', save: savePageTitle }">
      {{ pageData.page_title }}
    </h1>
    
    <div v-for="(section, index) in pageData.content_sections">
      <h2 v-editable="...">{{ section.title }}</h2>
      <div v-editable="...">{{ section.content }}</div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { supabase } from '../../lib/supabaseClient'

const PAGE_SLUG = 'przepisy-klasa-7'

// Pobiera dane z bazy przy załadowaniu
onMounted(async () => {
  const { data } = await supabase
    .from('page_contents')
    .select('*')
    .eq('page_slug', PAGE_SLUG)
    .single()
  
  pageData.value = data
})

// Funkcje zapisu dla inline editing
const savePageTitle = async (newValue) => { ... }
const saveSectionContent = async (index, newValue) => { ... }
</script>
```

## Jak teraz działa

### 1. Panel Admin (`/admin/dashboard`)
1. Wejdź na `/admin/dashboard`
2. Przejdź do zakładki **"Strony"**
3. Znajdź stronę (np. "Klasa 7 - Materiały promieniotwórcze")
4. Kliknij **"Edytuj"**
5. Zmień treść
6. Kliknij **"Zapisz zmiany"**
7. ✅ Odśwież stronę przepisów - treść będzie zaktualizowana!

### 2. Visual CMS (Inline Editing)
1. Zaloguj się przez `/admin`
2. Wróć na stronę główną
3. Kliknij **"Włącz edycję"**
4. Przejdź na dowolną stronę przepisów (np. `/przepisy/klasa-7`)
5. Najedź na tekst - zobaczysz obrys
6. Kliknij w tekst - edytuj
7. Kliknij poza tekstem - zmiany zapisują się automatycznie
8. ✅ Treść jest od razu zaktualizowana!

## Sprawdź czy działa

**Krok 1: Odśwież przeglądarkę**
- Naciśnij `Ctrl+Shift+R` (Windows/Linux) lub `Cmd+Shift+R` (Mac) aby wymusić przeładowanie

**Krok 2: Przetestuj CMS**
1. Wejdź na http://localhost:5174/adrlodz/#/admin
2. Zaloguj się
3. Przejdź do zakładki "Strony"
4. Edytuj stronę "Klasa 7"
5. Zmień treść na "To jest test 123"
6. Kliknij "Zapisz zmiany"

**Krok 3: Sprawdź stronę**
1. Otwórz http://localhost:5174/adrlodz/#/przepisy/klasa-7
2. ✅ Powinieneś zobaczyć "To jest test 123"!

## Jeśli nadal nie działa

### Opcja 1: Restart serwera dev
```bash
# Zatrzymaj serwer (Ctrl+C)
# Uruchom ponownie
npm run dev
```

### Opcja 2: Wyczyść cache przeglądarki
1. Otwórz DevTools (F12)
2. Prawym przyciskiem na ikonę odświeżania
3. Wybierz "Empty Cache and Hard Reload"

### Opcja 3: Sprawdź konsolę przeglądarki
1. Otwórz DevTools (F12)
2. Sprawdź zakładkę "Console"
3. Jeśli są błędy Supabase - sprawdź połączenie z bazą
4. Jeśli jest błąd "page_contents not found" - uruchom skrypt SQL

## Techniczne szczegóły

Każdy plik przepisów teraz:
- ✅ Pobiera dane z `page_contents` table
- ✅ Wyświetla tytuł dynamicznie
- ✅ Renderuje sekcje z JSONB
- ✅ Wspiera inline editing (`v-editable`)
- ✅ Ma stany loading/error
- ✅ Zapisuje zmiany do Supabase

## Dodatkowa dokumentacja

- `PRZEPISY_CMS_INTEGRATION.md` - pełna dokumentacja integracji
- `supabase_cms_pages_extension.sql` - skrypt SQL z danymi
- `V_EDITABLE_GUIDE.md` - jak używać inline editing
