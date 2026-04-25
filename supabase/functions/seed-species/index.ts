// Edge function `seed-species`
// Reçoit le contenu de `kultiva-catalog.json` (export depuis l'app
// Flutter Kultiva via le workflow GitHub Actions sync-catalog.yml) et
// fait un upsert idempotent dans la table public.species.
//
// Auth : header x-seed-secret doit matcher la variable d'env
// KULTIVA_SEED_SECRET (configurée dans Supabase Dashboard → Edge
// Functions → Secrets). Pas de JWT utilisateur — c'est un endpoint
// machine-à-machine appelé uniquement par le workflow CI.
//
// Déploiement :
//   supabase functions deploy seed-species --project-ref vkiwkeknfzwdvufcqbrp
//   supabase secrets set KULTIVA_SEED_SECRET="<générer une valeur aléatoire>"
//
// Test local :
//   curl -X POST http://localhost:54321/functions/v1/seed-species \
//     -H "x-seed-secret: $KULTIVA_SEED_SECRET" \
//     -H "Content-Type: application/json" \
//     --data-binary "@kultiva-catalog.json"

import { serve } from 'https://deno.land/std@0.208.0/http/server.ts';
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.45.0';

interface CatalogEntry {
  id: string;
  kind: string;
  name: string;
  emoji?: string | null;
  category: string;
  accessory_sub?: string | null;
  image_asset?: string | null;
  description?: string | null;
  note?: string | null;
  sowing_technique?: string | null;
  sowing_depth?: string | null;
  germination_temp?: string | null;
  germination_days?: string | null;
  exposure?: string | null;
  spacing?: string | null;
  watering?: string | null;
  soil?: string | null;
  watering_days_max?: number | null;
  yield_estimate?: string | null;
  harvest_time_by_season?: Record<string, string> | null;
  amazon_url?: string | null;
  regions?: Record<string, unknown> | null;
}

const SUPABASE_URL = Deno.env.get('SUPABASE_URL') ?? '';
const SERVICE_ROLE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '';
const SEED_SECRET = Deno.env.get('KULTIVA_SEED_SECRET') ?? '';

const json = (status: number, body: unknown) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { 'content-type': 'application/json' },
  });

serve(async (req) => {
  if (req.method !== 'POST') {
    return json(405, { error: 'method_not_allowed' });
  }

  if (!SEED_SECRET) {
    return json(500, { error: 'missing_server_secret' });
  }
  const provided = req.headers.get('x-seed-secret');
  if (provided !== SEED_SECRET) {
    return json(401, { error: 'invalid_secret' });
  }

  let payload: CatalogEntry[];
  try {
    payload = await req.json();
    if (!Array.isArray(payload)) {
      return json(400, { error: 'expected_array' });
    }
  } catch (_) {
    return json(400, { error: 'invalid_json' });
  }

  // Mappe `id` (clé côté app Flutter) → `slug` (clé côté table Supabase)
  // et ne garde que les colonnes attendues. Tout champ inconnu est
  // silencieusement ignoré (on évite les erreurs de schéma).
  const rows = payload.map((e) => ({
    slug: e.id,
    kind: e.kind,
    name: e.name,
    emoji: e.emoji ?? null,
    category: e.category,
    accessory_sub: e.accessory_sub ?? null,
    image_asset: e.image_asset ?? null,
    description: e.description ?? null,
    note: e.note ?? null,
    sowing_technique: e.sowing_technique ?? null,
    sowing_depth: e.sowing_depth ?? null,
    germination_temp: e.germination_temp ?? null,
    germination_days: e.germination_days ?? null,
    exposure: e.exposure ?? null,
    spacing: e.spacing ?? null,
    watering: e.watering ?? null,
    soil: e.soil ?? null,
    watering_days_max: e.watering_days_max ?? null,
    yield_estimate: e.yield_estimate ?? null,
    harvest_time_by_season: e.harvest_time_by_season ?? null,
    amazon_url: e.amazon_url ?? null,
    regions: e.regions ?? null,
    updated_at: new Date().toISOString(),
  }));

  // Validation rapide : refuser le batch si une entrée a un slug vide
  // (corromprait la PK).
  const invalid = rows.filter((r) => !r.slug || !r.kind || !r.name || !r.category);
  if (invalid.length > 0) {
    return json(400, {
      error: 'invalid_entries',
      count: invalid.length,
      sample: invalid.slice(0, 3).map((r) => r.slug || '(empty slug)'),
    });
  }

  const client = createClient(SUPABASE_URL, SERVICE_ROLE_KEY, {
    auth: { persistSession: false },
  });

  const { error } = await client
    .from('species')
    .upsert(rows, { onConflict: 'slug' });

  if (error) {
    return json(500, {
      error: 'upsert_failed',
      details: error.message,
      received: rows.length,
    });
  }

  // Optionnel : supprimer les slugs absents du payload (true source =
  // le Dart). Désactivé par défaut pour éviter les pertes accidentelles
  // si le workflow est mal configuré. Décommenter si on veut un sync
  // strict.
  //
  // const slugs = rows.map((r) => r.slug);
  // await client.from('species').delete().not('slug', 'in', `(${slugs.map((s) => `"${s}"`).join(',')})`);

  return json(200, {
    ok: true,
    upserted: rows.length,
    species: rows.filter((r) => r.kind === 'species').length,
    accessories: rows.filter((r) => r.kind === 'accessory').length,
    timestamp: new Date().toISOString(),
  });
});
