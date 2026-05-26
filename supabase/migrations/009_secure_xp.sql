-- ═══════════════════════════════════════════════════════════════════
-- Kultiva — Migration 009 : Sécurisation de l'XP Tamassi
-- À exécuter dans Supabase Dashboard → SQL Editor
-- ═══════════════════════════════════════════════════════════════════
--
-- Problème : actuellement le client peut écrire n'importe quelle
-- valeur dans user_xp via un simple upsert (la policy "xp_all_own"
-- autorise INSERT/UPDATE sans restriction). Un utilisateur malveillant
-- pourrait se donner 999 999 XP en un seul appel API.
--
-- Solution :
--   1. Créer une fonction increment_xp(amount) avec validation
--      serveur (1 ≤ amount ≤ 50) et SECURITY DEFINER.
--   2. Révoquer les droits INSERT/UPDATE directs sur user_xp
--      pour le rôle authenticated.
--   3. Remplacer la policy existante par une policy SELECT-only.
--
-- ⚠️ Après cette migration, le code Dart doit appeler la RPC
-- increment_xp() au lieu de faire un upsert direct sur user_xp.


-- ─── 1. Fonction sécurisée d'incrémentation ────────────────────────

create or replace function public.increment_xp(amount int)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  -- Validation : on refuse les montants aberrants.
  if amount < 1 or amount > 50 then
    raise exception 'Le montant XP doit être entre 1 et 50 (reçu : %)', amount;
  end if;

  -- Upsert : crée la ligne si elle n'existe pas, sinon incrémente.
  insert into public.user_xp (user_id, xp)
  values (auth.uid(), amount)
  on conflict (user_id)
  do update set xp = user_xp.xp + excluded.xp;
end;
$$;

comment on function public.increment_xp(int) is
  'Incrémente l''XP Tamassi de l''utilisateur courant. '
  'Montant validé côté serveur (1–50). '
  'Toute modification d''XP DOIT passer par cette fonction.';


-- ─── 2. Révoquer les droits d'écriture directe ─────────────────────

-- Supprime l'ancienne policy permissive (INSERT/UPDATE/DELETE).
drop policy if exists "xp_all_own" on public.user_xp;

-- Révoque INSERT et UPDATE directs pour le rôle authenticated.
revoke insert, update on public.user_xp from authenticated;


-- ─── 3. Policy SELECT-only pour les utilisateurs authentifiés ───────

-- Lecture publique : permet de voir l'XP des autres (classement,
-- visiteurs Tamassi).
create policy "xp_select_authenticated" on public.user_xp
  for select to authenticated using (true);


-- ═══════════════════════════════════════════════════════════════════
-- Fin — vérifie dans SQL Editor que la fonction increment_xp existe
-- et que user_xp n'accepte plus d'INSERT/UPDATE direct.
-- ═══════════════════════════════════════════════════════════════════
