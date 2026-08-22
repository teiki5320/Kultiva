# Kultiva

> Documentation pour futures sessions Claude Code.
> Dernière mise à jour : 2026-08-22.

## 🎯 Contexte

**Kultiva** est une application mobile Flutter de jardinage francophone, au style
pastel kawaii japonais. Elle s'adresse aux jardiniers amateurs de **France
métropolitaine** et d'**Afrique de l'Ouest**, et couvre :

- un calendrier mensuel de semis et de récolte adapté à la région ;
- un **catalogue** de 169 légumes, aromates, tubercules et accessoires
  (dont 130 cultures + 10 cultures d'Afrique de l'Ouest) ;
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
- des tutoriels HTML embarqués (33 fiches), un lexique, un guide de maladies et
  de compagnonnage ;
- un **cahier de culture** pleine terre avec étapes phénologiques auto-suggérées,
  avertissement de rotation et conseils canicule personnalisés ;
- un lien avec **Kultivaprix** (projet sœur, comparateur de prix) via sync
  unidirectionnelle du catalogue vers Supabase.

**Statut** : bi-marché **France + Afrique de l'Ouest** (v1.0.0+5), en polish
pré-publication — détection du pays et sous-zone climatique, calendriers et
saisons tropicaux, contenu local (noms, maraîchage, recettes, achat au marché),
feed par pays. CI iOS (Xcode Cloud) + GitHub Actions branchées, signing Android
actif, landing prête, Sentry, splash natif, privacy policy RGPD.
L'hydroponie a été retirée (archivée sur `archive/hydroponie-2026-05-03`).

## 🛠️ Stack technique

**Frontend / mobile**

- Flutter **≥3.38** / Dart **^3.5** (canal `stable`) — le code ne compile
  pas sous 3.32 (RadioGroup, activeThumbColor, scaleByDouble). CI épinglée
  sur `3.41.6`.
- Material3, thèmes clair et sombre
- `google_fonts` ^6.1 — typographie **Nunito**
- `shared_preferences` ^2.2 — persistance locale
- `url_launcher` ^6.2 — liens affiliés Amazon
- `flutter_local_notifications` ^17.2.3 + `timezone` ^0.9 +
  `flutter_timezone` ^1.0.8 — rappels mensuels, quotidiens (Tamassi),
  arrosage et canicule, planifiés dans le **fuseau réel** du device
- `flutter_localizations` (SDK) — locale fr-FR globale (DatePicker français)
- `pdf` ^3.10 + `printing` ^5.12 — export PDF du calendrier
- `geolocator` ^11.0 + `geocoding` ^3.0 — détection régionale + nom de ville
- `permission_handler` ^11.3 — permissions caméra / localisation
- `http` ^1.2 — appels Open-Meteo
- `audioplayers` ^6.1 — SFX et musique de fond
- `image_picker` ^1.0 + `path_provider` ^2.1 — caméra / galerie et stockage local
- `share_plus` ^7.2 — partage Instagram / social
- `sensors_plus` ^6.0 — accéléromètre / gyroscope (animations de la créature)
- `webview_flutter` ^4.10 — tutoriels HTML
- `sentry_flutter` ^8.3 — crash reporting (erreurs + stack traces)
- `in_app_review` ^2.0 — demande de note sur les stores

**Backend / services**

- **Supabase** (`supabase_flutter` ^2.5) — auth, Postgres, Storage
  (`plant-photos`, `news-images`) ; deux edge functions (`seed-species`
  pour sync catalogue vers Kultivaprix ; `delete-account` pour la
  suppression de compte in-app, à déployer manuellement)
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
├── lib/                    # Code Dart principal (~31 480 LoC sur 93 fichiers)
│   ├── main.dart           # Bootstrap : splash → onboarding → auth → tabs
│   ├── config/
│   │   └── supabase_config.dart    # URL, anon key, Google OAuth client IDs
│   ├── screens/            # 31 fichiers (dont my_garden/ découpé en 3)
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
│   │                               # my_garden/ (tamassi_view,
│   │                               # kawaii_background, garden_header),
│   │                               # poussidex/* (8 fichiers)
│   ├── models/             # 13 fichiers
│   │                       # plantation, vegetable, vegetable_medal,
│   │                       # country (pays + zone climatique),
│   │                       # region_data, culture_entry, garden_plan,
│   │                       # weather_data, tamassi_visitor, feed_post,
│   │                       # photo_pick_result, watering_alert,
│   │                       # watering_advice
│   ├── services/           # 17 fichiers
│   │                       # auth, prefs, cloud_sync, weather, geolocation,
│   │                       # notification, photo, audio, watering,
│   │                       # watering_advisor, feed, pdf, tamassi_stats,
│   │                       # plantation_migration, culture, garden_plan,
│   │                       # review
│   ├── data/               # 9 fichiers — 6 320 LoC
│   │   ├── vegetables_base.dart    # 169 entrées (130 cultures + 39 accessoires)
│   │   ├── badges.dart (51) / challenges.dart (51) / diseases.dart
│   │   ├── companions.dart / rotation.dart / lexicon.dart
│   │   ├── local_names.dart / market_data.dart / market_buying_tips.dart
│   │   ├── recipes.dart      # noms locaux, maraîchage FCFA, achat, cuisine (AO)
│   │   └── regions/          # france.dart, west_africa.dart,
│   │                         # west_africa_zones.dart (sous-zones),
│   │                         # regional_calendar.dart (sélecteur zone-aware)
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
│   ├── migrations/         # 001_initial_schema → 016_preferences_climate_zone
│   └── functions/          # delete-account (suppression de compte)
├── assets/
│   ├── images/             # créatures (3 variantes, 35 images), badges (50),
│   │                       # accessories (38 images kawaii), légumes (120),
│   │                       # backgrounds (4 time-of-day), cards, onboarding,
│   │                       # app_icon
│   ├── sounds/             # 8 fichiers (1 musique + 7 SFX)
│   └── tutos/              # 34 fichiers HTML (33 tutos + privacy) + screens/
├── .github/workflows/      # ci.yml, sync-catalog.yml
├── tool/                   # export_catalog.dart (sync Kultivaprix)
├── docs/                   # INFRA (fiche technique), MARKETING (plan),
│                           # FICHE_APP_STORE (fiche ASC copiable),
│                           # store-listings, catalog-sync,
│                           # kultivaprix-handoff, news-publication-guide,
│                           # v5-test-checklist
├── _plans/                 # roadmap.md
├── android/                # app/build.gradle.kts, key.properties (ignoré)
├── ios/                    # Podfile, Runner, ci_scripts/, entitlements
├── landing/                # Site vitrine (index.html + privacy.html + img/ WebP)
├── test/                   # 18 fichiers — 2 307 LoC
│                           # badges, medals, plantation, vegetable,
│                           # culture_entry, garden_plan, phenology,
│                           # region_data, vegetable_medal,
│                           # watering_advisor, widget_test
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
- **Audit mai 2026** : extraction de 6 modèles des services vers `lib/models/`,
  ajout `sentry_flutter` (crash reporting), `in_app_review` (notes store),
  `flutter_native_splash` (splash natif), privacy policy HTML + lien settings,
  migrations 009 (sécurisation XP) + 010 (modération feed) + 011 (sync_xp RPC),
  3 nouveaux tests (region_data, vegetable_medal, watering_advisor), CI durcie
  (warnings fatals), ~600 lignes de code mort supprimées, 10 deprecated APIs
  corrigés, `my_garden_screen.dart` découpé (2 607 → 264 LoC + 3 sous-fichiers),
  54 légumes `harvestTimeBySeason` complétés (120/120), 38 images d'accessoires
  kawaii générées (ComfyUI), lien Instagram `@toa.kultiva` câblé, version
  bumpée à 1.0.0+5.
- **Cap Afrique de l'Ouest (juillet 2026)** : 8 pays francophones,
  détection auto, saisons tropicales, calendrier AO complet, 10 cultures
  locales, migrations 012-013, manifest Android réparé (géoloc + notifs),
  assets 245→33 Mo (voir `_plans/rapport-cap-afrique-2026-07-18.md`).
- **Corrections pré-publication (24 juillet 2026)** : sections 1-4 de
  l'audit du 7 juillet. Bloquants stores (suppression de compte in-app via
  edge function `delete-account`, `CFBundleVersion`, portrait, splash natif,
  contrainte Flutter ≥3.38, CI épinglée + job appbundle, debug XP masqué) ;
  fiabilité sync cloud (`Plantation.merge` champ par champ, `uploadBadges`
  additif, prefs LWW par `updated_at`, timeouts 12 s, login non bloquant,
  `clearLocalData` complète, migration 014 `sync_xp` monotone) ; bugs UX
  (navigation déconnexion, `Scaffold` settings, inscription confirmation
  email, `tz.local` via `flutter_timezone`, streak/reset Tamassi, badges
  union, cycle de vie du planner + `PopScope` + thème sombre, décodage
  tolérant `garden_plan`, `flutter_localizations` fr-FR) ; bonus (tri/
  recherche sans accents, `feed_service` fiable, `ReviewService` branché,
  purge photos orphelines). +16 tests → 164. Voir
  `_plans/rapport-corrections-2026-07-24.md`.
- **Virage Afrique de l'Ouest (août 2026)** — l'app n'est plus une
  déclinaison France mais bi-marché :
  - **Modèle `Country`** (`lib/models/country.dart`) : France + 8 pays
    francophones AO, chacun avec drapeau, capitale (fallback météo) et
    zone climatique. La `Region` reste le pivot ; le pays l'affine.
  - **Détection** : à l'onboarding, le pays de l'utilisateur apparaît
    **en premier** (déduit de la langue du device, affiné par géoloc
    passive) — pas de privilège France. `GeolocationService.detectCountryAndZone`.
  - **Zones climatiques v2** : `ClimateZone {sahel, sudan, guinean}` ;
    `Country.zoneAt(latitude)` affine la sous-zone (Bamako soudanien, nord
    Côte d'Ivoire vs Abidjan…). `PrefsService.effectiveZone` alimente
    calendriers ET saisons. Surcharges dans `lib/data/regions/west_africa_zones.dart`,
    appliquées par `regionalCalendar(region, zone:)` (`regional_calendar.dart`).
  - **Saisons tropicales** : `Season.of(month, region, {zone})` →
    harmattan / saison sèche / hivernage (plus de flocons en AO), gradients
    ocre/vert. Seuil canicule 40 °C (AO) vs 30 °C, alerte « premières pluies ».
  - **Contenu** : calendrier AO 130 cultures + 10 locales (mil, fonio,
    moringa, djakhatou, corète…), noms locaux (`local_names.dart`),
    mode maraîchage FCFA (`market_data.dart`), conseils d'achat au marché
    (`market_buying_tips.dart`, remplace Amazon masqué en AO), recettes
    (`recipes.dart`), maladies tropicales, 4 tutos AO, feed filtrable par
    pays.
  - **Poids/data** : assets 245→33 Mo, Nunito bundlée, tutos 100 % hors-ligne,
    APK `--split-per-abi` en CI.
  - **Migrations 012-016** (FK feed→profiles, `country`, `sync_xp`,
    `challenge_posts.country`, `preferences.climate_zone`). Fiches stores
    par pays dans `docs/store-listings.md`. Tests → 183.
- **Préparation stores (août 2026)** : fiches `docs/INFRA.md` +
  `docs/MARKETING.md` au format du dashboard « Mes apps » (repo Dashboard),
  `docs/FICHE_APP_STORE.md` (fiche ASC prête à coller, décomptes vérifiés,
  mots-clés 98/100 octets), page publique `landing/privacy.html`, e-mail de
  support `kultiva.toa@gmail.com` câblé partout, landing en WebP
  (5,6 Mo → 0,2 Mo), chiffres marketing corrigés (33 tutos, 51 défis/51
  badges), audit `_plans/audit-2026-08-21.md` (analyze 3 infos,
  183 tests verts). Décisions ouvertes : mode invité (5.1.1), DSA
  (affiliation → trader), iPad (captures 13″ exigées).

## 💬 Instructions pour Claude Code

Règles spécifiques au projet pour être efficace dès la première action :

1. **Respecter le contrat local-first** : ne jamais introduire d'appel réseau
   bloquant dans un flux UI. Synchro cloud = arrière-plan uniquement.
2. **Migrations** : toujours créer un nouveau fichier `supabase/migrations/012_*.sql`,
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

0. **Actions manuelles Supabase avant publication** (bloquant review Apple) :
   appliquer les migrations **012 → 016** dans SQL Editor et **déployer
   l'edge function `delete-account`** (`supabase functions deploy
   delete-account`). Sans ce déploiement, « Supprimer mon compte » échoue.
   Les migrations 012-016 sont tolérées côté client (retry sans la colonne),
   mais feed par pays, sync du pays et de la sous-zone ne s'activent qu'une
   fois appliquées. Détails dans `_plans/rapport-corrections-2026-07-24.md`.
1. **Aucun test de widget ni d'intégration** — modèles, données, zones
   climatiques, `Country.zoneAt`, `watering_advisor`, `Plantation.merge`,
   `PrefsService` et `text_normalize` sont couverts (183 tests). Pas encore
   de test de widget.
2. **L'`anonKey` Supabase est committée dans `lib/config/supabase_config.dart`** —
   c'est correct pour une anon key JWT publique, mais à documenter pour éviter
   tout doute.
3. **Fichiers volumineux restants** — `tamassi_view.dart` (1 740 LoC),
   `garden_planner_screen.dart` (1 777 LoC). Candidats à un découpage futur.
4. **Connexion obligatoire au premier lancement** — l'écran de login n'a
   pas de « continuer sans compte », alors que le calendrier et les fiches
   n'exigent pas de compte : risque guideline 5.1.1 à la review Apple.
   Décision en attente : mode invité (recommandé) ou compte de démo seul.
   Voir `_plans/audit-2026-08-21.md`.
5. **Liens stores dans `landing/index.html`** — les boutons Télécharger
   pointent vers `href="#"`. À remplacer par les vrais liens App Store /
   Play Store une fois l'app publiée.
