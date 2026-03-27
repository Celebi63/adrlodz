# 🎨 Visual CMS - Quick Start

## ⚡ W 30 sekund

### 1. Zaloguj się
```
http://localhost:5173/#/admin/login
```

### 2. Włącz tryb edycji
<img src="https://via.placeholder.com/800x400/ff6b35/ffffff?text=Kliknij+%22W%C5%82%C4%85cz+edycj%C4%99%22+w+lewym+g%C3%B3rnym+rogu" alt="Enable edit mode" />

### 3. Kliknij i edytuj!
<img src="https://via.placeholder.com/800x400/10b981/ffffff?text=Kliknij+na+tekst+%E2%86%92+Edytuj+%E2%86%92+Kliknij+poza+%E2%86%92+Zapisane!" alt="Click and edit" />

---

## 🎬 Jak to wygląda?

### Normalna strona
```
┌─────────────────────────────────┐
│   🏠 Navbar                      │
├─────────────────────────────────┤
│                                  │
│   Kursy ADR Łódź                 │
│   Najbliższy kurs: 15-17 lutego  │
│                                  │
│   [Zapisz się]                   │
│                                  │
└─────────────────────────────────┘
```

### Tryb edycji WŁĄCZONY
```
┌──────────┬──────────────────────┐
│  PANEL   │   🏠 Navbar           │
│          ├──────────────────────┤
│ ✏️ Edycja │                      │
│          │   [Kursy ADR Łódź]   │ ← edytowalne
│ 👤 Admin │   Najbliższy kurs:   │
│          │   [15-17 lutego]     │ ← edytowalne
│ 📄 Home  │                      │
│          │   [Zapisz się]       │
│ 💾 Saving│                      │
│          │                      │
│ 🚪 Logout│                      │
└──────────┴──────────────────────┘
   320px        reszta ekranu
```

---

## 🖱️ Interakcje

### Hover nad tekstem
```
[Kurs ADR]  →  hover  →  ✏️ Kliknij aby edytować
      ↓
  pomarańczowa ramka przerywana
```

### Klik na tekst
```
[Kurs ADR]  →  klik  →  💾 Kliknij poza aby zapisać
      ↓
  solid ramka + contenteditable
  możesz pisać jak w Wordzie
```

### Klik poza tekstem
```
[Nowy tekst]  →  blur  →  Zapisywanie... → ✅ Zapisano!
       ↓
   zapis do bazy Supabase
```

---

## 🎯 Przykład użycia

### PRZED (hardcoded):
```vue
<h1 class="text-5xl font-bold">
  Kursy ADR Łódź
</h1>
```

### PO (edytowalne):
```vue
<EditableElement
  tag="h1"
  original-class="text-5xl font-bold"
  :model-value="title"
  :save-callback="saveTitle"
  label="Tytuł główny"
>
  {{ title }}
</EditableElement>
```

### Rezultat:
- ✅ Normalny użytkownik: widzi tytuł
- ✅ Admin w trybie edycji: może kliknąć i edytować
- ✅ Auto-save do bazy
- ✅ Bez przeładowania strony

---

## 📊 Porównanie: Stary CMS vs Visual CMS

### Stary sposób (Panel Admin):
```
1. Wejdź do /admin/dashboard
2. Kliknij zakładkę "Strony"
3. Znajdź stronę na liście
4. Kliknij "Edytuj"
5. Modal się otwiera
6. Szukaj pola tekstowego
7. Edytuj w textarea
8. Kliknij "Zapisz"
9. Wróć na stronę
10. Odśwież aby zobaczyć zmiany
```
⏱️ **~2 minuty**

### Nowy sposób (Visual CMS):
```
1. Kliknij "Włącz edycję"
2. Kliknij na tekst
3. Edytuj
4. Kliknij poza
```
⏱️ **~10 sekund!** 🚀

---

## 🎨 Kolory i style

### Edytowalny element:
- **Idle**: Normalny wygląd
- **Hover**: `border: 2px dashed #ff6b35` (pomarańczowy)
- **Edit**: `border: 2px solid #ff6b35` (pomarańczowy)
- **Saving**: Panel pokazuje spinner

### Panel:
- **Header**: Gradient pomarańczowy
- **Body**: Białe tło
- **Hover**: Szare podświetlenie

---

## 🔥 Najlepsze praktyki

### DO:
✅ Owij każdy tekst, który admin może chcieć zmienić  
✅ Dodaj sensowne `label` dla każdego elementu  
✅ Grupuj powiązane elementy  
✅ Testuj zapis do bazy  

### NIE:
❌ Nie owijaj buttonów/linków (tylko ich teksty)  
❌ Nie owijaj całych sekcji (tylko konkretne teksty)  
❌ Nie zapominaj o `saveCallback`  

---

## 📦 Co jest już gotowe?

### ✅ Gotowe:
- Composable `useEditMode`
- Komponent `EditModePanel`
- Komponent `EditableElement`
- Przykład: `HeroInlineEdit`
- App.vue zaktualizowane
- Dokumentacja

### ⏳ Do zrobienia:
- Zaktualizować Hero.vue
- Zaktualizować AboutSection.vue
- Zaktualizować Contact.vue
- Zaktualizować strony przepisów
- Dodać edycję obrazków

---

## 🚀 Instalacja

### Już zrobione:
- ✅ Wszystkie komponenty stworzone
- ✅ Composable gotowy
- ✅ App.vue zaktualizowany

### Musisz zrobić:
1. ⏳ Zamień `Hero.vue` na `HeroInlineEdit.vue` w `Home.vue`
2. ⏳ Przetestuj
3. ⏳ Stopniowo dodawaj do innych komponentów

---

## 💾 Zapis do bazy

Każda zmiana jest automatycznie zapisywana do:
- `hero_content` - hero section
- `page_contents` - strony
- `site_settings` - ustawienia
- `courses` - kursy

Wszystko przez **Supabase RLS** - bezpieczne!

---

## 🎉 TL;DR

**Masz teraz Visual CMS jak w WordPress!**

```
Kliknij "Włącz edycję" → Kliknij tekst → Edytuj → Gotowe!
```

To takie proste! 🎨✨

---

**Full docs:** `VISUAL_CMS_README.md`
