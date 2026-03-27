# ADMIN CMS - Lista zmian i TODO

## ✅ Zaimplementowane

### Baza Danych
- [x] Tabela `courses` - zarządzanie kursami
- [x] Tabela `site_settings` - ustawienia strony
- [x] Tabela `hero_content` - treść hero section
- [x] Tabela `gallery_images` - galeria (struktura gotowa)
- [x] Tabela `page_contents` - ⭐ NOWE - treść wszystkich stron
- [x] Row Level Security (RLS)
- [x] Polityki bezpieczeństwa
- [x] Triggery updated_at

### Panel Logowania
- [x] Strona logowania `/admin/login`
- [x] Integracja z Supabase Auth
- [x] Walidacja formularza
- [x] Komunikaty błędów
- [x] Link powrotu do strony głównej

### Dashboard
- [x] Layout z nawigacją
- [x] System zakładek (5 zakładek)
- [x] Wylogowanie
- [x] Ochrona route (wymaga logowania)

### Zarządzanie Kursami
- [x] Lista wszystkich kursów
- [x] Edycja cen
- [x] Edycja terminów
- [x] Edycja dat egzaminów
- [x] Edycja opisów
- [x] Modal edycji
- [x] Walidacja i komunikaty

### Zarządzanie Hero Section
- [x] Edycja tytułu
- [x] Edycja daty kursu
- [x] Edycja daty egzaminu
- [x] Edycja terminu zgłoszeń
- [x] Podgląd na żywo

### Zarządzanie Stronami ⭐ NOWE
- [x] Lista wszystkich stron
- [x] Filtrowanie po kategorii
- [x] Filtrowanie po statusie publikacji
- [x] Edycja tytułów stron
- [x] System sekcji (wiele sekcji na stronę)
- [x] Dodawanie/usuwanie sekcji
- [x] Edytor treści wieloliniowej
- [x] Publikowanie/ukrywanie stron
- [x] Modal edycji z podglądem
- [x] Dane początkowe dla stron:
  - [x] O nas
  - [x] Przepisy - Wstęp
  - [x] Przepisy - Klasyfikacja
  - [x] Przepisy - Zwolnienia
  - [x] Przepisy - Oznakowanie
  - [x] Wszystkie pozostałe strony przepisów

### Ustawienia Strony
- [x] Sekcja kontakt
- [x] Sekcja dane firmy
- [x] Sekcja statystyki
- [x] Zapis wszystkich ustawień naraz

### Zgłoszenia
- [x] Lista wszystkich zgłoszeń
- [x] Filtrowanie po kursie
- [x] Statystyki zgłoszeń
- [x] Formatowanie dat

## 🔄 Do zrobienia w przyszłości

### Priorytet wysoki
- [ ] Połączenie CMS z frontendem (pobieranie danych z bazy)
- [ ] Upload zdjęć do galerii
- [ ] Eksport zgłoszeń do CSV

### Priorytet średni
- [ ] Powiadomienia email po zgłoszeniu
- [ ] Historia zmian w kursach
- [ ] Backup i restore danych
- [ ] Wyszukiwarka w zgłoszeniach

### Priorytet niski
- [ ] Dark mode w panelu
- [ ] Statystyki i wykresy
- [ ] Zarządzanie wieloma adminami
- [ ] Logi aktywności
- [ ] Dwuskładnikowa autentykacja (2FA)

## 📝 Notatki

### Struktura plików
```
src/
├── views/
│   └── admin/
│       ├── AdminLogin.vue
│       └── AdminDashboard.vue
├── components/
│   └── admin/
│       ├── CoursesManager.vue
│       ├── SettingsManager.vue
│       ├── RegistrationsManager.vue
│       ├── HeroManager.vue
│       └── PagesManager.vue ⭐ NOWE
└── router/
    └── index.js (zaktualizowany)
```

### Tabele w Supabase
- `courses` - dane o kursach
- `site_settings` - ustawienia kontaktu, firmy, statystyk
- `hero_content` - treść na hero section
- `gallery_images` - przyszła galeria
- `registrations` - zgłoszenia (już istniejąca)
- `page_contents` - ⭐ NOWE - treść wszystkich stron

### Kolejne kroki dla integracji:
1. ✅ Uruchomić `supabase_cms_setup.sql`
2. ✅ Uruchomić `supabase_cms_pages_extension.sql` ⭐ NOWE
3. ⏳ Zaktualizować komponenty frontendowe aby pobierały dane z nowych tabel CMS
4. ⏳ Zastąpić hardcodowane wartości danymi z bazy
5. ⏳ Dodać loading states
6. ⏳ Dodać error handling

**Szczegółowa instrukcja integracji znajduje się w `CMS_PAGES_INTEGRATION.md`**

## 🐛 Znane problemy
- Brak (nowa instalacja)

## 💡 Pomysły na rozszerzenia
- Blog/aktualności
- FAQ
- Opinie kursantów
- Kalendarz kursów
- System rezerwacji online z płatnościami
