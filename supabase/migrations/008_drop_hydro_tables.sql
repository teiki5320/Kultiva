-- ═══════════════════════════════════════════════════════════════════
-- Kultiva — Migration 008 : suppression des tables hydroponie
-- À exécuter une seule fois dans Supabase Dashboard → SQL Editor
-- ═══════════════════════════════════════════════════════════════════
--
-- La feature hydroponie a été retirée de l'app en mai 2026 (le code
-- complet est conservé sur la branche `archive/hydroponie-2026-05-03`
-- pour réintégration future). Cette migration supprime les objets
-- côté Postgres qui n'ont plus de client :
--
--   - `culture_readings`   (mesures pH/EC/T°/niveau, migration 005)
--   - `hydro_builds`       (partages de build, migration 006)
--   - `hydro_build_likes`  (likes des builds, migration 006)
--   - trigger + fonction de comptage des likes
--
-- ⚠️ ATTENTION : DESTRUCTIF — toutes les données associées sont
-- effacées. À n'exécuter qu'après vérification que plus aucun
-- utilisateur connecté n'utilise une version pré-mai 2026 de l'app
-- (sinon ses INSERT échoueront silencieusement).
--
-- Si tu veux migrer les hydro_builds existants vers une autre table
-- pour conservation, fais-le AVANT de lancer cette migration.

drop trigger if exists trg_update_hydro_build_likes_count
    on public.hydro_build_likes;

drop function if exists public.update_hydro_build_likes_count();

drop table if exists public.hydro_build_likes cascade;
drop table if exists public.hydro_builds cascade;
drop table if exists public.culture_readings cascade;
