# 🎨 Dyrektywa v-editable - Edytuj KAŻDY tekst!

## 🚀 Jak używać

### Prosta edycja (bez zapisu do bazy):

```vue
<template>
  <h1 v-editable="{ label: 'Tytuł' }">
    Mój tytuł
  </h1>
  
  <p v-editable="{ label: 'Opis' }">
    To jest opis, który można edytować
  </p>
</template>
```

### Z zapisem do bazy:

```vue
<template>
  <h1 v-editable="{ 
    label: 'Tytuł główny',
    save: saveTitle 
  }">
    {{ pageData.title }}
  </h1>
</template>

<script setup>
import { ref } from 'vue'
import { useEditMode } from '../composables/useEditMode'

const pageData = ref({
  title: 'Mój tytuł'
})

const { saveSetting } = useEditMode()

const saveTitle = async (newValue) => {
  pageData.value.title = newValue
  await saveSetting('page_title', newValue)
}
</script>
```

---

## 📋 Przykłady użycia

### Navbar:
```vue
<router-link 
  to="/o-nas" 
  v-editable="{ label: 'Link O nas' }"
>
  O NAS
</router-link>
```

### Contact:
```vue
<h3 v-editable="{ 
  label: 'Telefon',
  save: (val) => saveSetting('contact_phone', val)
}">
  {{ settings.phone }}
</h3>
```

### Dowolny tekst:
```vue
<p v-editable="{ label: 'Akapit' }">
  Dowolny tekst na stronie
</p>

<span v-editable="{ label: 'Cena' }">
  1200 PLN
</span>

<div v-editable="{ label: 'Sekcja' }">
  Cała sekcja tekstu
</div>
```

---

## ⚙️ Opcje dyrektywy

```javascript
v-editable="{
  label: 'Nazwa pola',     // Wyświetlana w tooltip (WYMAGANE)
  save: async (val) => {}  // Funkcja zapisu (OPCJONALNE)
}"
```

### Tylko label (bez zapisu):
- Element będzie edytowalny
- Zmiany będą widoczne tylko do odświeżenia strony
- Przydatne do testowania

### Z funkcją save:
- Element będzie edytowalny
- Zmiany zostaną zapisane do bazy
- Persystentne zmiany

---

## 🎯 Jak działa?

1. **Tryb normalny:**
   - Tekst wygląda normalnie
   - Nie można klikać

2. **Tryb edycji włączony:**
   - Hover → pomarańczowa ramka + tooltip
   - Klik → zaznacza tekst, można edytować
   - Blur/Enter → zapisuje zmiany

3. **Wizualne wskazówki:**
   - Hover: "✏️ [Label] - Kliknij"
   - Edit: "💾 Zapisz (kliknij poza)"

---

## 🔥 Masowa edycja - przykład Contact.vue

```vue
<template>
  <!-- Telefon -->
  <h3 v-editable="{ 
    label: 'Telefon',
    save: (v) => saveSetting('contact_phone', v)
  }">
    {{ settings.phone }}
  </h3>
  
  <!-- Adres ulica -->
  <p v-editable="{ 
    label: 'Ulica',
    save: (v) => saveSetting('contact_address_street', v)
  }">
    {{ settings.street }}
  </p>
  
  <!-- Adres miasto -->
  <p v-editable="{ 
    label: 'Miasto',
    save: (v) => saveSetting('contact_address_city', v)
  }">
    {{ settings.city }}
  </p>
  
  <!-- NIP -->
  <p v-editable="{ 
    label: 'NIP',
    save: (v) => saveSetting('company_nip', v)
  }">
    {{ settings.nip }}
  </p>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useEditMode } from '../composables/useEditMode'
import { supabase } from '../lib/supabaseClient'

const settings = ref({
  phone: '',
  street: '',
  city: '',
  nip: ''
})

const { saveSetting } = useEditMode()

onMounted(async () => {
  // Load settings from database
  const { data } = await supabase
    .from('site_settings')
    .select('*')
  
  // Map to settings object
  data.forEach(s => {
    if (s.setting_key === 'contact_phone') settings.value.phone = s.setting_value
    if (s.setting_key === 'contact_address_street') settings.value.street = s.setting_value
    // etc...
  })
})
</script>
```

---

## ✨ Zalety

### Przed (z EditableElement):
```vue
<EditableElement
  tag="h1"
  original-class="text-5xl font-bold"
  :model-value="title"
  :save-callback="saveTitle"
  label="Tytuł"
>
  {{ title }}
</EditableElement>
```

### Po (z v-editable):
```vue
<h1 
  class="text-5xl font-bold"
  v-editable="{ label: 'Tytuł', save: saveTitle }"
>
  {{ title }}
</h1>
```

**Prościej, czytelniej, mniej kodu!**

---

## 🎨 Możesz teraz edytować:

- ✅ Każdy `<h1>`, `<h2>`, `<h3>`
- ✅ Każdy `<p>`, `<span>`, `<div>` z tekstem
- ✅ Linki `<a>`
- ✅ Buttony z tekstem
- ✅ Dosłownie KAŻDY element HTML z tekstem!

---

## 🚀 Next Steps

Teraz możesz dodać `v-editable` do:

1. **AboutSection.vue** - wszystkie teksty
2. **Contact.vue** - telefon, adres, NIP
3. **Navbar.vue** - nazwy linków
4. **Footer.vue** - teksty stopki
5. **Strony przepisów** - wszystkie paragrafy
6. **Kursy** - ceny, daty, opisy

Wystarczy dodać jedną dyrektywę i gotowe! 🎉

---

**Dokumentacja:** `V_EDITABLE_GUIDE.md`
