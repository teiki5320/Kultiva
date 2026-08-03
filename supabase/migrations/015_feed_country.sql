-- ═══════════════════════════════════════════════════════════════════
-- Kultiva — Migration 015 : pays du posteur dans le feed
-- À exécuter dans Supabase Dashboard → SQL Editor
-- ═══════════════════════════════════════════════════════════════════
--
-- Cap Afrique de l'Ouest : le feed peut être filtré par pays
-- (« Les jardins du Sénégal 🇸🇳 »). Le code client tolère l'absence de
-- la colonne (retry sans `country` au publish), mais le filtre ne
-- fonctionne qu'une fois cette migration appliquée.

alter table public.challenge_posts
  add column if not exists country text;

create index if not exists challenge_posts_country_idx
  on public.challenge_posts(country);
