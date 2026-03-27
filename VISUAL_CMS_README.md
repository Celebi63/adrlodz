# 🎨 Visual CMS - Edycja Inline (jak WordPress)

## 🌟 Nowa funkcjonalność!

Właśnie dodałem **Visual CMS** - system edycji inline, który działa jak WordPress! Możesz teraz:

✅ **Widzieć prawdziwą stronę** podczas edycji  
✅ **Klikać na elementy** aby je edytować (jak w Wordzie)  
✅ **Panel po lewej stronie** z informacjami i opcjami  
✅ **Automatyczne zapisywanie** zmian do bazy  
✅ **Wizualne podświetlenie** edytowalnych elementów  

---

## 🚀 Jak to działa?

### 1. Zaloguj się
```
1. Zaloguj się do /admin/login
2. Wróć na stronę główną
```

### 2. Włącz tryb edycji
```
W lewym górnym rogu zobaczysz przycisk:
"Włącz edycję" 🖊️

Kliknij go!
```

### 3. Edytuj na żywo
```
• Panel po lewej stronie się wysunie
• Edytowalne elementy będą podświetlone na hover
• Kliknij na dowolny tekst aby go edytować
• Edytuj jak w Wordzie
• Kliknij poza elementem aby zapisać
```

### 4. Wyłącz tryb edycji
```
Kliknij "Wyłącz edycję" w lewym górnym rogu
lub w panelu po lewej
```

---

## 🎯 Co zostało dodane?

### Nowe komponenty:

1. **`EditModePanel.vue`** - Panel po lewej stronie
   - Informacje o użytkowniku
   - Bieżąca strona
   - Szybkie akcje
   - Status zapisywania
   - Wylogowanie

2. **`EditableElement.vue`** - Komponent wrapper
   - Każdy element owinięty tym komponentem można edytować
   - Wizualne podświetlenie na hover
   - Inline editing
   - Automatyczny zapis

3. **`useEditMode.js`** - Composable
   - Globalny stan trybu edycji
   - Funkcje zapisywania
   - Autentykacja

---

## 📝 Jak użyć w komponentach?

### Przykład - Hero Section:

```vue
<template>
  <EditableElement
    tag="h1"
    original-class="text-5xl font-bold"
    :model-value="heroContent.title"
    :save-callback="(value) => saveHeroField('title', value)"
    label="Tytuł główny"
  >
    {{ heroContent.title }}
  </EditableElement>
</template>

<script setup>
import EditableElement from './EditableElement.vue'
import { useEditMode } from '../composables/useEditMode'

const { saveHeroContent } = useEditMode()

const saveHeroField = async (field, value) => {
  heroContent.value[field] = value
  await saveHeroContent(heroContent.value.id, { [field]: value })
}
</script>
```

### Props `EditableElement`:

```javascript
{
  tag: 'h1',                    // HTML tag (h1, p, span, div, etc.)
  originalClass: 'text-xl',     // Klasy CSS
  modelValue: 'Tytuł',          // Wartość tekstowa
  saveCallback: async (val) => {},  // Funkcja zapisu
  label: 'Tytuł główny',        // Label dla panelu
  editable: true                // Czy edytowalne (default: true)
}
```

---

## 🎨 Style wizualne

### Element edytowalny:
- **Hover**: Pomarańczowa przerywana ramka
- **Klik**: Solid pomarańczowa ramka + contenteditable
- **Tooltip**: "✏️ Kliknij aby edytować" / "💾 Kliknij poza aby zapisać"

### Panel:
- **Szerokość**: 320px (20rem)
- **Pozycja**: Przyklejony do lewej krawędzi
- **Animacja**: Slide-in/out
- **Z-index**: 99 (nad wszystkim)

---

## 🔧 Integracja z istniejącymi stronami

### Krok 1: Import komponentów

```vue
<script setup>
import EditableElement from '../components/EditableElement.vue'
import { useEditMode } from '../composables/useEditMode'
</script>
```

### Krok 2: Owijanie elementów

**Przed:**
```vue
<h1 class="text-4xl font-bold">{{ pageData.title }}</h1>
```

**Po:**
```vue
<EditableElement
  tag="h1"
  original-class="text-4xl font-bold"
  :model-value="pageData.title"
  :save-callback="(val) => savePage('title', val)"
  label="Tytuł strony"
>
  {{ pageData.title }}
</EditableElement>
```

### Krok 3: Funkcje zapisu

```javascript
const { savePageSection } = useEditMode()

const savePage = async (field, value) => {
  pageData.value[field] = value
  await savePageSection(pageData.value.id, pageData.value.content_sections)
}
```

---

## 📂 Nowe pliki:

```
src/
├── composables/
│   └── useEditMode.js              ← Composable trybu edycji
├── components/
│   ├── EditModePanel.vue           ← Panel po lewej
│   ├── EditableElement.vue         ← Edytowalny element
│   └── HeroInlineEdit.vue          ← Przykład Hero z edycją
└── App.vue                         ← Zaktualizowany (panel dodany)
```

---

## ✨ Funkcje

### Panel po lewej:
✅ Informacje o zalogowanym użytkowniku  
✅ Nazwa bieżącej strony  
✅ Wskaźnik zapisywania  
✅ Info o edytowanym elemencie  
✅ Szybkie linki (dashboard, home)  
✅ Przycisk wylogowania  

### Edytowalne elementy:
✅ Wizualne podświetlenie  
✅ Contenteditable po kliknięciu  
✅ Automatyczny zapis po blur  
✅ Tooltips z instrukcjami  
✅ Animacje i transitions  

### Globalny stan:
✅ `isEditMode` - czy tryb edycji włączony  
✅ `isAuthenticated` - czy użytkownik zalogowany  
✅ `isSaving` - czy trwa zapisywanie  
✅ `editingElement` - co jest edytowane  

---

## 🎬 Workflow użytkownika

1. **Logowanie** → `/admin/login`
2. **Wejście na stronę** → np. `/`
3. **Kliknięcie** "Włącz edycję" w lewym górnym rogu
4. **Panel** wyjeżdża z lewej strony
5. **Strona** przesuwa się w prawo (margin-left: 320px)
6. **Hover** nad tekstem → widoczna pomarańczowa ramka
7. **Klik** na tekst → contenteditable włączone
8. **Edycja** tekstu jak w Wordzie
9. **Klik** poza elementem → zapis do bazy
10. **Komunikat** "Zapisywanie..." w panelu
11. **Wyłączenie** trybu edycji → panel znika

---

## 🔐 Bezpieczeństwo

- ✅ Tylko zalogowani użytkownicy widzą przycisk "Włącz edycję"
- ✅ Tryb edycji wymaga autentykacji
- ✅ Wszystkie zapisy przez Supabase RLS
- ✅ Tylko admin może modyfikować dane

---

## 📱 Responsywność

- 🖥️ **Desktop**: Panel 320px po lewej, treść z prawej
- 📱 **Mobile**: Do rozważenia - może panel na całą szerokość?
- ⚙️ **Opcja**: Panel można zwinąć/rozwinąć (TODO)

---

## 🚧 TODO - Przyszłe rozszerzenia

- [ ] Obsługa mobile (panel fullwidth)
- [ ] Przycisk zwijania panelu
- [ ] Historia zmian (undo/redo)
- [ ] Wersjonowanie treści
- [ ] Podgląd przed zapisem
- [ ] Rich text editor (pogrubienia, linki)
- [ ] Upload obrazków inline
- [ ] Drag & drop sekcji
- [ ] Kopiowanie stylów
- [ ] Eksport/import treści

---

## 🎯 Przykłady stron do konwersji

### Gotowe do użycia:
✅ `HeroInlineEdit.vue` - Hero section z inline edycją

### Do zaktualizowania:
⏳ `AboutSection.vue` - Sekcja o nas  
⏳ `Contact.vue` - Dane kontaktowe  
⏳ Wszystkie podstrony przepisów  
⏳ Strony kursów  

---

## 💡 Porady

### Dla deweloperów:
1. Owij każdy edytowalny element w `EditableElement`
2. Zawsze podaj `label` dla lepszej UX
3. Dodaj funkcję `saveCallback`
4. Zachowaj oryginalne klasy CSS w `originalClass`
5. Testuj zapis do bazy

### Dla administratorów:
1. Zawsze włączaj tryb edycji przed edycją
2. Klikaj poza element aby zapisać
3. Czekaj na potwierdzenie zapisu
4. Odśwież stronę aby zobaczyć zmiany innych
5. Wyloguj się po skończeniu

---

## 🎉 Podsumowanie

**Masz teraz prawdziwy Visual CMS jak w WordPress!**

- ✅ Edycja inline
- ✅ Panel po lewej stronie
- ✅ Wizualne podświetlenie
- ✅ Automatyczny zapis
- ✅ Prosty i intuicyjny

**Następny krok:** Zaktualizuj komponenty aby używały `EditableElement`!

Zobacz `HeroInlineEdit.vue` jako przykład referencyjny.

---

**Pytania?** Sprawdź kod w:
- `useEditMode.js` - Logika
- `EditModePanel.vue` - UI panelu
- `EditableElement.vue` - Wrapper
- `HeroInlineEdit.vue` - Przykład
