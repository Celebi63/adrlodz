-- Extension: Pages/Content Management System
-- Dodaj to do istniejącej bazy danych

-- Tabela do przechowywania treści stron
CREATE TABLE IF NOT EXISTS page_contents (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  page_slug VARCHAR(100) NOT NULL UNIQUE, -- np. 'o-nas', 'przepisy-wstep', 'przepisy-zwolnienia'
  page_title VARCHAR(255) NOT NULL,
  page_category VARCHAR(50), -- 'main', 'przepisy', 'kursy', 'quizy'
  content_sections JSONB NOT NULL DEFAULT '[]'::jsonb, -- Array sekcji z tytułami i treścią
  meta_description TEXT,
  is_published BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Insertuję domyślne strony z obecną treścią

-- Strona O Nas
INSERT INTO page_contents (page_slug, page_title, page_category, content_sections, meta_description) VALUES
('o-nas', 'O nas', 'main', 
'[
  {
    "id": "intro",
    "title": "ADR Łódź - Twój partner w szkoleniach",
    "content": "Jesteśmy doświadczonym ośrodkiem szkoleniowym specjalizującym się w kursach ADR dla kierowców i przewoźników. Od wielu lat pomagamy profesjonalistom z branży transportowej zdobywać kwalifikacje niezbędne do przewozu towarów niebezpiecznych.\n\nNasze szkolenia prowadzą wykwalifikowani instruktorzy z wieloletnim doświadczeniem praktycznym. Zapewniamy kompleksową wiedzę teoretyczną oraz praktyczne wskazówki, które przydadzą się w codziennej pracy.\n\nCertyfikaty wydawane przez nasz ośrodek są uznawane w całej Europie zgodnie z międzynarodowymi przepisami ADR."
  },
  {
    "id": "why-us",
    "title": "Dlaczego my?",
    "content": "• Certyfikowane szkolenia zgodne z przepisami\n• Doświadczeni instruktorzy-praktycy\n• Nowoczesne materiały szkoleniowe\n• Dogodne terminy szkoleń\n• Konkurencyjne ceny\n• Wsparcie po zakończeniu kursu"
  },
  {
    "id": "mission",
    "title": "Nasza misja",
    "content": "Naszym celem jest zapewnienie najwyższej jakości szkoleń ADR, które nie tylko przygotują Cię do zdania egzaminu, ale przede wszystkim wyposażą w praktyczną wiedzę niezbędną w codziennej pracy kierowcy przewożącego towary niebezpieczne."
  }
]'::jsonb,
'Poznaj ADR Łódź - doświadczony ośrodek szkoleniowy specjalizujący się w kursach ADR'
),

-- Przepisy - Wstęp
('przepisy-wstep', 'Wstęp do przepisów ADR', 'przepisy',
'[
  {
    "id": "main",
    "title": "Wprowadzenie do ADR",
    "content": "ADR (Accord européen relatif au transport international des marchandises Dangereuses par Route) to europejska umowa dotycząca międzynarodowego przewozu drogowego towarów niebezpiecznych.\n\nPrzewoźnicy towarów niebezpiecznych muszą przestrzegać szeregu przepisów dotyczących bezpieczeństwa, oznakowania, dokumentacji i szkoleń.\n\nPoniżej znajdziesz podstawowe informacje o przepisach ADR obowiązujących w transporcie drogowym."
  }
]'::jsonb,
'Podstawowe informacje o przepisach ADR'
),

-- Przepisy - Klasyfikacja
('przepisy-klasyfikacja', 'Klasyfikacja towarów niebezpiecznych', 'przepisy',
'[
  {
    "id": "main",
    "title": "Klasy towarów niebezpiecznych",
    "content": "Towary niebezpieczne są podzielone na 9 klas według rodzaju zagrożenia:\n\nKlasa 1: Materiały i przedmioty wybuchowe\nKlasa 2: Gazy\nKlasa 3: Ciecze łatwopalne\nKlasa 4.1: Ciała stałe łatwopalne\nKlasa 4.2: Materiały samozapalne\nKlasa 4.3: Materiały wytwarzające w zetknięciu z wodą gazy łatwopalne\nKlasa 5.1: Materiały utleniające\nKlasa 5.2: Nadtlenki organiczne\nKlasa 6.1: Materiały trujące\nKlasa 6.2: Materiały zakaźne\nKlasa 7: Materiały promieniotwórcze\nKlasa 8: Materiały żrące\nKlasa 9: Różne materiały i przedmioty niebezpieczne"
  }
]'::jsonb,
'Poznaj 9 klas towarów niebezpiecznych zgodnie z przepisami ADR'
),

-- Przepisy - Zwolnienia
('przepisy-zwolnienia', 'Zwolnienia z przepisów ADR', 'przepisy',
'[
  {
    "id": "main",
    "title": "Kiedy można zastosować zwolnienia?",
    "content": "Zwolnienia z przepisów ADR dotyczą sytuacji, w których przewóz towarów niebezpiecznych nie wymaga pełnego stosowania przepisów.\n\nGłówne rodzaje zwolnień:\n\n1. Zwolnienia dotyczące transportu niektórych towarów niebezpiecznych w ograniczonych ilościach (LQ)\n2. Zwolnienia dotyczące ilości przewożonych na jednostkę transportową\n3. Zwolnienia dla małych ilości (1.1.3.6)\n4. Zwolnienia związane z charakterem operacji transportowych\n\nWażne: Nawet przy zwolnieniach kierowca powinien znać podstawowe zasady bezpieczeństwa."
  }
]'::jsonb,
'Dowiedz się kiedy możesz skorzystać ze zwolnień z przepisów ADR'
),

-- Przepisy - Oznakowanie
('przepisy-oznakowanie', 'Oznakowanie pojazdów i przesyłek', 'przepisy',
'[
  {
    "id": "main",
    "title": "Wymagane oznakowanie",
    "content": "Pojazdy przewożące towary niebezpieczne muszą być odpowiednio oznakowane:\n\n**Tablice ostrzegawcze pomarańczowe:**\n- Wymiary: 40 x 30 cm\n- Montowane z przodu i z tyłu pojazdu\n- Dla niektórych towarów zawierają numery identyfikacyjne\n\n**Etykiety (nalepki) ostrzegawcze:**\n- Wymiary: minimum 25 x 25 cm\n- Umieszczane na bokach i z tyłu pojazdu\n- Pokazują klasę zagrożenia\n\n**Numery UN:**\n- 4-cyfrowy kod identyfikujący substancję\n- Umieszczany na tablicach pomarańczowych\n\n**Znaki dotyczące temperatury:**\n- Dla substancji przewożonych w określonej temperaturze"
  }
]'::jsonb,
'Dowiedz się jak prawidłowo oznakować pojazd przewożący towary niebezpieczne'
);

-- Dodaj indeksy
CREATE INDEX IF NOT EXISTS idx_page_slug ON page_contents(page_slug);
CREATE INDEX IF NOT EXISTS idx_page_category ON page_contents(page_category);
CREATE INDEX IF NOT EXISTS idx_page_published ON page_contents(is_published);

-- Enable RLS
ALTER TABLE page_contents ENABLE ROW LEVEL SECURITY;

-- Public read access
CREATE POLICY "Public read access for published pages" ON page_contents 
  FOR SELECT USING (is_published = true);

-- Admin write access
CREATE POLICY "Authenticated users can manage pages" ON page_contents 
  FOR ALL USING (auth.role() = 'authenticated');

-- Add updated_at trigger
CREATE TRIGGER update_page_contents_updated_at BEFORE UPDATE ON page_contents 
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Dodaj pozostałe strony przepisów (możesz je wypełnić później przez CMS)
INSERT INTO page_contents (page_slug, page_title, page_category, content_sections) VALUES
('przepisy-zagrozenia', 'Zagrożenia i właściwości', 'przepisy', '[{"id":"main","title":"Zagrożenia","content":"Treść do uzupełnienia przez panel administracyjny"}]'::jsonb),
('przepisy-tunele', 'Przejazd przez tunele', 'przepisy', '[{"id":"main","title":"Tunele","content":"Treść do uzupełnienia przez panel administracyjny"}]'::jsonb),
('przepisy-dokument-przewozowy', 'Dokument przewozowy', 'przepisy', '[{"id":"main","title":"Dokument przewozowy","content":"Treść do uzupełnienia przez panel administracyjny"}]'::jsonb),
('przepisy-instrukcja', 'Instrukcje pisemne', 'przepisy', '[{"id":"main","title":"Instrukcje","content":"Treść do uzupełnienia przez panel administracyjny"}]'::jsonb),
('przepisy-cysterny', 'Cysterny', 'przepisy', '[{"id":"main","title":"Cysterny","content":"Treść do uzupełnienia przez panel administracyjny"}]'::jsonb),
('przepisy-hierarchizacja', 'Hierarchizacja przepisów', 'przepisy', '[{"id":"main","title":"Hierarchizacja","content":"Treść do uzupełnienia przez panel administracyjny"}]'::jsonb),
('przepisy-klasa-1', 'Klasa 1 - Materiały wybuchowe', 'przepisy', '[{"id":"main","title":"Klasa 1","content":"Treść do uzupełnienia przez panel administracyjny"}]'::jsonb),
('przepisy-klasa-7', 'Klasa 7 - Materiały promieniotwórcze', 'przepisy', '[{"id":"main","title":"Klasa 7","content":"Treść do uzupełnienia przez panel administracyjny"}]'::jsonb)
ON CONFLICT (page_slug) DO NOTHING;
