-- ═══════════════════════════════════════════════════════════════════
-- Kultiva — Migration 012 : FK challenge_posts → profiles
-- À exécuter dans Supabase Dashboard → SQL Editor
-- ═══════════════════════════════════════════════════════════════════
--
-- Le feed joint `challenge_posts` à `profiles(display_name)` via
-- l'embedding PostgREST, qui exige une clé étrangère DIRECTE entre les
-- deux tables. Or challenge_posts.user_id ne référençait que
-- auth.users : la jointure échouait (PGRST200) et le feed restait vide.
--
-- On ajoute la FK vers profiles (qui partage sa PK avec auth.users).
-- Les éventuels posts orphelins (utilisateur sans profil, cas
-- théoriquement impossible grâce au trigger handle_new_user) sont
-- nettoyés d'abord pour que la contrainte passe.

delete from public.challenge_posts p
where not exists (
  select 1 from public.profiles pr where pr.id = p.user_id
);

alter table public.challenge_posts
  add constraint challenge_posts_user_id_profiles_fkey
  foreign key (user_id) references public.profiles(id) on delete cascade;
