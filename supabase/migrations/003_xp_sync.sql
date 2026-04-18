-- Migration 003 : Sync XP de la créature Tamassi.
-- Un seul row par utilisateur (upsert pattern).

create table if not exists public.user_xp (
  user_id uuid primary key references auth.users(id) on delete cascade,
  xp int not null default 1,
  starter text, -- 'poussia', 'soleia', 'spira'
  creature_name text,
  updated_at timestamptz default now()
);

alter table public.user_xp enable row level security;

create policy "xp_all_own" on public.user_xp
  for all using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- Réutilise la trigger function déjà créée dans 001.
create trigger user_xp_touch_updated_at
  before update on public.user_xp
  for each row execute function public.touch_updated_at();
