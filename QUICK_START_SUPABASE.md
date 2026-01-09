# 🚀 Szybki Start - Integracja Supabase

## Co zostało zrobione?

✅ **Formularze rejestracji** zapisują dane do Supabase  
✅ **Quiz podstawowy** zapisuje wyniki do Supabase  
✅ **Typ kursu** (podstawowy/cysterny) jest automatycznie rozróżniany  
✅ **Zabezpieczenia RLS** skonfigurowane  

---

## ⚡ Szybka konfiguracja (2 minuty!)

### Krok 1: Uruchom skrypt setup
```bash
npm run setup:supabase
```

Ten skrypt:
- ✅ Sprawdzi połączenie z Supabase
- ✅ Wyświetli gotowy SQL do wklejenia
- ✅ Pokaże link do dashboardu

### Krok 2: Skopiuj SQL i uruchom w Supabase
1. Skrypt wyświetli SQL - skopiuj go
2. Przejdź do: https://supabase.com/dashboard
3. SQL Editor → New query
4. Wklej skopiowany SQL
5. Kliknij **Run**

### Krok 3: Gotowe! Testuj:
```bash
npm run dev
```

Przejdź do:
- **Formularz**: http://localhost:5173/ → wypełnij i wyślij
- **Quiz**: http://localhost:5173/quizy/podstawowy → hasło: `Romuald`

### Krok 4: Sprawdź dane w Supabase
1. W Supabase Dashboard → **Table Editor**
2. Sprawdź tabele:
   - `registrations` - zgłoszenia na kursy
   - `quiz_results` - wyniki quizów

---

## 📊 Co zapisuje każdy formularz?

### Formularz rejestracji
```
Homepage → course_type: "podstawowy"
Kurs Podstawowy → course_type: "podstawowy"  
Kurs Cysterny → course_type: "cysterny"
```

### Quiz
```
Quiz Podstawowy → quiz_type: "podstawowy"
+ wyniki, odpowiedzi, procent, zdany/niezdany
```

---

## 🔍 Szybkie sprawdzenie danych

### W Supabase SQL Editor:
```sql
-- Wszystkie rejestracje
SELECT * FROM registrations ORDER BY created_at DESC LIMIT 10;

-- Wyniki quizów
SELECT * FROM quiz_results ORDER BY completed_at DESC LIMIT 10;
```

---

## 📚 Więcej informacji

- **Szczegółowa dokumentacja**: `SUPABASE_SETUP.md`
- **Lista zmian**: `CHANGELOG_SUPABASE.md`
- **Skrypt SQL**: `supabase_setup.sql`

---

## ⚠️ Troubleshooting

**Problem**: Dane się nie zapisują  
**Rozwiązanie**: 
1. Sprawdź konsolę przeglądarki (F12)
2. Upewnij się, że tabele zostały utworzone
3. Sprawdź czy `.env` zawiera poprawne klucze

**Problem**: "Missing Supabase environment variables"  
**Rozwiązanie**: Upewnij się, że plik `.env` istnieje i zawiera VITE_SUPABASE_URL i VITE_SUPABASE_ANON_KEY

---

**Gotowe do użycia!** 🎉

