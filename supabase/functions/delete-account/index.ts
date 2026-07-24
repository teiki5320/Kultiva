// ═══════════════════════════════════════════════════════════════════
// Kultiva — Edge Function « delete-account »
// ═══════════════════════════════════════════════════════════════════
//
// Supprime définitivement le compte de l'utilisateur appelant :
//   1. purge ses photos dans le bucket Storage `plant-photos`
//      (préfixe {user_id}/…) ;
//   2. supprime la ligne auth.users → CASCADE sur profiles, plantations,
//      unlocked_badges, preferences, user_xp, challenge_posts,
//      post_likes, post_reports (toutes déclarées `on delete cascade`).
//
// Exigence Apple 5.1.1(v) : une app qui permet de créer un compte doit
// permettre de le supprimer depuis l'app.
//
// La suppression du compte auth exige la `service_role` : impossible
// côté client avec l'anon key, d'où cette fonction. L'identité de
// l'appelant est vérifiée via son JWT (jamais un user_id passé en clair).
//
// ─── Déploiement (action manuelle, une seule fois) ──────────────────
//   supabase functions deploy delete-account
// Les variables SUPABASE_URL et SUPABASE_SERVICE_ROLE_KEY sont injectées
// automatiquement par le runtime Edge de Supabase.
// ═══════════════════════════════════════════════════════════════════

import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const PHOTOS_BUCKET = 'plant-photos';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers':
    'authorization, x-client-info, apikey, content-type',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
};

function json(body: unknown, status = 200): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
  });
}

// deno-lint-ignore no-explicit-any
type StorageClient = any;

/// Liste récursivement tous les fichiers sous un préfixe et les supprime.
/// Le bucket est structuré en {user_id}/{plantation_id}/{fichier}.
async function purgeUserPhotos(
  storage: StorageClient,
  userId: string,
): Promise<void> {
  const toRemove: string[] = [];

  async function walk(prefix: string): Promise<void> {
    const { data, error } = await storage.list(prefix, { limit: 1000 });
    if (error || !data) return;
    for (const entry of data) {
      const path = prefix ? `${prefix}/${entry.name}` : entry.name;
      // Un « dossier » n'a pas de métadonnées ; un fichier oui.
      if (entry.id === null || entry.metadata === null) {
        await walk(path);
      } else {
        toRemove.push(path);
      }
    }
  }

  await walk(userId);
  if (toRemove.length > 0) {
    // remove() accepte jusqu'à 1000 chemins par appel.
    for (let i = 0; i < toRemove.length; i += 1000) {
      await storage.remove(toRemove.slice(i, i + 1000));
    }
  }
}

Deno.serve(async (req: Request) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }
  if (req.method !== 'POST') {
    return json({ error: 'Méthode non autorisée' }, 405);
  }

  const supabaseUrl = Deno.env.get('SUPABASE_URL');
  const serviceRoleKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY');
  const anonKey = Deno.env.get('SUPABASE_ANON_KEY');
  if (!supabaseUrl || !serviceRoleKey || !anonKey) {
    return json({ error: 'Configuration serveur manquante' }, 500);
  }

  const authHeader = req.headers.get('Authorization');
  if (!authHeader) {
    return json({ error: 'Non authentifié' }, 401);
  }

  // 1. Vérifie l'identité de l'appelant via son JWT.
  const userClient = createClient(supabaseUrl, anonKey, {
    global: { headers: { Authorization: authHeader } },
  });
  const { data: userData, error: userErr } = await userClient.auth.getUser();
  if (userErr || !userData?.user) {
    return json({ error: 'Session invalide' }, 401);
  }
  const userId = userData.user.id;

  // 2. Client admin (service_role) : purge Storage puis suppression auth.
  const admin = createClient(supabaseUrl, serviceRoleKey, {
    auth: { autoRefreshToken: false, persistSession: false },
  });

  try {
    await purgeUserPhotos(admin.storage.from(PHOTOS_BUCKET), userId);
  } catch (_) {
    // Best-effort : on continue même si la purge Storage échoue
    // partiellement — le compte doit quand même être supprimé.
  }

  const { error: deleteErr } = await admin.auth.admin.deleteUser(userId);
  if (deleteErr) {
    return json({ error: `Suppression échouée : ${deleteErr.message}` }, 500);
  }

  return json({ success: true });
});
