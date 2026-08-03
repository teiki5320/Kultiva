-- ═══════════════════════════════════════════════════════════════════
-- Kultiva — Migration 016 : sous-zone climatique dans les préférences
-- À exécuter dans Supabase Dashboard → SQL Editor
-- ═══════════════════════════════════════════════════════════════════
--
-- Zones climatiques v2 : au sein d'un même pays, la sous-zone (sahel /
-- soudanien / guinéen) affine les calendriers et les saisons (Bamako
-- est soudanien, le nord de la Côte d'Ivoire aussi…). Détectée par
-- latitude GPS ou choisie manuellement. Le code client tolère l'absence
-- de la colonne (retry sans), mais la synchro de la zone ne fonctionne
-- qu'une fois cette migration appliquée.

alter table public.preferences
  add column if not exists climate_zone text;
