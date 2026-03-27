# ✅ FORMULARZ ZAPISU - ZMIANY

## 🎯 Co się zmieniło?

### Przed:
- Osobne formularze dla każdego kursu
- Tytuł: "Zapis na kurs podstawowy ADR" (statyczny)
- Kurs był ustalony przez prop `course-type`

### Teraz:
- ✅ **Jeden uniwersalny formularz dla wszystkich kursów**
- ✅ **Rozwijane menu z listą kursów z bazy**
- ✅ **Format: "Nazwa kursu - Data"** (np. "Kurs ADR - Cysterny - 1-2 Marca 2025")
- ✅ **Automatyczna synchronizacja z CMS**

---

## 🎨 Nowy wygląd formularza

### Pole "Wybierz kurs" (nowe!)

```
┌─────────────────────────────────────────────────┐
│ Wybierz kurs *                                  │
│ ┌─────────────────────────────────────────────┐ │
│ │ -- Wybierz kurs --                        ▼ │ │
│ └─────────────────────────────────────────────┘ │
│                                                 │
│ Po kliknięciu:                                  │
│ ┌─────────────────────────────────────────────┐ │
│ │ Kurs ADR Podstawowy - 15-17 Lutego 2025     │ │
│ │ Kurs ADR - Cysterny - 1-2 Marca 2025        │ │
│ │ Kurs ADR - Klasa 1 - 8-9 Marca 2025         │ │
│ │ Kurs ADR - Klasa 7 - 12-13 Marca 2025       │ │
│ │ Kurs odświeżający ADR - 22-23 Marca 2025    │ │
│ └─────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────┘
```

Dalej:
- Imię *
- Nazwisko *
- Email *
- Telefon *
- PESEL *
- Miejsce urodzenia *
- Zgoda RODO *
- [Wyślij zgłoszenie]

---

## 🔄 Jak działa synchronizacja?

### Scenariusz 1: Edycja w CMS → Formularz aktualizuje się

1. **Wejdź na `/admin/dashboard`** → Zakładka "Kursy"
2. **Edytuj kurs "Cysterny":**
   - Zmień datę z "1-2 Marca" na "5-6 Marca"
   - Kliknij "Zapisz zmiany"
3. **Odśwież stronę z formularzem** (Ctrl+Shift+R)
4. **Rozwiń menu "Wybierz kurs"**
5. ✅ **Nowa data widoczna:** "Kurs ADR - Cysterny - 5-6 Marca 2025"

### Scenariusz 2: Nowy kurs w bazie → Pojawia się w formularzu

1. **Dodaj nowy kurs w Supabase**
2. **Odśwież stronę z formularzem**
3. ✅ **Nowy kurs pojawia się na liście!**

---

## 📍 Gdzie jest ten formularz?

### 1. Terminarz (`/terminarz`)
- Tabela z kursami
- Przycisk "Zapisz się" → scroll do formularza **na tej samej stronie**
- Formularz automatycznie ustawia wybrany kurs

### 2. Strony kursów (`/kursy/...`)
- KursPodstawowy
- KursCysterny
- KursKlasa1
- KursKlasa7
- KursOdswiezajacy
- Formularz na dole strony z domyślnie wybranym kursem

### 3. Homepage (`/`)
- Formularz na dole strony
- Domyślnie ustawiony na "podstawowy"

---

## 💻 Techniczne szczegóły

### Nowe funkcje w `RegistrationForm.vue`:

```javascript
// 1. Ładowanie kursów z bazy
const availableCourses = ref([])
const loadingCourses = ref(true)

onMounted(async () => {
  await loadCourses()
  if (props.courseType) {
    formData.selectedCourse = props.courseType // Auto-select if provided
  }
})

const loadCourses = async () => {
  const { data } = await supabase
    .from('courses')
    .select('*')
    .order('next_date', { ascending: true })
  
  availableCourses.value = data || []
}

// 2. Dynamiczny wybór kursu
const formData = reactive({
  selectedCourse: '', // ← NOWE POLE
  firstName: '',
  lastName: '',
  // ...
})

// 3. Watch dla zmian courseType (z Terminarz)
watch(() => props.courseType, (newType) => {
  if (newType) {
    formData.selectedCourse = newType
  }
})

// 4. Zapis z wybranym kursem
const handleSubmit = async () => {
  await supabase.from('registrations').insert({
    course_type: formData.selectedCourse, // ← używa wybranego kursu
    // ...
  })
}
```

### Struktura select:
```vue
<select v-model="formData.selectedCourse">
  <option value="" disabled>-- Wybierz kurs --</option>
  <option 
    v-for="course in availableCourses" 
    :value="course.course_type"
  >
    {{ course.title }} - {{ course.next_date }}
  </option>
</select>
```

---

## 🎯 Przepływ użytkownika

### Terminarz → Formularz:

1. **Użytkownik na `/terminarz`**
2. **Widzi tabelę z 5 kursami**
3. **Klika "Zapisz się" przy kursie "Cysterny"**
4. **Smooth scroll do formularza** (ta sama strona)
5. **Formularz ma już wybrany "Kurs ADR - Cysterny - 1-2 Marca 2025"**
6. **Wypełnia dane i wysyła**
7. ✅ **Zgłoszenie zapisane w bazie!**

### Strona kursu → Formularz:

1. **Użytkownik na `/kursy/cysterny`**
2. **Klika "Zapisz się na kurs cysterny"** (przycisk CTA)
3. **Scroll do formularza** (ta sama strona)
4. **Formularz ma już wybrany "Kurs ADR - Cysterny - 1-2 Marca 2025"**
5. **Wypełnia dane i wysyła**
6. ✅ **Zgłoszenie zapisane w bazie!**

### Homepage → Formularz:

1. **Użytkownik na homepage**
2. **Klika "Zapisz się na ten kurs"**
3. **Scroll do formularza**
4. **Formularz ma domyślnie wybrany "Kurs podstawowy"**
5. **Może zmienić kurs z rozwijanego menu**
6. **Wypełnia dane i wysyła**
7. ✅ **Zgłoszenie zapisane w bazie!**

---

## ✅ Podsumowanie zmian

### `RegistrationForm.vue`:
- ✅ Dodano select z dynamiczną listą kursów
- ✅ Kursy pobierane z tabeli `courses`
- ✅ Format: "Nazwa - Data"
- ✅ Auto-select jeśli `courseType` prop jest podany
- ✅ Watch dla zmian `courseType` (z Terminarz)
- ✅ Loading state podczas ładowania kursów
- ✅ Zapis wybranego kursu do `registrations`

### `Terminarz.vue`:
- ✅ Formularz na tej samej stronie
- ✅ Przycisk "Zapisz się" → scroll do formularza
- ✅ Auto-select wybranego kursu
- ✅ Prop `courseType` przekazywany do formularza

---

## 🚀 Przetestuj!

### Test 1: Terminarz
1. Odśwież stronę (Ctrl+Shift+R)
2. Wejdź na `/terminarz`
3. Kliknij "Zapisz się" przy kursie "Cysterny"
4. ✅ Scroll do formularza
5. ✅ Kurs "Cysterny - data" już wybrany w select!

### Test 2: Zmiana kursu w formularzu
1. Wejdź na `/terminarz`
2. Kliknij "Zapisz się" przy "Podstawowy"
3. W formularzu rozwiń menu "Wybierz kurs"
4. Wybierz "Klasa 1"
5. Wypełnij dane
6. Wyślij
7. ✅ Zgłoszenie zapisane z kursem "klasa1"!

### Test 3: Edycja daty w CMS
1. `/admin/dashboard` → "Kursy"
2. Edytuj "Cysterny" → Zmień datę na "10-11 Kwietnia"
3. Zapisz
4. Odśwież formularz zapisu
5. Rozwiń menu
6. ✅ Nowa data widoczna: "Kurs ADR - Cysterny - 10-11 Kwietnia"!

---

**Gotowe! Formularz jest teraz uniwersalny i w pełni zsynchronizowany z CMS!** 🎉
