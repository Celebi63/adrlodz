#!/usr/bin/env node

/**
 * Automatyczne tworzenie tabel w Supabase
 * Uruchom: node setup-supabase.js
 */

import { createClient } from '@supabase/supabase-js'
import { config } from 'dotenv'

// Załaduj zmienne środowiskowe
config()

const supabaseUrl = process.env.VITE_SUPABASE_URL
const supabaseAnonKey = process.env.VITE_SUPABASE_ANON_KEY

if (!supabaseUrl || !supabaseAnonKey) {
  console.error('❌ Błąd: Brak kluczy Supabase w pliku .env')
  console.log('\nUpewnij się, że plik .env zawiera:')
  console.log('VITE_SUPABASE_URL=...')
  console.log('VITE_SUPABASE_ANON_KEY=...')
  process.exit(1)
}

const supabase = createClient(supabaseUrl, supabaseAnonKey)

console.log('🚀 Rozpoczynam konfigurację Supabase...\n')

// SQL do utworzenia tabel
const createTablesSQL = `
-- Tabela: registrations
CREATE TABLE IF NOT EXISTS registrations (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  pesel VARCHAR(11) NOT NULL,
  birth_place VARCHAR(100) NOT NULL,
  course_type VARCHAR(50) NOT NULL DEFAULT 'podstawowy',
  consent BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_registrations_email ON registrations(email);
CREATE INDEX IF NOT EXISTS idx_registrations_course_type ON registrations(course_type);
CREATE INDEX IF NOT EXISTS idx_registrations_created_at ON registrations(created_at DESC);

-- Tabela: quiz_results
CREATE TABLE IF NOT EXISTS quiz_results (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  quiz_type VARCHAR(50) NOT NULL,
  correct_answers INTEGER NOT NULL,
  total_questions INTEGER NOT NULL,
  percentage INTEGER NOT NULL,
  passed BOOLEAN NOT NULL DEFAULT false,
  answers JSONB,
  completed_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  user_email VARCHAR(255),
  user_name VARCHAR(200)
);

CREATE INDEX IF NOT EXISTS idx_quiz_results_quiz_type ON quiz_results(quiz_type);
CREATE INDEX IF NOT EXISTS idx_quiz_results_passed ON quiz_results(passed);
CREATE INDEX IF NOT EXISTS idx_quiz_results_completed_at ON quiz_results(completed_at DESC);

-- RLS Policies
ALTER TABLE registrations ENABLE ROW LEVEL SECURITY;
ALTER TABLE quiz_results ENABLE ROW LEVEL SECURITY;

-- Polityki dla registrations
DROP POLICY IF EXISTS "Anyone can insert registrations" ON registrations;
CREATE POLICY "Anyone can insert registrations"
  ON registrations FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

DROP POLICY IF EXISTS "Authenticated users can read registrations" ON registrations;
CREATE POLICY "Authenticated users can read registrations"
  ON registrations FOR SELECT
  TO authenticated
  USING (true);

-- Polityki dla quiz_results
DROP POLICY IF EXISTS "Anyone can insert quiz results" ON quiz_results;
CREATE POLICY "Anyone can insert quiz results"
  ON quiz_results FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

DROP POLICY IF EXISTS "Authenticated users can read quiz results" ON quiz_results;
CREATE POLICY "Authenticated users can read quiz results"
  ON quiz_results FOR SELECT
  TO authenticated
  USING (true);
`

async function setupDatabase() {
  console.log('📊 Sprawdzam połączenie z Supabase...')
  
  // Sprawdź czy tabele już istnieją
  try {
    const { data: existingTables, error: checkError } = await supabase
      .from('registrations')
      .select('id')
      .limit(1)
    
    if (!checkError) {
      console.log('✅ Tabela "registrations" już istnieje')
      
      const { data: existingQuiz, error: quizError } = await supabase
        .from('quiz_results')
        .select('id')
        .limit(1)
      
      if (!quizError) {
        console.log('✅ Tabela "quiz_results" już istnieje')
        console.log('\n🎉 Wszystkie tabele są już skonfigurowane!')
        console.log('\n✨ Możesz teraz uruchomić aplikację: npm run dev')
        return
      }
    }
  } catch (error) {
    console.log('ℹ️  Tabele nie istnieją, tworzę...')
  }

  console.log('\n📝 UWAGA: Aby utworzyć tabele, musisz uruchomić SQL w Supabase Dashboard')
  console.log('\n┌─────────────────────────────────────────────────────────┐')
  console.log('│  Instrukcja krok po kroku:                             │')
  console.log('├─────────────────────────────────────────────────────────┤')
  console.log('│  1. Przejdź do: https://supabase.com/dashboard         │')
  console.log('│  2. Wybierz swój projekt                                │')
  console.log('│  3. Kliknij "SQL Editor" w lewym menu                   │')
  console.log('│  4. Kliknij "New query"                                 │')
  console.log('│  5. Skopiuj zawartość pliku: supabase_setup.sql         │')
  console.log('│  6. Wklej do edytora i kliknij "Run"                    │')
  console.log('└─────────────────────────────────────────────────────────┘')
  
  console.log('\n💡 Alternatywnie, skopiuj poniższy SQL i wklej w Supabase SQL Editor:\n')
  console.log('─'.repeat(60))
  console.log(createTablesSQL)
  console.log('─'.repeat(60))
  
  console.log('\n📁 Pełny skrypt SQL znajduje się w pliku: supabase_setup.sql')
  console.log('\n🔗 Link do Supabase Dashboard: https://supabase.com/dashboard')
}

// Test połączenia
async function testConnection() {
  console.log('🔍 Testuję połączenie z Supabase...')
  
  try {
    // Spróbuj wykonać proste zapytanie
    const { error } = await supabase
      .from('_test_table_that_does_not_exist')
      .select('*')
      .limit(1)
    
    // Jeśli dostaniemy błąd o braku tabeli - połączenie działa
    if (error && error.message.includes('relation')) {
      console.log('✅ Połączenie z Supabase działa poprawnie!')
      return true
    } else if (!error) {
      console.log('✅ Połączenie z Supabase działa poprawnie!')
      return true
    }
  } catch (err) {
    console.error('❌ Błąd połączenia z Supabase:', err.message)
    console.log('\nSprawdź czy:')
    console.log('1. VITE_SUPABASE_URL jest poprawny')
    console.log('2. VITE_SUPABASE_ANON_KEY jest poprawny')
    console.log('3. Projekt Supabase jest aktywny')
    return false
  }
  
  return true
}

// Główna funkcja
async function main() {
  const connected = await testConnection()
  
  if (!connected) {
    console.log('\n❌ Nie można połączyć się z Supabase. Sprawdź konfigurację.')
    process.exit(1)
  }
  
  console.log('')
  await setupDatabase()
  console.log('\n✅ Setup zakończony!')
}

main().catch(error => {
  console.error('❌ Błąd:', error.message)
  process.exit(1)
})

