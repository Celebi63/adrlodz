# Konfiguracja Supabase dla ADR Łódź

## 1. Konfiguracja środowiska

### Plik `.env`
Upewnij się, że masz plik `.env` w głównym katalogu projektu z następującymi zmiennymi:

```env
VITE_SUPABASE_URL=https://ypaqzdcnmmdlokmywiab.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlwYXF6ZGNubW1kbG9rbXl3aWFiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjY5MjQ1OTksImV4cCI6MjA4MjUwMDU5OX0.g8UZa32FpB7ui8j2ejvPb-9lMJkzEHBxKfyoO3lwiRs
```

## 2. Utworzenie tabel w Supabase

### Krok po kroku:

1. **Zaloguj się do Supabase Dashboard**
   - Przejdź do: https://supabase.com/dashboard
   - Wybierz swój projekt

2. **Otwórz SQL Editor**
   - W lewym menu kliknij "SQL Editor"
   - Kliknij "New query"

3. **Wykonaj skrypt SQL**
   - Skopiuj zawartość pliku `supabase_setup.sql`
   - Wklej do edytora SQL
   - Kliknij "Run" (lub Ctrl/Cmd + Enter)

4. **Weryfikacja**
   - Przejdź do "Table Editor" w lewym menu
   - Powinieneś zobaczyć dwie nowe tabele:
     - `registrations`
     - `quiz_results`

## 3. Struktura tabel

### Tabela: `registrations`
Przechowuje dane zgłoszeń na kursy ADR.

| Kolumna | Typ | Opis |
|---------|-----|------|
| id | UUID | Unikalny identyfikator (automatyczny) |
| first_name | VARCHAR(100) | Imię uczestnika |
| last_name | VARCHAR(100) | Nazwisko uczestnika |
| email | VARCHAR(255) | Adres email |
| phone | VARCHAR(20) | Numer telefonu |
| pesel | VARCHAR(11) | Numer PESEL |
| birth_place | VARCHAR(100) | Miejsce urodzenia |
| course_type | VARCHAR(50) | Typ kursu ('podstawowy' lub 'cysterny') |
| consent | BOOLEAN | Zgoda RODO |
| created_at | TIMESTAMP | Data utworzenia (automatyczna) |
| updated_at | TIMESTAMP | Data aktualizacji (automatyczna) |

### Tabela: `quiz_results`
Przechowuje wyniki quizów online.

| Kolumna | Typ | Opis |
|---------|-----|------|
| id | UUID | Unikalny identyfikator (automatyczny) |
| quiz_type | VARCHAR(50) | Typ quizu ('podstawowy' lub 'cysterny') |
| correct_answers | INTEGER | Liczba poprawnych odpowiedzi |
| total_questions | INTEGER | Łączna liczba pytań |
| percentage | INTEGER | Procent poprawnych odpowiedzi |
| passed | BOOLEAN | Czy quiz został zdany (≥75%) |
| answers | JSONB | Szczegółowe odpowiedzi (format JSON) |
| completed_at | TIMESTAMP | Data ukończenia quizu |
| user_email | VARCHAR(255) | Email użytkownika (opcjonalny) |
| user_name | VARCHAR(200) | Imię użytkownika (opcjonalny) |

## 4. Zabezpieczenia (RLS - Row Level Security)

Skrypt automatycznie konfiguruje polityki bezpieczeństwa:

### Dla `registrations`:
- ✅ **INSERT**: Każdy może dodawać nowe rejestracje (anon, authenticated)
- ✅ **SELECT**: Tylko zalogowani użytkownicy mogą odczytywać dane

### Dla `quiz_results`:
- ✅ **INSERT**: Każdy może dodawać wyniki quizów (anon, authenticated)
- ✅ **SELECT**: Tylko zalogowani użytkownicy mogą odczytywać wyniki

## 5. Integracja z aplikacją

### Formularz rejestracji (`RegistrationForm.vue`)
Automatycznie zapisuje dane do tabeli `registrations` z odpowiednim typem kursu:
- **Homepage**: `course_type = 'podstawowy'`
- **Strona "Kurs Podstawowy"**: `course_type = 'podstawowy'`
- **Strona "Kurs Cysterny"**: `course_type = 'cysterny'`

### Quiz Podstawowy (`QuizPodstawowy.vue`)
Automatycznie zapisuje wyniki do tabeli `quiz_results`:
- Typ quizu: `'podstawowy'`
- Zapisuje: liczbę poprawnych odpowiedzi, procent, status zdany/niezdany
- Przechowuje szczegółowe odpowiedzi w formacie JSON

## 6. Przydatne zapytania SQL

### Pobranie wszystkich rejestracji
```sql
SELECT * FROM registrations 
ORDER BY created_at DESC;
```

### Rejestracje dla konkretnego kursu
```sql
SELECT * FROM registrations 
WHERE course_type = 'podstawowy' 
ORDER BY created_at DESC;
```

### Statystyki quizów
```sql
SELECT 
  quiz_type,
  COUNT(*) as total_attempts,
  COUNT(*) FILTER (WHERE passed = true) as passed_count,
  ROUND(AVG(percentage), 2) as avg_percentage
FROM quiz_results
GROUP BY quiz_type;
```

### Ostatnie wyniki quizów
```sql
SELECT * FROM quiz_results 
ORDER BY completed_at DESC 
LIMIT 10;
```

### Liczba rejestracji w ostatnich 7 dniach
```sql
SELECT 
  course_type,
  COUNT(*) as registrations_count
FROM registrations
WHERE created_at >= NOW() - INTERVAL '7 days'
GROUP BY course_type;
```

## 7. Backup i eksport danych

### Eksport rejestracji do CSV
W Supabase Dashboard:
1. Przejdź do "Table Editor"
2. Wybierz tabelę `registrations`
3. Kliknij "Export" → "CSV"

### Backup całej bazy
```bash
# Używając Supabase CLI (jeśli zainstalowane)
supabase db dump -f backup.sql
```

## 8. Troubleshooting

### Problem: "Missing Supabase environment variables"
**Rozwiązanie**: Sprawdź czy plik `.env` istnieje i zawiera poprawne klucze

### Problem: "Row Level Security policy violation"
**Rozwiązanie**: Upewnij się, że polityki RLS zostały poprawnie utworzone (wykonaj ponownie skrypt SQL)

### Problem: Dane nie zapisują się
**Rozwiązanie**: 
1. Sprawdź konsolę przeglądarki (F12) czy są błędy
2. Sprawdź czy tabele istnieją w Supabase
3. Sprawdź czy klucze API są poprawne

## 9. Monitoring

### Sprawdzanie aktywności
W Supabase Dashboard → "Logs" możesz monitorować:
- Zapytania API
- Błędy
- Wydajność

### Alerty
Możesz skonfigurować alerty email dla:
- Nowych rejestracji
- Błędów w bazie danych
- Przekroczenia limitów

---

**Data utworzenia**: 2026-01-09
**Wersja**: 1.0

