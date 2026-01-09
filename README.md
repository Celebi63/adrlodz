# ADR Łódź - Website

A professional website for ADR training courses in Łódź, built with Vue 3, Vite, Tailwind CSS, and Supabase.

## 🚀 Features

- **Formularz rejestracji**: Zapisy na kursy podstawowy i cysterny
- **Interaktywne quizy**: Quiz podstawowy z 20 pytaniami + weryfikacja odpowiedzi
- **Strony kursów**: Szczegółowe informacje o kursach ADR
- **Baza przepisów**: 12 stron z przepisami ADR
- **Integracja Supabase**: Automatyczny zapis rejestracji i wyników quizów
- **Responsywny design**: Tailwind CSS + Inter font
- **Zabezpieczenia**: RLS policies + password protection dla quizów
- **Modern Stack**: Vue 3 Composition API + Vite + Vue Router

## 📋 Prerequisites

- Node.js (v16 or higher)
- npm or yarn
- Supabase account

## 🛠️ Setup Instructions

### 1. Install Dependencies

```bash
npm install
```

### 2. Configure Environment Variables

Create a `.env` file in the root directory:

```env
VITE_SUPABASE_URL=your_supabase_project_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
```

Replace the values with your actual Supabase project credentials.

### 3. Set Up Supabase Database

**Automatycznie (polecane):**
```bash
npm run setup:supabase
```

Skrypt sprawdzi połączenie i wyświetli gotowy SQL do uruchomienia.

**Ręcznie:**
Go to your Supabase project dashboard and run the following SQL in the SQL Editor:

```sql
-- Użyj zawartości pliku: supabase_setup.sql
-- Lub skopiuj SQL wyświetlony przez: npm run setup:supabase
```

**Pełny skrypt znajduje się w pliku `supabase_setup.sql`**

### 4. Run Development Server

```bash
npm run dev
```

The application will be available at `http://localhost:5173`

### 5. Build for Production

```bash
npm run build
```

## 📁 Project Structure

```
adrlodz/
├── src/
│   ├── components/           # Reusable Vue components
│   ├── views/                # Page components (Home, Kursy, Quizy, etc.)
│   ├── router/               # Vue Router configuration
│   ├── lib/                  # Supabase client
│   ├── assets/               # Images and static files
│   └── style.css             # Tailwind CSS
├── supabase_setup.sql        # SQL script for Supabase tables
├── setup-supabase.js         # Automated setup script
├── QUICK_START_SUPABASE.md   # Quick start guide
└── SUPABASE_SETUP.md         # Detailed documentation
```

## 🎨 Tech Stack

- **Vue 3**: Progressive JavaScript framework with Composition API
- **Vite**: Next-generation frontend tooling
- **Tailwind CSS**: Utility-first CSS framework
- **Supabase**: Open-source Firebase alternative for database and backend

## 🔒 Security Notes

- Never commit your `.env` file to version control
- Keep your Supabase credentials secure
- RLS (Row Level Security) is enabled for the trainings table
- Public read access is granted via Supabase policies

## 📝 License

This project is for ADR Łódź training center.

## 🤝 Support

For support, contact:
- Email: kontakt@adrlodz.pl
- Phone: +48 123 456 789
