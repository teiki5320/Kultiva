# Kultiva

> Documentation pour futures sessions Claude Code.
> Dernière mise à jour : 2026-11-01.

## 🎯 Contexte

**Kultiva** est une application mobile Flutter de jardinage au style
pastel kawaii japonais, en **français et en anglais**. Elle s'adresse
d'abord aux jardiniers amateurs de **France métropolitaine**, et couvre
depuis le 01/11/2026 **73 pays sur six continents**. Elle propose :

- un calendrier mensuel de semis et de récolte adapté à la région ;
- un **catalogue** de 169 légumes, aromates, tubercules et accessoires
  (dont 130 cultures + 10 cultures d'Afrique de l'Ouest) ;
- un **journal du jardin** : plantations, arrosages, récoltes et photos
  inscrits à leur date, dans le cahier de culture ;
- **Mes jardins** : potager carré multi-jardins avec placement par
  glisser-déposer, suivi par plant (arrosage, phase de croissance auto, photos),
  conseils contextuels selon la météo ;
- **Défis & badges** : 50 défis photo et 50 badges, sur leur écran,
  joignable depuis le dashboard ;
- un **onglet « Garder ta récolte »** : trois **conservations** par
  légume (bocal, congélation, séchage, lacto-fermentation, confiture,
  huile, vinaigre), chacune avec sa durée de garde et son pas-à-pas
  animé hors ligne. 736 recettes, 448 déroulées étape par étape ; les
  plats à manger le jour même sont dessous. Favoris et « déjà
  cuisiné » par recette ;
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

**Statut** : **mondial, France en priorité** (v1.0.0+5), en polish
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
  Amazon remis le 30/10/2026, tag `kultiva1-21`, France seulement —
  la condition est le **pays**, pas la région, voir
  `amazonLinkVisible`)
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
├── lib/                    # Code Dart principal (119 fichiers, données
│                           # comprises ; 22 906 lignes hors data et l10n,
│                           # mesuré le 31/10/2026)
│   ├── main.dart           # Bootstrap : onboarding → tabs
│   ├── config/
│   │   └── app_info.dart           # version affichée (à synchroniser avec pubspec)
│   ├── screens/            # 33 fichiers
│   │   ├── onboarding_screen.dart
│   │   ├── root_tabs.dart          # Conteneur 5 onglets (Bottom nav)
│   │   ├── vegetable_detail_screen.dart
│   │   ├── vegetable_detail/       # detail_header / _calendar / _culture
│   │   │                           # / _voisins / _recettes (02/11/2026)
│   │   └── home/                   # sow, vegetables, my_garden, tutos,
│   │                               # settings, weather, calendrier mensuel,
│   │                               # tuto_fiche (WebView),
│   │                               # garden_planner, mes_jardins,
│   │                               # garden_plan_config_sheet,
│   │                               # cahier/ (today_card,
│   │                               # plants_section, journal_section,
│   │                               # journal_view, season_recap),
│   │                               # defis/ (defis_badges_screen,
│   │                               # badges_grid, challenges_grid),
│   │                               # recettes/ (recettes_screen,
│   │                               #   recipe_player_screen),
│   │                               # plants/ (plantation_sheet = le
│   │                               # seul point d'entrée du dossier
│   │                               # d'un plant, + detail_sheet),
│   │                               # garden_planner/ (screen +
│   │                               # planner_cell / _advice / _plants,
│   │                               # planner_widgets = point d'entrée)
│   ├── l10n/               # app_fr.arb, app_en.arb + généré
│   │                       # (flutter gen-l10n, voir l10n.yaml)
│   ├── models/             # 12 fichiers
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
│   ├── data/               # 16 fichiers (+ names_en, zone_shift,
│   │                       #  recipes_i18n, recipes_en)
│   │   ├── vegetables_base.dart    # 169 entrées (130 cultures + 39 accessoires)
│   │   ├── badges.dart (50) / challenges.dart (50) / diseases.dart
│   │   ├── companions.dart / rotation.dart / lexicon.dart
│   │   ├── local_names.dart / market_buying_tips.dart
│   │   ├── recipes.dart      # 736 recettes, source de vérité (français)
│   │   ├── recipes_i18n.dart # le mécanisme de surcouche par langue
│   │   ├── recipes_en.dart   # les recettes en anglais (tomate faite)
│   │   └── regions/          # france.dart, west_africa.dart,
│   │                         # west_africa_zones.dart (sous-zones),
│   │                         # regional_calendar.dart (zone + hémisphère,
│   │                         #   currentCalendar()),
│   │                         # zone_shift.dart (dérive les zones tempérées)
│   ├── theme/
│   │   └── app_theme.dart  # KultivaColors, thèmes Material3 light/dark
│   ├── widgets/            # 16 fichiers (dont badge_card/ : recto,
│   │                       #  verso, déblocage — découpé le 02/11/2026)
│   │                       # badge_card (1 097 lignes), readable_width,
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
│   ├── recipes/            # recipe_player.html — UN template pour les
│   │                       # 736 recettes, nourri par du JSON injecté
│   ├── images/             # badges (50),
│   │                       # accessories (38 images kawaii), légumes (120),
│   │                       # cards, onboarding,
│   │                       # app_icon
│   ├── sounds/             # 6 fichiers (1 musique + 5 SFX)
│   └── tutos/              # 34 fichiers HTML (33 tutos + privacy)
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
├── test/                   # 54 fichiers — 1 151 tests (03/11/2026)
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

Le projet est sur **`~/Dev/apps/kultiva`**. ⚠️ Cette fiche a longtemps
dit `~/Code/kultiva` : ce dossier n'existe plus depuis un rangement
d'octobre 2026, et il n'y a qu'un seul Mac. Branche de travail
courante : **`main`**. Commande à donner systématiquement après une modif
poussée par Claude Code :

```bash
cd ~/Dev/apps/kultiva && git stash && git pull origin main && flutter pub get && flutter run --release
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

# Traduction : sortir un lot de recettes à traduire
dart run tool/exporter_recettes.dart --lots
dart run tool/exporter_recettes.dart --squelette --langue=en --lot=3
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
- **Localisation** : **français (source), anglais, espagnol**.
  Depuis le 02/11/2026, le **contenu** est complet dans les trois
  langues — 130 cultures, 736 recettes, 33 tutos (1 267 phrases),
  maladies, lexique, badges, défis (780 phrases). Soit ≈ 2 900 chaînes
  par langue, écrites par huit agents Sonnet et validées par les tests
  de nombres.
  **L'interface aussi**, depuis le 02/11/2026 : 772 chaînes par
  langue, branchées par 718 appels `trUi()` dans 53 fichiers. Vérifié
  à l'écran dans les trois langues. ⚠️ Les mois, les jours et les
  73 noms de pays passent par des **tables indexées** et non par le
  dictionnaire — voir la section « Traduire l'interface » plus bas, et
  l'avertissement en tête de `ui_i18n.dart`.
  Les neuf méthodes de conservation, les unités de durée et les
  libellés du lecteur sont traduits aussi — un test refuse une langue
  qui aurait les recettes sans eux. Voir
  « Traduire le contenu » plus bas. ⚠️ **La note du réglage « Langue »
  vit dans les trois ARB** (`settingsLanguagePartial`) et change avec
  la langue : chacune n'est pas au même stade. Elle était écrite en
  dur dans le widget et disait faux dès que l'anglais a été fini. Les chaînes passent par
  `lib/l10n/*.arb` (`flutter gen-l10n`), les noms de légumes par
  `lib/data/names_en.dart` et `v.displayName`. **`v.name` reste le nom
  français** : c'est la source de vérité des clés, de la recherche
  sans accent et des tests.

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
- **Ne pas tester `region == Region.westAfrica` pour une question
  climatique** — utiliser `region.isTropicalBase`. Depuis l'ouverture
  mondiale, la première expression veut dire « contenu ouest-africain ».
- **Ne pas recopier un calendrier pour une nouvelle zone** — le dériver
  dans `zone_shift.dart`. Quatre copies de 806 lignes, ce sont quatre
  fichiers qui divergent à la première correction.
- **Ne pas réintroduire de CDN ni de Google Fonts** dans un tuto *ni
  dans le lecteur de recettes* : ils doivent tourner hors ligne.
- **Ne jamais traduire un nombre.** Dans une recette, les grammes de
  sel, les degrés, les pourcentages de vinaigre et les temps de
  stérilisation sont des règles de sécurité alimentaire. Les unités se
  traduisent (« 30 g de sel » → « 30 g of salt »), les valeurs se
  recopient — pas de Fahrenheit, pas d'onces.
  `test/recipes_i18n_test.dart` le vérifie sur chaque chaîne.
- **Ne pas faire éditer `recipes.dart` par un traducteur** : 11 821
  lignes de Dart avec des `\'` et des `\$` échappés. Passer par
  `tool/exporter_recettes.dart`, qui sort un squelette déjà valide.
- **Un test de libellés doit dire sa langue** — l'environnement de test
  tourne en `en-US`. `onglets_test` a validé des libellés anglais
  pendant un moment en croyant lire du français.
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
    conseils d'achat au marché (⚠️ le mode maraîchage FCFA a été retiré le 02/11/2026)
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
- **Suppression du Poussidex (31/10/2026)** : l'album de collection
  faisait doublon avec le cahier de culture — « Mes plants » et « Au
  jardin en ce moment » listaient les mêmes plants, lus dans le même
  service. Son meilleur écran, le journal daté, était enterré sous un
  sélecteur de quatre vues. Partis : l'écran album, sa barre de
  filtres, la grille de collection, le podium, les statistiques, la
  carte de plant, le carrousel d'accueil (1 900 lignes). Le
  **journal** remonte dans le cahier (trois derniers jours + « Tout le
  journal ») ; les 50 défis et les 50 badges ont leur écran
  **Défis & badges**. Les fichiers quittent `poussidex/` pour
  `plants/`, `defis/` et `cahier/`.
- **Cinq onglets (01/11/2026)** : Home, **Cahier**, Étal,
  **Conservation**, **Tutos**. Tutos est passé en dernier le
  01/11/2026 (demande de Jean) : Conservation prend l'index 3, Tutos
  le 4. L'onglet s'appelait « Recettes » jusqu'au 02/11/2026 —
  renommé par Jean, parce que ce sont d'abord des **conservations**. ⚠️ Les tutos HTML naviguent par index
  (`RootTabs.tabIndex`) : tout changement d'ordre doit passer par
  `tuto_fiche_screen.dart`, et `test/onglets_test.dart` le verrouille.
  Il a été **ajouté en bout de barre** pour ne décaler aucun index
  existant. La barre est en `fixed` avec des libellés rétrécis : à
  cinq, le libellé était tronqué. « Conservation » y tient, vérifié à
  l'écran.
  Un **onglet Photo** a été ajouté puis retiré le même jour — voir
  l'alerte 15. Son retrait a recalé Recettes de l'index 5 à 4 ; la
  route `kultiva://photos` survit et mène au cahier.
- **Ouverture mondiale (01/11/2026)** : 73 pays. Deux bases de
  calendrier seulement — tempérée (`franceData`) et tropicale
  (`westAfricaData`) — qu'une `ClimateZone` affine et qu'un
  `Hemisphere` retourne de six mois. Les zones méditerranéenne,
  continentale et subtropicale **dérivaient** de la base française par
  décalage explicite (`lib/data/regions/zone_shift.dart`) et portaient
  une note qui le disait. ⚠️ C'étaient des approximations ; les
  **trois sont désormais écrites culture par culture** (voir la
  section sur les calendriers plus bas). La dérivation reste le repli
  pour les cultures qu'aucune surcharge ne couvre.
  ⚠️ **`Region.westAfrica` ne veut plus dire « tropical ».** Il veut
  dire « tropical **et** contenu ouest-africain » (noms locaux,
  achat au marché). Pour une question climatique, utiliser
  `region.isTropicalBase`, jamais `== Region.westAfrica` — sinon un
  Brésilien reçoit des prix en francs CFA.
  ⚠️ Ne pas recomposer région + zone + hémisphère à la main :
  `currentCalendar()` et `Season.current()` le font. Trois écrans
  portaient chacun leur copie, et aucun n'aurait pensé à l'hémisphère.

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

1. **Pas de test d'intégration** — 1 151 tests au 03/11/2026, dont une
   première couche de widgets : `text_scale_test.dart` monte dix écrans
   sur un iPhone SE à police normale puis 1,3 ;
   `ipad_landscape_test.dart` fait de même aux dimensions d'un iPad en
   portrait et en paysage, **et** vérifie que grilles et colonnes de
   texte sont rangées chacune dans son camp ;
   `assets_exist_test.dart` vérifie qu'une image déclarée existe **et**
   qu'une image embarquée sert à quelqu'un ;
   `accessibilite_test.dart` compte les zones tactiles nues sans
   étiquette VoiceOver.
   Aucun parcours complet n'est joué de bout en bout, et **rien n'a
   encore été essayé avec VoiceOver réellement activé** : un compte
   voit qu'une étiquette existe, pas qu'un écran est agréable à
   écouter.
2. ~~**L'`anonKey` Supabase est committée**~~ — sans objet depuis le
   retrait des comptes (30/10/2026) : `lib/config/supabase_config.dart`
   est supprimé.
3. ~~**Fichiers volumineux restants**~~ — ✅ **FAIT le 02/11/2026.**
   Les trois derniers fichiers au-dessus de 1 000 lignes sont
   découpés, et **plus aucun fichier de `lib/` hors données ne
   dépasse 723 lignes** (`plantation_detail_sheet.dart`).

   | Avant | Après |
   | --- | --- |
   | `vegetable_detail_screen.dart` 1 357 | l'écran 342 + cinq fichiers dans `vegetable_detail/` (header, calendar, culture, voisins, recettes) |
   | `badge_card.dart` 1 097 | le point d'entrée 212 + trois dans `badge_card/` (recto, verso, déblocage) |
   | `sow_screen.dart` 1 051 | l'écran 478 + deux dans `accueil/` (cartes, diapos) |

   Même patron que le potager carré : un fichier par sujet, les
   classes privées deviennent publiques puisqu'elles changent de
   fichier, et le fichier d'origine **réexporte** pour que les imports
   existants continuent de marcher.

   ⚠️ **Deux pièges du découpage**, tous deux attrapés par `analyze` :
   un import relatif sans `../` pointe sur le dossier du fichier, donc
   il casse dès qu'on descend d'un cran ; et `dart fix --apply` a
   retiré un import devenu « inutile » dans `challenges_grid.dart`
   alors qu'il servait à joindre une fonction déplacée — c'est
   l'export du point d'entrée qui le rattrape. `vegetables_base.dart` (4 281) et
   `west_africa.dart` (945) sont des fichiers de données, ils ne sont
   pas concernés.
   `vegetables_base.dart` (4 306) et `west_africa.dart` (945) sont des
   fichiers de données, ils ne sont pas concernés. **Mesurer avant de
   citer** : les chiffres du 30/10 (1 740 / 1 777) étaient périmés, ces
   fichiers avaient déjà été découpés.
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
   Grille / Journal / Podium / Stats — **supprimé le 31/10/2026**, voir
   l'historique. Entrée unique : le bouton flottant
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

9. ~~**Il n'y a plus de simulateur iOS du tout**~~ — ✅ **RÉSOLU le
   02/11/2026, et deux diagnostics à corriger avec.**

   `xcodebuild -downloadPlatform iOS` (~8,3 Go, lancé par Jean) a
   réinstallé le runtime **iOS 27.2**. Depuis : `flutter build ios
   --simulator --debug` passe en 129 s, l'app s'installe, se lance, et
   **`simctl io screenshot` rend l'écran pour de vrai**. Tout ce qui
   suit a été fait ce jour-là sur un iPhone 17 — démarrage, onboarding,
   tableau de bord, recettes en espagnol, tuto en espagnol dans la
   WebView.

   ⚠️ **J'avais écrit deux fois une cause fausse.** La première était
   « un nettoyage de disque » (c'était la mise à jour de Xcode, Jean
   l'a corrigée). La seconde, plus coûteuse, était d'affirmer que
   **`Simulator.app` manquant rendrait les captures noires de toute
   façon** — j'avais conclu que seule une réinstallation complète de
   Xcode débloquerait les fiches stores. C'est faux : `Simulator.app`
   est **toujours** absent, Xcode.app pèse toujours 4,0 Go, et les
   captures marchent. `simctl io screenshot` parle directement à
   `CoreSimulator`, pas à l'interface graphique ; l'app Simulator ne
   sert qu'à **regarder** avec ses yeux. Les captures étaient noires
   parce qu'il n'y avait **pas de runtime**, point. Une seule cause,
   pas deux. **Mesurer avant de citer**, y compris quand la mesure
   coûte une commande de dix secondes.

   **La recette qui marche**, sans Simulator.app :

   ```bash
   xcrun simctl boot "iPhone 17" && xcrun simctl bootstatus "iPhone 17"
   flutter build ios --simulator --debug
   xcrun simctl install booted build/ios/iphonesimulator/Runner.app
   xcrun simctl launch booted com.toa.kultiva
   xcrun simctl io booted screenshot ecran.png
   ```

   Le premier démarrage d'un device neuf prend ~90 s et montre le logo
   Apple : ne pas conclure « écran noir » sur la première capture.

   ⚠️ **Le premier lancement après un `simctl install` est lent**, une
   à trois minutes, et l'app reste sur son splash pendant ce temps.
   Les lancements suivants affichent l'écran en dix secondes. Je m'y
   suis fait prendre deux fois le 02/11, et la seconde j'ai conclu à
   une régression du code puis attribué le déblocage à une correction
   de mise en page faite entre-temps. **C'était faux** : la correction
   était bonne en soi — un titre tronqué — mais elle n'a rien débloqué.
   Avant de diagnostiquer un blocage au démarrage : relancer sans
   réinstaller, et vérifier le CPU du processus (`ps -o %cpu`). À 0 %
   il attend, et attendre un `Future` n'est pas boucler.
   Pour piloter (taper, glisser), l'outil `Claude_Code_iOS_Simulator`
   prend des **points** (ici 402 × 874 pour 1206 × 2622 pixels, donc
   diviser par 3).

   **Garnir une installation sans un seul tap (03/11/2026).** Les
   captures des boutiques demandent un jardin peuplé, et le peupler à
   la main coûte une cinquantaine de gestes — dont chacun passe par
   l'autorisation d'accès au simulateur, qui se **redemande dès que
   l'appareil change d'identifiant** (c'est ce qui arrive après un
   `killall CoreSimulatorService`). Tout le cahier tient pourtant dans
   trois chaînes JSON de NSUserDefaults :
   `kultiva.plantations.v1`, `kultiva.cultures.v1` et
   `garden_plans_v1`, toutes préfixées `flutter.`.
   `tool/garnir_simulateur.py` les écrit — 6 plants, 6 cases, 6
   cultures, 13 badges débloqués — et porte la marche à suivre.

   ⚠️ **Le redémarrage du simulateur est obligatoire, pas prudent.**
   `cfprefsd` sert le plist depuis son cache : sans
   `shutdown` + `boot`, l'app relit ce qu'elle avait avant et on croit
   que l'écriture n'a rien fait. C'est exactement la cause de
   l'avertissement ci-dessous sur la langue, et le redémarrage est ce
   qui le lève — vérifié dans les deux sens le 03/11.

   **Changer la langue de l'app** : écrire la préférence dans le plist
   ne marche pas — `shared_preferences` le réécrit au lancement. Deux
   voies : le réglage « Langue » de l'app, ou la langue du **device**,
   que `effectiveLanguage` suit :

   ```bash
   xcrun simctl shutdown "iPhone 17"
   plutil -replace AppleLanguages -json '["es-ES"]' \
     ~/Library/Developer/CoreSimulator/Devices/<UDID>/data/Library/Preferences/.GlobalPreferences.plist
   xcrun simctl boot "iPhone 17"
   ```

   ⚠️ **`plutil` coupe les clés sur les points.** Une clé
   `flutter.kultiva.language` doit s'écrire `'flutter\.kultiva\.language'`,
   sinon c'est « Key path not found ».

   ⚠️ **Le disque.** Un build iOS debug laisse 1 Go dans `build/` et
   370 Mo dans `~/Library/Developer/Xcode/DerivedData` ; le runtime
   iOS pèse ~8 Go. Il restait **15 Go libres** après installation du
   runtime le 02/11 — surveiller, et `flutter clean` après une session
   de builds iOS.

   **Reste vrai** : personne n'a **vu** l'app bouger en vidéo, et un
   test golden rend toujours n'importe quel widget en PNG sans
   appareil (charger Nunito depuis `assets/google_fonts/` avec un
   `FontLoader`, sinon le texte sort en rectangles ; ne pas committer
   un tel test, le rendu diffère en CI). C'est comme ça qu'ont été
   trouvés le débordement de 15 px de la légende du calendrier et
   l'aperçu de grille resté blanc.

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

13. ~~**Quatre médaillons de badge contredisent leur badge**~~ — ✅
    **FAIT (31/10/2026, 42 crédits OpenArt, accord de Jean).** Refaits
    dans le style actuel des badges : parterre surélevé pour « Premier
    jardin », cinq légumes pour « Cinq espèces », trois parterres pour
    « Trois jardins », appareil photo pour « Album ». Recette et mise
    en garde dans `assets/images/vegetables_kawaii/README.md`.

    **Comment le problème était né** : la réécriture des badges a gardé
    les 50 identifiants, donc les 50 images, qui sont nommées d'après
    eux. La plupart tombaient juste par chance (une pousse pour
    « 5 plants », une licorne pour « rare »), mais quatre montraient
    la créature supprimée ou un objet sans rapport — deux créatures qui
    se saluent pour « Créer ton premier jardin », une foule pour
    « Créer 3 jardins », cinq créatures pour « Planter 5 espèces », un
    cœur rose pour « 10 photos ». **Vérifier les images quand le sens
    d'un badge change** : `flutter analyze` ne voit rien, et
    `assets_exist_test.dart` non plus — le fichier existe, il raconte
    simplement autre chose.

    **Restent discutables, sans être faux** : `first_pet`
    (main + cœur → « mettre en favori », le cœur sauve la mise),
    `first_fertilize`, `fertilize_20` et `fertilize_100` (sacs
    d'engrais → cases de potager carré).

    Régénérables en une planche OpenArt, **42 crédits** — à demander à
    Jean avant de dépenser (règle permanente). Garder les noms de
    fichiers : `assets/images/badges/<id>.webp`.

14. ~~**Le tuto animé du dashboard est périmé**~~ — ✅ **FAIT
    (31/10/2026).** Refait par une session design à partir de
    `docs/prompt-tuto-dashboard.md`, puis mis en conformité ici.

    **Le changement qui compte** : il ne contient plus **aucune
    capture d'écran**. L'interface est redessinée en HTML/CSS, donc
    le tuto ne dépend plus d'un simulateur et ne peut plus devenir
    faux parce qu'un écran a bougé d'un pixel. Les dix captures de
    `assets/tutos/screens/` (1,3 Mo) sont supprimées avec leurs deux
    entrées de `pubspec.yaml` ; le fichier passe de 1,4 Mo à 110 Ko.

    **Deux corrections apportées à la livraison** : elle chargeait
    GSAP depuis cdnjs et Nunito depuis Google Fonts. Les 33 autres
    tutos n'ont **aucun** appel réseau, et l'ancien dashboard
    embarquait déjà GSAP en dur. GSAP est donc inliné et la police
    est la pile système (`-apple-system, SF Pro Rounded…`), comme
    partout ailleurs. ⚠️ **Ne pas réintroduire de CDN ni de Google
    Fonts dans un tuto** : ils doivent tourner hors ligne.

    Vérifié dans le navigateur à 375 × 812 : les dix scènes
    s'enchaînent, le halo désigne le bon élément, la barre d'onglets
    suit, et le bouton pause répond.

## 🧹 3,2 Mo d'images que personne n'affichait (03/11/2026)

**Ce qui partait dans chaque téléchargement sans jamais s'afficher** :
les quatre fonds par moment de la journée
(`assets/images/backgrounds/`, 2,3 Mo) — ils servaient à la créature
supprimée le 31/10 — plus `potager.png`, `potager_bg.png` et
`onboarding_5.png` (864 Ko). Le dossier `backgrounds/` était déclaré
dans `pubspec.yaml`, donc bel et bien embarqué.

**Pourquoi aucun test ne le voyait** : `assets_exist_test.dart` ne
regardait que dans un sens — qu'un chemin déclaré par le catalogue
existe. Jamais qu'un fichier présent serve à quelqu'un. Le test
inverse existe maintenant, et il ne regarde **que ce que
`pubspec.yaml` déclare** : les dossiers `*_png_v1` qui traînent sur le
disque depuis la bascule vers le WebP ne sont ni suivis par git ni
déclarés, les signaler serait du bruit. Les dossiers adressés par
identifiant (badges, légumes, accessoires) sont exclus par leur nom.

**Deux dépendances sont parties avec** : `sensors_plus`
(accéléromètre, pour les animations de la créature — plus aucun
`import` depuis le 31/10, mais du code natif dans chaque build) et
`cupertino_icons`, qui venait du gabarit Flutter et n'a jamais servi.

23. ~~**Trois images du catalogue montrent le mauvais légume**~~ — ✅
    **FAIT le 03/11/2026, une planche 2×2, 37 crédits, accord de
    Jean.** Trouvées en garnissant une installation pour les captures
    des boutiques, pas en lisant le code.

    | Fichier | Ce qu'il montre | Ce qu'il devrait montrer |
    | --- | --- | --- |
    | `haricot.webp` | une courgette | une gousse de haricot vert |
    | `navet.webp` | un radis (le même dessin que `radis.webp`) | un navet blanc et violet |
    | `concombre.webp` | un troisième rendu de la même courgette | un concombre |

    ⚠️ **Aucun test ne pouvait le voir.** `assets_exist_test` vérifie
    qu'un fichier existe, et depuis ce matin qu'un fichier embarqué
    sert à quelqu'un. Ni l'un ni l'autre ne regarde **ce que l'image
    montre**. C'est exactement l'angle mort des quatre médaillons de
    badge du 31/10 : le fichier existe, il raconte autre chose.

    `test/images_distinctes_test.dart` compare les 130 images deux à
    deux. Sa liste de dette est **vide** depuis la correction : la
    paire la plus proche est maintenant `haricot_beurre` et
    `salsifis` à 7,21 — deux sujets pâles et allongés, légitimement
    voisins. Le test refuse toute paire sous 7.

    ⚠️ **Et une empreinte en noir et blanc ne marche pas** : ces
    images sont toutes « un objet centré sur fond crème », donc elles
    se ressemblent toutes en luminance — ma première version trouvait
    qu'une carotte orange et une aubergine violette étaient la même
    image. C'est la couleur qui sépare. Seuil retenu : 7, parce que
    les doublons avérés sont entre 4 et 6 et que la première paire
    légitimement proche — panais et salsifis, deux racines pâles — est
    à 7,6.

    **Ce que la correction a coûté, mesuré** : une planche 2×2 en
    image-to-image sur GPT Image 2, 1:1, 2k, qualité moyenne —
    **37 crédits**, une seule génération. Trois images séparées en
    auraient coûté 126. La quatrième case a servi à un second essai du
    haricot vert, le sujet le plus dur : une gousse plate se confond
    vite avec une courgette, et c'est précisément celui qui tombait
    dans la capture de boutique.

    ⚠️ **Un légume repeint demande sa version détourée** :
    `python3 tool/detoure_legumes.py haricot navet concombre`, sinon
    `recipe_player_test` tombe. rembg n'est pas sur le système — venv
    jetable, et le modèle `isnet-general-use` pèse 179 Mo au premier
    lancement.

24. ~~**« Légume du jour · Arachide » à un jardinier français**~~ — ✅
    **FAIT le 03/11/2026.** Vu à l'écran en prenant la capture du
    tableau de bord pour les boutiques, pas en lisant le code.

    `vegetableOfTheDay()` tirait dans les **130 cultures** sans
    regarder le calendrier de l'utilisateur. Mesuré avant de corriger :
    **19 cultures sur 130** sont impossibles en France, soit **un jour
    sur sept** — dix n'ont aucune entrée au calendrier français (mil,
    fonio, moringa, aubergine africaine, corète, célosie, baselle,
    citronnelle, papayer, bananier plantain), neuf y sont marquées
    `shelterOnly` (patate douce, gombo, pastèque, igname, manioc,
    arachide, bissap, sésame, taro). Côté tropical, quatorze cultures
    ont des mois vides — pommier, cassissier, kiwi.

    **Deux exclusions, et elles ne disent pas la même chose** : une
    culture **sans mois** au calendrier d'ici ne s'y cultive pas, c'est
    la convention que la base tropicale appliquait déjà ; une culture
    `shelterOnly` s'y cultive, mais sa note dit « culture
    expérimentale » ou « résultats aléatoires en plein air ». Elle
    **reste au catalogue avec sa pastille** — montrer plutôt que
    cacher, décision de Jean le 02/11. Mais une **mise en avant** est
    une recommandation, pas un inventaire.

    ⚠️ **Le paramètre `calendar` est obligatoire exprès.** Avec une
    valeur par défaut, l'appelant qui l'oublie ramène le défaut sans
    qu'`analyze` ni aucun test ne voient rien passer. C'est la même
    précaution que `displayName` contre `v.name`.

    ⚠️ **Et un test par calendrier ne suffit pas** : chacun vérifie le
    sien, donc un paramètre purement ignoré les passerait tous les
    deux. Un quatrième test exige que France et Afrique de l'Ouest ne
    mettent pas en avant la même culture plus de 266 jours sur 366.
    Vérifié en recassant volontairement la ligne : le test nomme les
    coupables, arachide comprise.

    ⚠️ **Et le même écran portait le défaut deux fois.** Une heure
    après la correction, le tableau de bord conseillait « 🍌 Bananier
    plantain adore pousser à côté de 🟤 Taro ! » à la même
    installation française : `_tipOfTheDay` composait ses conseils sur
    les 130 cultures — compagnonnage, rotation, maladies — sans
    regarder le calendrier non plus. **Une règle écrite dans une
    fonction se corrige une fois ; une règle nommée se corrige
    partout.** D'où `cultivablesEnPleineTerre()`, que les deux
    appellent maintenant.

    ⚠️ **Pour le compagnonnage, les deux cultures doivent pousser
    ici** : un filtre posé sur la seule culture de gauche aurait laissé
    « tomate adore pousser à côté de taro ».

    Le conseil du jour vivait dans l'état de `SowScreen`, donc aucun
    test ne pouvait l'atteindre. Il est parti dans
    `lib/utils/conseil_du_jour.dart` — c'est de la logique métier, et
    la règle 10 dit où elle vit. `conseilsPossibles()` et
    `culturesCiteesParLesConseils()` existent pour que le test lise les
    **identifiants** plutôt que de relire la phrase à l'envers avec une
    expression régulière.

    **Troisième fois que cette famille de défaut sort** — après le
    manioc semé à Lyon (02/11) et les trois images du catalogue
    (alerte 23). À chaque fois, l'information existait et le code ne
    la lisait pas, et à chaque fois c'est l'écran qui l'a dit.

25. ~~**La description d'un badge était coupée en plein milieu d'une
    ligne**~~ — ✅ **FAIT le 03/11/2026.** Vu en prenant la capture
    « Défis & badges » pour les boutiques : « Planter ton premier »
    suivi de la moitié haute des lettres de « légume ».

    **Ce n'est pas l'ellipse qui manquait, c'est qu'elle ne partait
    pas.** Le `Text` portait `maxLines: 4` dans un `Expanded` qui
    n'offrait la place que d'**une** ligne (mesuré). Le paragraphe se
    croyait donc dans les clous, aucune ellipse n'était demandée, et
    c'est la **boîte** qui tranchait. ⚠️ Un `RenderParagraph` plus
    haut que sa boîte ne déclenche **pas** la bande jaune : il est
    simplement rogné. Ni `analyze` ni les tests de débordement ne
    pouvaient le voir.

    **Un `maxLines` doit valoir ce que la boîte peut montrer**, pas ce
    que l'auteur espère. `lignesQuiTiennent()` (`utils/text_scale.dart`)
    le calcule depuis la hauteur disponible, **échelle de police
    comprise** — sans ça le compte retomberait faux dès que
    l'utilisateur agrandit le texte, soit exactement le cas que ce
    fichier existe pour couvrir. La tuile passe de 145 à 175 points :
    trois lignes pour un badge débloqué, deux pour un badge verrouillé
    (le cadenas prend la troisième).

    ⚠️ **Le premier test était aveugle au défaut** : il filtrait les
    `Text` sur `maxLines != 1`, c'est-à-dire précisément la valeur que
    le défaut produisait. Il échouait, mais en disant « aucune tuile
    rendue » au lieu de « une description n'a qu'une ligne ». Un test
    qui échoue pour la mauvaise raison passera le jour où la mauvaise
    raison disparaît.

## 📐 L'iPad : les grilles prennent la largeur (03/11/2026)

**Ce qui a été regardé** : l'app, écran par écran, sur un **iPad Pro
13″** en simulateur. C'est la première fois — jusqu'ici seuls des tests
widget disaient qu'une boîte ne débordait pas, ce qui ne dit rien de
l'allure.

**Ce qu'on y voyait.** Les six cartes du tableau de bord faisaient
510 points de large pour 138 de haut — des bandes, là où le téléphone
montre des tuiles presque carrées. Le sous-titre de l'onboarding tenait
sur une seule ligne de 130 caractères. Dans l'onglet Conservation, le
signet d'une recette était à 1 400 points de son titre. Une feuille
modale occupait toute la largeur.

**Le premier correctif, et sa honte** : `ReadableWidth` existait
**depuis le 30/10/2026**, avec un commentaire qui décrivait exactement
ce problème — et il était branché sur **un** écran sur trente-trois.
Encore un widget écrit et non relié (règle 10, cinquième fois).

⚠️ **Et j'ai corrigé trop fort.** Tout borner à 720 laissait 150 points
vides de chaque côté, et à l'intérieur les tuiles des tutos — larges de
90 points dans une liste horizontale — n'en remplissaient pas la
moitié. Jean a regardé l'écran et dit ce qui s'y voyait : « ça ne prend
pas toute la place ». **La règle juste n'est pas « borner », c'est
« borner le texte »** :

| Contenu | Traitement | Pourquoi |
| --- | --- | --- |
| Grille de tuiles | prend toute la largeur | une tuile de plus par ligne, c'est une tuile de plus qu'on voit sans défiler |
| Colonne de texte | garde sa mesure | au-delà, l'œil perd le début de la ligne suivante |

**Ce qui prend la largeur** : le tableau de bord (trois colonnes au
lieu de deux, via `GrilleAdaptative`), l'Étal (huit colonnes de
vignettes), les tutos (quatre tuiles par ligne au lieu d'une liste qui
défile). **Ce qui reste borné** : Conservation (760 — trois lignes de
description par recette et un signet au bout), le cahier (900), les
écrans poussés, la diapositive du conseil du jour (620 — une phrase
n'a pas besoin de 908 points), et **toutes** les feuilles modales d'un
coup par `bottomSheetTheme.constraints` dans `app_theme.dart`.

⚠️ **`GrilleAdaptative` se règle par la largeur *souhaitée* d'une
tuile**, pas par un nombre de colonnes. Et la valeur se vérifie des
deux côtés : une cible de 200 donnait **une seule colonne** sur un
iPhone de 375 points — l'inverse du défaut qu'on corrigeait. C'est
160. Un test monte la grille à 343 et à 1 000 points et compte les
colonnes.

⚠️ **Une tuile de hauteur fixe redevient une bande dès qu'elle
s'élargit.** `KawaiiCard.hauteurPour()` fait suivre la hauteur
(0,62 × largeur, entre 138 et 190) : à 325 de large sur iPad, la carte
fait 190 de haut et non 138.

⚠️ **En dessous de la borne, rien ne change.** Sur un téléphone,
l'affichage est identique au pixel près — un test le vérifie à 390
points, et les deux colonnes du tableau de bord sont retombées sur
leurs 165 points d'avant.

**Le splash suit aussi.** Le logo mesurait 256 points sur tous les
appareils : 65 % de la largeur d'un iPhone, 25 % de celle d'un iPad
13 pouces. `LaunchScreen.storyboard` lui donne maintenant 65 % de la
largeur, entre 256 et 384 points — 384 étant la taille à laquelle
l'image @3x de 768 px reste nette sur un écran @2x.
⚠️ **`flutter_native_splash` réécrit ce storyboard** s'il est relancé :
la contrainte est à reposer après coup.

**Ce qui reste, non bloquant** : le bas de l'écran est vide sur les
pages courtes.

## 🔭 Sentry ne parle qu'en release (02/11/2026)

**Ce qui s'est passé** : un débordement de 6 px vu sur un simulateur
pendant le développement a déclenché une alerte « New issue, level
fatal » dans la boîte mail de Jean, avec `environment: debug`.

**Pourquoi c'est un défaut de réglage et pas un incident** : une erreur
de mise en page qu'on est en train de corriger se voit déjà à l'écran,
en rayures jaunes. Elle est bruyante par nature en debug — chaque
contrainte trop serrée pendant un remaniement en produit une. Noyer les
vraies alertes sous les siennes, c'est apprendre à ne plus les lire.

**Le filtre `beforeSend` a été remplacé le 03/11/2026 par une garde
plus haut**, dans `main()` : en debug, Sentry n'est **pas initialisé du
tout**, et `_bootstrapAndRun()` est appelé directement.

```dart
if (!kReleaseMode) {
  await _bootstrapAndRun();
  return;
}
```

**Pourquoi** : le filtre rejetait déjà tout en debug, donc le SDK natif
n'y faisait que coûter — et il coûtait cher. Mesuré sur un **iPad Pro
13″ en simulateur** : plus de **deux minutes** de splash, processus
vivant à 0 % de CPU. Un `sample` du processus a montré le fil principal
bloqué dans `objc_copyClassList` → `realizeAllClasses` → **CloudKit**,
c'est-à-dire le balayage de classes que fait Sentry pour instrumenter
les contrôleurs de vue. Sans Sentry, le même build dessine en **20 s**.

⚠️ **Et ce n'est pas un défaut de l'app livrée.** Le même commit
compilé en **release** dessine le tableau de bord en **moins de 4 s**
sur le même iPad, Sentry compris. Le blocage est propre au debug
(JIT + simulateur). Ne pas le citer comme un bug utilisateur.

⚠️ **Conséquence à connaître** : un plantage survenu pendant un
`flutter run` ne remonte plus à Sentry — et il n'y a plus de zone
surveillée du tout en debug. C'est voulu : il est déjà dans la console,
avec sa pile d'appels. Pour tester Sentry lui-même, il faut un build
release.

## 🧹 Zéro installation : ce que ça autorise (02/11/2026)

**Décision de Jean** : « personne n'a encore téléchargé Kultiva ».
Aucune donnée ancienne n'existe donc sur aucun téléphone, et tout ce
qui ne servait qu'à la compatibilité est parti.

**Ce qui a été supprimé, et pourquoi c'était mort par construction :**

- `services/plantation_migration.dart` (81 lignes) — convertissait une
  « ancienne grille 2D » vers la collection de plants. Ce format n'a
  jamais quitté un poste de développement ;
- `CultureService.linkLegacyEntries()` — rattachait les cultures
  écrites avant le 30/10/2026. ⚠️ Son filet de sécurité vivant,
  `_plantationIdFor()`, **reste** : il recrée le dossier d'un plant
  supprimé sous une culture encore active, ce qui peut arriver
  aujourd'hui ;
- `Plantation.merge()` — n'avait plus qu'un appelant, la migration.
  Elle datait de la synchronisation cloud, retirée le 30/10 ;
- les préférences `kultiva.gardenGrid` et
  `kultiva.gridMigratedToPoussidex`, et dans `clearUserScopedData` les
  clés `kultiva.creature.*`, `tamassi.stats.*` et `kultiva.auth.*` :
  du ménage pour une poussière qui n'existe nulle part ;
- les routes `kultiva://poussidex` et `kultiva://photos`, conservées
  « pour les anciens liens » — il n'y a pas d'ancien lien ;
- `PhotoService.pick()`, zéro appelant ;
- `dayLabel()` et `monthLabel()` de `months.dart`, zéro appelant
  (`journal_view` et `weather_screen` ont chacun leur `_dayLabel`) ;
- deux entrées de lexique, « poussidex » et « streak ».

**Renommé, sans toucher aux identifiants** : `PoussidexBadge` devient
`GardenBadge`, et `onboarding_poussidex.png` devient
`onboarding_journal.png`. ⚠️ **Les 50 identifiants de badge n'ont pas
bougé** : ce sont les noms des fichiers d'images et les clés
persistées. Renommer une classe est sans risque ; renommer un
identifiant ne l'est pas.

**Un commentaire qui mentait** : `clearUserScopedData()` se disait
« plus appelée par l'app » alors que « Effacer mon jardin » l'appelle.

**Bilan** : −22 tests (leur code est parti avec eux), 1 070 tests
verts, `analyze` propre.

⚠️ **Ce que cette décision ne couvre pas.** Elle vaut **jusqu'à la
première publication**. Le jour où une version est sur une boutique,
toute clé de préférence et tout format persisté deviennent un contrat :
un champ renommé, c'est un jardin perdu. Le bon moment pour ce ménage,
c'était maintenant.

⚠️ **`supabase/migrations/` reste**, volontairement : c'est l'historique
du schéma, et CLAUDE.md le conserve comme point de départ si un backend
revenait (Cloudflare, pas Supabase). Il ne coûte rien et ne s'exécute
jamais.

## 🌴 Le manioc ne se sème pas à Lyon (02/11/2026)

**Signalé par Jean** : « certains produits ne devraient pas être en
Europe ». En mai, l'écran Semer d'un jardinier lyonnais comptait le
**manioc, le taro, l'igname, le bissap, l'arachide et le sésame**
parmi les légumes à semer.

⚠️ **L'information existait, mais en prose.** Vingt-six notes
régionales disaient « non adapté au climat français hors DOM-TOM » ou
« besoin de froid hivernal » — et le code n'en savait rien. Une
donnée que seul un humain peut lire n'est pas une donnée.

⚠️ **Et la base tropicale, elle, réglait déjà le problème** : pommier,
cassissier et kiwi y ont des mois **vides**, donc ils n'apparaissent
jamais dans Semer à Dakar. La convention existait ; elle n'était
appliquée que d'un côté. C'est le genre d'asymétrie qu'on ne voit
qu'en comparant les deux fichiers.

**`RegionData.shelterOnly`**, posé sur les neuf cultures françaises
dont la note le disait. La vignette porte une pastille **« Sous
serre »**, dans le catalogue et dans le calendrier mensuel.

⚠️ **Choix de Jean : montrer, pas cacher.** Trois options lui ont été
proposées — faire disparaître de Semer, afficher avec une pastille,
retirer du catalogue. Il a pris la pastille : un jardinier qui a une
serre cherche ces cultures, et les cacher serait décider à sa place.

⚠️ **C'est une propriété du couple culture + zone, pas de la
culture.** La pastèque est sous serre à Lille et en pleine terre à
Séville : `deriveTemperate` **ne reprend pas** le drapeau quand la
zone a son calendrier écrit à la main, et le reprend sinon. Donc le
manioc reste marqué à Varsovie et à Tokyo sans qu'on l'écrive.

`test/sous_serre_test.dart` verrouille, et son test le plus utile est
celui qui refuse la **contradiction** : une note qui dit « non adapté »
sous un drapeau qui dit le contraire. C'est exactement ce qui avait
laissé passer le manioc.

### 💰 Le bloc Maraîchage est retiré

`market_data.dart` donnait un rendement et un **prix de détail au kg
en FCFA** pour 45 légumes, affiché dans les 8 pays d'Afrique de
l'Ouest. Il venait du virage AO du 03/08/2026.

Décision de Jean le 02/11/2026 : **il disparaît**. C'est une
fonctionnalité de maraîcher professionnel dans une app de jardiniers
amateurs, et les prix dataient de 2025 — vieux d'un an dans une app
qui promet de ne rien dire de faux.

Partis avec : `lib/data/market_data.dart`, `_MarketSection`,
`_MarketRow`, le test « données marché » et sept clés d'interface
devenues orphelines. ⚠️ **« Rendement » est restée** : elle sert aussi
à la fiche du catalogue.

⚠️ **Ne pas confondre avec `market_buying_tips.dart`**, qui reste : ce
sont les conseils pour **choisir** au marché, pas pour vendre. Ils
remplacent le bouton Amazon là où Amazon ne livre pas.

## 🗂️ Le catalogue n'était pas traduit du tout (02/11/2026)

**Trouvé en regardant le catalogue espagnol à l'écran**, pas en lisant
le code : les chips de sous-catégorie disaient « Herramientas » au-dessus
de vignettes nommées « Binette / serfouette ». Seul le **nom** des 130
cultures passait par `names_{en,es}.dart`. La note, la description et
les neuf champs techniques des 169 fiches restaient en français, dans
une interface par ailleurs entièrement traduite — **1 032 chaînes,
8 324 mots**, depuis l'ouverture mondiale.

| Ce qui ne l'était pas | Chaînes distinctes |
| --- | --- |
| Descriptions | 169 |
| Notes (la ligne sous le nom) | 169 |
| Durées de récolte par saison | 200 |
| Technique de semis | 83 |
| Sol | 78 |
| Rendement | 67 |
| Arrosage | 65 |
| Espacement | 62 |
| Noms des 39 accessoires | 39 |
| Exposition, température, profondeur, levée | 98 |

**La surcouche** : `displayNote`, `displayDescription` et neuf getters
sur `Vegetable` (`content_i18n.dart`), branchés dans la fiche, la
vignette du catalogue et l'écran Semer. Les noms d'accessoires, eux,
rejoignent `names_{en,es}.dart` avec les cultures — `displayName` les
lisait déjà.

⚠️ **Composer plutôt qu'écrire, partout où c'est possible.** Six des
dix jeux ont été **générés par règle** et non traduits à la main :

- les chiffres (température, profondeur, levée, espacement) par un
  patron, parce qu'une profondeur de semis est une **consigne** ;
- le **sol** par segments — 52 segments couvrent 78 phrases, séparés
  par des virgules ;
- le **rendement** par chiffre + unité + dénominateur ;
- les **durées de récolte** par durée + précision — 91 parenthèses et
  44 phrases libres couvrent les 200.

C'est plus sûr que la main, et ça garde la même formulation d'une
fiche à l'autre. Le poseur (`scratchpad/poser.py`, hors dépôt) refuse
d'écrire si un chiffre bouge.

⚠️ **Quatre pièges rencontrés, tous attrapés par le test des nombres
ou par le mien :**

- le « 1 » de « 1ère récolte » compte comme un nombre : « first
  harvest » le perdait, d'où « 1st harvest » et « 1.ª cosecha » ;
- le « 2 » de « Vaporisation 2× par jour » disparaissait dans « Mist
  twice a day » ;
- « 3 000 ans » devenu « 3,000 years » : la virgule anglaise des
  milliers casse la comparaison ;
- « humifère » et « riche en humus » traduits pareil donnaient
  « rich, humus-rich » dans la même ligne.

### ⚠️ `v.name` affiché : le défaut qui est revenu treize fois

`Vegetable.name` est le nom **français** — la clé des données, de la
recherche sans accent et des tests. Ce qui s'affiche, c'est
`displayName`. Onze endroits les confondaient le 01/11, un douzième le
02/11 (la vignette du catalogue, qui disait « Chou kale » à un
anglophone alors que la vue liste juste à côté traduisait) et un
treizième le même jour : les pastilles de **compagnonnage et de
rotation**, vues en espagnol à l'écran — « Fraise », « Carotte »,
« Haricot vert » sous une fiche entièrement castillane.

`flutter analyze` ne peut rien dire : les deux sont des `String`.
`test/noms_affiches_test.dart` cherche donc les expressions qui
**affichent** un nom (`Text(v.name)`, `label: Text(…)`, un trou de
`trUiArgs`) et laisse tranquilles la recherche et les clés, qui s'en
servent à bon droit. Vérifié en recassant volontairement une ligne.

**L'état, mesuré le 02/11/2026** : **4 894 chaînes par langue** —
1 943 de contenu, 1 267 de tutos, 779 d'interface, 736 de recettes,
169 de noms. Couverture **complète** en anglais et en espagnol. Les
six noms identiques au français (Melon, Taro, Cosmos, Zinnia, Fonio,
Moringa) le sont parce que c'est le même mot.

## 🌾 La neuvième zone, et le climat qui suit enfin la zone (02/11/2026)

**`ClimateZone.coolWinter` — tropical à hiver frais.** Mousson de juin à
septembre, puis une saison sèche et fraîche de novembre à mars où l'on
cultive les légumes tempérés. Plaine du Gange, nord du Viêt Nam.

**Pourquoi elle manquait** : les huit autres zones n'avaient pas
d'hiver. Hanoï cultive chou et carotte en décembre à 16 °C, et le
maraîchage de Delhi est le *rabi*, de novembre à mars. Les calendriers
guinéen et soudanien passaient cette saison entière sous silence — la
moitié de l'année agricole de deux pays qui pèsent un milliard et demi
d'habitants.

`coolWinterCalendar` (`west_africa_zones.dart`) porte **55 cultures** en
trois saisons : le *rabi* d'octobre-novembre (choux, racines,
légumineuses, bulbes, feuilles), le *kharif* de juin-juillet, et le
*zaid* de février-mars pour les cucurbitacées.
`test/cool_winter_test.dart` verrouille, et deux de ses règles ont
attrapé mes propres erreurs : le panais répétait la base à l'identique
(surcharge inutile, donc bruit), et ma première formulation interdisait
les semis avant septembre alors que **la pépinière de chou-fleur part
en août**, fin de mousson. La règle juste est « pas d'avril à
juillet », pas « après septembre ».

**Inde** et **Viêt Nam** la portent, affinées par latitude : au sud de
24° N l'Inde redevient soudanienne puis guinéenne, au sud de 16° N le
Viêt Nam redevient guinéen.

### Le climat ne lit plus la région

Le même défaut que le calendrier du matin, dans cinq autres endroits.
Une **région** ne dit plus que le contenu (ouest-africain ou non) ; le
climat est une propriété de la **zone**.

| Ce qui lisait la région | Ce que ça donnait |
| --- | --- |
| `Season.of` | Darwin voyait les quatre saisons européennes, São Paulo un hivernage là où il gèle |
| `heatwaveThresholdFor` | Darwin alertait dès 30 °C — presque tous les jours ; São Paulo attendait 40 °C, jamais atteints |
| `computeMedalTier` | São Paulo n'avait que deux saisons à collectionner au lieu de quatre, son podium plafonnait |
| `checkAndNotifyFirstRains` | l'alerte « premières pluies » ne partait pas à Darwin, et partait à São Paulo |
| `Country.isTropical` | répondait d'après la région du pays |

`heatwaveThresholdFor(Region)` devient `heatwaveThresholdForZone(ClimateZone?)`,
plus `currentHeatwaveThreshold()` pour les quatre appelants.
`Region.isTropicalBase` **reste**, mais son seul usage légitime est
désormais de **choisir une zone par défaut** quand aucune n'est connue.
Trois endroits le font, et ils le disent.

⚠️ **Une huitième saison, et pourquoi pas une des sept** :
`Season.coolDry`, « Saison fraîche ». Elle ne pouvait pas être
`harmattan`, qui désigne un vent sahélien dont personne n'a entendu
parler à Delhi, ni `winter`, dont les particules sont des **flocons** —
il ne neige pas à Hanoï. Dégradé bleu pâle, brume et feuillage :
c'est la saison où le potager est le plus vert, pas la plus morte.

## 🧰 Les 39 fiches d'accessoires ont un mode d'emploi (02/11/2026)

**Demande de Jean** : « les fiches accessoires doivent être plus
fournies en contenu ». Mesuré avant d'écrire : elles ne portaient qu'un
nom, un emoji, une ligne de note et deux phrases de description. Pas de
calendrier, pas de maladies, pas de recettes, pas de médaille — c'étaient
les plus vides de l'app, et de loin.

`lib/data/accessory_guide.dart` porte **177 phrases** en cinq champs :

- `when` — le moment de l'année ou du cycle ;
- `how` — le geste, et la faute qu'on fait sans le savoir ;
- `howMuch` — la quantité, à l'échelle d'un carré de 1,20 m ;
- `care` — entretien, rangement, durée de vie ;
- `diy` — ce qu'on peut fabriquer à la place. **Nullable** : on ne forge
  pas un sécateur. 22 accessoires sur 39 en ont un, et un test exige au
  moins la moitié — une app qui ne sait que renvoyer vers Amazon ne
  tient pas sa promesse de potager débrouillard.

⚠️ **Un fichier à part, pas cinq champs sur `Vegetable`** : les 130
cultures n'ont que faire d'un « combien il en faut pour un carré », et
le modèle porte déjà vingt champs. C'est le patron de
`local_names.dart` et `market_buying_tips.dart`.

⚠️ **Pas de gras Markdown** : `LexiconText` ne le rend pas, les
astérisques s'afficheraient en clair. J'en avais écrit 26 avant de m'en
apercevoir ; un test les refuse maintenant.

⚠️ **Les nombres sont des doses** : 5 g/m² de phosphate de fer, maille
de 0,8 mm contre la mouche de la carotte, saumure, profondeurs de bac,
2 L/h par goutteur. Ils passent par `content_i18n`, donc le test des
nombres les protège en traduction.

**Le contenu ne bloque pas les tests tant qu'il n'est pas traduit** :
`content_i18n_test` n'exige pas la couverture, seulement qu'aucune
traduction ne soit orpheline. Le français atterrit seul, et les cinq
langues suivront d'un coup. ⚠️ **L'interface, elle, exige la
couverture** : les cinq libellés de la carte ont dû être traduits dans
la foulée en anglais et en espagnol.

**Deux défauts trouvés en regardant la grille**, tous deux invisibles au
compilateur :

- la tuile affichait **`v.name`**, le nom français, alors que la vue
  liste juste à côté affichait `v.displayName`. Douzième endroit où
  `name` servait d'affichage, après les onze de la veille ;
- un nom sur deux lignes **débordait de 1,5 px** et son second mot était
  rogné — « Activateur de » puis rien. La colonne n'avait pas de
  `Flexible`, donc elle dépassait la tuile carrée. Visible sur la
  moitié des accessoires, dont les noms sont plus longs que ceux des
  légumes.

## Fiches à jour à chaque changement (règle de Jean, 22 octobre 2026)

Le Studio de Jean affiche les fiches de ce dépôt (docs/INFRA.md, docs/MARKETING.md, docs/PUBLICATION.md) et le README. Elles doivent toujours dire la vérité d'aujourd'hui.

- Dès qu'un travail change un fait affiché par ces fiches — version envoyée ou en ligne (App Store, Google Play, site), date de mise en ligne, hébergement ou domaine, service ajouté ou retiré, code Amazon Partenaires, état AdSense ou Pinterest, monétisation, nombre de contenus publiés —, mets à jour **dans le même envoi** toutes les phrases concernées des trois fiches (En bref, Parcours, Boutiques, Vue d'ensemble, Ce qui reste…) et du README.
- Une ancienne valeur ne reste qu'au passé, datée (« la 1.0.4 a été mise en ligne le 15 octobre »).
- Ne recopie jamais de secret ni de clé dans ces fichiers.
- Chaque matin, la tâche « Fiches Mes Apps » du Studio vérifie derrière toi, compare les versions avec ce que servent réellement les boutiques et signale toute phrase fausse.

15. **ML Kit a été essayé puis retiré (01/11/2026)** — décision de
    Jean, le même jour : « Franchement ça sert a rien du tt. Ça
    reconnais juste un fruit. » Il avait raison, et c'était aussi ma
    recommandation.

    **Ne pas le reproposer sans lire ceci.** Le code est dans
    l'historique git (commits `f6371ef` → `4973a21`, branche
    `essai/mlkit-stade`), avec sa logique pure et ses 19 tests.

    **Ce que l'essai a appris, et qui vaut pour n'importe quelle
    solution de vision :**

    - **Le prix, mesuré** sur deux builds release arm64 du même commit :
      **+12,8 Mio au téléchargement**, l'app passant de 48,6 à 61,4 Mio
      (+26 %). Dont 10,5 Mio de bibliothèque native, 2,9 Mio de modèle,
      1,2 Mio de dex.
    - ⚠️ **Comment mesurer sans se tromper** : `--target-platform
      android-arm64` ne filtre que les libs **de Flutter**. Celles des
      dépendances Android sont embarquées pour les trois architectures
      (28,7 Mio à elles trois), d'où un APK complet à +31 Mio qui
      **surestime** ce qu'un utilisateur télécharge, puisque Play
      découpe par ABI. Sommer les tailles **compressées** du zip en
      excluant `lib/x86_64/` et `lib/armeabi-v7a/`.
    - **Firebase entrait dans l'app** côté Android : le plugin tire
      `com.google.mlkit:linkfirebase`, l'APK déclarait
      `FirebaseInitProvider` et **trois permissions** nouvelles, dont
      `com.google.android.c2dm.permission.RECEIVE` (recevoir les push
      Google). Rien ne partait — sans `google-services.json` Firebase
      s'arrête au démarrage — mais dans une app qui promet qu'aucune
      donnée ne quitte le téléphone, c'était à déclarer aux boutiques.
      Côté iOS, Firebase est opt-in dans le Podfile : il n'y était pas.
    - **La raison du refus, et c'est la bonne** : le modèle générique ne
      reconnaît ni l'espèce (l'utilisateur l'a déjà choisie), ni les
      maladies, ni l'âge, et ne distingue pas une plantule d'un plant
      adulte. Il ne savait dire que « fleur », « fruit », « feuillage ».

    **Pourquoi la logique pure est partie aussi** : `stage_vision.dart`
    était bon et testé, mais plus rien ne l'appelait. La règle 10 est
    explicite, et ce projet s'est fait prendre quatre fois à garder du
    code « prêt pour plus tard » que personne n'atteignait.

    **Si la vision revient**, viser un modèle qui sait quelque chose que
    la date ignore — le stade sur les quatre phases, ou l'état sanitaire
    — et pas un étiqueteur généraliste. Pistes relevées le 01/11/2026 :
    un CNN sur photos iNaturalist atteint **86,4 %** sur exactement nos
    quatre stades (végétatif / bourgeons / floraison / fructification),
    et le papier dit que le point dur est la **qualité des photos**, pas
    le modèle ; `PlantNet-300K ResNet18` est publié en LiteRT sous
    Apache-2.0 (~16 ms sur un Pixel 8a) mais fait de l'**espèce**, ce
    dont on n'a pas besoin. Le prompt de discussion est dans
    `docs/prompt-modele-stade-plant.md`.

16. **L'onglet Photo a été ajouté puis retiré le 01/11/2026** —
    décision de Jean : « Non mais trop compliqué on retire le module
    photo. » Il avait raison sur le fond : l'onglet **doublait** le
    cahier de culture, qui portait déjà les photos d'un plant.

    **Ce qui est parti** : `lib/screens/home/photos/` (5 fichiers,
    dont la fiche conseil), `models/garden_photo.dart`,
    `services/photo_library_service.dart`, le libellé `tabPhoto` des
    deux ARB, et `Plantation.observedPhase` / `observedPhaseAt` avec
    `setObservedPhase` — ce champ n'était écrit que par la fiche
    conseil, il serait devenu un champ que rien ne remplit. Safe à
    retirer : il datait du jour même et n'a jamais été publié.

    **Ce qui reste, et qu'il ne faut pas confondre avec ce module** :
    les photos d'un plant dans le **cahier de culture**
    (`PlantationService.addPhoto`, `plantation_photo.dart`) et les
    **50 défis photo**, dont dépendent des badges. Le module retiré
    n'était qu'une **vue** par-dessus.

    ⚠️ **Conséquence sur les index d'onglets** : Recettes est repassé
    de 5 à 4. La route `kultiva://photos` survit pour les anciens liens
    et mène au cahier (index 1).

    **Une conséquence restée ouverte** : plus aucun écran ne permet à
    l'utilisateur de corriger le stade d'un plant. `AdviceService`
    le déduit de la date, et `planner_advice.dart` l'affiche dans le
    potager carré. Si la correction doit revenir, sa place est le
    dossier du plant (`showPlantationSheet`), pas un onglet.

17. ~~**Le tuto du dashboard montre quatre onglets**~~ — ✅ **FAIT le
    02/11/2026.** Le cinquième onglet (🫙 Conservation) est dans la
    barre, et son libellé est traduit dans les dictionnaires de tutos. Les
    scènes n'utilisaient que les index 0 à 2, donc l'ordre n'a pas
    bougé.

    **Deux choses ont suivi**, trouvées en regardant la page traduite :

    - les **noms et initiales de mois** du tuto venaient de son propre
      JavaScript, donc restaient français : il affichait « Novembre »
      et un « J » pour janvier sous une interface espagnole. Ils
      viennent maintenant de Dart (`__KULTIVA_MOIS__` et
      `__KULTIVA_MOIS1__`) ;
    - ses cartes avaient une **hauteur fixe de 104 px** : « Retos e
      insignias » passait sur deux lignes et chevauchait la pastille.
      `min-height` et une réserve de 34 px sous la pastille.

    ⚠️ `docs/prompt-tuto-dashboard.md` dit encore « quatre onglets » :
    à corriger avant de régénérer le tuto depuis ce prompt.

## 🫙 « Garder ta récolte » (structure arrêtée le 01/11/2026)

**Le top 3 d'un légume est fait de conservations.** Décision de Jean,
et c'est le pivot de tout l'onglet : un jardinier n'a pas une
courgette, il en a quinze d'un coup, et c'est le seul problème qu'un
livre de cuisine ne résout pas.

**Pourquoi c'est tenable.** Une conservation est une **méthode**
appliquée à un légume, pas une recette inventée pour lui.
`PreservationMethod` en compte neuf — congélation, blanchi puis
congelé, transformé puis congelé, bocal stérilisé, lacto-fermentation,
séchage, confiture, dans l'huile, au vinaigre. Neuf procédés écrits une
fois couvrent les 123 cultures comestibles ; 123 recettes sur mesure
auraient demandé quarante fois le travail.

⚠️ **`transformeCongele` est celle qu'on oublie.** J'ai d'abord affirmé
à Jean que les feuilles à salade étaient impossibles à conserver — « ni
congeler, ni sécher, ni mettre en bocal ». Il a répondu qu'un velouté
congelé **est** une conservation. Il avait raison, et c'est ce qui
couvre laitue, mâche, roquette et cresson. **La mâche est dans les
légumes de référence exprès**, pour que ce cas reste vérifié.

**Deux champs portent l'information qui décide** :

- `Recipe.method` — la méthode, ou `null` pour un plat du jour même.
- `Recipe.keeps` — « 1 an au placard », « 8 mois au congélateur ».
  Entre deux conservations, c'est **ça** qui tranche : un congélateur
  plein rend la stérilisation préférable, et inversement. Affiché dans
  la liste, pas seulement dans la fiche.

**Les trois légumes de référence** sont **tomate, fraise et mâche**.
Leurs neuf conservations sont écrites en entier. `recipes_test.dart`
exige pour chacun : trois conservations, chacune avec étapes,
ingrédients, temps, parts et durée de garde ; **au moins deux méthodes
distinctes** (la mâche est le plancher — une feuille tendre ne survit
que cuite puis congelée) ; et **une conservation rapide** (≤ 25 min),
sans quoi la seule réponse à un surplus demanderait deux heures pendant
que la récolte pourrit.

**Les plats à manger le jour même** ne sont pas perdus : ils quittent
le top 3 et vivent sous « N recettes à manger tout de suite », replié.
Un test vérifie que chacun des trois légumes en garde au moins un.

✅ **Les 123 légumes ont leurs trois conservations (01/11/2026).** Les
360 nouvelles ont été écrites sur le modèle de la tomate, de la fraise
et de la mâche, et placées **en tête** de chaque liste : les anciennes
recettes descendent sous « à manger tout de suite ». Le test du top 3
(trois conservations, deux méthodes au moins, une rapide, des étapes
complètes) s'applique désormais à **tous** les légumes, pas aux trois
de référence.

**Les règles de sécurité qu'elles suivent**, à garder pour toute
conservation ajoutée :

- **jamais de bocal stérilisé pour un légume peu acide** (haricot,
  carotte, courge, champignon, oignon, ail…) : risque de botulisme
  sans autoclave. Le bocal stérilisé est réservé aux fruits, à la
  tomate, à la rhubarbe, aux sirops ;
- vinaigre à 6 % minimum (8 % dans les recettes), **au moins autant de
  vinaigre que d'eau** ; pickles gardés au réfrigérateur ;
- saumure à **3 %** (30 g de sel par litre) ou 20 g par kg en sel sec ;
- tout ce qui est **dans l'huile** se garde au réfrigérateur ;
- manioc, taro et igname sont toujours **cuits** avant d'être mangés.

**Le temps d'une conservation compte son attente à température
ambiante** (fermentation, séchage, infusion), pas le temps passé au
réfrigérateur ou au congélateur : des piments séchés en guirlande,
c'est un mois ; des fraises congelées, un quart d'heure. `dureeLisible()` l'affiche en « 3
semaines » plutôt qu'en « 30240 min ». Une étape n'a de minuteur que
jusqu'à 12 h ; au-delà, son texte dit la durée.

### Le mécanisme du top 3 (inchangé)

Contrainte de Jean, et c'est la seule : **un top 3 par légume**. Trois
recettes mises en avant, jamais plus — vingt idées de plat ne se
choisissent pas. Et **une même recette peut servir plusieurs légumes**,
ce qu'il a explicitement autorisé.

**La donnée.** `recipesByVegetable` reste la source, mais une recette
déclare désormais les autres légumes qu'elle emploie (`Recipe.uses`).
Trois fonctions portent la structure, dans `lib/data/recipes.dart` :

- `top3For(id)` — les **trois premières** de la liste du légume.
  L'ordre du catalogue **est** le classement.
- `otherRecipesFor(id)` — ce qui dépasse de sa propre liste, **plus**
  les recettes d'autres légumes qui le citent dans `uses`. Sans ça, une
  recette hors du top 3 ne serait atteignable par aucun chemin : un bug,
  pas une réserve (règle 10). Un test le vérifie pour les 370.
- `ownerOf(recipe)` — le légume sous lequel la recette est rangée. La
  clé des favoris est `légume/nom` : une recette vue depuis un légume
  emprunteur doit garder la clé de son propriétaire, sinon elle
  apparaîtrait deux fois dans les favoris.

**À l'écran.** La fiche légume et l'onglet affichent le top 3, puis
« N autres recettes avec ce légume », replié. Chaque recette ouvre
**une fiche avec l'animation de ses étapes** (`recipe_player.html`, un
seul template nourri par du JSON) — minuteur par étape, ingrédients, et
quantités qui suivent le nombre de convives.

**Tomate et fraise sont les deux légumes de référence** : leurs trois
recettes du top ont étapes, ingrédients, temps et parts. Un test
l'exige, et exige aussi que le top 3 couvre **trois situations** — une
recette rapide (≤ 15 min), une de fond (≥ 55 min), et le surplus à
conserver. Trois recettes qui prennent toutes une heure ne servent à
rien à quelqu'un qui rentre du travail.

**Les plats du jour même** : 288 recettes n'ont pas encore d'étapes.
Elles s'ouvrent en fiche courte, qui dit la vérité au lieu d'afficher
un lecteur vide. Elles ne sont plus dans le top 3 (fait de
conservations) ; les écrire en pas-à-pas reste possible, légume par
légume, sans urgence.

⚠️ **Les chiffres sont verrouillés par deux tests** (`recipes_test.dart`) :
ajouter une recette fait échouer la suite jusqu'à ce que README,
`docs/MARKETING.md` et ce fichier soient corrigés. C'est volontaire :
les fiches ont annoncé « 340 recettes, dont huit animées » pendant une
journée alors qu'il y en avait 369 et 7.

18. **Le lecteur de recettes n'a jamais fonctionné jusqu'au
    01/11/2026** — page blanche sur les 88 recettes « animées ».

    **La cause** : `recipe_player.html` écrivait le marqueur
    `__RECIPE__` **deux fois**, une fois dans son commentaire d'en-tête
    et une fois dans son script. Dart appelle `replaceFirst`, donc
    c'est le **commentaire** qui recevait le JSON ; la ligne
    `var R = __RECIPE__;` restait intacte, le script mourait sur une
    variable inconnue, et il ne restait que les boutons.

    **Pourquoi rien ne l'a vu** : `flutter analyze` ne lit pas le HTML,
    `assets_exist_test.dart` vérifie qu'un fichier existe et pas ce
    qu'il contient, et aucun test ne remplissait le template. Découvert
    en voulant simplement montrer l'animation à Jean.

    `test/recipe_player_test.dart` verrouille maintenant : marqueur
    unique, aucun marqueur résiduel après remplissage, JSON relisible,
    et aucun appel réseau.

    ⚠️ **Leçon générale** : un asset qu'on remplit par substitution doit
    avoir un test qui fait la substitution. Le même piège attend les 33
    tutos si l'un d'eux devient paramétrable.

    ⚠️ **Et ça n'a pas suffi : le lecteur ne s'est ouvert dans l'app
    que le 02/11/2026.** Signalé par Jean — « les animations mettent
    beaucoup trop de temps à charger et d'ailleurs ne chargent même
    pas ». La cause était ailleurs, dans le Dart :

    ```dart
    onNavigationRequest: (_) => NavigationDecision.prevent,
    ```

    Le garde-fou, posé dès le premier commit de l'onglet pour que la
    recette reste un document fermé, refusait **toute** navigation. Or
    `loadHtmlString` **est** une navigation : la WKWebView la présente
    comme un passage vers `about:blank`. Le document était donc refusé
    lui-même, `onPageFinished` ne partait jamais, et l'écran restait
    sur son indicateur de chargement. On ne bloque plus que ce qui sort
    vraiment — `http`, `https`, `mailto`, `tel`.

    ⚠️ **Pourquoi personne ne l'avait vu** : la vérification du 01/11
    s'était faite dans **Chrome headless**, où il n'y a pas de
    `NavigationDelegate`. Le HTML était juste ; son hôte ne l'était
    pas. **Un asset rendu dans une WebView se vérifie dans la
    WebView**, pas dans un navigateur de bureau — et c'est maintenant
    possible, le simulateur rend l'écran.

19. **Le lecteur de recettes a été refait le 01/11/2026 (« Polaroïd »)**
    — choisi par Jean parmi seize maquettes. Toujours **un seul
    fichier**, `assets/recipes/recipe_player.html`, sans réseau, Nunito
    embarquée en base64, thème clair ou sombre lu dans le JSON.

    - Chaque étape est une **carte Polaroïd** (ruban adhésif vert,
      légende), avec au centre une **scène animée** en SVG/CSS : neuf
      gestes (laver, couper, mixer, cuire, attendre, saler, verser,
      mettre en bocal, congeler) choisis d'après l'emoji et le verbe de
      l'étape.
    - **Le légume joue dans la scène.** Dart envoie son image peinte et
      détourée dans le champ `vegetable` du JSON (`{name, emoji,
      image}` en data:URI, ~7 Ko) ; sans image, c'est son emoji.
    - Minuteurs réels, qui continuent quand on change d'étape, avec bip
      et vibration ; l'écran reste allumé.
    - Les sources de construction (moteur, scènes, variantes) ne sont
      pas dans le dépôt : le fichier livré **est** la source. Le
      modifier à la main, puis relancer `test/recipe_player_test.dart`.

    **Les légumes détourés** vivent dans
    `assets/images/vegetables_kawaii/detoure/` (130 WebP, 200 px, fond
    transparent, 1,5 Mo), produits par `tool/detoure_legumes.py`
    (rembg, modèle `isnet-general-use`). Un test exige qu'à chaque
    légume peint corresponde sa version détourée : **en ajoutant un
    légume, relancer l'outil** avec son id.

## 🌍 Les calendriers écrits à la main (02 et 03/11/2026)

**Ce que le décalage uniforme ratait.** `zone_shift.dart` dérivait ces
deux zones de la base française par un décalage d'un mois. Pour un
pommier, bonne approximation. Pour une laitue, faux de six mois : en
climat méditerranéen, **l'été est la saison morte** des
légumes-feuilles, pas leur pic. Une laitue semée en juillet à Séville
monte en graine avant de pommer. Salades, choux, radis et légumineuses
s'y sèment à l'**automne** et se récoltent en **hiver et au
printemps** — l'inverse du rythme français.

En continental, le problème est à l'autre bout : le sol gèle de
novembre à mars. Le poireau, la mâche, le chou pommé et le panais, que
la France récolte tout l'hiver, doivent y être **arrachés avant les
gelées**. Le décalage les laissait récolter en janvier, sous la neige.

**`lib/data/regions/temperate_zones.dart`** porte 51 calendriers
méditerranéens et 48 continentaux, écrits culture par culture, chacun
avec une note qui explique l'écart — sans elle, un jardinier français
installé en Espagne croit à une erreur.

**Ça ne remplace pas la dérivation, ça la corrige où elle se trompe.**
Une culture absente du fichier garde son calendrier dérivé et sa note
qui le dit. `deriveTemperate()` consulte la surcharge en premier, puis
applique l'hémisphère. Même principe que les surcouches de traduction.

`test/temperate_zones_test.dart` (16 tests) verrouille : aucune clé
inventée, mois valides, une note partout, **rien d'identique à ce que
le décalage dirait** (une surcharge inutile est du bruit), pas de
salade semée en plein été au sud, rien semé ni récolté dans le sol
gelé au nord — sauf l'ail, parce que c'est le froid qui fait diviser
la tête, et sauf les semis marqués « à l'abri ».

⚠️ **Deux anciens tests ont dû changer** : ils vérifiaient le décalage
uniforme sur la **tomate**, qui a maintenant un calendrier écrit. Ils
portent désormais sur le sarrasin, qui n'a pas de surcharge.

### Le subtropical humide (03/11/2026)

**Ce n'est pas un méditerranéen un peu plus chaud**, et c'est l'erreur
que faisait la dérivation. Les deux ont un hiver doux, mais le
méditerranéen a un été **sec** et celui-ci un été **lourd** : 30 à
35 °C avec de l'humidité et des orages. Une tomate n'y souffre pas de
la soif, elle attrape le mildiou ; une laitue n'y grille pas, elle
pourrit du collet.

**La dérivation subtropicale élargissait** : semis = base ∪ base−1,
récolte = base ∪ base+1. Elle ajoutait donc des mois de part et
d'autre sans jamais rien retirer — une laitue restait semable en
juillet à Atlanta comme à Buenos Aires.

`subtropicalCalendar` porte **58 cultures**, et sa signature est le
**double semis** : une récolte de printemps et une d'automne, de part
et d'autre du creux humide de juillet-août. Tomate, courgette,
concombre, maïs et pomme de terre se sèment deux fois ; le
méditerranéen, lui, n'a qu'une saison.

⚠️ **Trois détails qui ne se devinent pas** :

- **la fraise s'y mène en annuelle** — plants à l'automne, récolte
  d'hiver, puis on arrache : un pied laissé en place ne passe pas
  l'été humide ;
- **le chou de Bruxelles est possible sans être confortable** : les
  pommes ne se serrent qu'au froid, et l'hiver est doux. Sa note le
  dit, plutôt que de le faire disparaître ;
- **semer en août est normal ici** pour les choux, les racines et le
  poireau : c'est la pépinière de la récolte d'hiver. Le test
  n'interdit l'été lourd qu'aux salades, parce que c'est pour elles
  seules que c'est faux.

Zones concernées : sud-est des États-Unis, Argentine, Uruguay, sud du
Brésil, Japon, est de l'Australie, haut plateau sud-africain. Quatre
sur sept sont dans l'**hémisphère sud** : les calendriers s'écrivent
en mois du nord, et `deriveTemperate` applique le retournement après
la surcharge. Un test le vérifie nommément sur l'Argentine.

⚠️ **Restent des moyennes de zone.** Le méditerranéen de Marrakech
n'est pas celui de Zagreb, et le subtropical de Tokyo n'est pas celui
de Houston. Les affiner pays par pays reste à faire.

20. ~~**L'interface n'est pas traduite**~~ — ✅ **FAIT le
    02/11/2026.** 772 chaînes par langue, 718 appels `trUi()` dans
    53 fichiers, et les 33 clés ARB orphelines retirées. Treize agents
    en deux vagues : sept pour **brancher** (envelopper les littérales
    sans traduire), six pour **traduire**.

    **Ce que le branchement a appris, et qui resservira :**

    - ⚠️ **Deux collisions de clés**, trouvées seulement parce qu'un
      agent a su les nommer. « juin » est à la fois le mois court et le
      mois long — en anglais « jun » et « june », donc **une clé
      devrait rendre deux valeurs**. Et « Mar » est à la fois **mardi**
      et **mars**. Les mois et les jours sont donc des **tables
      indexées** dans `ui_i18n.dart`, pas des phrases. Un ensemble
      fermé et ordonné n'est pas du texte libre.
    - ⚠️ **Un champ d'enum `const` ne peut pas appeler de fonction.**
      `Country.label`, `Country.capitalName` et `Region.label` passent
      par un getter `displayLabel`, comme `Vegetable.displayName`.
      `tool/exporter_enums.dart` les sort pour le squelette, et le test
      les lit **dans l'enum**.
    - ⚠️ **Le tri et la recherche suivent la langue.** Le catalogue
      espagnol commence à Alemania, et une recherche répond aux deux
      langues — la clé reste le nom français, mais un hispanophone tape
      « zanahoria ».
    - ⚠️ **`v.name` affiché, c'était du français partout.** Onze
      endroits l'utilisaient au lieu de `v.displayName` : notifications,
      PDF, potager carré, dossier de plant. Et `advice_service`
      affichait des **identifiants bruts** de compagnonnage.
    - ⚠️ **Un `Spacer` vole l'espace d'un `Flexible`.** Les deux sont
      flexibles, donc ils se partagent l'espace libre à parts égales :
      le titre de la carte du dashboard n'obtenait qu'une ligne, et
      « Challenges & badges » s'affichait « Challenges & ». Le
      français, qui tient sur une ligne, ne montrait rien. La carte est
      passée à 138 px et sa colonne à `spaceBetween`.
      **Une traduction est un test de mise en page** : les autres
      langues sont plus longues, et c'est l'écran qui le dit, pas le
      compilateur.
    - ⚠️ **Vingt tests sont tombés d'un coup** en remplissant les
      dictionnaires : ils comparaient du français alors que
      l'environnement de test tourne en `en-US`. Il faut **deux**
      choses, pas une — `setUpAll(() => PrefsService.instance
      .language.value = 'fr')` **et** semer
      `'flutter.kultiva.language': 'fr'` dans
      `setMockInitialValues`, sinon `load()` écrase la première.
    - ⚠️ **Un seul propriétaire par chaîne.** Les sept conseils
      canicule ont été enveloppés par erreur dans `trUi` alors que
      leurs trois appelants font déjà `tr(…)` : ils auraient été
      traduits deux fois, et leurs entrées de `content_en.dart`
      seraient devenues orphelines. `heatwave_tips.dart` rend donc du
      français, et son commentaire dit pourquoi.

21. ~~**Des textes citent encore le Poussidex**~~ — ✅ **FAIT le
    02/11/2026.** Les quatre derniers endroits visibles sont réécrits :
    le sous-titre « Le tour complet — dashboard, Cahier, Étal,
    Recettes », le dialogue de suppression d'un plant (« de ton cahier
    de culture »), le texte de partage (« dans mon jardin Kultiva ») et
    le dos de la carte de badge (« BADGES » au lieu de
    « POUSSIDEX »).

    **Deux entrées de lexique sont parties avec** — « poussidex » et
    « streak » définissaient des notions supprimées le 31/10, et la
    définition de « streak » citait un badge « Fidèle » qui n'existe
    pas dans les 50. Le contenu passe de 784 à **780 phrases**, et le
    test des clés orphelines a réclamé leurs traductions tout seul.

    **Au passage** : « Apprends à jardiner en vidéo » devient
    « Apprends à jardiner, fiche par fiche » — les tutos sont des
    fiches HTML, pas des vidéos. Et les deux dernières notifications
    qui vouvoyaient (« Vos légumes ont soif ») tutoient comme le reste
    de l'app.

    ⚠️ **`kultiva.gridMigratedToPoussidex` reste**, et doit rester :
    c'est une **clé de préférence** déjà écrite sur les téléphones. La
    renommer relancerait la migration de l'ancienne grille chez tous
    ceux qui l'ont déjà faite.

22. **La passe de vérification des 73 pays (02/11/2026)** — demandée
    par Jean après la Nouvelle-Calédonie : « si tu en as loupé un il y
    en a peut-être d'autres ». Il y en avait. Fiche publiée :
    `https://claude.ai/artifact/Dpxa9TsY3QQ4Au3L56cLgF`.

    ✅ **Le défaut structurel, et c'est le plus grave** : la base de
    calendrier suivait la **région**, et `Country.zoneAt(latitude)`
    peut rendre une zone de l'**autre** base. Le répartiteur retombait
    alors sur la base brute — sans note, sans erreur, sans test.
    Quatre pays le subissaient, dont le plus peuplé :

    - **Brésil** au sud de 23° S (São Paulo, Curitiba, Porto Alegre) :
      zone subtropicale demandée, calendrier tropical non élargi ;
    - **Australie** au nord de 24° S (Darwin, Cairns) : zone
      soudanienne demandée, calendrier français retourné de six mois ;
    - **Maroc** et **Algérie** au sud de 31° N : zone sahélienne
      demandée, calendrier français brut.

    `regionalCalendar()` teste maintenant `zone.isTropical` et non
    `region.isTropicalBase`. **Le climat est une propriété de la zone,
    pas du pays** ; une région ne dit plus que le contenu
    (ouest-africain ou non).

    ⚠️ **Pourquoi aucun test ne l'avait vu** : `country_test` vérifiait
    la zone **déclarée** d'un pays, jamais celle que `zoneAt()` rend à
    une latitude donnée. Le nouveau test balaie −60° à +72° par
    demi-degré pour les 73 pays. Un test qui vérifie la donnée au
    repos ne dit rien de la fonction qui la transforme.

    ✅ **Cinq zones corrigées**, chacune avec le fait qui contredisait
    l'ancienne, écrit dans `country.dart` :

    | Pays | Était | Est | Le fait |
    | --- | --- | --- | --- |
    | Croatie | méditerranéen | continental | Zagreb : pluies maximales en juin, janvier à 1 °C |
    | Égypte | sahel (tropical) | méditerranéen (tempéré) | 25 mm de pluie par an, maraîchage irrigué d'hiver |
    | Nouvelle-Calédonie | subtropical (tempéré) | soudanien (tropical) | 22° sud, pluies décembre-mars |
    | Afrique du Sud | méditerranéen | subtropical | Pretoria : pluies d'octobre à mars, gelées en juin |
    | Australie | méditerranéen | subtropical | Canberra : pluie toute l'année, gelées en juillet |

    ⚠️ **Deux échanges assumés** : l'Afrique du Sud gagne le Gauteng et
    perd le Cap, seul vrai méditerranéen du pays ; l'Australie gagne
    Sydney-Melbourne-Canberra et perd Perth-Adélaïde. Distinguer Perth
    de Sydney demanderait la **longitude**, que `zoneAt` n'a pas.

    ⚠️ **Corriger une zone déclarée ne suffit pas** : j'ai mis
    l'Australie en subtropical et Canberra recevait encore le
    méditerranéen, parce que `zoneAt` le rendait toujours. **Une zone
    vit à deux endroits** — le champ de l'enum et l'affinage par
    latitude.

    ✅ **Le libellé nomme le pays** : `placeLabelFor(region, country)`
    remplace `region.displayLabel` dans les trois titres de la fiche
    légume et l'en-tête du PDF. Un jardinier allemand lisait
    « Semis — France ».

    ✅ **La deuxième porte du lien Amazon**, oubliée le matin même : le
    panier des accessoires testait encore la région, donc s'affichait
    dans les 36 pays de la base tempérée. **Une règle à deux endroits
    se corrige à deux endroits** — et c'est `grep` qui le dit, pas la
    mémoire.

    ⬜ **Reste ouvert** : les saisons (`Season.of`), le seuil de
    canicule (`climate.dart`), les médailles, les notifications et les
    animations de pétales lisent encore `region.isTropicalBase`. Ils
    diront donc autre chose que le calendrier à Darwin et à São Paulo.
    Le test `zoneAt` garde la donnée cohérente en attendant, en
    exemptant nommément le Brésil et l'Australie, qui chevauchent
    vraiment les deux bases.

    ⬜ **Reste ouvert** : Hanoï et Delhi réclament une **neuvième
    zone**, « hiver frais sous les tropiques ». Hanoï cultive chou et
    carotte en décembre à 16 °C ; le maraîchage de Delhi est le
    *rabi*, de novembre à mars. Les calendriers guinéen et soudanien
    ignorent cette saison entière.

    ⬜ **Reste ouvert** : Lima est un désert côtier classé tropical
    d'altitude, Antananarivo est à 1 280 m classée soudanienne — les
    deux inversées. Sans effet sur le calendrier (`sudan` et
    `highland` en produisent un identique, vérifié : 14 calendriers
    distincts pour 32 combinaisons), mais les saisons et les conseils
    mentent. Ankara et Abuja sont à confirmer.

## 🗣️ Traduire le contenu (structure posée le 02/11/2026)

**Le problème que ça règle.** L'app avait une interface anglaise posée
sur 736 recettes françaises. Un anglophone lisait « Recipes », cliquait,
et tombait sur « Coulis de tomates en bocaux ». Ce n'était pas une
traduction à venir, c'était une traduction cassée, déjà livrée.

**Pourquoi il fallait une structure avant de traduire.** Les 57 000 mots
de recettes sont en dur dans `lib/data/recipes.dart`, 11 821 lignes de
Dart avec apostrophes et dollars échappés. Il n'existait **aucun endroit
où une deuxième langue puisse atterrir**. Faire éditer ce fichier par un
agent de traduction, c'était risquer la compilation sur un `\'` oublié.

**Le patron retenu** est celui de `names_en.dart`, qui marche depuis le
01/11 : **une surcouche, pas un second catalogue.**

- `lib/data/recipes_i18n.dart` — le mécanisme. `RecipeText` (name,
  description, keeps, ingredients, steps), la table
  `recipeTextsByLanguage`, les fonctions pures `recipeNameIn`,
  `recipeStepsIn`… et l'extension `display*` qui lit la langue dans
  `PrefsService`. Y vivent aussi les neuf méthodes de conservation
  traduites (`methodLabelIn`) et `dureeLisibleIn` — sans quoi un écran
  anglais affichait « 3 semaines » sous un titre anglais.
- `lib/data/recipes_en.dart` — la surcouche anglaise. Clé =
  `légume/nom français`, celle des favoris. **Le nom français sert de
  clé même dans un fichier étranger** : il ne change pas quand on
  traduit, alors qu'une clé anglaise aurait obligé à renommer les sept
  lots à la première retouche de style.
- `tool/exporter_recettes.dart` — sort les lots à traduire. Il
  **importe** le catalogue au lieu de le lire : pas d'expression
  régulière, donc pas de casse sur un nom contenant une apostrophe.
- `test/recipes_i18n_test.dart` — 10 tests, dont celui qui compte.

**Ce qui ne voyage pas dans une traduction, exprès** : l'emoji d'une
étape (il choisit la scène animée du lecteur), son minuteur, les
minutes, les parts, la méthode. Ce qui n'a pas de langue reste dans le
catalogue, donc ne peut pas se perdre en route.

**Le repli est par champ.** Une recette dont le nom est traduit mais pas
les étapes affiche un nom anglais et des étapes françaises. C'est ce qui
permet de traduire par morceaux sans jamais casser l'app — et c'est
pourquoi une liste d'étapes de longueur différente est refusée **en
entier** plutôt que mélangée.

⚠️ **Le test des nombres est le garde-fou du chantier.** Il compare les
chiffres de chaque chaîne traduite à ceux du français. Une saumure à
3 % devenue 2 % ne conserve plus, elle fait pousser autre chose ; un
vinaigre dilué ne protège plus d'un botulisme. Vérifié en cassant
volontairement une étape : l'erreur nomme le fichier, la recette et
l'étape.

**L'état réel (02/11/2026)** : **les 736 recettes sont traduites en
anglais et en espagnol**, les 123 légumes, plus les 33 tutos
(1 267 phrases) et les 780 phrases de contenu dans les deux langues.
La tomate a été écrite à la main comme modèle de ton ; le reste a été
traduit par des agents Sonnet en parallèle, puis validé par les trois
suites de tests — aucune clé inventée, comptes d'étapes exacts,
nombres identiques au français. Un test verrouille la **couverture
par langue** : ajouter une recette sans sa traduction, ou enregistrer
une langue à moitié faite, fait échouer la suite.

⚠️ **Le prix réel, mesuré** : 130 000 à 240 000 jetons par lot sur
Sonnet, ≈ **1,5 million pour l'anglais complet** et **1,67 million
pour l'espagnol** (6 lots de recettes + tutos + contenu, huit agents
en parallèle, sept minutes de temps réel). Pas 360 000 comme je
l'avais estimé au départ : l'agent lit, vérifie et réfléchit en plus
d'écrire. Mesurer avant de citer.

⚠️ **Une charte vaut mieux qu'un prompt.** Les huit agents espagnols
ont reçu le même fichier (`build/traduction/CHARTE_ES.md`, hors
dépôt) : les quatre règles qui font échouer un fichier, ce qui ne se
traduit pas (plats ouest-africains, emoji, gras Markdown), le choix du
castillan sans doublet latino, l'échappement Dart, et le format du
rapport. Le prompt de chaque agent ne fait alors que dire quel fichier
remplir. Sept des huit ont écrit leur propre script de vérification
des nombres avant de rendre — parce que la charte disait qu'un test
refuserait le fichier.

⚠️ **`tool/exporter_contenu.dart` lit sa langue dans un fichier.** Ni
l'environnement du shell ni `--dart-define` n'atteignent l'isolat de
`flutter test` :

```bash
mkdir -p build/traduction && echo es > build/traduction/LANGUE
flutter test tool/exporter_contenu.dart   # → build/traduction/contenu_es.dart
```

Sans ce fichier, c'est l'anglais.

**Ajouter une langue** : écrire `lib/data/recipes_<code>.dart`, ajouter
une ligne à `recipeTextsByLanguage`, ajouter le code à
`PrefsService.supportedLanguages` et l'ARB correspondant. Rien d'autre
à brancher — les écrans lisent déjà la surcouche.

**Le lecteur de recettes parle la langue aussi.** `recipe_player.html`
est un document hors ligne : il ne peut pas lire les ARB. Ses propres
libellés — « Ce qu'il te faut », « étape 1 », « C'est parti », les
minuteurs, les mois — voyagent donc dans le JSON, champ `ui`, produit
par `playerUiFor()`. Une clé manquante retombe sur le français côté
JavaScript. Sans ça, une recette anglaise s'ouvrait dans une boîte
française : constaté à l'écran le 02/11/2026, puis corrigé et revérifié
en capture.

⚠️ **Restent en français dans l'écran Recettes**, et relèvent des ARB et
pas de ce chantier : « Il te faut », « Une idée pour ta récolte de… »
(partage) et « Pour 4 personnes · écrite pour 4 » (choix des parts).

### Les tutos : traduits sans être touchés (02/11/2026)

**Le volume, mesuré** : 34 tutos, **1 267 textes distincts, 11 158
mots** — cinq fois moins que les recettes. J'avais raisonné comme si
c'était un second chantier de même taille ; c'était faux.

**Ni copie par langue, ni gabarit.** Dupliquer, c'est 34 fichiers × n
langues qui divergent. Transformer les 34 pages en gabarits demandait
de les réécrire une par une, chacune ayant sa structure. À la place :
on injecte un dictionnaire et dix lignes de JavaScript avant
`</body>`, et le navigateur remplace les textes **dans le DOM**. Les
34 fichiers ne bougent jamais.

- `lib/data/tutos_i18n.dart` — le dictionnaire par langue et
  `tutoTraduit(html, langue)`. En français, le HTML ressort inchangé :
  pas de script inutile.
- `lib/data/tutos_en.dart` — l'anglais. **Clé = la phrase française
  exacte** : si le français est corrigé, la clé ne correspond plus et
  la phrase reste en français. Pas de traduction fantôme.
- `tool/exporter_tutos.py` — extrait les textes (nœuds de texte et
  attributs `alt`/`title`/`aria-label`), jamais le contenu des
  `<script>` ni des `<style>`.
- `test/tutos_i18n_test.dart` — 9 tests : chaque clé existe encore dans
  un tuto, les nombres ne bougent pas, le corps du tuto est intact,
  aucun appel réseau, et le français ressort tel quel.

Le walker ignore `<script>` et `<style>`, et un `MutationObserver`
reprend les textes ajoutés après coup — le tuto du dashboard écrit ses
légendes au fil de l'animation.

**Les 33 tutos sont traduits** — 1 267 phrases. `conserver_legumes` a
été écrit à la main comme modèle et vérifié en capture (mise en page
intacte, 8-12 °C, 3 %, 100 °C préservés) ; les 1 230 autres phrases
viennent d'un agent, validées par le test.

⚠️ **Un piège du test, trouvé le 02/11** : il cherchait la phrase
française dans le HTML brut, donc « Défis & badges » était introuvable
dans un fichier qui écrit « Défis &amp; badges ». Le test décode
maintenant les entités, comme l'extracteur.

⚠️ **Les mois d'un calendrier ne sont pas des phrases.** « J » vaut
janvier, juin et juillet, et vaut « E » en espagnol. Les cases d'un
calendrier portent donc `data-mois="1".."12"`, et le walker les
remplit depuis `__KULTIVA_MOIS1__`, posé par Dart. Les noms longs
voyagent aussi, dans `__KULTIVA_MOIS__`, pour les tutos qui
construisent leur contenu en JavaScript.

⚠️ **Deux blocs injectés, et l'ordre compte.** Les **données** entrent
juste après `<body>`, donc avant le script du tuto — sinon
`decouvrir_dashboard`, qui bâtit son calendrier lui-même, lirait la
table des mois avant qu'elle existe. Le **walker**, lui, passe avant
`</body>`, après que les scripts du tuto ont posé leur contenu. Un
test vérifie l'ordre, et un autre qu'en retirant les deux blocs on
retombe **exactement** sur le fichier d'origine.

⚠️ **« Jamais modifiés » veut dire « jamais dupliqués par langue »**,
pas « intouchables ». Le français d'un tuto reste la source : on le
corrige dans son fichier, comme n'importe quelle donnée. C'est ce qui
a permis de marquer les douze cases de `quand_semer`.

⚠️ **Phrases coupées par une balise.** Certains tutos coupent une
phrase en trois nœuds de texte (« Le » / « calendrier » / « lunaire au
potager »). Chaque morceau est traduit séparément, et la phrase ne se
recolle correctement que si l'ordre des mots le permet. À regarder en
premier si un tuto anglais lit bizarrement.

### Le reste du contenu (02/11/2026)

**780 phrases, 7 248 mots** : maladies et ravageurs (323), lexique
(158), défis (110), badges (100), achat au marché (56), familles
botaniques (26), conseils canicule (7).

Même principe, dictionnaire unique keyé par la phrase française :

- `lib/data/content_i18n.dart` — `tr()`, `trIn()` et les extensions
  `displayName` / `displayRemedy` / `displayDefinition` sur `Disease`,
  `LexiconEntry`, `PoussidexBadge` et `PhotoChallenge`.
- `lib/data/content_en.dart` — l'anglais.
- `tool/exporter_contenu.dart` — ⚠️ tourne sous **`flutter test`** et
  non `dart run` : badges et défis passent par `vegetable_medal.dart`,
  qui importe Flutter. Il écrit dans `build/traduction/contenu_en.dart`.
- `test/content_i18n_test.dart` — 7 tests : aucune clé orpheline, les
  nombres ne bougent pas, le français ressort inchangé.

**Pourquoi un dictionnaire ici et une surcouche par champ pour les
recettes** : une recette est un objet à cinq champs qu'on recouvre
champ par champ ; ici ce sont des phrases isolées, chacune unique. La
clé peut donc être la phrase elle-même, comme pour les tutos.

⚠️ **`LexiconText` souligne les mots en cherchant les termes
français.** Traduire un terme du lexique sans traduire le texte qui le
contient ne soulignerait plus rien : les deux vont ensemble.

⚠️ **Le compagnonnage n'a pas besoin de traduction** : `companions.dart`
ne contient que des identifiants de légumes, déjà traduits par
`Vegetable.displayName`.

⚠️ **`rotation_advisor.dart` compose ses messages par interpolation**
(« il y a 2 ans », « recommande 3 ans d'attente »). Ils ne passent pas
par le dictionnaire et relèvent des ARB. Non fait.

### Ce que la traduction a révélé dans le français

Traduire oblige à relire, et la relecture a trouvé ce que personne
n'avait vu :

- ✅ **Corrigé** : `pommier/Compote de pommes en bocaux`, étape 5,
  disait « stérilise à 100 °C à partir de l'ébullition » **sans
  durée**. Le minuteur de l'étape portait bien 25 minutes, mais la
  fiche courte affiche le texte sans minuteur. Une durée de
  stérilisation muette, c'est une règle sanitaire perdue : la phrase
  le dit maintenant, en français et en anglais.
- ✅ **Sans objet, et c'était une erreur de cette fiche** (vérifié le
  03/11/2026). Elle annonçait que `fraise/Confiture de fraises` disait
  « poids pour poids avec le sucre » tout en donnant 1 kg de fraises
  pour 700 g de sucre. La recette dit « 700 g de sucre par kilo de
  fruits » et liste 1 kg / 700 g : elle est cohérente, en français, en
  anglais et en espagnol. `git log -S'poids pour poids'` ne trouve
  **aucun** commit : la phrase n'a jamais existé dans `recipes.dart`.
  ⚠️ C'est une incohérence inventée, pas corrigée — la fiche a décrit
  de mémoire un fichier qu'elle n'avait pas relu. **Mesurer avant de
  citer**, y compris quand on signale un défaut.
- ⬜ **À trancher** : le lexique définit encore **« poussidex »** et
  **« streak »**, deux notions supprimées le 31/10/2026, et la
  définition de « streak » cite un badge « Fidèle » qui n'existe pas
  dans les 50.
- ⬜ **À faire relire par un jardinier anglophone** : une dizaine de
  noms de ravageurs sans équivalent anglais établi — « Mouche de
  l'ail », « Puceron noir du prunier », « Mouche de la figue »,
  « Charançon de la rhubarbe », « Mouche mineuse du poireau »,
  « Maruca », « Mineuse de l'épi du mil ». **« Mildiou » est une
  seule clé** partagée par neuf cultures, rendue « Late blight /
  downy mildew » : juste pour la tomate et la pomme de terre, approché
  pour les autres. Un nom de maladie faux envoie acheter le mauvais
  traitement.
- ⬜ **Détail de forme** : les heures gardent la notation française en
  anglais (« Water before 9h ») parce que « 9 am » changerait le
  chiffre et ferait échouer le test des nombres. Lisible, mais sec.

### Traduire l'interface (02/11/2026)

**772 chaînes par langue**, 718 appels `trUi()` dans 53 fichiers.
`lib/data/ui_i18n.dart` porte le mécanisme, `ui_en.dart` et
`ui_es.dart` les dictionnaires.

**Pourquoi un dictionnaire et pas les ARB** — la raison est écrite en
tête de `ui_i18n.dart`, en trois points : la moitié de ces chaînes
vivent dans des services sans `BuildContext` (y faire descendre un
contexte, ce serait mélanger présentation et logique métier) ; nommer
772 clés produit 772 noms qui mentent à la première retouche ; et
c'est déjà le patron des trois autres surcouches. Les ARB gardent les
cinq onglets et la note du réglage « Langue ».

**Les chaînes composées ont des trous numérotés** :

```dart
trUiArgs('{0} ans avant de replanter au même endroit', <Object?>[3])
```

La place d'un trou est **libre** dans la traduction — c'est l'intérêt
par rapport à une concaténation, qui fige l'ordre des mots.

**Ce qui n'est pas dans le dictionnaire, et pourquoi** : les mois, les
jours et les 73 noms de pays. Les deux premiers parce qu'une clé ne
peut pas rendre deux valeurs (« juin » court et long, « Mar » mardi et
mars) ; les pays parce qu'un champ d'enum `const` ne peut pas appeler
de fonction — ils passent par `displayLabel`.

**L'outillage** :

```bash
python3 tool/exporter_interface.py --compte
flutter test tool/exporter_enums.dart     # les libellés d'enum
python3 tool/exporter_interface.py --squelette --langue=es --part=2/3
```

⚠️ **L'exportateur lit du code, pas des données**, donc il embarque un
vrai lecteur de chaînes Dart : une expression régulière se fait piéger
par `'l\'ail'` et par les littérales adjacentes que Dart colle en une.
Le test embarque le même lecteur, et tous deux ignorent les
commentaires — un commentaire qui citait `trUi()` avait été pris pour
un appel.

⚠️ **Ajouter une chaîne d'interface fait échouer la suite** jusqu'à ce
qu'elle soit traduite dans les deux langues. C'est voulu : une langue
enregistrée est une langue finie, sinon l'app panache deux langues
dans la même phrase.

### Voir un écran HTML sans le simulateur

Le simulateur rend bien l'écran depuis le 02/11/2026 (alerte 9), mais
pour un tuto ou une recette, qui sont du HTML, Chrome headless reste
plus rapide : pas de build, pas d'installation. ⚠️ À une réserve près,
apprise le 02/11 : **un asset rendu dans une WebView se vérifie dans la
WebView** — Chrome n'a pas de `NavigationDelegate`.

```bash
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  --headless=old --disable-gpu --hide-scrollbars \
  --window-size=500,880 --force-device-scale-factor=2 \
  --screenshot=sortie.png --virtual-time-budget=2500 "file://$PWD/page.html"
```

⚠️ **Trois pièges, tous rencontrés le 01/11/2026 :**

- `--window-size` est **ignoré pour la mise en page** : Chrome rend en
  **500 px** quoi qu'on demande, puis recadre la capture. Demander
  390 px donne une image coupée à droite qu'on prend pour un bug de
  l'app. Capturer en 500 de large.
- **Ne pas forcer `width: 390px` sur `body`** pour compenser : le pied
  de page du lecteur est en `position: fixed`, donc il suit la fenêtre
  et pas le corps — le bouton « Suivant » part hors cadre, et on croit
  qu'il manque.
- Le panneau navigateur de Claude Code **fige** les fichiers hors du
  projet (« static snapshots ») : le JavaScript ne tourne pas, la page
  sort vide. Et il n'a pas réussi à joindre un `http.server` local.
