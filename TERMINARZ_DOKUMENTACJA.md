# 📅 Terminarz Kursów ADR - Dokumentacja

## ✅ Co zostało dodane?

### Nowa podstrona: **TERMINARZ**

Podstrona wyświetlająca wszystkie dostępne kursy w formie przejrzystej tabeli z możliwością zapisu.

---

## 📍 Gdzie znajdziesz Terminarz?

### W Menu Nawigacyjnym:
**O NAS** → **KURSY** → **TERMINARZ** ← TUTAJ! → **PRZEPISY** → **QUIZY** → **KONTAKT**

### URL:
```
http://localhost:5174/adrlodz/#/terminarz
```

---

## 🎯 Funkcje

### 1. **Tabela wszystkich kursów**
Wyświetla:
- Nazwa kursu (np. "Kurs ADR Podstawowy")
- Czas trwania (np. "3 dni (24 godziny)")
- Termin kursu (np. "15-17 Lutego 2025")
- Data egzaminu (np. "18 Lutego 2025")
- Cena (np. "1200 PLN")
- Przycisk CTA "Zapisz się"

### 2. **Responsywny design**
- **Desktop:** Tabela z 6 kolumnami
- **Mobile:** Karty z pełnymi informacjami

### 3. **Automatyczna synchronizacja z CMS**
- ✅ Wszystkie dane pobierane z tabeli `courses` w Supabase
- ✅ Zmiana w panelu admin → automatycznie widoczna w terminarzu
- ✅ Sortowanie chronologiczne (najbliższe kursy na górze)

### 4. **Przekierowanie do zapisu**
- Kliknięcie "Zapisz się" → przekierowanie na stronę kursu
- Automatyczne przewinięcie do formularza zapisu
- Smooth scroll dla lepszego UX

---

## 🗄️ Struktura danych

### Źródło danych: Tabela `courses`

```sql
SELECT * FROM courses ORDER BY next_date ASC;
```

**Zwraca wszystkie kursy z:**
- `course_type` - identyfikator kursu
- `title` - nazwa kursu
- `price` - cena
- `duration` - czas trwania
- `next_date` - termin kursu
- `exam_date` - data egzaminu
- `description` - opis (nie wyświetlany w tabeli)
- `program` - program (nie wyświetlany w tabeli)
- `requirements` - wymagania (nie wyświetlane w tabeli)

---

## 🎨 Wygląd

### Desktop (Tabela):
```
┌──────────────────────┬──────────────┬────────────────┬──────────────┬────────┬────────────┐
│ Kurs                 │ Czas trwania │ Termin kursu   │ Egzamin      │ Cena   │ Zapis      │
├──────────────────────┼──────────────┼────────────────┼──────────────┼────────┼────────────┤
│ Kurs ADR Podstawowy  │ 3 dni        │ 15-17 Lutego   │ 18 Lutego    │ 1200   │ [Zapisz]   │
│ Kurs ADR - Cysterny  │ 2 dni        │ 1-2 Marca      │ 3 Marca      │ 900    │ [Zapisz]   │
│ ...                  │ ...          │ ...            │ ...          │ ...    │ [...]      │
└──────────────────────┴──────────────┴────────────────┴──────────────┴────────┴────────────┘
```

### Mobile (Karty):
```
┌───────────────────────────────┐
│ Kurs ADR Podstawowy           │
├───────────────────────────────┤
│ Czas trwania: 3 dni (24h)     │
│ Cena: 1200 PLN                │
│ Termin kursu: 15-17 Lutego    │
│ Egzamin: 18 Lutego            │
│ [      Zapisz się      ]      │
└───────────────────────────────┘
```

---

## 🔄 Jak działa synchronizacja?

### Panel Admin → Terminarz:

1. **Edytujesz kurs w `/admin/dashboard`:**
   - Zakładka "Kursy" → Edytuj "Podstawowy"
   - Zmień datę z "15-17 Lutego" na "22-24 Lutego"
   - Kliknij "Zapisz zmiany"

2. **Odświeżasz `/terminarz`:**
   - Ctrl+Shift+R (Windows) lub Cmd+Shift+R (Mac)
   - ✅ Nowa data "22-24 Lutego" jest widoczna!

3. **Visual CMS:**
   - Niestety terminarz nie ma inline editing (to tylko tabela z danymi)
   - Musisz edytować przez panel admin

---

## 🚀 Przekierowanie do zapisu

### Jak działa przycisk "Zapisz się"?

1. **Użytkownik klika "Zapisz się" przy kursie "Cysterny"**
2. **Router przekierowuje na `/kursy/cysterny`**
3. **Automatyczne przewinięcie do formularza zapisu**
4. **Użytkownik wypełnia formularz**

### Mapowanie course_type → route:

```javascript
{
  'podstawowy'   → '/kursy/podstawowy'
  'cysterny'     → '/kursy/cysterny'
  'klasa1'       → '/kursy/klasa-1'
  'klasa7'       → '/kursy/klasa-7'
  'odswiezajacy' → '/kursy/odswiezajacy'
}
```

---

## 📝 Pliki utworzone/zmodyfikowane

### Nowe pliki:
1. **`/src/views/Terminarz.vue`** - główny komponent
2. **`TERMINARZ_DOKUMENTACJA.md`** - ta dokumentacja

### Zmodyfikowane pliki:
1. **`/src/router/index.js`** - dodany route `/terminarz`
2. **`/src/components/Navbar.vue`** - dodany link w menu desktop i mobile

---

## 💡 Dodatkowe informacje

### Sekcja informacyjna:
Na dole strony terminarz znajduje się box z informacjami:
- 📅 "Zgłoszenia przyjmujemy do czwartku włącznie"
- 🎯 "Liczba miejsc ograniczona"
- 📧 "Po wysłaniu formularza skontaktujemy się"
- 📞 "W razie pytań zadzwoń: +48 123 456 789"

### Loading state:
- Podczas ładowania danych: "Ładowanie terminów kursów..."
- Brak kursów: "Brak dostępnych terminów kursów."

### Sortowanie:
- Kursy są sortowane chronologicznie (najbliższe na górze)
- SQL: `ORDER BY next_date ASC`

---

## 🎨 Styling

### Kolory:
- Header: Gradient pomarańczowy (primary → orange-600)
- Przycisk CTA: Primary color (pomarańczowy)
- Hover tabeli: Szary (#gray-50)
- Ceny: Primary color (pomarańczowy, bold)
- Daty kursu: Primary color (pomarańczowy)

### Responsywność:
- Desktop: Tabela (>= 1024px)
- Mobile: Karty (< 1024px)
- Padding: 16px (mobile), 32px (desktop)

---

## ⚠️ Co zrobić jeśli nie działa?

### 1. Odśwież stronę
```
Ctrl + Shift + R (Windows/Linux)
Cmd + Shift + R (Mac)
```

### 2. Sprawdź konsolę (F12)
Jeśli widzisz błąd:
- **"courses not found"** → Uruchom `supabase_cms_setup.sql`
- **"Failed to fetch"** → Sprawdź połączenie z Supabase

### 3. Sprawdź czy dane są w bazie
1. Wejdź na https://supabase.com
2. Otwórz swój projekt
3. **Table Editor** → `courses`
4. Sprawdź czy są 5 wpisów (podstawowy, cysterny, klasa1, klasa7, odswiezajacy)

### 4. Restart serwera dev
```bash
# Zatrzymaj (Ctrl+C)
npm run dev
```

---

## 🎉 Podsumowanie

### ✅ Co działa:
- [x] Terminarz wyświetla wszystkie kursy z bazy
- [x] Responsywny design (desktop + mobile)
- [x] Przycisk "Zapisz się" przekierowuje na stronę kursu
- [x] Automatyczne przewinięcie do formularza
- [x] Synchronizacja z panelem admin
- [x] Loading states
- [x] Sortowanie chronologiczne

### 📍 Gdzie znajdziesz:
- **Menu:** KURSY → **TERMINARZ** ← TUTAJ! → PRZEPISY
- **URL:** `/terminarz`
- **Plik:** `/src/views/Terminarz.vue`

### 🔄 Jak aktualizować:
1. Edytuj w `/admin/dashboard` → zakładka "Kursy"
2. Zmień daty/ceny/terminy
3. Kliknij "Zapisz zmiany"
4. Odśwież `/terminarz`
5. ✅ Nowe dane widoczne!

---

**Gotowe! Terminarz działa i synchronizuje się z CMS!** 🎉
