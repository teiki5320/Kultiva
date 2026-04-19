-- ═══════════════════════════════════════════════════════════════════
-- Kultiva — Migration 002 : Feed communautaire des défis photo
-- À exécuter dans Supabase Dashboard → SQL Editor
-- ═══════════════════════════════════════════════════════════════════

-- 1. Posts de défis (chaque soumission de défi = un post dans le feed)
create table if not exists public.challenge_posts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  challenge_id text not null,
  photo_url text not null,
  caption text,
  likes_count int default 0,
  created_at timestamptz default now()
);

create index if not exists challenge_posts_created_idx
  on public.challenge_posts(created_at desc);
create index if not exists challenge_posts_user_idx
  on public.challenge_posts(user_id);

-- 2. Likes (un user ne peut liker un post qu'une fois)
create table if not exists public.post_likes (
  user_id uuid not null references auth.users(id) on delete cascade,
  post_id uuid not null references public.challenge_posts(id) on delete cascade,
  created_at timestamptz default now(),
  primary key (user_id, post_id)
);

-- 3. RLS
alter table public.challenge_posts enable row level security;
alter table public.post_likes enable row level security;

-- Posts : tout le monde peut lire, seul le propriétaire peut écrire/supprimer
create policy "posts_select_all" on public.challenge_posts
  for select to authenticated using (true);
create policy "posts_insert_own" on public.challenge_posts
  for insert to authenticated with check (auth.uid() = user_id);
create policy "posts_delete_own" on public.challenge_posts
  for delete to authenticated using (auth.uid() = user_id);

-- Likes : tout le monde peut lire, chacun gère ses propres likes
create policy "likes_select_all" on public.post_likes
  for select to authenticated using (true);
create policy "likes_insert_own" on public.post_likes
  for insert to authenticated with check (auth.uid() = user_id);
create policy "likes_delete_own" on public.post_likes
  for delete to authenticated using (auth.uid() = user_id);

-- 4. Fonction pour incrémenter/décrémenter likes_count automatiquement
create or replace function public.update_likes_count()
returns trigger
language plpgsql
security definer
as $$
begin
  if (TG_OP = 'INSERT') then
    update public.challenge_posts
    set likes_count = likes_count + 1
    where id = NEW.post_id;
    return NEW;
  elsif (TG_OP = 'DELETE') then
    update public.challenge_posts
    set likes_count = likes_count - 1
    where id = OLD.post_id;
    return OLD;
  end if;
  return null;
end;
$$;

drop trigger if exists on_like_change on public.post_likes;
create trigger on_like_change
  after insert or delete on public.post_likes
  for each row execute function public.update_likes_count();

-- ═══════════════════════════════════════════════════════════════════
-- Fin — vérifie dans Table Editor que challenge_posts + post_likes
-- sont créées.
-- ═══════════════════════════════════════════════════════════════════
