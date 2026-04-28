-- Table des actualités diffusées par Kultiva sous forme de stories.
-- Source unique de vérité : Kultiva (app), Kultivaprix (site web)
-- consomment cette table en lecture seule.

CREATE TABLE IF NOT EXISTS news_items (
  id           uuid          PRIMARY KEY DEFAULT gen_random_uuid(),
  title        text          NOT NULL CHECK (char_length(title) <= 80),
  caption      text          NOT NULL CHECK (char_length(caption) <= 280),
  image_url    text          NOT NULL,
  article_url  text,
  video_url    text,
  tags         text[]        NOT NULL DEFAULT '{}',
  priority     int           NOT NULL DEFAULT 0,
  published_at timestamptz   NOT NULL DEFAULT now(),
  created_at   timestamptz   NOT NULL DEFAULT now(),
  updated_at   timestamptz   NOT NULL DEFAULT now()
);

-- Index pour ordonner par date de publication décroissante.
CREATE INDEX IF NOT EXISTS news_items_published_at_idx
  ON news_items (published_at DESC);

-- Trigger pour maintenir updated_at automatiquement.
CREATE OR REPLACE FUNCTION touch_news_items_updated_at()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
  NEW.updated_at := now();
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_news_items_updated_at ON news_items;
CREATE TRIGGER trg_news_items_updated_at
  BEFORE UPDATE ON news_items
  FOR EACH ROW
  EXECUTE FUNCTION touch_news_items_updated_at();

-- RLS : tout le monde peut lire (anon + authentifié).
-- Personne ne peut écrire depuis l'app (gestion via Supabase Studio
-- avec la clé service_role).
ALTER TABLE news_items ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS news_items_read_all ON news_items;
CREATE POLICY news_items_read_all
  ON news_items FOR SELECT
  USING (true);

-- Pas de policy d'écriture : seules les opérations service_role
-- (ou via le dashboard Supabase) peuvent insérer/modifier/supprimer.

-- Bucket Storage pour les images des actus.
INSERT INTO storage.buckets (id, name, public)
VALUES ('news-images', 'news-images', true)
ON CONFLICT (id) DO NOTHING;

-- Lecture publique du bucket news-images.
DROP POLICY IF EXISTS news_images_read_all ON storage.objects;
CREATE POLICY news_images_read_all
  ON storage.objects FOR SELECT
  USING (bucket_id = 'news-images');
