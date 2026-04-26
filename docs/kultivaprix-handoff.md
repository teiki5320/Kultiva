# 🤝 Handoff Kultivaprix — Catalogue d'espèces partagé

> Document à transmettre au mainteneur de **Kultivaprix** (comparateur de prix kawaii) pour qu'il puisse consommer le catalogue d'espèces de Kultiva via Supabase.

## Le contrat en 3 lignes

- **Source** : table `public.species` dans le projet Supabase **Kultiva** (`vkiwkeknfzwdvufcqbrp`)
- **Mise à jour** : automatique à chaque modif de `lib/data/vegetables_base.dart` mergée sur `main` (workflow `sync-catalog.yml`)
- **Lecture** : publique, anon key, RLS configuré

## Coordonnées du projet Supabase

| Champ | Valeur |
|---|---|
| Project ref | `vkiwkeknfzwdvufcqbrp` |
| API URL | `https://vkiwkeknfzwdvufcqbrp.supabase.co` |
| Anon key | Récupérer depuis `lib/config/supabase_config.dart:url` côté Kultiva (constante publique) ou Dashboard → Settings → API |

L'anon key est volontairement publique : la sécurité passe par RLS. Pour Kultivaprix, copier l'anon key dans `.env.local` ou équivalent (`NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_ANON_KEY`).

## Schéma de la table `public.species`

```sql
create table public.species (
  slug                    text primary key,   -- ex 'tomate', 'acc_secateur'
  kind                    text not null,      -- 'species' | 'accessory'
  name                    text not null,      -- 'Tomate'
  emoji                   text,               -- '🍅'
  category                text not null,      -- enum FR : flowers|leaves|fruits|bulbs|tubers|seeds|roots|stems|aromatics|accessories
  accessory_sub           text,               -- enum si kind='accessory' : tools|pots|soil|seeds|watering|protection|structures
  image_asset             text,               -- chemin Flutter, ex 'assets/images/accessories/secateur.png' (null pour les espèces : juste l'emoji)
  description             text,
  note                    text,               -- phrase courte pour la card (~80 chars)
  sowing_technique        text,
  sowing_depth            text,               -- ex '0,5 cm'
  germination_temp        text,               -- ex '18 à 25 °C'
  germination_days        text,               -- ex '6 à 10 jours'
  exposure                text,
  spacing                 text,
  watering                text,
  soil                    text,
  watering_days_max       int,
  yield_estimate          text,
  harvest_time_by_season  jsonb,              -- {"spring":"90 à 110 jours", "summer":"...", "autumn":"...", "winter":"..."}
  amazon_url              text,               -- lien affilié Amazon (tag=kultiva-21)
  regions                 jsonb,              -- voir plus bas
  updated_at              timestamptz default now()
);

alter table public.species enable row level security;
create policy "public_read_species" on public.species
  for select using (true);
```

### Volumétrie actuelle

| `kind` | Count |
|---|---|
| `species` | **59** (vraies espèces végétales) |
| `accessory` | **39** (outils, accessoires de jardinage) |
| Total | 98 |

### Format `regions` (jsonb)

Pour les `species` (toujours null pour `accessory`) :

```json
{
  "france": {
    "sowing_months":  [3, 4, 5],     // numéros de mois 1-12
    "harvest_months": [7, 8, 9, 10],
    "regional_note":  null            // ou string FR avec adaptation locale
  },
  "west_africa": {
    "sowing_months":  [10, 11, 12],
    "harvest_months": [1, 2, 3],
    "regional_note":  "Cultiver en saison sèche..."
  }
}
```

## Comment requêter

### Via curl

```bash
# Toutes les vraies espèces (sans accessoires)
curl "https://vkiwkeknfzwdvufcqbrp.supabase.co/rest/v1/species?kind=eq.species&select=*&order=name" \
  -H "apikey: $SUPABASE_ANON_KEY"

# Une espèce par slug
curl "https://vkiwkeknfzwdvufcqbrp.supabase.co/rest/v1/species?slug=eq.tomate&select=*" \
  -H "apikey: $SUPABASE_ANON_KEY"

# Filtrer par catégorie
curl "https://vkiwkeknfzwdvufcqbrp.supabase.co/rest/v1/species?kind=eq.species&category=eq.fruits&select=slug,name,emoji" \
  -H "apikey: $SUPABASE_ANON_KEY"
```

### Via le SDK Supabase JS

```ts
import { createClient } from '@supabase/supabase-js';

const sb = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
);

// Toutes les espèces (pas les accessoires)
const { data: species } = await sb
  .from('species')
  .select('*')
  .eq('kind', 'species')
  .order('name');

// Une fiche spécifique
const { data: tomate } = await sb
  .from('species')
  .select('*')
  .eq('slug', 'tomate')
  .single();

// Espèces semables en France au mois courant (filtrage côté serveur via jsonb)
const month = new Date().getMonth() + 1;
const { data: sowable } = await sb
  .from('species')
  .select('slug,name,emoji,regions')
  .eq('kind', 'species')
  .filter('regions->france->sowing_months', 'cs', `[${month}]`); // contains
```

> Note : pour les filtres jsonb avancés, [PostgREST docs](https://postgrest.org/en/stable/api.html#json-columns) sont la référence. `cs` = contains, `cd` = contained by.

### Via le SDK Supabase Dart (si Kultivaprix devient une app mobile)

```dart
final species = await Supabase.instance.client
    .from('species')
    .select()
    .eq('kind', 'species')
    .order('name');
```

## Cycle de mise à jour

```
Modif lib/data/vegetables_base.dart
        │
        ▼  push sur main
GitHub Actions sync-catalog.yml
        │  (~30s : setup Dart + export + curl POST)
        ▼
Edge function seed-species (vkiwkeknfzwdvufcqbrp)
        │  upsert idempotent (clé = slug)
        ▼
public.species  ◄──── Kultivaprix re-fetch au prochain refresh
```

Le sync est **unidirectionnel** : la source de vérité reste `vegetables_base.dart` côté Kultiva. **Toute modification faite à la main dans la table `public.species` (UPDATE, INSERT) sera écrasée au prochain sync**. Si Kultivaprix a besoin d'enrichir les données (prix, photos, etc.), créer une **nouvelle table** (ex. `public.species_pricing`) avec une FK sur `species(slug)`.

## RLS et sécurité

| Action | Anon | Authenticated | Service role |
|---|---|---|---|
| `SELECT` | ✅ | ✅ | ✅ |
| `INSERT` | ❌ | ❌ | ✅ |
| `UPDATE` | ❌ | ❌ | ✅ |
| `DELETE` | ❌ | ❌ | ✅ |

Seul le service role (utilisé par l'edge function `seed-species` côté CI Kultiva) peut écrire. Tout le reste est en lecture publique.

## Recommandations côté Kultivaprix

1. **Cache côté serveur** : la table change peu (~1 fois par semaine max). Cacher pour 1h via Redis ou un ISR Next.js de 3600s suffit largement.
2. **Filtrer les `accessory`** : Kultivaprix est probablement un comparateur de **graines / plants**. Filtrer `kind='species'` côté requête évite de charger inutilement les 39 accessoires.
3. **Snapshot CI** : si vous voulez vous prémunir d'une indispo Supabase, télécharger le JSON brut depuis le repo Kultiva à chaque deploy :
   ```bash
   curl -fL https://raw.githubusercontent.com/teiki5320/Kultiva/main/kultiva-catalog.json -o catalog-snapshot.json
   ```
4. **Naming** : le `slug` côté Supabase est le `id` côté Dart Kultiva (mappé par l'edge function). Garder `slug` comme clé primaire de référence inter-projets.

## Contact / debug

Si une espèce attendue n'apparaît pas / la sync semble cassée :

1. Vérifier que la table existe : `select count(*) from public.species;` (devrait être 98)
2. Vérifier la dernière sync : `select max(updated_at) from public.species;`
3. Côté Kultiva, regarder le dernier run du workflow `sync-catalog.yml` sur GitHub Actions
4. Si le run a échoué, voir `docs/catalog-sync.md` (section debug) pour les codes d'erreur courants

Toute modification structurelle (nouveau champ dans `Vegetable` côté Kultiva par exemple) demande une coordination : ajouter la colonne côté Postgres, mettre à jour le mapping dans `supabase/functions/seed-species/index.ts`, puis pousser. Documenté dans `docs/catalog-sync.md`.
