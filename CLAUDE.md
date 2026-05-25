# Kultiva

> Documentation pour futures sessions Claude Code.
> Dernière mise à jour : 2026-05-25.

## 🎯 Contexte

**Kultiva** est une application mobile Flutter de jardinage francophone, au style
pastel kawaii japonais. Elle s'adresse aux jardiniers amateurs de **France
métropolitaine** et d'**Afrique de l'Ouest**, et couvre :

- un calendrier mensuel de semis et de récolte adapté à la région ;
- un **catalogue** de 158 légumes, aromates, tubercules et accessoires ;
- le **Poussidex** : collection chronologique des plants de l'utilisateur, avec
  photos, notes, historique d'arrosage et compteur de récoltes ;
- **Mes jardins** : potager carré multi-jardins avec placement par
  glisser-déposer, suivi par plant (arrosage, phase de croissance auto, photos),
  conseils contextuels selon la météo ;
- **Tamassi** : créature virtuelle animée qui évolue avec l'activité au jardin
  (XP, niveaux, émotions, 3 variantes : Poussia, Soleia, Spira) ;
- des **alertes météo + arrosage + canicule** basées sur la géolocalisation et
  l'API Open-Meteo (gratuite, sans clé) ;
- un **feed communautaire** de défis photo (51 badges, 51 défis, médailles, likes) ;
- de la gamification : badges, défis, médailles bronze/argent/or par légume ;
- une synchronisation **cloud facultative** via Supabase (auth + Postgres +
  Storage) ;
- des tutoriels HTML embarqués (29 fiches), un lexique, un guide de maladies et
  de compagnonnage ;
- un **cahier de culture** pleine terre avec étapes phénologiques auto-suggérées,
  avertissement de rotation et conseils canicule personnalisés ;
- un lien avec **Kultivaprix** (projet sœur, comparateur de prix) via sync
  unidirectionnelle du catalogue vers Supabase.

**Statut** : en phase de polish pré-publication (v1.0.0+4) — CI iOS (Xcode
Cloud) + CI GitHub Actions branchées, config de signing Android active, landing
page marketing prête, conformité Amazon Associates en place. L'hydroponie a été
retirée (archivée sur `archive/hydroponie-2026-05-03`).

## 🛠️ Stack technique

**Frontend / mobile**

- Flutter **≥3.24** / Dart **^3.5** (canal `stable`)
- Material3, thèmes clair et sombre
- `google_fonts` ^6.1 — typographie **Nunito**
- `shared_preferences` ^2.2 — persistance locale
- `url_launcher` ^6.2 — liens affiliés Amazon
- `flutter_local_notifications` ^17.2.3 + `timezone` ^0.9 — rappels mensuels,
  quotidiens (Tamassi), arrosage et canicule
- `pdf` ^3.10 + `printing` ^5.12 — export PDF du calendrier
- `geolocator` ^11.0 + `geocoding` ^3.0 — détection régionale + nom de ville
- `permission_handler` ^11.3 — permissions caméra / localisation
- `http` ^1.2 — appels Open-Meteo
- `audioplayers` ^6.1 — SFX et musique de fond
- `image_picker` ^1.0 + `path_provider` ^2.1 — caméra / galerie et stockage local
- `share_plus` ^7.2 — partage Instagram / social
- `sensors_plus` ^6.0 — accéléromètre / gyroscope (animations de la créature)
- `webview_flutter` ^4.10 — tutoriels HTML

**Backend / services**

- **Supabase** (`supabase_flutter` ^2.5) — auth, Postgres, Storage
  (`plant-photos`, `news-images`) ; une edge function (`seed-species` pour sync
  catalogue vers Kultivaprix)
- **Open-Meteo** — météo 7 jours, aucune clé d'API requise
- **Google Sign-In** (`google_sign_in` ^6.2) — OAuth natif
- **Apple Sign-In** (`sign_in_with_apple` ^6.1) avec nonce SHA-256 (`crypto`)

**Outillage / plateformes**

- Android : Gradle 8.14, Kotlin + Java 17, signing release via
  `android/key.properties`, core library desugaring activé (desugar_jdk_libs
  2.1.4), app ID `com.toa.kultiva`, min SDK 21
- iOS : Xcode Cloud (`ios/ci_scripts/ci_post_clone.sh`), Apple Sign-In
  entitlement, URL scheme Google, permissions caméra / photos / localisation
  déclarées dans `Info.plist` (en français)
- CI : GitHub Actions (`ci.yml` : `flutter analyze` + `flutter test` sur push
  main et PR ; `sync-catalog.yml` : sync catalogue vers Supabase sur modif des
  fichiers source)
- Lints : `flutter_lints` ^5.0 + règles custom (`prefer_const_constructors`,
  `prefer_const_literals_to_create_immutables`, `avoid_print`,
  `use_key_in_widget_constructors`). Exclusion : `tool/**`.
- Tests : `flutter_test` (unitaires uniquement pour l'instant)
- Icônes : `flutter_launcher_icons` ^0.14 — icône adaptative Android (fond
  `#FCF4E1`), iOS avec fond crème

## 📁 Architecture

```
Kultiva/
├── lib/                    # Code Dart principal (~31 640 LoC sur 83 fichiers)
│   ├── main.dart           # Bootstrap : splash → onboarding → auth → tabs
│   ├── config/
│   │   └── supabase_config.dart    # URL, anon key, Google OAuth client IDs
│   ├── screens/            # 28 fichiers — 14 955 LoC
│   │   ├── splash_screen.dart
│   │   ├── onboarding_screen.dart
│   │   ├── root_tabs.dart          # Conteneur 4 onglets (Bottom nav)
│   │   ├── vegetable_detail_screen.dart
│   │   ├── auth/                   # login_screen, register_screen
│   │   └── home/                   # sow, vegetables, my_garden, tutos,
│   │                               # settings, weather, calendrier mensuel,
│   │                               # tuto_fiche (WebView),
│   │                               # garden_planner, mes_jardins,
│   │                               # culture_start_sheet,
│   │                               # garden_plan_config_sheet,
│   │                               # poussidex/* (8 fichiers)
│   ├── models/             # 6 fichiers — 885 LoC
│   │                       # plantation, vegetable, vegetable_medal,
│   │                       # region_data, culture_entry, garden_plan
│   ├── services/           # 16 fichiers — 3 209 LoC
│   │                       # auth, prefs, cloud_sync, weather, geolocation,
│   │                       # notification, photo, audio, watering,
│   │                       # watering_advisor, feed, pdf, tamassi_stats,
│   │                       # plantation_migration, culture, garden_plan
│   ├── data/               # 9 fichiers — 6 320 LoC
│   │   ├── vegetables_base.dart    # 158 entrées (120 légumes + 38 accessoires)
│   │   ├── badges.dart (51) / challenges.dart (51) / diseases.dart
│   │   ├── companions.dart / rotation.dart / lexicon.dart
│   │   └── regions/        # france.dart, west_africa.dart
│   ├── theme/
│   │   └── app_theme.dart  # KultivaColors, thèmes Material3 light/dark
│   ├── widgets/            # 15 fichiers — 5 365 LoC
│   │                       # plant_creature (55 Ko), badge_card (34 Ko),
│   │                       # petal_animation, season_header, share_card,
│   │                       # challenge_story_card, garden_tutorial_sheet,
│   │                       # jardins_intro_sheet, lexicon_text, medal_badge,
│   │                       # plantation_photo, tamassi_story_card,
│   │                       # vegetable_card, watering_bars,
│   │                       # camera_permission_dialog
│   └── utils/              # 6 fichiers — 428 LoC
│                           # category_colors, months, phenology,
│                           # companion_status, heatwave_tips,
│                           # rotation_advisor
├── supabase/
│   └── migrations/         # 001_initial_schema → 008_drop_hydro_tables
├── assets/
│   ├── images/             # créatures (3 variantes, 35 images), badges (50),
│   │                       # accessories (vide, fallback emoji), légumes (120),
│   │                       # backgrounds (4 time-of-day), cards, onboarding,
│   │                       # app_icon
│   ├── sounds/             # 8 fichiers (1 musique + 7 SFX)
│   └── tutos/              # 29 fichiers HTML + screens/
├── .github/workflows/      # ci.yml, sync-catalog.yml
├── tool/                   # export_catalog.dart (sync Kultivaprix)
├── docs/                   # catalog-sync, kultivaprix-handoff,
│                           # news-publication-guide, v5-test-checklist
├── _plans/                 # roadmap.md
├── android/                # app/build.gradle.kts, key.properties (ignoré)
├── ios/                    # Podfile, Runner, ci_scripts/, entitlements
├── landing/                # Site HTML statique marketing (index.html + img/)
├── test/                   # 8 fichiers — 988 LoC
│                           # badges, medals, plantation, vegetable,
│                           # culture_entry, garden_plan, phenology,
│                           # widget_test (stub)
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
```

**Flux d'état** : `main.dart` orchestre un bootstrap asynchrone qui initialise
Supabase, les services, charge les préférences, puis affiche selon l'état
(Splash → Onboarding si première ouverture → Auth si non connecté → RootTabs).

**Schéma Supabase** (voir `supabase/migrations/`) :

| Table              | Clé primaire        | Accès                                           |
| ------------------ | ------------------- | ----------------------------------------------- |
| `profiles`         | `id`                | Own only (RLS)                                  |
| `plantations`      | `id` (text)         | Own only                                        |
| `unlocked_badges`  | `(user_id,badge_id)`| Own only                                        |
| `preferences`      | `user_id`           | Own only                                        |
| `challenge_posts`  | `id`                | Lecture publique (authentifiés), écriture own   |
| `post_likes`       | `(user_id,post_id)` | Lecture publique, écriture own ; trigger counter|
| `user_xp`          | `user_id`           | Lecture publique (visiteurs Tamassi), écriture own |
| `news_items`       | `id` (uuid)         | Lecture publique (anon+auth), écriture service_role uniquement |

Triggers : `handle_new_user` (auto-profile), `touch_updated_at` (4 tables),
`update_likes_count` (compteur de likes), `touch_news_items_updated_at`.
Buckets Storage : `plant-photos`, `news-images` (public).

Tables supprimées (migration 008) : `culture_readings`, `hydro_builds`,
`hydro_build_likes` (feature hydroponie archivée).

## 💻 Règles de code

- **Langue** : strings UI et commentaires visibles utilisateur **en français**.
  Commentaires internes peuvent être en français aussi (pattern dominant).
- **State management** : pas de Provider / Riverpod / Bloc. On utilise
  `ValueNotifier` + `ValueListenableBuilder`, singletons de services et
  `SharedPreferences`. Ne pas introduire de framework externe sans discussion.
- **Local-first** : toute mutation passe d'abord par les services locaux
  (`PrefsService`, fichiers) ; `CloudSyncService` synchronise en arrière-plan
  de manière non bloquante. Si Supabase est indisponible, l'app doit continuer
  à fonctionner.
- **Services** = logique métier ; **widgets** = présentation. Éviter de mélanger.
- **Navigation** : `Navigator.push` et `showModalBottomSheet`. Pas de package
  de routing.
- **Lints** : `prefer_const_constructors`, `prefer_const_literals_to_create_immutables`,
  `avoid_print`, `use_key_in_widget_constructors`. Lancer `flutter analyze`
  avant toute PR.
- **Thème** : couleurs centralisées dans `lib/theme/app_theme.dart`
  (`KultivaColors`). Pour les catégories de légumes, utiliser
  `lib/utils/category_colors.dart`.
- **Photos** : stockées dans `app documents/plant_photos/` localement, puis
  uploadées dans le bucket `plant-photos` (chemin `{user_id}/{plantation_id}/{filename}`).
- **Assets** : après ajout dans `assets/`, déclarer le chemin dans la section
  `assets:` de `pubspec.yaml`. Des fichiers `.gitkeep` peuvent être nécessaires
  pour tracker des dossiers vides (cf commit `cba299c`).
- **Migrations Supabase** : **toujours** créer un nouveau fichier numéroté
  (`009_*.sql`, etc.). Ne jamais modifier une migration existante.
- **Dépendances** : toute nouvelle dépendance mérite un commentaire inline dans
  `pubspec.yaml` expliquant son usage (pattern observé).

## ⚡ Commandes utiles

### 🚀 Lancer l'app sur le Mac de Jean (routine quotidienne)

Le projet est sur **`~/Code/kultiva`** (Mac-mini-de-Jean). Branche de travail
courante : **`main`**. Commande à donner systématiquement après une modif
poussée par Claude Code :

```bash
cd ~/Code/kultiva && git stash && git pull origin main && flutter pub get && flutter run --release
```

- `git stash` est nécessaire car les lock files (`pubspec.lock`, `Podfile.lock`)
  sont régulièrement régénérés localement et bloquent le pull sinon.
- `--release` est le mode utilisé par défaut pour tester l'app sur device.
- Si la branche de travail change (ex. `claude/xxx`), adapter `origin/main`.

### Autres commandes

```bash
# Installation et exécution
flutter pub get
flutter run                         # debug
flutter run --release

# Qualité
flutter analyze
flutter test                        # tests unitaires dans test/

# Builds de release
flutter build apk --release
flutter build appbundle --release   # Google Play
flutter build ios --release         # iOS (signer via Xcode)

# iOS local (après install)
cd ios && pod install --repo-update && cd ..

# CI iOS
# Xcode Cloud lance automatiquement ios/ci_scripts/ci_post_clone.sh :
#   flutter precache --ios && flutter pub get && pod install

# CI GitHub Actions
# ci.yml : flutter analyze (--no-fatal-infos --no-fatal-warnings) + flutter test
# sync-catalog.yml : export du catalogue vers Supabase (table public.species)

# Android signing
# Nécessite un fichier android/key.properties (non commité) :
#   storeFile=...  storePassword=...  keyAlias=...  keyPassword=...

# Supabase
# Les migrations se trouvent dans supabase/migrations/ et sont appliquées
# manuellement via le dashboard Supabase (pas de supabase/config.toml).
```

## 🎨 Design / UX

- **Style** : pastel kawaii japonais, lignes arrondies (cards 18, chips 20,
  boutons 20), ombres douces, emojis parcimonieux mais bienvenus.
- **Font** : Nunito (bold pour les titres, regular pour le corps).
- **Palette claire** : `#F5FAF8` (fond), `#4A9B5A` (primaire vert),
  `#A8D5A2` (vert clair), `#E8A87C` (terracotta), `#2A4A3A` (texte).
- **Palette sombre** : `#0F1F18`, `#5ABD6A`, `#1A2E22`, `#1F3528`.
- **Gradients saisonniers** : printemps rose-vert, été jaune-vert, automne
  orange, hiver bleu-gris.
- **Animations** : pétales qui tombent, papillons, feuilles, flocons selon la
  saison ; créature Tamassi animée via accéléromètre.
- **Tone of voice** : chaleureux, ludique, enfantin. Exemples : « Kultiva
  utilise ta localisation pour afficher la météo de ton jardin », « Le potager
  kawaii dans ta poche 🌱 ».
- **Localisation** : app **fr-FR** uniquement pour l'instant.

### 🎨 Génération d'images ComfyUI (prompts produits)

Format retenu pour générer les visuels kawaii des plantes et accessoires —
même style que les 38 accessoires existants. Les images générées sont
**partagées avec Kultivaprix** (projet sœur, comparateur de prix), donc le
style doit rester identique sur les deux apps.

**Formule retenue (validée Apr 2026) :**

```
a [SUBJECT] icon, simple flat 2D vector design, solid [COLOR] color, [DETAILS], minimalist app icon, plain cream beige background, centered, 1:1 square
```

Exemple validé sur tomate :

```
a tomato icon, simple flat 2D vector design, solid red color, small green stem on top, minimalist app icon, plain cream beige background, centered, 1:1 square
```

⚠️ **Pourquoi cette formule** :
- `icon` + `vector design` + `minimalist app icon` → ancrent fort vers du logo plat
- `solid [color] color` → empêche le mélange de couleurs (sinon le modèle hésite)
- **NE PAS** ajouter « kawaii », « cute », « illustration », « character », « chibi »,
  « smiling face » — ces mots tirent vers du personnage anthropomorphisé,
  surtout sur les checkpoints anime/character (ex. `sdxl_afrotok_final`).
- Si le modèle reste biaisé character : baisser `cfg` à 4.5 sur le KSampler,
  ou désactiver les LoRAs actifs (clic-droit → Bypass).

**Format de sortie attendu** : TSV (tabulation entre prompt et filename),
copiable dans Numbers/Sheets ou un node ComfyUI batch :

```
<prompt complet sujet + style>	<id>.png
<prompt complet sujet + style>	<id>.png
```

Le filename = `{Vegetable.id}.png` (ex. `cornichon.png`, `pommier.png`).

Destination : `assets/images/vegetables/<id>.png` côté Kultiva, et même
fichier hébergé côté Kultivaprix (à voir : Supabase Storage public bucket
ou CDN partagé).

## 🚫 Pièges à éviter

- **Ne pas casser le mode offline** — toute nouvelle feature doit continuer à
  fonctionner sans session Supabase.
- **Ne pas monter en version majeure** de `flutter_local_notifications`
  (17 → 21), `geolocator` (11 → 14), `share_plus` (7 → 13),
  `google_fonts` (6 → 8) ou `printing` (5 → latest) sans plan de
  migration. Ces pins sont intentionnels et documentés dans `pubspec.yaml`.
- **Ne jamais committer** `android/key.properties`, `*.jks`, ou la `service_role`
  key Supabase. L'`anonKey` actuellement en source est publique (c'est normal).
- **Synchroniser `assets/` ⇄ `pubspec.yaml`** — les incidents récents sur les
  dossiers `accessories/` et `badges/` l'ont rappelé.
- **Ne jamais modifier une migration SQL existante** — créer toujours un nouveau
  fichier numéroté.
- **Ne pas mettre de logique métier dans les widgets** — elle doit vivre dans
  `lib/services/`.
- **Ne pas utiliser `print`** — désactivé par le lint `avoid_print`.
- **Attention aux permissions iOS** : les descriptions (caméra, photos,
  localisation) doivent rester en français et factuelles (pattern observé dans
  `Info.plist`).
- **Fallback météo** : si la géoloc échoue ou est refusée, le service retombe
  sur **Paris** par défaut. Ne pas supprimer ce fallback.

## 📝 Historique technique

Décisions et évolutions significatives :

- **CI GitHub Actions** : `ci.yml` (analyze + test sur push main et PR) et
  `sync-catalog.yml` (export catalogue vers Supabase pour Kultivaprix).
- **Cahier de culture pleine terre** (v5) : multi-jardins avec placement par
  glisser-déposer, suivi par plant, phases de croissance auto-suggérées,
  avertissement de rotation, conseils canicule.
- **Retrait de l'hydroponie** (mai 2026) : code archivé sur
  `archive/hydroponie-2026-05-03`, migrations 006/008 pour nettoyage Supabase.
- **Xcode Cloud** branché côté iOS via `ci_post_clone.sh` (clone Flutter stable,
  précache, pub get, pod install).
- **Dashboard onboarding** reconfiguré : tuto statique remplacé par animation
  kawaii dans une WebView centrée.
- **38 images d'accessoires** kawaii câblées avec fallback emoji ; `.gitkeep`
  ajouté pour tracker le dossier vide (images pas encore générées).
- **Android** : signing release wiré via `key.properties` ; chemin keystore
  corrigé (`rootProject.file` plutôt que `file`) ; core library desugaring
  activé pour supporter `flutter_local_notifications` 17+.
- **Permissions iOS** : correctifs sur l'ouverture caméra après grant, et
  gestion de la géolocalisation refusée avec fallback Paris.
- **Météo** : nom de ville affiché dans le header, bouton rafraîchir ajouté,
  alertes canicule avec tips par légume.
- **Amazon Associates** : mention « Lien partenaire » visible + bouton agrandi
  pour conformité du programme d'affiliation.
- **Gros ménage lint** : 308 substitutions `withOpacity` → `withValues` sur
  38 fichiers, >90 % des avertissements résorbés.
- **Sync catalogue Kultivaprix** : workflow GitHub Actions + edge function
  Supabase `seed-species`, documentation dans `docs/catalog-sync.md`.
- **Actualités** : table `news_items` + bucket `news-images` (migration 007),
  publication via Supabase Studio uniquement (service_role).

## 💬 Instructions pour Claude Code

Règles spécifiques au projet pour être efficace dès la première action :

1. **Respecter le contrat local-first** : ne jamais introduire d'appel réseau
   bloquant dans un flux UI. Synchro cloud = arrière-plan uniquement.
2. **Migrations** : toujours créer un nouveau fichier `supabase/migrations/009_*.sql`,
   jamais éditer les existants.
3. **Assets** : après `cp` d'un asset, penser à déclarer le chemin dans
   `pubspec.yaml`.
4. **Français** : rédiger en français les strings visibles utilisateur, les
   descriptions de permissions, les textes des notifications.
5. **Pas de nouvelle dépendance sans justification** dans le `pubspec.yaml`
   (commentaire inline obligatoire).
6. **Avant toute PR** : `flutter analyze` + `flutter test` doivent passer.
7. **Tests** : pour un nouveau modèle, ajouter `test/<nom>_test.dart` sur le
   pattern existant (voir `vegetable_test.dart`).
8. **Navigation** : rester sur `Navigator.push` / `showModalBottomSheet`. Pas
   de package de routing.
9. **Services externes** : privilégier les APIs gratuites sans clé (cf
   Open-Meteo) quand c'est possible.
10. **Créer une migration** quand on touche au schéma, pas un ALTER à la volée
    côté code.

## ⚠️ Alertes

À signaler à l'utilisateur / à traiter dans un futur ticket :

1. **Aucun test de widget ni d'intégration** — seuls les modèles et les
   données sont couverts (988 LoC de tests sur 31 640 LoC de code source).
   Aucun des 16 services n'a de test. 2 modèles non testés : `region_data`,
   `vegetable_medal`.
2. **Aucun edge function Supabase pour la logique métier** — XP, likes,
   modération du feed sont côté Dart, donc contournables si quelqu'un
   interroge l'API directement. (Note : l'edge function `seed-species` existe
   mais ne concerne que la sync catalogue.)
3. **L'`anonKey` Supabase est committée dans `lib/config/supabase_config.dart`** —
   c'est correct pour une anon key JWT publique, mais à documenter pour éviter
   tout doute.
4. **Commits dominés par Claude** (108 sur 157) — vérifier que les revues
   humaines restent régulières pour éviter les dérives stylistiques.
5. **`assets/images/accessories/` est vide** — les 38 images d'accessoires
   référencées dans le code ne sont pas encore générées (fallback emoji actif).
6. **54 légumes sur 120 n'ont pas de `harvestTimeBySeason`** — des trous dans
   les calendriers saisonniers sont possibles (66 sur 120 renseignés).
7. **Modèles définis dans les services au lieu de `lib/models/`** —
   `WeatherData` (weather_service), `TamassiVisitor` (cloud_sync_service),
   `PhotoPickResult` (photo_service), `FeedPost` (feed_service),
   `WateringAlert` (watering_service), `WateringAdvice` + enum
   `WateringUrgency` (watering_advisor).
8. **Aucune accessibilité** — 0 usage de `Semantics` dans le code. L'app est
   inutilisable avec VoiceOver / TalkBack.
9. **Pas de privacy policy, CGU, ni mention RGPD** — obligatoire pour les
   stores Apple et Google.
10. **Pas d'analytics ni crash reporting** — aucun Firebase Analytics,
    Crashlytics ou Sentry. Impossible de diagnostiquer les crashs en prod.
11. **2 `debugPrint()` sans garde `kDebugMode`** — `cloud_sync_service.dart:401`
    et `feed_service.dart:103`. Les 15 autres appels sont correctement gardés.
12. **`my_garden_screen.dart` fait 3 070 lignes** — le plus gros fichier du
    projet, à découper en sous-widgets. Autres fichiers volumineux :
    `plant_creature.dart` (1 798 LoC), `garden_planner_screen.dart` (1 777 LoC).
