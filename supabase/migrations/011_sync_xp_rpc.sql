-- ═══════════════════════════════════════════════════════════════════
-- Kultiva — Migration 011 : Fonction sync_xp pour la synchro cloud
-- À exécuter dans Supabase Dashboard → SQL Editor
-- ═══════════════════════════════════════════════════════════════════
--
-- La migration 009 a révoqué les INSERT/UPDATE directs sur user_xp.
-- Le code Dart utilisait un upsert direct pour synchroniser l'XP
-- au login — il faut maintenant passer par une RPC sécurisée.
--
-- sync_xp() remplace l'ancien upsert : elle accepte la valeur
-- absolue d'XP (validée côté serveur) + starter + creature_name.
-- increment_xp() reste disponible pour les gains ponctuels.

create or replace function public.sync_xp(
  total_xp int,
  p_starter text default null,
  p_creature_name text default null
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if total_xp < 0 or total_xp > 100000 then
    raise exception 'XP doit être entre 0 et 100 000 (reçu : %)', total_xp;
  end if;

  insert into public.user_xp (user_id, xp, starter, creature_name)
  values (auth.uid(), total_xp, p_starter, p_creature_name)
  on conflict (user_id)
  do update set
    xp = excluded.xp,
    starter = coalesce(excluded.starter, user_xp.starter),
    creature_name = coalesce(excluded.creature_name, user_xp.creature_name);
end;
$$;

comment on function public.sync_xp(int, text, text) is
  'Synchronise l''XP Tamassi depuis le client. Valeur absolue validée (0–100k). '
  'Utilisé par CloudSyncService au login. Pour les gains ponctuels, utiliser increment_xp().';

-- ═══════════════════════════════════════════════════════════════════
-- Fin — vérifie que sync_xp existe avec \df sync_xp dans SQL Editor.
-- ═══════════════════════════════════════════════════════════════════
