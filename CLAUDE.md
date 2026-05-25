# Kultiva

> Documentation pour futures sessions Claude Code.
> Dernière mise à jour : 2026-05-25.

## 🎯 Contexte

**Kultiva** est une application mobile Flutter de jardinage francophone, au style
pastel kawaii japonais. Elle s'adresse aux jardiniers amateurs de **France
métropolitaine** et d'**Afrique de l'Ouest**, et couvre :

- un calendrier mensuel de semis et de récolte adapté à la région ;
- un **catalogue** d'une centaine de légumes, aromates, tubercules et accessoires ;
- le **Poussidex** : collection chronologique des plants de l'utilisateur, avec
  photos, notes, historique d'arrosage et compteur de récoltes ;
- **Tamassi** : créature virtuelle animée qui évolue avec l'activité au jardin
  (XP, niveaux, émotions) ;
- des **alertes météo + arrosage** basées sur la géolocalisation et l'API
  Open-Meteo (gratuite, sans clé) ;
- un **feed communautaire** de défis photo (badges, médailles, likes) ;
- de la gamification : badges, défis, médailles bronze/argent/or par légume ;
- une synchronisation **cloud facultative** via Supabase (auth + Postgres +
  Storage) ;
- des tutoriels HTML embarqués, un lexique, un guide de maladies et de
  compagnonnage.

**Statut** : en phase de polish pré-publication. La CI GitHub Actions
(`flutter analyze` + `flutter test`) est branchée et passe à 0 issues.
Xcode Cloud est actif côté iOS. La config signing Android est en place. La
landing page marketing est prête (liens stores à remplir). La conformité
Amazon Associates est active.

## 🛠️ Stack technique

**Frontend / mobile**

- Flutter **≥3.24** / Dart **^3.5** (canal `stable`)
- Material3, thèmes clair et sombre
- `google_fonts` — typographie **Nunito**
- `shared_preferences` — persistance locale
- `url_launcher` — liens affiliés Amazon
- `flutter_local_notifications` ^17.2.3 + `timezone` — rappels mensuels,
  quotidiens (Tamassi) et d'arrosage
- `pdf` + `printing` — export PDF du calendrier
- `geolocator` + `geocoding` — détection régionale + nom de ville
- `permission_handler` — permissions caméra / localisation
- `http` — appels Open-Meteo
- `audioplayers` — SFX et musique de fond
- `image_picker` + `path_provider` — caméra / galerie et stockage local
- `share_plus` — partage Instagram / social
- `sensors_plus` — accéléromètre / gyroscope (animations de la créature)
- `webview_flutter` — tutoriels HTML

**Backend / services**

- **Supabase** (`supabase_flutter` ^2.5) — auth, Postgres, Storage
  (`plant-photos`) ; 1 edge function (`seed-species` pour sync catalogue)
- **Open-Meteo** — météo 7 jours, aucune clé d'API requise
- **Google Sign-In** (`google_sign_in` ^6.2) — OAuth natif
- **Apple Sign-In** (`sign_in_with_apple` ^6.1) avec nonce SHA-256 (`crypto`)

**Outillage / plateformes**

- Android : Gradle 8.14, Kotlin + Java 17, signing release via
  `android/key.properties`, core library desugaring activé, app ID
  `com.toa.kultiva`
- iOS : Xcode Cloud (`ios/ci_scripts/ci_post_clone.sh`), Apple Sign-In
  entitlement, URL scheme Google, permissions caméra / photos / localisation
  déclarées dans `Info.plist`
- CI : GitHub Actions (`flutter analyze` strict + `flutter test`),
  sync catalogue vers Supabase (`sync-catalog.yml`)
- Lints : `flutter_lints` ^5.0 + règles custom (`prefer_const_constructors`,
  `prefer_const_literals_to_create_immutables`, `avoid_print`,
  `use_key_in_widget_constructors`) ; `tool/` exclu de l'analyse
- Tests : `flutter_test` (8 fichiers — modèles et données)

## 📁 Architecture

```
Kultiva/
├── lib/                    # Code Dart principal (~31 000 LoC sur 83 fichiers)
│   ├── main.dart           # Bootstrap : splash → onboarding → auth → tabs
│   ├── config/
│   │   └── supabase_config.dart    # URL, anon key, Google OAuth client IDs
│   ├── screens/
│   │   ├── splash_screen.dart
│   │   ├── onboarding_screen.dart
│   │   ├── root_tabs.dart          # Conteneur 4 onglets (Bottom nav)
│   │   ├── vegetable_detail_screen.dart
│   │   ├── auth/                   # login_screen, register_screen
│   │   └── home/                   # sow, vegetables, my_garden, tutos,
│   │                               # settings, weather, calendrier mensuel,
│   │                               # tuto_fiche (WebView), poussidex/*,
│   │                               # garden_planner, culture_start, mes_jardins
│   ├── models/             # plantation, vegetable, region_data, culture_entry,
│   │                       # vegetable_medal, garden_plan
│   ├── services/           # auth, prefs, cloud_sync, weather, geolocation,
│   │                       # notification, photo, audio, watering, watering_advisor,
│   │                       # feed, pdf, tamassi_stats, plantation_migration,
│   │                       # culture_service, garden_plan_service
│   ├── data/               # Catalogues statiques (français)
│   │   ├── vegetables_base.dart    # ~100 entrées
│   │   ├── badges.dart / challenges.dart / diseases.dart
│   │   ├── companions.dart / rotation.dart / lexicon.dart
│   │   └── regions/        # france.dart, west_africa.dart
│   ├── theme/
│   │   └── app_theme.dart  # KultivaColors, thèmes Material3 light/dark
│   ├── widgets/            # plant_creature, badge_card, petal_animation,
│   │                       # season_header, share_card, challenge_story_card,
│   │                       # tamassi_story_card, watering_bars, etc.
│   └── utils/              # category_colors, months, phenology
├── tool/
│   └── export_catalog.dart # Script d'export catalogue → kultiva-catalog.json
├── supabase/
│   └── migrations/         # 001_initial_schema → 008_drop_hydro_tables
├── assets/
│   ├── images/             # creatures, badges (50), accessories (38),
│   │                       # backgrounds saisonniers + time-of-day, cards,
│   │                       # onboarding, app_icon
│   ├── sounds/             # 8 SFX
│   └── tutos/              # fichiers HTML embarqués
├── android/                # app/build.gradle.kts, key.properties (ignoré)
├── ios/                    # Podfile, Runner, ci_scripts/, entitlements
├── landing/                # Site HTML statique marketing (index.html + img/)
├── test/                   # 8 suites : badges, medals, plantation, vegetable,
│                           # culture_entry, garden_plan, phenology, widget (stub)
│                           # — ~988 LoC
├── .github/workflows/      # ci.yml (analyze + test), sync-catalog.yml
├── pubspec.yaml
├── analysis_options.yaml
└── README.md               # ⚠️ Obsolète — voir section Alertes
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

Triggers : `handle_new_user` (auto-profile), `touch_updated_at` (4 tables),
`update_likes_count` (compteur de likes). Bucket Storage : `plant-photos`.

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
- **Navigation** : `Navigator.push` et `showModalBottomSheet`. Ne pas
  introduire de router déclaratif sans migration explicite.
- **Lints** : `prefer_const_constructors`, `prefer_const_literals_to_create_immutables`,
  `avoid_print`, `use_key_in_widget_constructors`. `flutter analyze` doit
  passer à **0 issues** avant toute PR (CI strict, aucun `--no-fatal-*`).
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
- **Code mort** : supprimer plutôt que commenter. L'historique git conserve
  tout. Ne pas laisser de méthodes / classes inutilisées.

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

# Qualité (CI reproduit ces 2 étapes)
flutter analyze                     # doit passer à 0 issues
flutter test                        # tests unitaires dans test/

# Fix automatique des lints (const, imports, etc.)
dart fix --apply

# Builds de release
flutter build apk --release
flutter build appbundle --release   # Google Play
flutter build ios --release         # iOS (signer via Xcode)

# iOS local (après install)
cd ios && pod install --repo-update && cd ..

# CI iOS
# Xcode Cloud lance automatiquement ios/ci_scripts/ci_post_clone.sh :
#   flutter precache --ios && flutter pub get && pod install

# Android signing
# Nécessite un fichier android/key.properties (non commité) :
#   storeFile=...  storePassword=...  keyAlias=...  keyPassword=...

# Supabase
# Les migrations se trouvent dans supabase/migrations/ et sont appliquées
# manuellement via le dashboard Supabase (pas de supabase/config.toml).

# Export catalogue (utilisé par CI sync-catalog.yml)
dart run tool/export_catalog.dart   # → kultiva-catalog.json
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

**Pourquoi cette formule** :
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
  (17 → 21) ou `geolocator` (11 → 14) sans plan de migration. Ces pins sont
  intentionnels et documentés dans `pubspec.yaml`.
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
- **`flutter analyze` doit passer à 0** — la CI est en mode strict (fatal-infos
  + fatal-warnings). Lancer `dart fix --apply` pour corriger automatiquement
  les `prefer_const_*` et imports.

## 📝 Historique technique

Décisions et évolutions significatives :

- **CI GitHub Actions** ajoutée : `flutter analyze` strict (0 issues) +
  `flutter test` sur chaque push/PR vers main. Workflow `sync-catalog.yml`
  pour exporter le catalogue vers Supabase (Kultivaprix).
- **Nettoyage code mort** : ~580 lignes supprimées dans `my_garden_screen.dart`
  (méthodes CRUD plantation déplacées vers Poussidex, widgets _StarterButton /
  _ThirstyBanner / _DeleteModeBanner retirés), headers saisonniers morts dans
  `vegetables_screen.dart`, champs inutilisés partout. `dart fix --apply`
  appliqué sur 34 fichiers (217 `prefer_const_*` corrigés).
- **Hydroponie retirée** : tout le module (cultures, builds, readings) supprimé
  et archivé sur `archive/hydroponie-2026-05-03`. Migration 008 drop les tables.
- **Xcode Cloud** branché côté iOS via `ci_post_clone.sh` (clone Flutter stable,
  précache, pub get, pod install).
- **Dashboard** : tuto statique remplacé par animation kawaii ; carte Actualités
  avec lien Instagram.
- **38 images d'accessoires** kawaii câblées avec fallback emoji.
- **Android** : signing release via `key.properties` ; core library desugaring
  activé pour supporter `flutter_local_notifications` 17+.
- **Permissions iOS** : correctifs sur l'ouverture caméra après grant, et
  gestion de la géolocalisation refusée avec fallback Paris.
- **Météo** : nom de ville affiché dans le header, bouton rafraîchir.
- **Amazon Associates** : mention « Lien partenaire » visible + bouton agrandi.

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
6. **Avant toute PR** : `flutter analyze` (0 issues) + `flutter test` doivent
   passer. Utiliser `dart fix --apply` pour corriger les lints automatiquement.
7. **Tests** : pour un nouveau modèle, ajouter `test/<nom>_test.dart` sur le
   pattern existant (voir `vegetable_test.dart`).
8. **Navigation** : rester sur `Navigator.push` / `showModalBottomSheet`. Ne
   pas introduire de router déclaratif sans migration complète.
9. **Services externes** : privilégier les APIs gratuites sans clé (cf
   Open-Meteo) quand c'est possible.
10. **Créer une migration** quand on touche au schéma, pas un ALTER à la volée
    côté code.
11. **Code mort** : supprimer immédiatement. Ne pas commenter du code « pour
    plus tard » — l'historique git suffit.
12. **`BuildContext` après `await`** : toujours vérifier `mounted` (ou
    `context.mounted`) avant d'utiliser `context` après un appel asynchrone.

## ⚠️ Alertes

### 🔴 Bloquants publication App Store / Play Store

1. **Aucune Privacy Policy** — ni dans l'app, ni dans `landing/`. Obligatoire
   dès qu'il y a auth + photos. Créer `landing/privacy.html` et ajouter un
   lien dans l'app (Settings) et dans `landing/index.html`.
2. **Aucune CGU / Terms of Service** — Apple exige un lien EULA pour les apps
   avec création de compte. Même traitement que la privacy policy.
3. **Liens stores `href="#"`** dans `landing/index.html:146-147` — à remplacer
   par les vraies URLs App Store / Play Store avant lancement marketing.
4. **AndroidManifest.xml sans `<uses-permission>`** — les plugins Flutter
   (geolocator, image_picker, etc.) mergent leurs permissions via Gradle, mais
   il faut **valider sur device Android réel** que caméra, géoloc et notifs
   (POST_NOTIFICATIONS Android 13+) fonctionnent.

### 🟡 Importants avant v1.0

5. **`README.md` sévèrement obsolète** — il décrit une « v1 » avec
   `AuthService` en démo locale et 4 fonctionnalités. À réécrire.
6. **Aucun test de widget ni d'intégration** — seuls les modèles et les
   données sont couverts (988 LoC de test sur ~31 000 LoC de source).
7. **Aucune modération du feed** — `challenge_posts` est en lecture publique,
   pas de filtre server-side. Un user peut poster n'importe quoi. Besoin
   d'un edge function de modération ou d'un système de signalement.
8. **Aucune validation server-side** — RLS protège l'accès mais aucune
   contrainte de taille (notes, photos). Un user motivé peut spammer le storage.
9. **Pas de cache météo** — Open-Meteo refetch à chaque ouverture de l'écran.
   Pas de TTL local → spinner infini si réseau down.
10. **Timer carrousel** dans `sow_screen.dart` — `Timer.periodic(6s)` continue
    de tourner même quand l'écran n'est pas affiché. À brancher sur le
    lifecycle du widget.
11. **Instagram URL placeholder** — `sow_screen.dart:30` : TODO « remplacer
    par le vrai pseudo Kultiva ».
12. **Zéro accessibilité** — pas de `Semantics`, pas de support
    `textScaleFactor`. À tester avec VoiceOver / TalkBack avant soumission.
13. **i18n** — 100 % français hardcodé, pas de `intl` / `app_localizations`.
    OK si lancement FR-only assumé, sinon refacto complète requise.

### 🟢 Backlog

14. Retry exponential pour `CloudSyncService` (actuellement fire-and-forget).
15. Edge functions Supabase pour XP / likes (évite le contournement client).
16. Compression d'images avant upload Storage.
17. `go_router` (^12.0.0) est importé mais inutilisé — soit l'activer, soit le
    retirer du `pubspec.yaml`.
18. L'`anonKey` Supabase est committée dans `lib/config/supabase_config.dart` —
    correct pour une anon key JWT publique, documenté ici pour éviter le doute.
19. Commits dominés par Claude (109 sur 160) — vérifier que les revues
    humaines restent régulières.
