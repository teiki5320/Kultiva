-- ═══════════════════════════════════════════════════════════════════
-- Kultiva — Migration 014 : sync_xp monotone + plafond dur
-- À exécuter dans Supabase Dashboard → SQL Editor
-- ═══════════════════════════════════════════════════════════════════
--
-- La 011 faisait `xp = excluded.xp` (écriture absolue) : deux problèmes
--   1. un appareil en retard (ou un rollback multi-appareils) pouvait
--      FAIRE BAISSER l'XP cloud ;
--   2. dépasser 100 000 levait une exception qui bloquait toute la
--      synchro du client.
--
-- On rend l'XP monotone (GREATEST : il ne redescend jamais) et on BORNE
-- au plafond au lieu de rejeter (least/greatest). Un client ne peut donc
-- que faire monter son propre XP (auth.uid()) jusqu'au plafond, jamais
-- rétrograder le sien ni toucher celui d'autrui.
--
-- Résiduel connu (hors périmètre) : un client modifié peut toujours
-- pousser directement 100 000 pour atteindre le plafond. Empêcher cela
-- demanderait de n'autoriser que des incréments serveur — redesign à
-- prévoir si la triche du classement Tamassi devient un problème réel.

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
declare
  v_xp int;
begin
  -- Plafond dur (0–100 000), borné plutôt que rejeté.
  v_xp := least(greatest(coalesce(total_xp, 0), 0), 100000);

  insert into public.user_xp (user_id, xp, starter, creature_name)
  values (auth.uid(), v_xp, p_starter, p_creature_name)
  on conflict (user_id)
  do update set
    -- Progression monotone : l'XP ne redescend jamais.
    xp = greatest(user_xp.xp, excluded.xp),
    starter = coalesce(excluded.starter, user_xp.starter),
    creature_name = coalesce(excluded.creature_name, user_xp.creature_name);
end;
$$;

comment on function public.sync_xp(int, text, text) is
  'Synchronise l''XP Tamassi depuis le client. Monotone (GREATEST) et '
  'borné à [0, 100000]. Utilisé par CloudSyncService.';

-- ═══════════════════════════════════════════════════════════════════
-- Fin — après application, un appel sync_xp avec un XP inférieur ne doit
-- plus faire baisser la valeur stockée.
-- ═══════════════════════════════════════════════════════════════════
