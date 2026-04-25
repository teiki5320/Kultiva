-- ═══════════════════════════════════════════════════════════════════
-- Kultiva — Migration 005 : mesures du cahier de culture
-- À exécuter une seule fois dans Supabase Dashboard → SQL Editor
-- ═══════════════════════════════════════════════════════════════════
--
-- Crée la table `culture_readings` qui stocke les mesures ponctuelles
-- attachées aux cultures du cahier (pH, EC, température solution,
-- niveau réservoir pour l'hydroponie ; température sol, récolte,
-- observations pour la pleine terre).
--
-- Le cahier (table cultures) reste local-first via SharedPreferences ;
-- cette table est prête pour une sync future. Pas encore branchée à
-- CloudSyncService.

create table if not exists public.culture_readings (
  id text primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  culture_id text not null,
  recorded_at timestamptz not null,
  type text not null,
  value double precision,
  unit text not null default '',
  note text,
  created_at timestamptz default now()
);

create index if not exists culture_readings_user_id_idx
  on public.culture_readings(user_id);

create index if not exists culture_readings_culture_id_idx
  on public.culture_readings(culture_id);

create index if not exists culture_readings_recorded_at_idx
  on public.culture_readings(recorded_at);


-- ─── RLS : own only ────────────────────────────────────────────────

alter table public.culture_readings enable row level security;

create policy "culture_readings_select_own" on public.culture_readings
  for select to authenticated using (auth.uid() = user_id);

create policy "culture_readings_insert_own" on public.culture_readings
  for insert to authenticated with check (auth.uid() = user_id);

create policy "culture_readings_update_own" on public.culture_readings
  for update to authenticated using (auth.uid() = user_id);

create policy "culture_readings_delete_own" on public.culture_readings
  for delete to authenticated using (auth.uid() = user_id);
