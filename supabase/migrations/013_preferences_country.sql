-- ═══════════════════════════════════════════════════════════════════
-- Kultiva — Migration 013 : colonne pays dans les préférences
-- À exécuter dans Supabase Dashboard → SQL Editor
-- ═══════════════════════════════════════════════════════════════════
--
-- Cap Afrique de l'Ouest : l'utilisateur choisit désormais un pays
-- (FR, SN, CI, ML, BF, BJ, TG, NE, GN) qui détermine sa région, ses
-- saisons et sa position météo de secours. Le code client tolère
-- l'absence de la colonne (retry sans `country`), mais la synchro du
-- pays ne fonctionne qu'une fois cette migration appliquée.

alter table public.preferences
  add column if not exists country text;
