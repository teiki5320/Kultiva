-- ═══════════════════════════════════════════════════════════════════
-- Kultiva — Migration 010 : Modération du feed communautaire
-- À exécuter dans Supabase Dashboard → SQL Editor
-- ═══════════════════════════════════════════════════════════════════
--
-- Problème : actuellement n'importe qui peut poster dans le feed
-- et il n'existe aucun mécanisme pour signaler ou masquer du contenu
-- inapproprié.
--
-- Solution :
--   1. Ajouter les colonnes `hidden` et `reported_count` à
--      challenge_posts.
--   2. Créer la table `post_reports` (un signalement par utilisateur
--      par post, avec raison obligatoire).
--   3. RLS sur post_reports : chacun peut insérer et lire ses propres
--      signalements.
--   4. Trigger qui incrémente reported_count et masque le post
--      automatiquement à partir de 3 signalements.
--   5. Mettre à jour la policy SELECT de challenge_posts pour exclure
--      les posts masqués.


-- ─── 1. Nouvelles colonnes sur challenge_posts ─────────────────────

alter table public.challenge_posts
  add column if not exists hidden boolean not null default false;

alter table public.challenge_posts
  add column if not exists reported_count int not null default 0;


-- ─── 2. Table post_reports ──────────────────────────────────────────

create table if not exists public.post_reports (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  post_id uuid not null references public.challenge_posts(id) on delete cascade,
  reason text not null check (char_length(reason) <= 500),
  created_at timestamptz default now(),
  unique (user_id, post_id)
);

create index if not exists post_reports_post_idx
  on public.post_reports(post_id);


-- ─── 3. RLS sur post_reports ────────────────────────────────────────

alter table public.post_reports enable row level security;

-- Chaque utilisateur peut créer un signalement (un seul par post).
create policy "reports_insert_own" on public.post_reports
  for insert to authenticated with check (auth.uid() = user_id);

-- Chaque utilisateur peut voir ses propres signalements.
create policy "reports_select_own" on public.post_reports
  for select to authenticated using (auth.uid() = user_id);


-- ─── 4. Trigger : compteur de signalements + masquage auto ─────────

create or replace function public.update_reported_count()
returns trigger
language plpgsql
security definer
as $$
begin
  -- Incrémente le compteur et masque si ≥ 3 signalements.
  update public.challenge_posts
  set reported_count = reported_count + 1,
      hidden = (reported_count + 1 >= 3)
  where id = NEW.post_id;
  return NEW;
end;
$$;

drop trigger if exists on_report_insert on public.post_reports;
create trigger on_report_insert
  after insert on public.post_reports
  for each row execute function public.update_reported_count();


-- ─── 5. Mise à jour de la policy SELECT de challenge_posts ─────────

-- Supprime l'ancienne policy qui ne filtrait pas les posts masqués.
drop policy if exists "posts_select_all" on public.challenge_posts;

-- Nouvelle policy : exclut les posts masqués (hidden = true).
create policy "posts_select_visible" on public.challenge_posts
  for select to authenticated using (hidden = false);


-- ═══════════════════════════════════════════════════════════════════
-- Fin — vérifie dans Table Editor que post_reports existe et que
-- challenge_posts a les colonnes hidden + reported_count.
-- ═══════════════════════════════════════════════════════════════════
