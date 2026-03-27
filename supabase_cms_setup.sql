-- Admin CMS Tables for ADR Łódź

-- 1. Courses table - przechowuje informacje o kursach
CREATE TABLE IF NOT EXISTS courses (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  course_type VARCHAR(50) NOT NULL UNIQUE, -- 'podstawowy', 'cysterny', 'klasa1', 'klasa7', 'odswiezajacy'
  title VARCHAR(255) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  duration VARCHAR(100),
  next_date VARCHAR(100),
  exam_date VARCHAR(100),
  description TEXT,
  program JSONB, -- Array of program items
  requirements JSONB, -- Array of requirements
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. Site settings table - ustawienia strony (kontakt, NIP, etc.)
CREATE TABLE IF NOT EXISTS site_settings (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  setting_key VARCHAR(100) NOT NULL UNIQUE,
  setting_value TEXT,
  setting_type VARCHAR(50) DEFAULT 'text', -- 'text', 'number', 'email', 'phone'
  category VARCHAR(50), -- 'contact', 'company', 'hero', etc.
  label VARCHAR(255),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 3. Gallery images table - zdjęcia do galerii ośrodka
CREATE TABLE IF NOT EXISTS gallery_images (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  image_url TEXT NOT NULL,
  title VARCHAR(255),
  description TEXT,
  display_order INTEGER DEFAULT 0,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 4. Hero section table - treść na hero section
CREATE TABLE IF NOT EXISTS hero_content (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  next_course_date VARCHAR(255),
  exam_date VARCHAR(255),
  registration_deadline VARCHAR(255),
  is_active BOOLEAN DEFAULT true,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Insert default courses data
INSERT INTO courses (course_type, title, price, duration, next_date, exam_date, description, program, requirements) VALUES
('podstawowy', 'Kurs ADR Podstawowy', 1200.00, '3 dni (24 godziny)', '15-17 Lutego 2025', '18 Lutego 2025', 
  'Kurs podstawowy ADR to szkolenie wymagane dla kierowców przewożących towary niebezpieczne. Po ukończeniu kursu i zdaniu egzaminu otrzymasz świadectwo ADR ważne przez 5 lat.',
  '["Przepisy krajowe i międzynarodowe dotyczące przewozu towarów niebezpiecznych", "Klasyfikacja towarów niebezpiecznych", "Oznakowanie pojazdów i opakowań", "Dokumenty przewozowe", "Postępowanie w sytuacjach awaryjnych", "Bezpieczeństwo podczas załadunku i rozładunku"]'::jsonb,
  '["Prawo jazdy kategorii B lub wyższej", "Ukończone 21 lat (18 lat dla przewozu krajowego)", "Ważne badania lekarskie", "Zdjęcie 35x45mm", "Kopia prawa jazdy i dowodu osobistego"]'::jsonb
),
('cysterny', 'Kurs ADR - Cysterny', 900.00, '2 dni (16 godzin)', '1-2 Marca 2025', '3 Marca 2025',
  'Kurs specjalistyczny ADR - Cysterny to dodatkowe uprawnienie dla kierowców posiadających certyfikat ADR podstawowy. Umożliwia przewóz towarów niebezpiecznych w cysternach o pojemności powyżej 1000 litrów.',
  '["Przepisy dotyczące przewozu w cysternach", "Konstrukcja i wyposażenie cystern", "Oznakowanie i tablice ostrzegawcze", "Napełnianie i opróżnianie cystern", "Stopień napełnienia - obliczenia", "Postępowanie awaryjne specyficzne dla cystern"]'::jsonb,
  '["Ważne świadectwo ADR podstawowe", "Prawo jazdy odpowiedniej kategorii", "Ukończone 21 lat", "Ważne badania lekarskie", "Zdjęcie 35x45mm", "Kopia świadectwa ADR podstawowego"]'::jsonb
),
('klasa1', 'Kurs ADR - Klasa 1 (Materiały Wybuchowe)', 800.00, '2 dni (16 godzin)', '8-9 Marca 2025', '10 Marca 2025',
  'Kurs specjalistyczny ADR - Klasa 1 to dodatkowe uprawnienie dla kierowców posiadających certyfikat ADR podstawowy. Uprawnia do przewozu materiałów i przedmiotów wybuchowych oraz wyrobów pirotechnicznych.',
  '["Klasyfikacja materiałów wybuchowych", "Przepisy specyficzne dla klasy 1", "Grupy zgodności i ich znaczenie", "Zasady pakowania i oznakowania", "Dokumentacja przewozowa dla klasy 1", "Środki ostrożności i procedury awaryjne", "Zabezpieczenie przed kradzieżą"]'::jsonb,
  '["Ważne świadectwo ADR podstawowe", "Prawo jazdy odpowiedniej kategorii", "Ukończone 21 lat", "Ważne badania lekarskie", "Zdjęcie 35x45mm", "Kopia świadectwa ADR podstawowego"]'::jsonb
),
('klasa7', 'Kurs ADR - Klasa 7 (Materiały Promieniotwórcze)', 850.00, '2 dni (16 godzin)', '12-13 Marca 2025', '14 Marca 2025',
  'Kurs specjalistyczny ADR - Klasa 7 to dodatkowe uprawnienie dla kierowców posiadających certyfikat ADR podstawowy. Uprawnia do przewozu materiałów promieniotwórczych stosowanych w medycynie, przemyśle i nauce.',
  '["Podstawy fizyki jądrowej i promieniowania", "Klasyfikacja materiałów promieniotwórczych", "Kategorie przesyłek klasy 7", "Specjalne wymagania dotyczące opakowań", "Oznakowanie i etykietowanie", "Indeks transportowy i kategorie transportowe", "Procedury awaryjne i ochrona radiologiczna"]'::jsonb,
  '["Ważne świadectwo ADR podstawowe", "Prawo jazdy odpowiedniej kategorii", "Ukończone 21 lat", "Ważne badania lekarskie", "Zdjęcie 35x45mm", "Kopia świadectwa ADR podstawowego"]'::jsonb
),
('odswiezajacy', 'Kurs Odświeżający ADR', 800.00, '2 dni (16 godzin)', '22-23 Marca 2025', '24 Marca 2025',
  'Kurs odświeżający ADR jest obowiązkowy dla wszystkich kierowców posiadających świadectwo ADR, które wygasa lub wygasło nie wcześniej niż rok przed rozpoczęciem kursu. Pozwala przedłużyć ważność certyfikatu na kolejne 5 lat.',
  '["Zmiany w przepisach ADR od ostatniego szkolenia", "Przypomnienie podstawowych zasad bezpieczeństwa", "Aktualizacja wiedzy o klasyfikacji towarów", "Nowe oznakowania i dokumenty przewozowe", "Procedury awaryjne - aktualizacja", "Najczęstsze błędy w praktyce przewozowej", "Zmiany w zakresie uprawnień specjalistycznych"]'::jsonb,
  '["Świadectwo ADR (nawet przeterminowane)", "Kurs musi być ukończony przed upływem 1 roku od wygaśnięcia", "Prawo jazdy odpowiedniej kategorii", "Ważne badania lekarskie", "Zdjęcie 35x45mm", "Kopia dotychczasowego świadectwa ADR"]'::jsonb
)
ON CONFLICT (course_type) DO NOTHING;

-- Insert default site settings
INSERT INTO site_settings (setting_key, setting_value, setting_type, category, label) VALUES
('contact_phone', '+48 663 234 234', 'phone', 'contact', 'Telefon kontaktowy'),
('contact_address_street', 'ul. Wersalska 47/pok 709', 'text', 'contact', 'Ulica i numer'),
('contact_address_city', '91-212 Łódź', 'text', 'contact', 'Kod pocztowy i miasto'),
('company_nip', '123-456-78-90', 'text', 'company', 'NIP'),
('company_account_number', '12 3456 7890 1234 5678 9012 3456', 'text', 'company', 'Numer konta bankowego'),
('hero_title', 'Kursy ADR Łódź', 'text', 'hero', 'Tytuł na stronie głównej'),
('stats_graduates', '500+', 'text', 'stats', 'Liczba absolwentów'),
('stats_experience', '10+', 'text', 'stats', 'Lata doświadczenia'),
('stats_pass_rate', '98%', 'text', 'stats', 'Procent zdawalności')
ON CONFLICT (setting_key) DO NOTHING;

-- Insert default hero content
INSERT INTO hero_content (title, next_course_date, exam_date, registration_deadline, is_active) VALUES
('Kursy ADR Łódź', '15-17 Lutego 2025', '18 Lutego 2025', 'Zgłoszenia do czwartku włącznie.', true)
ON CONFLICT DO NOTHING;

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_courses_type ON courses(course_type);
CREATE INDEX IF NOT EXISTS idx_settings_key ON site_settings(setting_key);
CREATE INDEX IF NOT EXISTS idx_settings_category ON site_settings(category);
CREATE INDEX IF NOT EXISTS idx_gallery_order ON gallery_images(display_order);
CREATE INDEX IF NOT EXISTS idx_gallery_active ON gallery_images(is_active);

-- Enable Row Level Security
ALTER TABLE courses ENABLE ROW LEVEL SECURITY;
ALTER TABLE site_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE gallery_images ENABLE ROW LEVEL SECURITY;
ALTER TABLE hero_content ENABLE ROW LEVEL SECURITY;

-- Public read access for all CMS tables
CREATE POLICY "Public read access for courses" ON courses FOR SELECT USING (true);
CREATE POLICY "Public read access for site_settings" ON site_settings FOR SELECT USING (true);
CREATE POLICY "Public read access for gallery_images" ON gallery_images FOR SELECT USING (true);
CREATE POLICY "Public read access for hero_content" ON hero_content FOR SELECT USING (true);

-- Admin write access (authenticated users only)
CREATE POLICY "Authenticated users can manage courses" ON courses 
  FOR ALL USING (auth.role() = 'authenticated');
  
CREATE POLICY "Authenticated users can manage site_settings" ON site_settings 
  FOR ALL USING (auth.role() = 'authenticated');
  
CREATE POLICY "Authenticated users can manage gallery_images" ON gallery_images 
  FOR ALL USING (auth.role() = 'authenticated');
  
CREATE POLICY "Authenticated users can manage hero_content" ON hero_content 
  FOR ALL USING (auth.role() = 'authenticated');

-- Add updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for updated_at
CREATE TRIGGER update_courses_updated_at BEFORE UPDATE ON courses 
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
  
CREATE TRIGGER update_site_settings_updated_at BEFORE UPDATE ON site_settings 
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
  
CREATE TRIGGER update_hero_content_updated_at BEFORE UPDATE ON hero_content 
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
