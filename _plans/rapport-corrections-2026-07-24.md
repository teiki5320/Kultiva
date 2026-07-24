# 🛠️ Rapport de corrections pré-publication — 24 juillet 2026

> Branche : `claude/loving-noether-7Vw5y` — 7 commits.
> **164 tests passent** (148 → 164, +16), **`flutter analyze` 0 erreur** (3 infos
> préexistantes hors périmètre). Corrections des sections 1 à 4 de
> `_plans/audit-2026-07-07.md` (hors items déjà traités par le chantier
> Cap Afrique de l'Ouest).

## ✅ Corrigé

### 1. Bloquants stores (commit `412e017`, `cac0f7c`)
- **Suppression de compte in-app** (exigence Apple 5.1.1(v)) : entrée
  « Supprimer mon compte » dans les Paramètres → confirmation → edge
  function `delete-account` (service_role) qui purge le bucket
  `plant-photos` puis supprime `auth.users` (cascade sur toutes les
  tables) → `signOut` → purge locale complète.
- **iOS `Info.plist`** : `CFBundleVersion = $(FLUTTER_BUILD_NUMBER)`
  (fini les rejets TestFlight au 2ᵉ upload), `ITSAppUsesNonExemptEncryption=false`,
  orientation **verrouillée en portrait** (+ `SystemChrome` runtime Android).
- **Splash natif** généré et committé (`flutter_native_splash:create`) —
  fini l'écran blanc au lancement Android.
- **`pubspec` `flutter ">=3.38.0"`** (le code ne compile pas sous 3.32).
- **CI** : version Flutter épinglée (`3.41.6`) + nouveau job
  `flutter build appbundle` (valide manifest / fusion plugins / desugaring).
- **Contrôles debug XP** (bouton +10 XP, slider niveau) masqués derrière
  `kDebugMode`.

### 2. Fiabilité de la synchro cloud (commit `d22f075`, `cac0f7c`)
- `uploadBadges` **additif** : plus de suppression cloud après un échec
  transitoire de `fetchBadges`.
- `Plantation.merge` : **fusion champ par champ** (arrosages + photos
  unionnés, compteurs au max, note la plus riche) — aucune donnée perdue
  au merge multi-appareils.
- `fetchAndApplyPreferences` : **last-write-wins par `updated_at`** +
  garde `applyRemotePreferences` — ne réécrase plus un choix offline, plus
  d'uploads concurrents pendant l'application du cloud.
- **Timeouts explicites (12 s)** sur toutes les requêtes Supabase.
- **Login non bloquant** : navigation immédiate, `syncAllOnLogin` en fond.
- `clearLocalData` purge désormais **tout** le user-scoped (Tamassi,
  cultures, jardins, défis, favoris, stats, badges).
- **Migration 014** : `sync_xp` monotone (`GREATEST`) + plafond borné.
- **Tests** : `Plantation.merge` (9 cas) + `PrefsService` purge/LWW (4 cas).

### 3. Bugs UX majeurs (commits `cac0f7c`, `75c3b38`, `19d62a9`, `caee138`)
- **Déconnexion → écran de connexion** enfin atteignable
  (`RootTabs.requestSignOut`) ; le callback mort du proxy est réparé.
- **`SettingsScreen` dans un `Scaffold`** : fini le fond noir et les
  SnackBars invisibles.
- **Inscription avec confirmation email** : si pas de session, message
  « vérifie ta boîte mail » + retour au login (au lieu de lâcher
  l'utilisateur déconnecté dans l'app). + garde double-soumission.
- **Notifications** : `tz.local` réglé sur le fuseau réel du device
  (`flutter_timezone`) — rappels à la bonne heure (fini 9h → 11h).
- **Tamassi** : streak à clé de date paddée + calcul en jours calendaires
  + `maxStreak` historique (badges streak_* plus révoqués) ; reset
  **conserve l'XP** (comme promis) + réaligne `_prevStage` ; starter vide
  ne résout plus en Poussia.
- **Poussidex bootstrap** : badges en **union** (plus de révocation après
  réinstallation) ; migration grille legacy **fusionnée** au lieu d'écraser.
- **Planner** : réconciliation des `CultureEntry` (plus de cultures
  orphelines ni de `cultureId` pendouillant) ; crash `cultures.first`
  supprimé ; closures rafraîchies ; **`PopScope`** ; **thème sombre**.
- **`garden_plan_service`** : décodage **tolérant entrée par entrée** (un
  jardin corrompu n'efface plus tous les jardins).
- **`flutter_localizations` + locale fr-FR** : DatePicker en français.

### 4. Bonus (commit `8bb05f7`)
- **Tri & recherche insensibles aux accents** (`utils/text_normalize`,
  + tests) sur l'Étal et le calendrier annuel.
- `feed_service` : `fetchFeed` relance l'erreur (écran « Réessayer »
  fonctionnel) ; `toggleLike` throw en cas d'erreur (plus de compteur
  négatif) + gère le double-tap ; callers retrouvent le post par id après
  `await` (plus de `RangeError`).
- `ReviewService.maybeRequestReview` **branché** (complétion d'un défi) +
  durci.
- `PhotoService.purgeOrphans` au boot + suppression du fichier temporaire
  d'`image_picker`.

## 🔧 Actions manuelles requises (côté Supabase)

À faire **avant** la soumission stores, dans le dashboard Supabase :

1. **Appliquer les migrations SQL** dans SQL Editor, dans l'ordre :
   - `012_feed_profiles_fk.sql` (FK feed → profiles) — *chantier AO*
   - `013_preferences_country.sql` (colonne `country`) — *chantier AO*
   - `014_sync_xp_monotonic.sql` (XP monotone + plafond) — *cette session*
2. **Déployer l'edge function** de suppression de compte :
   ```bash
   supabase functions deploy delete-account
   ```
   (elle utilise `SUPABASE_URL` / `SUPABASE_SERVICE_ROLE_KEY` injectées par
   le runtime). **Sans ce déploiement, le bouton « Supprimer mon compte »
   affiche une erreur** — donc bloquant pour la review Apple.
3. **Vérifier les policies Storage** du bucket `plant-photos` (un
   utilisateur ne doit pas lire/écrire dans le dossier d'un autre) —
   finding audit non vérifiable depuis le repo.

## ⏳ Reste de l'audit (hors périmètre de cette session)

Findings identifiés mais volontairement non traités (risque/scope) :

- **Perf Tamassi/onglet invisible** : animations + polling Supabase
  tournent en permanence dans l'`IndexedStack` (audit « Tamassi & Mon
  jardin ») — nécessite `TickerMode`/visibilité, refactor à part.
- **Compteurs `recordLogin`/`recordTab`** faussés par l'`IndexedStack`
  (login/nuit comptés au boot et à chaque bascule de sous-onglet).
- **6 vues Poussidex orphelines** (collection, journal, podium, stats,
  feed, fiche détail) : brancher ou supprimer — décision produit.
- **Export PDF de fiche légume** mort (emoji + police Helvetica Type1) :
  nécessite une police TTF embarquée.
- **Tuto « Découvrir l'app »** : ~38 Mo d'images inlinées en base64 (pic
  mémoire / OOM sur entrée de gamme) — compression des screenshots.
- **`GardenPlan.copyWith`** ne taille pas les cellules hors-grille au
  rétrécissement (cellules fantômes) ; `location`/`cultureId` non
  effaçables via `copyWith` (`??`).
- **Planner picker** : filtre saison codé sur `franceData` (ignore AO) ;
  bannière irrigation sur les 3 jours passés au lieu des 3 prochains.
- **Divers mineurs** : parsing météo `weather_code` absent (emoji figé
  ☀️), `expectedHarvestDays` interprète semaines/années comme jours,
  contradiction compagnonnage concombre/radis, fuites `TapGestureRecognizer`
  /`TextPainter`, `share_plus` sans `sharePositionOrigin` (iPad), etc.
- **Landing** : liens stores `href="#"` à remplacer à la publication.

Voir `_plans/audit-2026-07-07.md` pour le détail complet.

---
_Rapport généré le 24 juillet 2026._
