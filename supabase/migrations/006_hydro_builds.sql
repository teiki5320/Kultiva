-- ═══════════════════════════════════════════════════════════════════
-- Kultiva — Migration 006 : partage de builds hydroponiques
-- À exécuter une seule fois dans Supabase Dashboard → SQL Editor
-- ═══════════════════════════════════════════════════════════════════
--
-- Permet à un utilisateur de partager publiquement son installation
-- hydroponique : type de système (DWC, NFT, Kratky, etc.), liste
-- d'équipements, photo et description courte. Inspirations pour la
-- communauté.
--
-- Lecture publique (authentifiés) ; écriture/suppression sur ses
-- propres builds uniquement.

create table if not exists public.hydro_builds (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  system_type text not null,
  equipment jsonb default '[]'::jsonb,
  photo_url text,
  caption text,
  vegetable_id text,
  likes_count int default 0,
  created_at timestamptz default now()
);

create index if not exists hydro_builds_created_idx
  on public.hydro_builds(created_at desc);
create index if not exists hydro_builds_user_idx
  on public.hydro_builds(user_id);
create index if not exists hydro_builds_system_idx
  on public.hydro_builds(system_type);


-- ─── Likes spécifiques aux builds (table séparée du feed défis) ────

create table if not exists public.hydro_build_likes (
  user_id uuid not null references auth.users(id) on delete cascade,
  build_id uuid not null references public.hydro_builds(id)
    on delete cascade,
  created_at timestamptz default now(),
  primary key (user_id, build_id)
);


-- ─── RLS ───────────────────────────────────────────────────────────

alter table public.hydro_builds enable row level security;
alter table public.hydro_build_likes enable row level security;

create policy "hydro_builds_select_all" on public.hydro_builds
  for select to authenticated using (true);

create policy "hydro_builds_insert_own" on public.hydro_builds
  for insert to authenticated with check (auth.uid() = user_id);

create policy "hydro_builds_update_own" on public.hydro_builds
  for update to authenticated using (auth.uid() = user_id);

create policy "hydro_builds_delete_own" on public.hydro_builds
  for delete to authenticated using (auth.uid() = user_id);

create policy "hydro_build_likes_select_all" on public.hydro_build_likes
  for select to authenticated using (true);

create policy "hydro_build_likes_insert_own" on public.hydro_build_likes
  for insert to authenticated with check (auth.uid() = user_id);

create policy "hydro_build_likes_delete_own" on public.hydro_build_likes
  for delete to authenticated using (auth.uid() = user_id);


-- ─── Trigger compteur de likes ─────────────────────────────────────

create or replace function public.update_hydro_build_likes_count()
returns trigger
language plpgsql
security definer
as $$
begin
  if (TG_OP = 'INSERT') then
    update public.hydro_builds
    set likes_count = likes_count + 1
    where id = NEW.build_id;
    return NEW;
  elsif (TG_OP = 'DELETE') then
    update public.hydro_builds
    set likes_count = likes_count - 1
    where id = OLD.build_id;
    return OLD;
  end if;
  return null;
end;
$$;

drop trigger if exists on_hydro_build_like_change
  on public.hydro_build_likes;
create trigger on_hydro_build_like_change
  after insert or delete on public.hydro_build_likes
  for each row execute function public.update_hydro_build_likes_count();
