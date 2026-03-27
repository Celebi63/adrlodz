# Panel Administracyjny ADR Łódź

## 📋 Instrukcja Instalacji CMS

### Krok 1: Uruchom skrypty SQL w Supabase

1. Zaloguj się do swojego projektu Supabase: https://supabase.com
2. Przejdź do **SQL Editor** (po lewej stronie)
3. **Pierwszy skrypt** - Otwórz plik `supabase_cms_setup.sql`
   - Skopiuj całą zawartość i wklej do SQL Editor
   - Kliknij **RUN**
4. **Drugi skrypt** - Otwórz plik `supabase_cms_pages_extension.sql`
   - Skopiuj całą zawartość i wklej do SQL Editor
   - Kliknij **RUN**
5. Poczekaj na komunikat o sukcesie dla obu skryptów

### Krok 2: Utwórz konto administratora

1. W Supabase przejdź do **Authentication** → **Users**
2. Kliknij **Add user** → **Create new user**
3. Wpisz:
   - **Email**: twój-admin@email.com
   - **Password**: bezpieczne-haslo
4. Kliknij **Create user**

### Krok 3: Zaloguj się do panelu

1. Odwiedź: `http://twoja-strona.pl/#/admin/login`
2. Zaloguj się używając utworzonych powyżej danych
3. Zostaniesz przekierowany do panelu administracyjnego

---

## 🎯 Funkcje Panelu Administracyjnego

### Dwa tryby pracy:

#### 🎨 Visual CMS (Inline Editing) ⭐ NOWOŚĆ
**Edycja jak w WordPress - zobacz stronę i klikaj aby edytować!**

- **Włącz tryb edycji** przyciskiem w lewym górnym rogu
- **Panel po lewej** z informacjami i opcjami
- **Kliknij na tekst** aby go edytować (jak w Wordzie)
- **Automatyczny zapis** do bazy danych
- **Wizualne podświetlenie** edytowalnych elementów
- **Natychmiastowy podgląd** zmian

📖 Zobacz: `VISUAL_CMS_QUICKSTART.md` i `VISUAL_CMS_README.md`

#### 📋 Klasyczny Panel Admin
**Tradycyjny panel z tabelami i formularzami**

### 1. **Zarządzanie Kursami**
- Edycja cen kursów
- Zmiana terminów kursów i egzaminów
- Aktualizacja opisów kursów
- Modyfikacja programów szkoleń

### 2. **Edycja Strony Głównej (Hero Section)**
- Zmiana tytułu głównego
- Aktualizacja daty najbliższego kursu
- Zmiana daty egzaminu
- Modyfikacja terminu zgłoszeń

### 3. **Zarządzanie Stronami** ⭐ NOWE
- **Edycja wszystkich podstron:**
  - Strona O nas
  - Wszystkie strony z zakładki Przepisy
  - Przyszłe strony
- **System sekcji:**
  - Każda strona może mieć wiele sekcji
  - Każda sekcja ma tytuł i treść
  - Dodawanie/usuwanie sekcji
- **Publikowanie:**
  - Ukryj/pokaż stronę bez usuwania
- **Filtrowanie:**
  - Po kategorii (główne, przepisy, kursy, quizy)
  - Po statusie (opublikowane/ukryte)

### 4. **Ustawienia Strony**
- **Dane kontaktowe:**
  - Telefon
  - Adres (ulica, miasto)
- **Dane firmy:**
  - NIP
  - Numer konta bankowego
- **Statystyki:**
  - Liczba absolwentów
  - Lata doświadczenia
  - Procent zdawalności

### 5. **Zgłoszenia na Kursy**
- Lista wszystkich zgłoszeń
- Filtrowanie po typie kursu
- Statystyki zgłoszeń
- Eksport danych (będzie dodane)

---

## 🔐 Bezpieczeństwo

- Panel dostępny tylko po zalogowaniu
- Hasła szyfrowane przez Supabase Auth
- Row Level Security (RLS) włączone
- Automatyczne wylogowanie po nieaktywności

---

## 📱 Dostęp

### URL Panelu Administracyjnego:
```
http://twoja-strona.pl/#/admin
```

### Struktura:
- `/admin` → przekierowuje do logowania
- `/admin/login` → strona logowania
- `/admin/dashboard` → panel główny (wymaga logowania)

---

## ✅ Checklist po instalacji

- [ ] Wykonano oba skrypty SQL w Supabase
  - [ ] `supabase_cms_setup.sql`
  - [ ] `supabase_cms_pages_extension.sql`
- [ ] Utworzono konto administratora
- [ ] Przetestowano logowanie
- [ ] Zaktualizowano dane kontaktowe
- [ ] Zaktualizowano ceny kursów
- [ ] Ustawiono aktualne terminy kursów
- [ ] Wypełniono treść stron (opcjonalne)

---

## 📄 Dodatkowa dokumentacja

- **`CMS_PAGES_INTEGRATION.md`** - Szczegółowa instrukcja integracji CMS ze stronami
- **`CMS_CHANGELOG.md`** - Lista zmian i planowanych funkcji

---

## 🆘 Rozwiązywanie problemów

### Nie mogę się zalogować
1. Sprawdź czy konto zostało utworzone w Supabase → Authentication → Users
2. Sprawdź czy email i hasło są poprawne
3. Sprawdź czy skrypt SQL został wykonany pomyślnie

### Nie widzę danych w panelu
1. Sprawdź w Supabase → Table Editor czy tabele zostały utworzone:
   - `courses`
   - `site_settings`
   - `hero_content`
   - `gallery_images`
2. Sprawdź czy Row Level Security (RLS) jest włączone
3. Sprawdź polityki bezpieczeństwa w Supabase

### Nie mogę zapisać zmian
1. Sprawdź czy jesteś zalogowany
2. Sprawdź polityki RLS w Supabase
3. Sprawdź konsolę przeglądarki (F12) w poszukiwaniu błędów

---

## 📞 Wsparcie

W razie problemów:
1. Sprawdź konsolę przeglądarki (F12) → Console
2. Sprawdź logi w Supabase → Logs
3. Skontaktuj się z deweloperem

---

## 🔄 Aktualizacja danych na stronie

Po zapisaniu zmian w panelu administracyjnym:
1. Zmiany są natychmiast widoczne w bazie danych
2. Odśwież stronę główną aby zobaczyć aktualizacje
3. Niektóre zmiany mogą wymagać przebudowania cache (Ctrl+F5)

---

## 📊 Planowane funkcje

- [ ] Upload zdjęć do galerii ośrodka
- [ ] Eksport zgłoszeń do CSV/Excel
- [ ] Wysyłanie powiadomień email
- [ ] Statystyki i raporty
- [ ] Zarządzanie użytkownikami admina
- [ ] Historia zmian

---

**Autor:** Filip Celebias  
**Wersja:** 1.0  
**Data:** 2025
