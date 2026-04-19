-- Migration 004 : Permettre aux utilisateurs authentifiés de lire les
-- Tamassi des autres (pour les "visites" sur l'écran Tamassi).
-- Les écritures restent privées.

drop policy if exists "xp_all_own" on public.user_xp;

create policy "xp_select_all" on public.user_xp
  for select to authenticated using (true);

create policy "xp_insert_own" on public.user_xp
  for insert to authenticated with check (auth.uid() = user_id);

create policy "xp_update_own" on public.user_xp
  for update to authenticated using (auth.uid() = user_id);

create policy "xp_delete_own" on public.user_xp
  for delete to authenticated using (auth.uid() = user_id);
