-- ============================================
-- SQL Setup dla ADR Łódź - Supabase Tables
-- ============================================

-- Tabela: registrations (Rejestracje na kursy)
-- --------------------------------------------
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

-- Indeksy dla lepszej wydajności
CREATE INDEX idx_registrations_email ON registrations(email);
CREATE INDEX idx_registrations_course_type ON registrations(course_type);
CREATE INDEX idx_registrations_created_at ON registrations(created_at DESC);

-- Automatyczna aktualizacja updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_registrations_updated_at
  BEFORE UPDATE ON registrations
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- ============================================

-- Tabela: quiz_results (Wyniki quizów)
-- --------------------------------------------
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

-- Indeksy
CREATE INDEX idx_quiz_results_quiz_type ON quiz_results(quiz_type);
CREATE INDEX idx_quiz_results_passed ON quiz_results(passed);
CREATE INDEX idx_quiz_results_completed_at ON quiz_results(completed_at DESC);

-- ============================================

-- RLS (Row Level Security) Policies
-- Włączenie RLS dla bezpieczeństwa
-- --------------------------------------------

-- Włącz RLS dla registrations
ALTER TABLE registrations ENABLE ROW LEVEL SECURITY;

-- Polityka: Wszyscy mogą wstawiać nowe rejestracje
CREATE POLICY "Anyone can insert registrations"
  ON registrations
  FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

-- Polityka: Tylko authenticated mogą czytać rejestracje
CREATE POLICY "Authenticated users can read registrations"
  ON registrations
  FOR SELECT
  TO authenticated
  USING (true);

-- --------------------------------------------

-- Włącz RLS dla quiz_results
ALTER TABLE quiz_results ENABLE ROW LEVEL SECURITY;

-- Polityka: Wszyscy mogą wstawiać wyniki quizów
CREATE POLICY "Anyone can insert quiz results"
  ON quiz_results
  FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

-- Polityka: Tylko authenticated mogą czytać wyniki
CREATE POLICY "Authenticated users can read quiz results"
  ON quiz_results
  FOR SELECT
  TO authenticated
  USING (true);

-- ============================================

-- Przykładowe zapytania (do testowania)
-- --------------------------------------------

-- Wyświetl wszystkie rejestracje
-- SELECT * FROM registrations ORDER BY created_at DESC;

-- Wyświetl rejestracje dla konkretnego kursu
-- SELECT * FROM registrations WHERE course_type = 'podstawowy' ORDER BY created_at DESC;

-- Statystyki quizów
-- SELECT 
--   quiz_type,
--   COUNT(*) as total_attempts,
--   COUNT(*) FILTER (WHERE passed = true) as passed_count,
--   ROUND(AVG(percentage), 2) as avg_percentage
-- FROM quiz_results
-- GROUP BY quiz_type;

-- Ostatnie wyniki quizów
-- SELECT * FROM quiz_results ORDER BY completed_at DESC LIMIT 10;

-- ============================================
-- UWAGA: Uruchom ten skrypt w Supabase SQL Editor
-- ============================================

