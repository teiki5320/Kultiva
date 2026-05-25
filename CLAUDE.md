# Kultiva

> Documentation pour futures sessions Claude Code.
> Derniere mise a jour : 2026-05-25.

## Contexte

**Kultiva** est une application mobile Flutter de jardinage francophone, au style
pastel kawaii japonais. Elle s'adresse aux jardiniers amateurs de **France
metropolitaine** et d'**Afrique de l'Ouest**, et couvre :

- un calendrier mensuel de semis et de recolte adapte a la region ;
- un **catalogue** de 158 legumes, aromates, tubercules et accessoires ;
- le **Poussidex** : collection chronologique des plants de l'utilisateur, avec
  photos, notes, historique d'arrosage et compteur de recoltes ;
- **Mes jardins** : potager carre multi-jardins avec placement par
  glisser-deposer, suivi par plant (arrosage, phase de croissance auto, photos),
  conseils contextuels selon la meteo ;
- **Tamassi** : creature virtuelle animee qui evolue avec l'activite au jardin
  (XP, niveaux, emotions, 3 variantes : Poussia, Soleia, Spira) ;
- des **alertes meteo + arrosage + canicule** basees sur la geolocalisation et
  l'API Open-Meteo (gratuite, sans cle) ;
- un **feed communautaire** de defis photo (51 badges, 51 defis, medailles, likes) ;
- de la gamification : badges, defis, medailles bronze/argent/or par legume ;
- une synchronisation **cloud facultative** via Supabase (auth + Postgres +
  Storage) ;
- des tutoriels HTML embarques (29 fiches), un lexique, un guide de maladies et
  de compagnonnage ;
- un **cahier de culture** pleine terre avec etapes phenologiques auto-suggerees,
  avertissement de rotation et conseils canicule personnalises ;
- un lien avec **Kultivaprix** (projet soeur, comparateur de prix) via sync
  unidirectionnelle du catalogue vers Supabase.

**Statut** : en phase de polish pre-publication (v1.0.0+4) — CI iOS (Xcode
Cloud) + CI GitHub Actions branchees, config de signing Android active, landing
page marketing prete, conformite Amazon Associates en place. L'hydroponie a ete
retiree (archivee sur `archive/hydroponie-2026-05-03`).

## Stack technique

**Frontend / mobile**

- Flutter **>=3.24** / Dart **^3.5** (canal `stable`)
- Material3, themes clair et sombre
- `google_fonts` — typographie **Nunito**
- `shared_preferences` — persistance locale
- `url_launcher` — liens affilies Amazon
- `flutter_local_notifications` ^17.2.3 + `timezone` — rappels mensuels,
  quotidiens (Tamassi), arrosage et canicule
- `pdf` + `printing` — export PDF du calendrier
- `geolocator` + `geocoding` — detection regionale + nom de ville
- `permission_handler` — permissions camera / localisation
- `http` — appels Open-Meteo
- `audioplayers` — SFX et musique de fond
- `image_picker` + `path_provider` — camera / galerie et stockage local
- `share_plus` — partage Instagram / social
- `sensors_plus` — accelerometre / gyroscope (animations de la creature)
- `webview_flutter` — tutoriels HTML

**Backend / services**

- **Supabase** (`supabase_flutter` ^2.5) — auth, Postgres, Storage
  (`plant-photos`, `news-images`) ; une edge function (`seed-species` pour sync
  catalogue vers Kultivaprix)
- **Open-Meteo** — meteo 7 jours, aucune cle d'API requise
- **Google Sign-In** (`google_sign_in` ^6.2) — OAuth natif
- **Apple Sign-In** (`sign_in_with_apple` ^6.1) avec nonce SHA-256 (`crypto`)

**Outillage / plateformes**

- Android : Gradle 8.14, Kotlin + Java 17, signing release via
  `android/key.properties`, core library desugaring active, app ID
  `com.toa.kultiva`
- iOS : Xcode Cloud (`ios/ci_scripts/ci_post_clone.sh`), Apple Sign-In
  entitlement, URL scheme Google, permissions camera / photos / localisation
  declarees dans `Info.plist`
- CI : GitHub Actions (`ci.yml` : `flutter analyze` + `flutter test` sur push
  main et PR ; `sync-catalog.yml` : sync catalogue vers Supabase sur modif des
  fichiers source)
- Lints : `flutter_lints` ^5.0 + regles custom (`prefer_const_constructors`,
  `prefer_const_literals_to_create_immutables`, `avoid_print`,
  `use_key_in_widget_constructors`). Exclusion : `tool/**`.
- Tests : `flutter_test` (unitaires uniquement pour l'instant)

## Architecture

```
Kultiva/
|-- lib/                    # Code Dart principal (~31 640 LoC sur 83 fichiers)
|   |-- main.dart           # Bootstrap : splash -> onboarding -> auth -> tabs
|   |-- config/
|   |   +-- supabase_config.dart    # URL, anon key, Google OAuth client IDs
|   |-- screens/
|   |   |-- splash_screen.dart
|   |   |-- onboarding_screen.dart
|   |   |-- root_tabs.dart          # Conteneur 4 onglets (Bottom nav)
|   |   |-- vegetable_detail_screen.dart
|   |   |-- auth/                   # login_screen, register_screen
|   |   +-- home/                   # sow, vegetables, my_garden, tutos,
|   |                               # settings, weather, calendrier mensuel,
|   |                               # tuto_fiche (WebView),
|   |                               # garden_planner, mes_jardins,
|   |                               # culture_start_sheet,
|   |                               # garden_plan_config_sheet,
|   |                               # poussidex/*
|   |-- models/             # plantation, vegetable, vegetable_medal,
|   |                       # region_data, culture_entry, garden_plan
|   |-- services/           # auth, prefs, cloud_sync, weather, geolocation,
|   |                       # notification, photo, audio, watering,
|   |                       # watering_advisor, feed, pdf, tamassi_stats,
|   |                       # plantation_migration, culture, garden_plan
|   |-- data/               # Catalogues statiques (francais)
|   |   |-- vegetables_base.dart    # 158 entrees (120 legumes + 38 accessoires)
|   |   |-- badges.dart (51) / challenges.dart (51) / diseases.dart
|   |   |-- companions.dart / rotation.dart / lexicon.dart
|   |   +-- regions/        # france.dart, west_africa.dart
|   |-- theme/
|   |   +-- app_theme.dart  # KultivaColors, themes Material3 light/dark
|   |-- widgets/            # plant_creature (55 Ko), badge_card (34 Ko),
|   |                       # petal_animation, season_header, share_card,
|   |                       # challenge_story_card, garden_tutorial_sheet,
|   |                       # jardins_intro_sheet, lexicon_text, medal_badge,
|   |                       # plantation_photo, tamassi_story_card,
|   |                       # vegetable_card, watering_bars,
|   |                       # camera_permission_dialog
|   +-- utils/              # category_colors, months, phenology,
|                           # companion_status, heatwave_tips,
|                           # rotation_advisor
|-- supabase/
|   +-- migrations/         # 001_initial_schema -> 008_drop_hydro_tables
|-- assets/
|   |-- images/             # creatures (3 variantes, 35 images), badges (50),
|   |                       # accessories (vide, fallback emoji), vegetables (120),
|   |                       # backgrounds (4 time-of-day), cards, onboarding,
|   |                       # app_icon
|   |-- sounds/             # 8 fichiers (1 musique + 7 SFX)
|   +-- tutos/              # 29 fichiers HTML + screens/
|-- .github/workflows/      # ci.yml, sync-catalog.yml
|-- tool/                   # export_catalog.dart (sync Kultivaprix)
|-- docs/                   # catalog-sync, kultivaprix-handoff,
|                           # news-publication-guide, v5-test-checklist
|-- _plans/                 # roadmap.md
|-- android/                # app/build.gradle.kts, key.properties (ignore)
|-- ios/                    # Podfile, Runner, ci_scripts/, entitlements
|-- landing/                # Site HTML statique marketing (index.html + img/)
|-- test/                   # 8 fichiers — 988 LoC
|                           # badges, medals, plantation, vegetable,
|                           # culture_entry, garden_plan, phenology,
|                           # widget_test (stub)
|-- pubspec.yaml
|-- analysis_options.yaml
+-- README.md
```

**Flux d'etat** : `main.dart` orchestre un bootstrap asynchrone qui initialise
Supabase, les services, charge les preferences, puis affiche selon l'etat
(Splash -> Onboarding si premiere ouverture -> Auth si non connecte -> RootTabs).

**Schema Supabase** (voir `supabase/migrations/`) :

| Table              | Cle primaire        | Acces                                           |
| ------------------ | ------------------- | ----------------------------------------------- |
| `profiles`         | `id`                | Own only (RLS)                                  |
| `plantations`      | `id` (text)         | Own only                                        |
| `unlocked_badges`  | `(user_id,badge_id)`| Own only                                        |
| `preferences`      | `user_id`           | Own only                                        |
| `challenge_posts`  | `id`                | Lecture publique (authentifies), ecriture own   |
| `post_likes`       | `(user_id,post_id)` | Lecture publique, ecriture own ; trigger counter|
| `user_xp`          | `user_id`           | Lecture publique (visiteurs Tamassi), ecriture own |
| `news_items`       | `id` (uuid)         | Lecture publique (anon+auth), ecriture service_role uniquement |

Triggers : `handle_new_user` (auto-profile), `touch_updated_at` (4 tables),
`update_likes_count` (compteur de likes), `touch_news_items_updated_at`.
Buckets Storage : `plant-photos`, `news-images` (public).

Tables supprimees (migration 008) : `culture_readings`, `hydro_builds`,
`hydro_build_likes` (feature hydroponie archivee).

## Regles de code

- **Langue** : strings UI et commentaires visibles utilisateur **en francais**.
  Commentaires internes peuvent etre en francais aussi (pattern dominant).
- **State management** : pas de Provider / Riverpod / Bloc. On utilise
  `ValueNotifier` + `ValueListenableBuilder`, singletons de services et
  `SharedPreferences`. Ne pas introduire de framework externe sans discussion.
- **Local-first** : toute mutation passe d'abord par les services locaux
  (`PrefsService`, fichiers) ; `CloudSyncService` synchronise en arriere-plan
  de maniere non bloquante. Si Supabase est indisponible, l'app doit continuer
  a fonctionner.
- **Services** = logique metier ; **widgets** = presentation. Eviter de melanger.
- **Navigation** : `Navigator.push` et `showModalBottomSheet`. Pas de package
  de routing.
- **Lints** : `prefer_const_constructors`, `prefer_const_literals_to_create_immutables`,
  `avoid_print`, `use_key_in_widget_constructors`. Lancer `flutter analyze`
  avant toute PR.
- **Theme** : couleurs centralisees dans `lib/theme/app_theme.dart`
  (`KultivaColors`). Pour les categories de legumes, utiliser
  `lib/utils/category_colors.dart`.
- **Photos** : stockees dans `app documents/plant_photos/` localement, puis
  uploadees dans le bucket `plant-photos` (chemin `{user_id}/{plantation_id}/{filename}`).
- **Assets** : apres ajout dans `assets/`, declarer le chemin dans la section
  `assets:` de `pubspec.yaml`. Des fichiers `.gitkeep` peuvent etre necessaires
  pour tracker des dossiers vides (cf commit `cba299c`).
- **Migrations Supabase** : **toujours** creer un nouveau fichier numerote
  (`009_*.sql`, etc.). Ne jamais modifier une migration existante.
- **Dependances** : toute nouvelle dependance merite un commentaire inline dans
  `pubspec.yaml` expliquant son usage (pattern observe).

## Commandes utiles

### Lancer l'app sur le Mac de Jean (routine quotidienne)

Le projet est sur **`~/Code/kultiva`** (Mac-mini-de-Jean). Branche de travail
courante : **`main`**. Commande a donner systematiquement apres une modif
poussee par Claude Code :

```bash
cd ~/Code/kultiva && git stash && git pull origin main && flutter pub get && flutter run --release
```

- `git stash` est necessaire car les lock files (`pubspec.lock`, `Podfile.lock`)
  sont regulierement regeneres localement et bloquent le pull sinon.
- `--release` est le mode utilise par defaut pour tester l'app sur device.
- Si la branche de travail change (ex. `claude/xxx`), adapter `origin/main`.

### Autres commandes

```bash
# Installation et execution
flutter pub get
flutter run                         # debug
flutter run --release

# Qualite
flutter analyze
flutter test                        # tests unitaires dans test/

# Builds de release
flutter build apk --release
flutter build appbundle --release   # Google Play
flutter build ios --release         # iOS (signer via Xcode)

# iOS local (apres install)
cd ios && pod install --repo-update && cd ..

# CI iOS
# Xcode Cloud lance automatiquement ios/ci_scripts/ci_post_clone.sh :
#   flutter precache --ios && flutter pub get && pod install

# CI GitHub Actions
# ci.yml : flutter analyze (--no-fatal-infos --no-fatal-warnings) + flutter test
# sync-catalog.yml : export du catalogue vers Supabase (table public.species)

# Android signing
# Necessite un fichier android/key.properties (non commite) :
#   storeFile=...  storePassword=...  keyAlias=...  keyPassword=...

# Supabase
# Les migrations se trouvent dans supabase/migrations/ et sont appliquees
# manuellement via le dashboard Supabase (pas de supabase/config.toml).
```

## Design / UX

- **Style** : pastel kawaii japonais, lignes arrondies (cards 18, chips 20,
  boutons 20), ombres douces, emojis parcimonieux mais bienvenus.
- **Font** : Nunito (bold pour les titres, regular pour le corps).
- **Palette claire** : `#F5FAF8` (fond), `#4A9B5A` (primaire vert),
  `#A8D5A2` (vert clair), `#E8A87C` (terracotta), `#2A4A3A` (texte).
- **Palette sombre** : `#0F1F18`, `#5ABD6A`, `#1A2E22`, `#1F3528`.
- **Gradients saisonniers** : printemps rose-vert, ete jaune-vert, automne
  orange, hiver bleu-gris.
- **Animations** : petales qui tombent, papillons, feuilles, flocons selon la
  saison ; creature Tamassi animee via accelerometre.
- **Tone of voice** : chaleureux, ludique, enfantin. Exemples : "Kultiva
  utilise ta localisation pour afficher la meteo de ton jardin", "Le potager
  kawaii dans ta poche".
- **Localisation** : app **fr-FR** uniquement pour l'instant.

### Generation d'images ComfyUI (prompts produits)

Format retenu pour generer les visuels kawaii des plantes et accessoires —
meme style que les 38 accessoires existants. Les images generees sont
**partagees avec Kultivaprix** (projet soeur, comparateur de prix), donc le
style doit rester identique sur les deux apps.

**Formule retenue (validee Apr 2026) :**

```
a [SUBJECT] icon, simple flat 2D vector design, solid [COLOR] color, [DETAILS], minimalist app icon, plain cream beige background, centered, 1:1 square
```

Exemple valide sur tomate :

```
a tomato icon, simple flat 2D vector design, solid red color, small green stem on top, minimalist app icon, plain cream beige background, centered, 1:1 square
```

**Pourquoi cette formule** :
- `icon` + `vector design` + `minimalist app icon` -> ancrent fort vers du logo plat
- `solid [color] color` -> empeche le melange de couleurs (sinon le modele hesite)
- **NE PAS** ajouter "kawaii", "cute", "illustration", "character", "chibi",
  "smiling face" — ces mots tirent vers du personnage anthropomorphise,
  surtout sur les checkpoints anime/character (ex. `sdxl_afrotok_final`).
- Si le modele reste biaise character : baisser `cfg` a 4.5 sur le KSampler,
  ou desactiver les LoRAs actifs (clic-droit -> Bypass).

**Format de sortie attendu** : TSV (tabulation entre prompt et filename),
copiable dans Numbers/Sheets ou un node ComfyUI batch :

```
<prompt complet sujet + style>	<id>.png
<prompt complet sujet + style>	<id>.png
```

Le filename = `{Vegetable.id}.png` (ex. `cornichon.png`, `pommier.png`).

Destination : `assets/images/vegetables/<id>.png` cote Kultiva, et meme
fichier heberge cote Kultivaprix (a voir : Supabase Storage public bucket
ou CDN partage).

## Pieges a eviter

- **Ne pas casser le mode offline** — toute nouvelle feature doit continuer a
  fonctionner sans session Supabase.
- **Ne pas monter en version majeure** de `flutter_local_notifications`
  (17 -> 21), `geolocator` (11 -> 14), `share_plus` (7 -> 13),
  `google_fonts` (6 -> 8) ou `printing` (5 -> latest) sans plan de
  migration. Ces pins sont intentionnels et documentes dans `pubspec.yaml`.
- **Ne jamais committer** `android/key.properties`, `*.jks`, ou la `service_role`
  key Supabase. L'`anonKey` actuellement en source est publique (c'est normal).
- **Synchroniser `assets/` <-> `pubspec.yaml`** — les incidents recents sur les
  dossiers `accessories/` et `badges/` l'ont rappele.
- **Ne jamais modifier une migration SQL existante** — creer toujours un nouveau
  fichier numerote.
- **Ne pas mettre de logique metier dans les widgets** — elle doit vivre dans
  `lib/services/`.
- **Ne pas utiliser `print`** — desactive par le lint `avoid_print`.
- **Attention aux permissions iOS** : les descriptions (camera, photos,
  localisation) doivent rester en francais et factuelles (pattern observe dans
  `Info.plist`).
- **Fallback meteo** : si la geoloc echoue ou est refusee, le service retombe
  sur **Paris** par defaut. Ne pas supprimer ce fallback.

## Historique technique

Decisions et evolutions significatives :

- **CI GitHub Actions** : `ci.yml` (analyze + test sur push main et PR) et
  `sync-catalog.yml` (export catalogue vers Supabase pour Kultivaprix).
- **Cahier de culture pleine terre** (v5) : multi-jardins avec placement par
  glisser-deposer, suivi par plant, phases de croissance auto-suggerees,
  avertissement de rotation, conseils canicule.
- **Retrait de l'hydroponie** (mai 2026) : code archive sur
  `archive/hydroponie-2026-05-03`, migrations 006/008 pour nettoyage Supabase.
- **Xcode Cloud** branche cote iOS via `ci_post_clone.sh` (clone Flutter stable,
  precache, pub get, pod install).
- **Dashboard onboarding** reconfigure : tuto statique remplace par animation
  kawaii dans une WebView centree.
- **38 images d'accessoires** kawaii cablees avec fallback emoji ; `.gitkeep`
  ajoute pour tracker le dossier vide (images pas encore generees).
- **Android** : signing release wire via `key.properties` ; chemin keystore
  corrige (`rootProject.file` plutot que `file`) ; core library desugaring
  active pour supporter `flutter_local_notifications` 17+.
- **Permissions iOS** : correctifs sur l'ouverture camera apres grant, et
  gestion de la geolocalisation refusee avec fallback Paris.
- **Meteo** : nom de ville affiche dans le header, bouton rafraichir ajoute,
  alertes canicule avec tips par legume.
- **Amazon Associates** : mention "Lien partenaire" visible + bouton agrandi
  pour conformite du programme d'affiliation.
- **Gros menage lint** : 308 substitutions `withOpacity` -> `withValues` sur
  38 fichiers, >90 % des avertissements resorbes.
- **Sync catalogue Kultivaprix** : workflow GitHub Actions + edge function
  Supabase `seed-species`, documentation dans `docs/catalog-sync.md`.
- **Actualites** : table `news_items` + bucket `news-images` (migration 007),
  publication via Supabase Studio uniquement (service_role).

## Instructions pour Claude Code

Regles specifiques au projet pour etre efficace des la premiere action :

1. **Respecter le contrat local-first** : ne jamais introduire d'appel reseau
   bloquant dans un flux UI. Synchro cloud = arriere-plan uniquement.
2. **Migrations** : toujours creer un nouveau fichier `supabase/migrations/009_*.sql`,
   jamais editer les existants.
3. **Assets** : apres `cp` d'un asset, penser a declarer le chemin dans
   `pubspec.yaml`.
4. **Francais** : rediger en francais les strings visibles utilisateur, les
   descriptions de permissions, les textes des notifications.
5. **Pas de nouvelle dependance sans justification** dans le `pubspec.yaml`
   (commentaire inline obligatoire).
6. **Avant toute PR** : `flutter analyze` + `flutter test` doivent passer.
7. **Tests** : pour un nouveau modele, ajouter `test/<nom>_test.dart` sur le
   pattern existant (voir `vegetable_test.dart`).
8. **Navigation** : rester sur `Navigator.push` / `showModalBottomSheet`. Pas
   de package de routing.
9. **Services externes** : privilegier les APIs gratuites sans cle (cf
   Open-Meteo) quand c'est possible.
10. **Creer une migration** quand on touche au schema, pas un ALTER a la volee
    cote code.

## Alertes

A signaler a l'utilisateur / a traiter dans un futur ticket :

1. **Aucun test de widget ni d'integration** — seuls les modeles et les
   donnees sont couverts (988 LoC de tests sur 31 640 LoC de code source).
2. **Aucun edge function Supabase pour la logique metier** — XP, likes,
   moderation du feed sont cote Dart, donc contournables si quelqu'un
   interroge l'API directement. (Note : l'edge function `seed-species` existe
   mais ne concerne que la sync catalogue.)
3. **L'`anonKey` Supabase est committee dans `lib/config/supabase_config.dart`** —
   c'est correct pour une anon key JWT publique, mais a documenter pour eviter
   tout doute.
4. **Commits domines par Claude** (107 sur 156) — verifier que les revues
   humaines restent regulieres pour eviter les derives stylistiques.
5. **`assets/images/accessories/` est vide** — les 38 images d'accessoires
   referencees dans le code ne sont pas encore generees (fallback emoji actif).
6. **54 legumes sur 120 n'ont pas de `harvestTimeBySeason`** — des trous dans
   les calendriers saisonniers sont possibles.
7. **3 modeles definis dans les services au lieu de `lib/models/`** —
   `WeatherData` (weather_service), `TamassiVisitor` (cloud_sync_service),
   `PhotoPickResult` (photo_service).
8. **Aucune accessibilite** — 0 usage de `Semantics` dans le code. L'app est
   inutilisable avec VoiceOver / TalkBack.
9. **Pas de privacy policy, CGU, ni mention RGPD** — obligatoire pour les stores.
10. **Pas d'analytics ni crash reporting** — aucun moyen de diagnostiquer les
    crashs en production.
11. **2 `debugPrint()` sans garde `kDebugMode`** — `cloud_sync_service.dart:401`
    et `feed_service.dart:103`.
