-- ═══════════════════════════════════════════════════════════════════
-- Kultiva — Migration initiale
-- À exécuter une seule fois dans Supabase Dashboard → SQL Editor
-- ═══════════════════════════════════════════════════════════════════
--
-- Crée 4 tables :
--   1. profiles           — profil public (display_name, email)
--   2. plantations        — la collection Poussidex de l'utilisateur
--   3. unlocked_badges    — badges débloqués
--   4. preferences        — préférences (région, son, etc.)
--
-- Ajoute Row Level Security (RLS) pour que chaque utilisateur ne voie
-- QUE ses propres données. Ajoute un trigger qui crée un profil
-- automatiquement à l'inscription.


-- ─── 1. Table profiles ──────────────────────────────────────────────

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text,
  email text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);


-- ─── 2. Table plantations ───────────────────────────────────────────

create table if not exists public.plantations (
  id text primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  vegetable_id text not null,
  planted_at timestamptz not null,
  harvested_at timestamptz,
  harvest_count int default 0,
  watered_at jsonb default '[]'::jsonb,
  note text,
  photo_paths jsonb default '[]'::jsonb,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create index if not exists plantations_user_id_idx
  on public.plantations(user_id);


-- ─── 3. Table unlocked_badges ───────────────────────────────────────

create table if not exists public.unlocked_badges (
  user_id uuid not null references auth.users(id) on delete cascade,
  badge_id text not null,
  unlocked_at timestamptz default now(),
  primary key (user_id, badge_id)
);


-- ─── 4. Table preferences ───────────────────────────────────────────

create table if not exists public.preferences (
  user_id uuid primary key references auth.users(id) on delete cascade,
  region text default 'france',
  dark_mode bool default false,
  notifications bool default true,
  sound_enabled bool default true,
  music_enabled bool default false,
  sound_volume real default 0.7,
  updated_at timestamptz default now()
);


-- ─── RLS : chaque utilisateur voit UNIQUEMENT ses données ───────────

alter table public.profiles enable row level security;
alter table public.plantations enable row level security;
alter table public.unlocked_badges enable row level security;
alter table public.preferences enable row level security;

-- Profiles
create policy "profiles_select_own" on public.profiles
  for select using (auth.uid() = id);
create policy "profiles_insert_own" on public.profiles
  for insert with check (auth.uid() = id);
create policy "profiles_update_own" on public.profiles
  for update using (auth.uid() = id);

-- Plantations (all = select/insert/update/delete)
create policy "plantations_all_own" on public.plantations
  for all using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- Badges
create policy "badges_all_own" on public.unlocked_badges
  for all using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- Preferences
create policy "prefs_all_own" on public.preferences
  for all using (auth.uid() = user_id)
  with check (auth.uid() = user_id);


-- ─── Trigger : crée un profil auto à l'inscription ──────────────────

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, email, display_name)
  values (
    new.id,
    new.email,
    coalesce(new.raw_user_meta_data ->> 'display_name',
             split_part(new.email, '@', 1))
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();


-- ─── Trigger : met à jour updated_at automatiquement ────────────────

create or replace function public.touch_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists plantations_touch_updated_at on public.plantations;
create trigger plantations_touch_updated_at
  before update on public.plantations
  for each row execute function public.touch_updated_at();

drop trigger if exists profiles_touch_updated_at on public.profiles;
create trigger profiles_touch_updated_at
  before update on public.profiles
  for each row execute function public.touch_updated_at();

drop trigger if exists preferences_touch_updated_at on public.preferences;
create trigger preferences_touch_updated_at
  before update on public.preferences
  for each row execute function public.touch_updated_at();


-- ═══════════════════════════════════════════════════════════════════
-- Fin — vérifie dans Dashboard → Table Editor que les 4 tables sont là.
-- ═══════════════════════════════════════════════════════════════════
