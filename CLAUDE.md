# Kultiva

> Documentation pour futures sessions Claude Code.
> Dernière mise à jour : 2026-04-22.

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

**Statut** : en phase de polish pré-publication — la CI iOS (Xcode Cloud) est
branchée, la config de signing Android est active, la landing page marketing
est prête et la conformité Amazon Associates est en place. Aucune issue
GitHub ouverte à ce jour.

## 🛠️ Stack technique

**Frontend / mobile**

- Flutter **≥3.24** / Dart **^3.5** (canal `stable`)
- Material3, thèmes clair et sombre
- `google_fonts` — typographie **Nunito**
- `shared_preferences` — persistance locale
- `go_router` — déclaré mais non utilisé en v1 (navigation via `Navigator`)
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
  (`plant-photos`) ; aucun edge function
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
- Lints : `flutter_lints` ^5.0 + règles custom (`prefer_const_constructors`,
  `prefer_const_literals_to_create_immutables`, `avoid_print`,
  `use_key_in_widget_constructors`)
- Tests : `flutter_test` (unitaires uniquement pour l'instant)

## 📁 Architecture

```
Kultiva/
├── lib/                    # Code Dart principal (~24 685 LoC sur 68 fichiers)
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
│   │                               # tuto_fiche (WebView), poussidex/*
│   ├── models/             # plantation, vegetable, region_data, medal,
│   │                       # weather_data, tamassi_visitor, photo_pick_result
│   ├── services/           # auth, prefs, cloud_sync, weather, geolocation,
│   │                       # notification, photo, audio, watering, feed,
│   │                       # pdf, tamassi_stats, plantation_migration
│   ├── data/               # Catalogues statiques (français)
│   │   ├── vegetables_base.dart    # ~100 entrées
│   │   ├── badges.dart / challenges.dart / diseases.dart
│   │   ├── companions.dart / rotation.dart / lexicon.dart
│   │   └── regions/        # france.dart, west_africa.dart
│   ├── theme/
│   │   └── app_theme.dart  # KultivaColors, thèmes Material3 light/dark
│   ├── widgets/            # plant_creature (55 Ko), badge_card (34 Ko),
│   │                       # petal_animation, season_header, share_card, etc.
│   └── utils/              # category_colors, months
├── supabase/
│   └── migrations/         # 001_initial_schema → 004_tamassi_visitors
├── assets/
│   ├── images/             # creatures, badges (50), accessories (38),
│   │                       # backgrounds saisonniers + time-of-day, cards,
│   │                       # onboarding, app_icon
│   ├── sounds/             # 8 SFX
│   └── tutos/              # 34 fichiers + screens/
├── android/                # app/build.gradle.kts, key.properties (ignoré)
├── ios/                    # Podfile, Runner, ci_scripts/, entitlements
├── landing/                # Site HTML statique marketing (index.html + img/)
├── test/                   # badges_test, medals_test, plantation_test,
│                           # vegetable_test, widget_test (stub) — 631 LoC
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
- **Navigation** : `Navigator.push` et `showModalBottomSheet`. `go_router` est
  importé mais inutilisé — ne pas s'appuyer dessus sans migration explicite.
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
  (`005_*.sql`, etc.). Ne jamais modifier une migration existante.
- **Dépendances** : toute nouvelle dépendance mérite un commentaire inline dans
  `pubspec.yaml` expliquant son usage (pattern observé).

## ⚡ Commandes utiles

### 🚀 Lancer l'app sur le Mac de Jean (routine quotidienne)

Le projet est sur **`~/Kultiva`** (Mac-mini-de-Jean). Branche de travail
courante : **`main`**. Commande à donner systématiquement après une modif
poussée par Claude Code :

```bash
cd ~/Kultiva && git stash && git pull origin main && flutter pub get && flutter run --release
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

**Style commun (suffixe à concaténer derrière chaque sujet) :**

```
plain object, isolated, soft pastel colors, cream beige solid background, simple rounded shapes, clean line art, soft shading, app icon style, centered, 1:1 square
```

**Préfixe à mettre devant chaque sujet :**

```
flat pastel illustration of a
```

⚠️ **Pas de negative prompt disponible côté ComfyUI** — il faut tout baker
dans le positif. Donc on **N'AJOUTE PAS** : « kawaii character », « cute
chibi », « smiling face », « big sparkly eyes », « mascot ». Ces termes
créent des créatures anthropomorphisées au lieu de légumes lisibles. Les
images cibles sont du style **« légume joliment dessiné en pastel »**
(comme les 38 accessoires existants), pas des mascottes à yeux.

**Negative prompt (si workflow le permet) :**

```
realistic, photo, photography, 3d render, dark, scary, gloomy, harsh shadows, complex background, text, watermark, logo, low quality, blurry, multiple subjects, distorted, anthropomorphic, character, mascot, eyes, face, mouth, smiling, chibi creature, kawaii character
```

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
  (17 → 21), `geolocator` (11 → 14), ou `go_router` (12 → 17) sans plan de
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

Décisions et évolutions significatives déduites des 20 derniers commits :

- **Xcode Cloud** branché côté iOS via `ci_post_clone.sh` (clone Flutter stable,
  précache, pub get, pod install).
- **Dashboard onboarding** reconfiguré : tuto statique remplacé par animation
  kawaii dans une WebView centrée.
- **38 images d'accessoires** kawaii câblées avec fallback emoji ; `.gitkeep`
  ajouté pour tracker le dossier vide.
- **Android** : signing release wiré via `key.properties` ; chemin keystore
  corrigé (`rootProject.file` plutôt que `file`) ; core library desugaring
  activé pour supporter `flutter_local_notifications` 17+.
- **Permissions iOS** : correctifs sur l'ouverture caméra après grant, et
  gestion de la géolocalisation refusée avec fallback Paris.
- **Météo** : nom de ville affiché dans le header, bouton rafraîchir ajouté,
  mois en overlap retiré.
- **Amazon Associates** : mention « Lien partenaire » visible + bouton agrandi
  pour conformité du programme d'affiliation.
- **Tutos** : `reussir_semis` repassé en HTML pur (suppression du PDF et du
  viewer PNG pour simplifier).

## 💬 Instructions pour Claude Code

Règles spécifiques au projet pour être efficace dès la première action :

1. **Respecter le contrat local-first** : ne jamais introduire d'appel réseau
   bloquant dans un flux UI. Synchro cloud = arrière-plan uniquement.
2. **Migrations** : toujours créer un nouveau fichier `supabase/migrations/005_*.sql`,
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
8. **Navigation** : rester sur `Navigator.push` / `showModalBottomSheet`. Ne
   pas activer `go_router` sans migration complète.
9. **Services externes** : privilégier les APIs gratuites sans clé (cf
   Open-Meteo) quand c'est possible.
10. **Créer une migration** quand on touche au schéma, pas un ALTER à la volée
    côté code.

## ⚠️ Alertes

À signaler à l'utilisateur / à traiter dans un futur ticket :

1. **`README.md` sévèrement obsolète** — il décrit une « v1 » avec
   `AuthService` en démo locale et 4 fonctionnalités, alors que la v2 actuelle
   inclut Supabase, Poussidex, Tamassi, météo, OAuth Google/Apple, feed
   communautaire, notifications locales. À réécrire.
2. **`go_router` est une dépendance morte** — importée (`^12.0.0`) mais aucune
   route enregistrée. Soit l'activer, soit la retirer.
3. **Aucun test de widget ni d'intégration** — seuls les modèles et les
   données sont couverts (631 LoC sur 24 685 LoC de code source).
4. **Aucune CI GitHub Actions** — seul Xcode Cloud tourne côté iOS. Pas de
   vérification automatique de `flutter analyze` / `flutter test` sur les PR.
5. **Aucun edge function Supabase** — toute la logique métier (XP, likes,
   modération du feed) est côté Dart, donc contournable si quelqu'un
   interroge l'API directement.
6. **L'`anonKey` Supabase est committée dans `lib/config/supabase_config.dart`** —
   c'est correct pour une anon key JWT publique, mais à documenter pour éviter
   tout doute.
7. **Commits dominés par Claude** (192 sur 238) — vérifier que les revues
   humaines restent régulières pour éviter les dérives stylistiques.
