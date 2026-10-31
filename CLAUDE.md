# Kultiva

> Documentation pour futures sessions Claude Code.
> Dernière mise à jour : 2026-10-21.

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
- **Poussidex** : collection de plants, 50 défis photo et 50 badges, joignable
  depuis le dashboard (ce n'est plus un onglet depuis le 30/10/2026) ;
- des **alertes météo + arrosage + canicule** basées sur la géolocalisation et
  l'API Open-Meteo (gratuite, sans clé) ;
- des **défis photo** avec 50 badges, 50 défis et des médailles (les photos
  restent privées — le feed communautaire a été retiré de la v1) ;
- de la gamification : badges, défis, médailles bronze/argent/or par légume ;
- **aucun compte et aucun serveur** : tout vit sur l'appareil ;
- des tutoriels HTML embarqués (33 fiches), un lexique, un guide de maladies et
  de compagnonnage ;
- un **cahier de culture** pleine terre avec étapes phénologiques auto-suggérées,
  avertissement de rotation et conseils canicule personnalisés ;

**Statut** : bi-marché **France + Afrique de l'Ouest** (v1.0.0+5), en polish
pré-publication — détection du pays et sous-zone climatique, calendriers et
saisons tropicaux, contenu local (noms, maraîchage, recettes, achat au marché),
CI iOS (Xcode Cloud) + GitHub Actions branchées, signing Android
actif, landing prête, Sentry, splash natif, privacy policy RGPD.
L'hydroponie a été retirée (archivée sur `archive/hydroponie-2026-05-03`).

## 🛠️ Stack technique

**Frontend / mobile**

- Flutter **≥3.47** / Dart **^3.5** (canal `stable`). Borne relevée le
  30/10/2026 : sous 3.41.6, `pdf_service.dart` ne compile plus. Les trois
  environnements disent la même version — Mac, GitHub Actions
  (`ci.yml`) et Xcode Cloud (`ci_post_clone.sh`) : **3.47.3**.
- Material3, thèmes clair et sombre
- `google_fonts` ^6.1 — typographie **Nunito**
- `shared_preferences` ^2.2 — persistance locale
- `url_launcher` ^6.2 — liens externes (Instagram ; boutons « Acheter »
  Amazon remis le 30/10/2026, tag `kultiva1-21`, France seulement)
- `flutter_local_notifications` ^17.2.3 + `timezone` ^0.9 +
  `flutter_timezone` ^3.0.1 — rappels mensuels,
  arrosage et canicule, planifiés dans le **fuseau réel** du device
- `flutter_localizations` (SDK) — locale fr-FR globale (DatePicker français)
- `pdf` ^3.10 + `printing` ^5.12 — export PDF du calendrier
- `geolocator` ^11.0 + `geocoding` ^3.0 — détection régionale + nom de ville
- `permission_handler` ^13.0 — uniquement `openAppSettings()` (renvoyer
  vers les réglages système après un refus de la caméra). Exige le SDK
  Android 37, installé explicitement par la CI.
- `http` ^1.2 — appels Open-Meteo
- `audioplayers` ^6.1 — SFX et musique de fond
- `image_picker` ^1.0 + `path_provider` ^2.1 — caméra / galerie et stockage local
- `share_plus` ^7.2 — partage Instagram / social
- `sensors_plus` ^6.0 — accéléromètre / gyroscope (animations de la créature)
- `webview_flutter` ^4.10 — tutoriels HTML
- `sentry_flutter` ^8.3 — crash reporting (erreurs + stack traces)
- `in_app_review` ^2.0 — demande de note sur les stores

**Backend / services**

- **Aucun backend.** Les comptes ont été retirés le 30/10/2026 : plus de
  Supabase, plus de synchronisation, plus de suppression de compte à
  implémenter (l'exigence Apple ne s'applique qu'aux apps qui créent des
  comptes). Le projet Supabase existe toujours, en pause, et ses
  migrations restent dans `supabase/migrations/` à titre d'historique —
  **plus aucune ligne de Dart ne les utilise**
- **Open-Meteo** — météo 7 jours, aucune clé d'API requise

**Outillage / plateformes**

- Android : Gradle 8.14, Kotlin 2.2.20 (le pin en 2.1.x pour
  sentry_flutter 8 est levé ; Flutter 3.47 exige ≥ 2.2.20), Java 17,
  compile contre le SDK 37 via permission_handler, signing release via
  `android/key.properties`, core library desugaring activé (desugar_jdk_libs
  2.1.4), app ID `com.toa.kultiva`, min SDK 24 / target SDK 36
- iOS : Xcode Cloud (`ios/ci_scripts/ci_post_clone.sh`), permissions
  caméra / photos / localisation
  déclarées dans `Info.plist` (en français)
- CI : GitHub Actions (`ci.yml` : `flutter analyze` + `flutter test` +
  build appbundle et APK par ABI, sur push main et PR ; `site.yml` :
  publication du dossier `landing/`). Flutter épinglé en **3.47.3**,
  aligné sur le Mac : une CI en retard ne voit pas ce qui casse en local
- Lints : `flutter_lints` ^5.0 + règles custom (`prefer_const_constructors`,
  `prefer_const_literals_to_create_immutables`, `avoid_print`,
  `use_key_in_widget_constructors`). Exclusion : `tool/**`.
- Tests : `flutter_test` (unitaires uniquement pour l'instant)
- Icônes : `flutter_launcher_icons` ^0.14 — icône adaptative Android (fond
  `#FCF4E1`), iOS avec fond crème

## 📁 Architecture

```
Kultiva/
├── lib/                    # Code Dart principal (32 093 LoC sur 100 fichiers,
│                           # mesuré le 31/10/2026)
│   ├── main.dart           # Bootstrap : onboarding → tabs
│   ├── config/
│   │   └── app_info.dart           # version affichée (à synchroniser avec pubspec)
│   ├── screens/            # 33 fichiers
│   │   ├── onboarding_screen.dart
│   │   ├── root_tabs.dart          # Conteneur 4 onglets (Bottom nav)
│   │   ├── vegetable_detail_screen.dart
│   │   └── home/                   # sow, vegetables, my_garden, tutos,
│   │                               # settings, weather, calendrier mensuel,
│   │                               # tuto_fiche (WebView),
│   │                               # garden_planner, mes_jardins,
│   │                               # garden_plan_config_sheet,
│   │                               # my_garden/ (garden_header),
│   │                               # cahier/ (today_card, plants_section),
│   │                               # garden_planner/ (screen +
│   │                               # planner_cell / _advice / _plants,
│   │                               # planner_widgets = point d'entrée),
│   │                               # poussidex/* (9 fichiers, dont
│   │                               # plantation_sheet = le seul point
│   │                               # d'entrée du dossier d'un plant)
│   ├── models/             # 11 fichiers
│   │                       # plantation, vegetable, vegetable_medal,
│   │                       # country (pays + zone climatique),
│   │                       # region_data, culture_entry, garden_plan,
│   │                       # weather_data,
│   │                       # photo_pick_result, watering_alert,
│   │                       # watering_advice
│   ├── services/           # 16 fichiers
│   │                       # prefs, plantation, error_reporter, weather,
│   │                       # geolocation,
│   │                       # notification, photo, audio, watering,
│   │                       # watering_advisor, pdf, garden_stats,
│   │                       # plantation_migration, culture, garden_plan,
│   │                       # review
│   ├── data/               # 11 fichiers
│   │   ├── vegetables_base.dart    # 169 entrées (130 cultures + 39 accessoires)
│   │   ├── badges.dart (50) / challenges.dart (50) / diseases.dart
│   │   ├── companions.dart / rotation.dart / lexicon.dart
│   │   ├── local_names.dart / market_data.dart / market_buying_tips.dart
│   │   ├── recipes.dart      # noms locaux, maraîchage FCFA, achat, cuisine (AO)
│   │   └── regions/          # france.dart, west_africa.dart,
│   │                         # west_africa_zones.dart (sous-zones),
│   │                         # regional_calendar.dart (sélecteur zone-aware)
│   ├── theme/
│   │   └── app_theme.dart  # KultivaColors, thèmes Material3 light/dark
│   ├── widgets/            # 13 fichiers
│   │                       # badge_card (1 090 lignes), readable_width,
│   │                       # petal_animation, season_header, share_card,
│   │                       # challenge_story_card, garden_tutorial_sheet,
│   │                       # jardins_intro_sheet, lexicon_text, medal_badge,
│   │                       # plantation_photo,
│   │                       # vegetable_card, camera_permission_dialog
│   └── utils/              # 9 fichiers
│                           # category_colors, months (dont
│                           # monthRangesLabel), phenology, climate,
│                           # text_scale (hauteurs qui suivent la police),
│                           # text_normalize, companion_status,
│                           # heatwave_tips, rotation_advisor
├── supabase/
│   └── migrations/         # 001 → 016 : historique du schéma, plus
│                           # utilisé par l'app (aucun backend)
├── assets/
│   ├── images/             # badges (50),
│   │                       # accessories (38 images kawaii), légumes (120),
│   │                       # backgrounds (4 time-of-day), cards, onboarding,
│   │                       # app_icon
│   ├── sounds/             # 7 fichiers (1 musique + 6 SFX)
│   └── tutos/              # 34 fichiers HTML (33 tutos + privacy) + screens/
├── .github/workflows/      # ci.yml, site.yml
├── docs/                   # INFRA (fiche technique), MARKETING (plan),
│                           # FICHE_APP_STORE (fiche ASC copiable),
│                           # store-listings, catalog-sync,
│                           # news-publication-guide,
│                           # v5-test-checklist
├── _plans/                 # roadmap.md
├── android/                # app/build.gradle.kts, key.properties (ignoré)
├── ios/                    # Podfile, Runner, ci_scripts/, entitlements
├── landing/                # Site vitrine (index.html + privacy.html + img/ WebP)
├── test/                   # 31 fichiers — 4 062 LoC — 325 tests
│                           # badges, medals, plantation, vegetable,
│                           # culture_entry, garden_plan, phenology,
│                           # region_data, vegetable_medal,
│                           # watering_advisor, plantation_service,
│                           # corrupt_save, assets_exist,
│                           # text_scale, ipad_landscape, widget_test
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
```

**Flux d'état** : `main.dart` initialise Sentry **puis** lance le
bootstrap dans son `appRunner` — préférences, migration de l'ancienne
grille, chargement de la collection de plants, rattachement des cultures
du cahier, notifications — et affiche selon l'état (Onboarding si
première ouverture, sinon RootTabs). Plus d'authentification, et plus
d'écran de démarrage Dart : `flutter_native_splash` s'en charge.

**Schéma Supabase** — ⚠️ **historique seulement.** Plus aucune ligne de
Dart ne touche ces tables depuis le retrait des comptes (30/10/2026). Le
tableau est conservé parce que le projet existe encore, en pause, et
qu'il servirait de point de départ si un backend revenait un jour
(décision alors à prendre : Cloudflare D1 + R2 plutôt que Supabase, voir
`_plans/`).

| Table              | Clé primaire        | Accès                                           |
| ------------------ | ------------------- | ----------------------------------------------- |
| `profiles`         | `id`                | Own only (RLS)                                  |
| `plantations`      | `id` (text)         | Own only                                        |
| `unlocked_badges`  | `(user_id,badge_id)`| Own only                                        |
| `preferences`      | `user_id`           | Own only                                        |
| `challenge_posts`  | `id`                | Lecture publique (authentifiés), écriture own   |
| `post_likes`       | `(user_id,post_id)` | Lecture publique, écriture own ; trigger counter|
| `user_xp`          | `user_id`           | Lecture publique, écriture own (table d'un ancien XP, sans objet) |
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
- **Local-only** : toute donnée passe par les services locaux
  (`PrefsService`, `PlantationService`, fichiers). Il n'y a plus de
  synchronisation. **Ne pas réintroduire d'appel réseau bloquant** : les
  deux seuls appels sortants sont Open-Meteo (météo) et Sentry (crashs),
  tous deux non bloquants.
- **Services** = logique métier ; **widgets** = présentation. Éviter de mélanger.
- **Navigation** : `Navigator.push` et `showModalBottomSheet`. Pas de package
  de routing.
- **Lints** : `prefer_const_constructors`, `prefer_const_literals_to_create_immutables`,
  `avoid_print`, `use_key_in_widget_constructors`. Lancer `flutter analyze`
  avant toute PR.
- **Thème** : couleurs centralisées dans `lib/theme/app_theme.dart`
  (`KultivaColors`). Pour les catégories de légumes, utiliser
  `lib/utils/category_colors.dart`.
- **Photos** : stockées dans `app documents/plant_photos/`, et nulle part
  ailleurs — il n'y a plus d'upload depuis le retrait des comptes. Les
  orphelines sont purgées au démarrage (`PhotoService.purgeOrphans`), qui
  **ne supprime rien** si l'inventaire des photos encore référencées n'a
  pas pu être reconstitué.
- **Assets** : après ajout dans `assets/`, déclarer le chemin dans la section
  `assets:` de `pubspec.yaml`. Des fichiers `.gitkeep` peuvent être nécessaires
  pour tracker des dossiers vides (cf commit `cba299c`).
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
# site.yml : publication du dossier landing/ sur GitHub Pages

# Android signing
# Nécessite un fichier android/key.properties (non commité) :
#   storeFile=...  storePassword=...  keyAlias=...  keyPassword=...

# Aucun backend : rien à lancer ni à configurer côté serveur.
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
  saison.
- **Tone of voice** : chaleureux, ludique, enfantin. Exemples : « Kultiva
  utilise ta localisation pour afficher la météo de ton jardin », « Le potager
  kawaii dans ta poche 🌱 ».
- **Localisation** : app **fr-FR** uniquement pour l'instant.

### 🎨 Génération d'images

> ⚠️ **Changement de style décidé le 30/10/2026** : tous les visuels du
> catalogue (130 légumes, 50 badges) passent au **kawaii peint**,
> générés sur **OpenArt** (GPT Image 2, image-to-image avec une planche
> de référence). Le chantier est en cours dans
> `assets/images/vegetables_kawaii/`, dont le README porte la recette,
> l'avancement et la marche à suivre pour basculer.
>
> La formule ComfyUI ci-dessous décrit l'**ancien** style plat, celui
> des 122 légumes et 38 accessoires encore en place. Elle interdit le
> mot « kawaii » — c'était cohérent pour du logo plat, ça ne l'est plus
> pour le nouveau style. Les deux ne se mélangent pas : conservée ici
> tant que l'ancien style est à l'écran.

### 🎨 Ancienne formule ComfyUI (style plat)

Format retenu pour générer les visuels kawaii des plantes et accessoires —
même style que les 38 accessoires existants. Les images générées sont
le style des 38 accessoires existants, qu'il faut conserver pour que le
catalogue reste homogène.

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

Destination : `assets/images/vegetables/<id>.png`.

**Poids** : les visuels actuels sont des PNG 512 px en palette 8 bits,
≈ 29 Ko. Le nouveau lot est en **WebP 512 px qualité 80, ≈ 8,5 Ko** —
Flutter lit le WebP nativement, et le catalogue s'allège, ce qui compte
pour l'Afrique de l'Ouest.

## 🚫 Pièges à éviter

- **Ne pas casser le mode hors ligne** — l'app entière doit fonctionner
  sans réseau, à l'exception de la météo.
- **Ne pas monter en version majeure** de `flutter_local_notifications`
  (17 → 21), `geolocator` (11 → 14), `share_plus` (7 → 13),
  `google_fonts` (6 → 8) ou `printing` (5 → latest) sans plan de
  migration. Ces pins sont intentionnels et documentés dans `pubspec.yaml`.
- **Ne jamais committer** `android/key.properties` ni `*.jks`. Les seules
  valeurs publiques par design encore en source sont le DSN Sentry
  (`lib/main.dart`).
- **Synchroniser `assets/` ⇄ `pubspec.yaml`** — les incidents récents sur les
  dossiers `accessories/` et `badges/` l'ont rappelé.
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

- **Suppression de Tamassi (31/10/2026)** : la créature virtuelle, ses
  trois variantes, son XP, ses visiteurs et son rappel de 19 h sont
  partis — 10 fichiers, 3,7 Mo d'images, −4 141 lignes. Les 50 badges
  ont été réécrits sur des gestes de jardin (plants, arrosages,
  récoltes, cases remplies) en **gardant leurs identifiants**, les
  médaillons étant nommés d'après eux. `TamassiStats` est remplacé par
  `GardenStats`, qui ne stocke rien et recalcule tout depuis les
  services propriétaires de la donnée.
- **Refonte du calendrier annuel (31/10/2026)** : le `DataTable` de
  130 lignes sur 13 colonnes, qu'on faisait défiler latéralement,
  devient une ligne pleine largeur par légume avec douze segments.
  `monthRangesLabel()` (`lib/utils/months.dart`) compresse une liste de
  mois en plages lisibles, séries à cheval sur le nouvel an comprises.
- **Le cahier de culture répond au matin (31/10/2026)** : carte « à
  faire aujourd'hui » (arrosages dus, récoltes mûres, canicule), aperçu
  de la grille sur chaque carte de jardin, liste « au jardin en ce
  moment ». `showPlantationSheet()` devient le point d'entrée unique du
  dossier d'un plant, partagé avec le Poussidex.
- **CI GitHub Actions** : `ci.yml` (analyze + test + builds Android sur
  push main et PR) et `site.yml` (publication de `landing/`).
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
- **Amazon Associates** (actif depuis le 30/10/2026) : mention « Lien
  partenaire » visible sous le bouton, pour la conformité du programme.
  Les 159 liens avaient été retirés le 20/10/2026 (commit 0dbe0e4) après
  la fermeture du compte du tag `kultiva-21` le 18/10 ; ils sont revenus
  le 30/10 sous `kultiva1-21`. **Le catalogue ne stocke plus d'URL** mais
  les mots cherchés (`amazonQuery`) ; l'URL et le tag sont construits par
  `amazonUrlFor`, et le tag vit dans la seule constante
  `kAmazonAffiliateTag`. Changer de compte, c'est désormais une ligne,
  pas 159. ⚠️ Conséquence à ne pas oublier : le statut **trader** au sens
  du DSA redevient applicable.
- **Gros ménage lint** : 308 substitutions `withOpacity` → `withValues` sur
  38 fichiers, >90 % des avertissements résorbés.
- **Sync catalogue Kultivaprix** (retirée le 30/10/2026) : Kultivaprix
  n'a plus de lien avec Kultiva. Le workflow `sync-catalog.yml`,
  `tool/export_catalog.dart`, le snapshot `kultiva-catalog.json`, l'edge
  function `seed-species` et les deux fiches de passation sont supprimés
  (récupérables dans l'historique git). Le secret GitHub
  `KULTIVA_SEED_SECRET` et la table `species` côté Supabase peuvent être
  retirés à la main.
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
    (`recipes.dart`), maladies tropicales, 4 tutos AO.
  - **Poids/data** : assets 245→33 Mo, Nunito bundlée, tutos 100 % hors-ligne,
    APK `--split-per-abi` en CI.
  - **Migrations 012-016** (FK feed→profiles, `country`, `sync_xp`,
    `challenge_posts.country`, `preferences.climate_zone`). Fiches stores
    par pays dans `docs/store-listings.md`. Tests → 183.
- **Préparation stores (août 2026)** : fiches `docs/INFRA.md` +
  `docs/MARKETING.md` au format du dashboard « Mes apps » (repo Dashboard),
  `docs/FICHE_APP_STORE.md` (fiche ASC prête à coller, décomptes vérifiés,
  mots-clés 98/100 octets), page publique `landing/privacy.html`, e-mail de
  support `kultiva@toakeur.com` câblé partout, landing en WebP
  (5,6 Mo → 0,2 Mo), chiffres marketing corrigés (33 tutos ; le 51/51 annoncé était faux,
  recompté à 50/50 le 24/08 — voir plus bas
  badges), audit `_plans/audit-2026-08-21.md` (analyze 3 infos,
  183 tests verts). Décisions ouvertes : mode invité (5.1.1), DSA
  (affiliation → trader ; affiliation retirée le 20/10/2026, à revoir),
  iPad (captures 13″ exigées).

- **Tamassi supprimé, badges réécrits (31/10/2026)** : la créature
  virtuelle disparaît — 10 fichiers, ~90 Ko de code, 3,7 Mo d'images,
  le rappel quotidien de 19 h, les visiteurs générés localement. Le
  point dur était ailleurs : **35 des 50 badges dépendaient d'elle**
  (caresses, XP, connexions du matin, abeilles aperçues). Ils comptent
  maintenant des plants, arrosages, récoltes, photos, cases et
  jardins, via un nouveau `GardenStats` qui recalcule depuis les
  services au lieu de tenir des compteurs parallèles. **Les 50
  identifiants sont inchangés** : les médaillons sont des fichiers
  nommés d'après eux. Le Poussidex garde Mes plants / Défis / Badges
  et se joint depuis le dashboard.
- **Nouvel ordre des onglets (30/10/2026)** : Home, **Cahier**, Étal,
  Tutos. Le cahier de culture passe devant le catalogue ; le Poussidex
  quitte la barre. ⚠️ Les tutos HTML naviguent par index
  (`RootTabs.tabIndex`) : tout changement d'ordre doit passer par
  `tuto_fiche_screen.dart`, et `test/onglets_test.dart` le verrouille.

## 💬 Instructions pour Claude Code

Règles spécifiques au projet pour être efficace dès la première action :

1. **Respecter le contrat local-only** : ne jamais introduire d'appel
   réseau bloquant dans un flux UI, et ne pas réintroduire de backend
   sans en discuter (décision du 30/10/2026).
2. **Un seul registre par donnée** : les arrosages, récoltes et photos
   d'un plant vivent dans sa `Plantation`, et nulle part ailleurs. Ne pas
   recréer un stockage parallèle « juste pour cet écran » — c'est ce qui
   a produit quatre registres d'arrosage dont trois morts.
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
10. **Brancher ce qu'on écrit** : un écran, un service ou un conseiller
    qu'aucun chemin de l'app n'atteint est un bug, pas une avance. Quatre
    fonctionnalités annoncées ont déjà été livrées sans être reliées.

## ⚠️ Alertes

À signaler à l'utilisateur / à traiter dans un futur ticket :

0. ~~**Actions manuelles Supabase avant publication**~~ — ✅ **FAIT
   (vérifié le 24/08/2026 par appels API)** : migrations 012 → 016
   appliquées (`preferences.country`, `preferences.climate_zone`,
   `challenge_posts.country`, FK feed→profiles, RPC `sync_xp`) et edge
   function `delete-account` déployée.

1. **Pas de test d'intégration** — 280 tests au 30/10/2026, dont une
   première couche de widgets : `text_scale_test.dart` monte dix écrans
   sur un iPhone SE à police normale puis 1,3, `ipad_landscape_test.dart`
   fait de même aux dimensions d'un iPad en portrait et en paysage, et
   `assets_exist_test.dart` vérifie que chaque image déclarée existe.
   Aucun parcours complet n'est joué de bout en bout, et **rien n'a
   encore été essayé avec VoiceOver réellement activé** : un test voit
   qu'une boîte ne déborde pas, pas qu'un écran est agréable à écouter.
2. ~~**L'`anonKey` Supabase est committée**~~ — sans objet depuis le
   retrait des comptes (30/10/2026) : `lib/config/supabase_config.dart`
   est supprimé.
3. **Fichiers volumineux restants** — mesurés le 31/10/2026 :
   `vegetable_detail_screen.dart` (1 283), `badge_card.dart` (1 090),
   `sow_screen.dart` (1 033). `vegetables_base.dart` (4 281) et
   `west_africa.dart` (945) sont des fichiers de données, ils ne sont
   pas concernés.
   `planner_widgets.dart` a été découpé le 30/10 en `planner_cell`,
   `planner_advice` et `planner_plants`, le fichier d'origine servant de
   point d'entrée. ⚠️ Les chiffres précédents (1 740 / 1 777) étaient
   périmés : ces deux fichiers avaient déjà été découpés. **Mesurer
   avant de citer.**
4. ~~**Connexion obligatoire au premier lancement**~~ — ✅ **RÉSOLU
   (24/08/2026, commit d60b962)** : mode invité livré. Bouton
   « Continuer sans compte » sur l'écran de connexion,
   `PrefsService.guestMode` persisté, levé à la connexion comme à
   l'inscription. Vérifié sur simulateur iPhone 17.

5. **Le feed communautaire a été retiré de la v1 (24/08/2026).**
   `PoussidexFeed` n'avait jamais été branché à l'interface, alors que
   les défis téléversaient quand même les photos vers `challenge_posts` :
   du contenu que personne ne voyait, sans bouton de signalement, contre
   une promesse de communauté modérée dans la fiche et la landing —
   risque de rejet guideline 1.2. Décision de Jean : couper pour la v1.
   Supprimés : `poussidex_feed.dart`, `feed_service.dart`,
   `feed_post.dart` ; l'appel `publishChallengePost` est retiré des
   défis (les photos restent locales, et dans le cloud **privé** du
   compte). Fiche App Store, `store-listings.md`, les deux privacy
   policies et la landing alignées. Conséquence utile : plus de contenu
   généré par les utilisateurs → **classification 4+ au lieu de 13+**.

   **Pour le rétablir** : le code est dans l'historique git (avant
   `main`@24/08/2026) et les tables Supabase (`challenge_posts`,
   `post_likes`) sont intactes. Il faudra alors brancher l'écran,
   ajouter le **blocage d'utilisateur** (guideline 1.2 exige signalement
   ET blocage), repasser le questionnaire d'âge en CGU/13+ et remettre
   les mentions dans les fiches et les privacy policies.

6. **Liens stores dans `landing/index.html`** — les boutons Télécharger
   pointent vers `href="#"`. À remplacer par les vrais liens App Store /
   Play Store une fois l'app publiée.

8. ~~**Le Poussidex « collection de plants » n'existait pas dans l'app**~~ —
   ✅ **RÉSOLU (30/10/2026)**. Diagnostic : 2 168 lignes écrites et
   injoignables (`plantation_detail_sheet.dart`, `poussidex_card.dart`,
   `poussidex_journal.dart`, `poussidex_podium.dart`,
   `poussidex_stats.dart`, plus `share_card.dart` par ricochet) ; aucune
   interface ne créait de `Plantation`, dont le seul producteur était la
   migration unique de l'ancienne grille — donc **0 plant à vie** pour
   une nouvelle installation, et des médailles éternellement `none`.
   Risque de rejet guideline 2.3.1, la fiche App Store promettant la
   collection en titre.

   **Ce qui a été fait** : nouveau `PlantationService`, propriétaire
   unique des mutations (ajout, arrosage, récolte, clôture, note,
   photos, suppression), local d'abord puis cloud en arrière-plan, et
   recalé sur `plantationsVersion` pour reprendre une fusion cloud.
   Nouvel onglet **🪴 Mes plants** (`AlbumFilter.collection`) qui relie
   les quatre écrans existants derrière un sélecteur
   Grille / Journal / Podium / Stats. Entrée unique : le bouton flottant
   **« Je l'ai planté »** sur une fiche légume (masqué pour les
   accessoires). 13 tests (`test/plantation_service_test.dart`).

   ⚠️ **Correction d'un diagnostic erroné** : j'avais écrit que
   `_onWater()` (`my_garden_screen.dart`) « n'enregistre rien ». C'est
   faux — c'est le bouton de soin de **Tamassi**, et
   `TamassiView.triggerEffect` enregistre bien le jour, incrémente la
   stat et donne +1 XP une fois par jour. Il n'a simplement rien à voir
   avec l'arrosage d'un *plant*, qui lui n'avait aucun moyen d'être
   enregistré.

   ⚠️ **Ce paragraphe disait faux (corrigé le 31/10/2026).** Il
   annonçait que `CultureEntry.linkedPlantationId` était « écrite et
   lue nulle part » et que les deux arrosages vivaient dans des
   registres séparés. C'était vrai avant le 30/10 et plus après : le
   même chantier a branché `CultureService.wateringsFor`, qui lit la
   plantation liée, et `CultureService.water*`, qui délègue à
   `PlantationService`. Un arrosage saisi depuis le potager carré et
   un arrosage saisi depuis le Poussidex atterrissent au même endroit.
   **Mesurer avant de citer**, ici comme pour les tailles de fichiers.

   **Reste ouvert** : les trois modèles se recouvrent toujours
   (`Plantation`, `PlannedCell`, `CultureEntry`) pour « un légume
   planté à une date ». Ils ne divergent plus, mais trois classes pour
   un concept, ça reste trois endroits où se tromper.

7. ~~**Projet Supabase en pause**~~ — ✅ **SANS OBJET (30/10/2026)** :
   les comptes ont été retirés de la v1, l'app ne contacte plus aucun
   backend. Le projet reste en pause chez Supabase, ses données et ses
   migrations conservées un an ; **ne pas le supprimer**, mais il ne
   bloque plus rien.

8. **Décision du 30/10/2026 : pas de comptes en v1.** Le jardin vit sur
   l'appareil. Raison : l'app n'avait aucun utilisateur, et le backend
   gratuit de Supabase se met en pause après une semaine sans trafic —
   une app non publiée ne peut donc pas le garder éveillé. Supprimés :
   `lib/screens/auth/`, `auth_service.dart`, `cloud_sync_service.dart`,
   `supabase_config.dart`, les dépendances `supabase_flutter`,
   `google_sign_in`, `sign_in_with_apple`, `crypto` (−36 paquets, −70
   lignes de `Podfile.lock`), l'entitlement Apple Sign-In et le schéma
   d'URL Google.

   **Conséquences voulues** : plus d'obligation Apple de suppression de
   compte, questionnaire de confidentialité réduit à 2 types
   (localisation, plantages), guideline 4.8 sans objet, et les deux
   politiques de confidentialité réécrites — rien ne quitte plus
   l'appareil hors Open-Meteo et Sentry.

   **Conséquence à assumer** : changer de téléphone fait perdre le
   jardin. Décision du 30/10/2026 : **pas d'export/import de
   fichier** — une sauvegarde manuelle ne protège que ceux qui y
   pensent avant de casser leur téléphone. Si la portabilité redevient
   un besoin, elle passera par la synchro (voir ci-dessous).

   **Pour rétablir la synchro** : ne pas reprendre Supabase. La piste
   retenue est **Cloudflare** (Worker + D1 + R2, gratuit, ne s'endort
   jamais, juridiction EU disponible), avec Google + Apple **seulement**
   — le Worker n'a alors qu'à vérifier le jeton d'identité, sans jamais
   manipuler de mot de passe.

9. **Le runtime iOS n'est pas installé sur ce Mac** — `xcrun simctl
   list runtimes` ne renvoie rien, donc aucun simulateur ne démarre et
   personne n'a encore **vu l'iPad tourner** depuis que la rotation a
   été rendue aux tablettes (30/10/2026). Le SDK est là, le runtime
   non. Pour l'installer :

   ```bash
   xcodebuild -downloadPlatform iOS
   ```

   ⚠️ Environ 8 Go. Le disque n'avait que 13 Go libres le 30/10/2026
   (94 % plein) ; il en avait 15 le 31/10 (45 %), et le
   téléchargement a été lancé ce jour-là.

   **En attendant, pour voir un écran sans appareil** : un test golden
   rend n'importe quel widget en PNG, qu'on peut ensuite regarder.
   Charger Nunito depuis `assets/google_fonts/` avec un `FontLoader`,
   sinon tout le texte sort en rectangles ; les emoji et les icônes
   Material sortent en rectangles de toute façon. Ne **pas** committer
   un tel test : en CI, le rendu diffère et la comparaison échoue.
   C'est comme ça qu'ont été trouvés le débordement de 15 px de la
   légende du calendrier et l'aperçu de grille resté blanc (un
   `DecoratedBox` sans enfant s'écrase à zéro sous une contrainte de
   hauteur lâche).

10. **Le build Android ne marche qu'avec le JDK d'Android Studio** —
    le `java` du PATH est un OpenJDK 25 (Homebrew) que Gradle 8.14 ne
    supporte pas. Préfixer :

    ```bash
    JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home" flutter build apk --release
    ```

11. **Les planches 4K d'origine** (294 crédits OpenART) sont hors du
    dépôt, dans `~/Dev/apps/kultiva-planches-sources/`. Le découpeur,
    lui, est versionné : `assets/images/vegetables_kawaii/_split.py`.

12. ~~**La fiche App Store et les fiches par pays parlent encore de
    Tamassi**~~ — ✅ **FAIT (31/10/2026)** : les 53 mentions sont
    réécrites, et les décomptes de caractères recalculés sur le texte
    réel (sept étaient déjà faux avant).

13. **Le tuto animé du dashboard est périmé** —
    `assets/tutos/decouvrir_dashboard.html` est une timeline GSAP de
    dix scènes posée sur dix captures d'écran réelles
    (`assets/tutos/screens/dashboard/`, prises le 22/08/2026). Les
    captures montrent l'ancienne barre d'onglets, et trois scènes
    visent un onglet Poussidex qui n'est plus dans la barre — dont une
    « Poussidex Tamassi ». **Bloqué sur les captures** : il faut un
    simulateur ou un appareil, et les rendus golden ne conviennent pas
    (ni emoji ni icônes Material). À refaire dès que le runtime iOS
    est installé.

## Fiches à jour à chaque changement (règle de Jean, 22 octobre 2026)

Le Studio de Jean affiche les fiches de ce dépôt (docs/INFRA.md, docs/MARKETING.md, docs/PUBLICATION.md) et le README. Elles doivent toujours dire la vérité d'aujourd'hui.

- Dès qu'un travail change un fait affiché par ces fiches — version envoyée ou en ligne (App Store, Google Play, site), date de mise en ligne, hébergement ou domaine, service ajouté ou retiré, code Amazon Partenaires, état AdSense ou Pinterest, monétisation, nombre de contenus publiés —, mets à jour **dans le même envoi** toutes les phrases concernées des trois fiches (En bref, Parcours, Boutiques, Vue d'ensemble, Ce qui reste…) et du README.
- Une ancienne valeur ne reste qu'au passé, datée (« la 1.0.4 a été mise en ligne le 15 octobre »).
- Ne recopie jamais de secret ni de clé dans ces fichiers.
- Chaque matin, la tâche « Fiches Mes Apps » du Studio vérifie derrière toi, compare les versions avec ce que servent réellement les boutiques et signale toute phrase fausse.
