# Kultiva : stack technique et architecture

> Texte déplacé tel quel depuis `CLAUDE.md` le 16 novembre 2026, pour alléger les consignes lues à chaque session. Rien n'a été réécrit.

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
├── test/                   # 56 fichiers — 1 183 tests (09/11/2026)
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
