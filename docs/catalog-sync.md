# Synchronisation du catalogue d'espèces vers Supabase

> Pour partager le catalogue avec le projet sœur **Kultivaprix** (comparateur de prix) sans toucher au runtime de l'app Kultiva.

## Architecture

```
lib/data/vegetables_base.dart  ── source de vérité (Dart, const)
        │
        ▼  (push sur main)
GitHub Actions sync-catalog.yml
        │
        │  dart run tool/export_catalog.dart
        ▼
kultiva-catalog.json (98 entrées, 112 KB indenté)
        │
        │  POST + x-seed-secret
        ▼
Supabase Edge Function seed-species
        │
        │  upsert (clé : slug)
        ▼
public.species  ◄──── lecture publique par Kultivaprix
```

L'app Kultiva continue à lire `vegetablesBase` en const (zéro changement runtime, offline-first préservé).

## Éditer le catalogue

1. Modifie `lib/data/vegetables_base.dart` (ou `lib/data/regions/france.dart` / `west_africa.dart`).
2. Commit + push sur `main`.
3. Le workflow `sync-catalog.yml` détecte le changement, regénère `kultiva-catalog.json` et POST le résultat à `seed-species`.
4. La table `public.species` est à jour en moins d'1 minute.

## Forcer une re-sync manuelle

Onglet **Actions** sur GitHub → workflow **Sync catalog → Supabase** → bouton **Run workflow**. Pas besoin de modifier un fichier.

Alternative locale (si tu as Dart + curl) :

```bash
dart run tool/export_catalog.dart
curl -X POST "https://vkiwkeknfzwdvufcqbrp.supabase.co/functions/v1/seed-species" \
  -H "x-seed-secret: $KULTIVA_SEED_SECRET" \
  -H "Content-Type: application/json" \
  --data-binary "@kultiva-catalog.json"
```

## Setup initial (une seule fois)

### Côté Supabase

```bash
# Depuis le repo Kultiva, avec la CLI supabase installée
supabase functions deploy seed-species --project-ref vkiwkeknfzwdvufcqbrp

# Générer un secret aléatoire et le configurer côté serveur
SEED_SECRET=$(openssl rand -hex 32)
supabase secrets set KULTIVA_SEED_SECRET="$SEED_SECRET" --project-ref vkiwkeknfzwdvufcqbrp
echo "Garde ce secret pour GitHub : $SEED_SECRET"
```

La table `public.species` doit exister avec le schéma défini dans le brief Kultivaprix (clé primaire `slug`). Si elle n'est pas encore créée, la première POST échouera avec `upsert_failed`.

### Côté GitHub

Settings → Secrets and variables → Actions → New repository secret :
- **Name** : `KULTIVA_SEED_SECRET`
- **Value** : la même valeur que celle configurée dans Supabase ci-dessus

## Debugger un sync qui casse

### 1. Vérifier les logs du workflow

Actions → dernier run de "Sync catalog → Supabase" → log de l'étape "POST to Supabase seed-species function". Le corps de la réponse de l'edge function est imprimé.

| Erreur | Cause probable | Fix |
|---|---|---|
| `HTTP 401 invalid_secret` | Secret GitHub ≠ secret Supabase | Re-set les deux avec la même valeur |
| `HTTP 400 expected_array` | JSON malformé en entrée | `dart run tool/export_catalog.dart` localement et inspecter `kultiva-catalog.json` |
| `HTTP 400 invalid_entries` | Une entrée du Dart sans `id`/`name`/`category` | Inspecter `vegetables_base.dart` à la ligne signalée par le `sample` retourné |
| `HTTP 500 upsert_failed` | Schéma de la table changé ou colonne manquante | Voir `details` dans la réponse, ajuster la migration côté Kultivaprix |
| `HTTP 500 missing_server_secret` | `KULTIVA_SEED_SECRET` non configuré dans Supabase | `supabase secrets set ...` |

### 2. Vérifier les logs de l'edge function

Supabase Dashboard → Edge Functions → `seed-species` → Logs. Affiche les erreurs runtime (panique Deno, timeout, RLS bloquant…).

### 3. Vérifier la table

```sql
select count(*), kind from public.species group by kind;
-- attendu : species 59 / accessory 39
select max(updated_at) from public.species;
-- doit être récent (< 1 min après le push)
```

## Hors scope

- **L'app Kultiva ne lit jamais `public.species`** — elle continue à lire `vegetablesBase` en const sync. Le sync est unidirectionnel Dart → Supabase.
- Toute modification du catalogue côté Supabase (UPDATE manuel dans le SQL Editor par exemple) sera **écrasée** au prochain sync. La source de vérité reste le Dart.
