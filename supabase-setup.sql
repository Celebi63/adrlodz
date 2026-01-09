-- ADR Łódź - Supabase Database Setup
-- Run this SQL in your Supabase SQL Editor

-- Create the trainings table
CREATE TABLE trainings (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  duration INTEGER NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  next_date DATE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW())
);

-- Enable Row Level Security (RLS)
ALTER TABLE trainings ENABLE ROW LEVEL SECURITY;

-- Create policy to allow public read access
CREATE POLICY "Allow public read access" ON trainings
  FOR SELECT
  USING (true);

-- Insert sample training data
INSERT INTO trainings (name, description, duration, price, next_date) VALUES
('Kurs podstawowy ADR', 'Szkolenie podstawowe dla kierowców przewożących towary niebezpieczne. Obejmuje wszystkie klasy towarów niebezpieczych z wyjątkiem klas 1 i 7.', 3, 1200.00, '2025-02-15'),
('Kurs ADR - Klasa 1', 'Specjalistyczne szkolenie dotyczące przewozu materiałów wybuchowych (klasa 1). Wymagane jest posiadanie certyfikatu podstawowego ADR.', 2, 800.00, '2025-02-20'),
('Kurs ADR - Cysterny', 'Szkolenie specjalistyczne dla kierowców przewożących towary niebezpieczne w cysternach. Dodatkowe uprawnienia do certyfikatu podstawowego.', 2, 900.00, '2025-03-01'),
('Kurs ADR - Klasa 7', 'Kurs specjalistyczny dotyczący przewozu materiałów radioaktywnych (klasa 7). Obejmuje szczegółowe procedury bezpieczeństwa.', 2, 850.00, '2025-03-10'),
('Kurs odświeżający ADR', 'Szkolenie dla kierowców posiadających certyfikat ADR, który wymaga przedłużenia. Przypomnienie najważniejszych przepisów i nowości.', 2, 600.00, '2025-02-25'),
('Kurs ADR Pełny', 'Kompleksowy kurs obejmujący wszystkie klasy towarów niebezpiecznych oraz uprawnienia do przewozu w cysternach.', 5, 2500.00, '2025-03-15');

-- Verify the data
SELECT * FROM trainings ORDER BY name;

