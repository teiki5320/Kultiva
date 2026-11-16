# Kultiva : historique technique

> Texte déplacé tel quel depuis `CLAUDE.md` le 16 novembre 2026, pour alléger les consignes lues à chaque session. Rien n'a été réécrit.

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
- **Cahier en pile, Conservation par meuble (06/11/2026)** — deux
  maquettes validées par Jean sur le canvas Design (« C4c · La pile du
  jour » et « F · Les portes qui s'ouvrent »).
  - **Cahier** : `CahierTodayCard` devient une **pile de post-it**, une
    tâche à la fois. Glisser à droite **écrit** (arrosage par
    `waterMany`, récolte par `harvest`), à gauche remet à demain.
    « Plus tard » ne vit que la journée et la session (ensembles
    statiques), volontairement : pas de nouvelle préférence pour un
    report d'un jour. ⚠️ `_regler` est **synchrone** : un `Dismissible`
    glissé doit quitter l'arbre dans la même image.
    `CahierPlantsSection` range les plants en **trois colonnes**
    (levée / croissance / récolte) d'après `expectedStage`.
  - **Conservation** : trois meubles en tête de liste
    (`widgets/storage_doors.dart`), dont les portes s'entrouvrent à
    tour de rôle ; celle qu'on touche s'ouvre et pose ses bocaux sur
    une étagère (`StorageShelf`), et la liste ne garde que ce qui s'y
    range. Le meuble se **lit dans `Recipe.keeps`**
    (`utils/storage_place.dart`) : 167 congélateur, 96 réfrigérateur,
    106 placard. « au sec » l'emporte sur « au frais » (un cellier),
    et rien de ce qui est dans l'huile ne va au placard —
    `test/storage_place_test.dart` le vérifie.
  - Les animations d'attente s'arrêtent avec
    `MediaQuery.disableAnimations`.
  - **Compilé, testé et complété le 07/11/2026.** La session du 06/11
    n'avait ni Flutter ni pub.dev : son code n'avait jamais été
    compilé. Il l'était pourtant juste — `analyze` propre et les
    1 160 tests verts dès le premier passage. Ce qui manquait, c'était
    la **couverture** : rien ne glissait un `Dismissible`.
  - **Ce qui a été ajouté pour finir les deux maquettes** : le journal
    en **éventail** de trois post-it (−14° / 0° / +14°, le plus récent
    au-dessus, couleur selon le geste), les **jardins en post-it**
    pastel, et sous l'étagère la carte **« DE SAISON · AU JARDIN »**
    avec son bouton « C'est parti » qui ouvre le pas-à-pas. L'aperçu
    de grille **reste** dans la carte de jardin : la maquette ne le
    montrait pas, mais c'est lui qui distingue deux potagers d'un
    coup d'œil.
  - ⚠️ **Un seul propriétaire pour le journal** : l'éventail et la
    liste datée lisent la même fonction, `journalEvents()`, remontée
    publique dans `journal_view.dart`. Deux lecteurs du même registre,
    pas deux registres.
  - ⚠️ **Trois pièges du test de glissement**, qu'aucune lecture
    n'aurait donnés : `pumpAndSettle` **n'expire jamais** sur ces
    écrans (les pétales du bandeau de saison tournent en boucle, donc
    `pump()` explicites) ; les ensembles « fait / plus tard » sont
    **statiques**, donc un test vidait la pile du suivant (d'où
    `CahierTodayCard.resetForTesting`) ; et la pile porte **plusieurs**
    tâches, donc la bonne assertion est « la clé a changé », pas « la
    pile est vide ».
  - ⚠️ **Le cahier est un `ListView` paresseux** : trois tests sont
    tombés parce que les widgets passés sous la ligne de flottaison
    n'étaient jamais construits. Il faut faire défiler dans le test.
  - ⚠️ **Et c'est l'écran qui a trouvé le vrai défaut, pas les
    tests.** L'éventail sortait par la gauche, deux post-it coupés
    par le bord. Cause : la colonne du cahier est en
    `CrossAxisAlignment.start`, donc une boîte **sans largeur** se
    réduit à son contenu et se colle à gauche — il manquait
    `width: double.infinity`. Ni `analyze` ni les 1 169 tests ne
    pouvaient le voir : aucun ne regarde **où** une boîte est
    dessinée. Deuxième passe à l'écran, deuxième défaut : à 34 points
    d'écart les post-it se coupaient un mot l'un l'autre
    (« Arrosé 🍅 Tom »). Le décalage est passé à 46.
  - **Vérifié sur simulateur le 07/11/2026** : pile, trois colonnes,
    éventail, post-it de jardin, les trois meubles, l'étagère, la
    carte « De saison · au jardin » et son bouton qui ouvre bien le
    pas-à-pas. En clair et en **sombre**, à police normale et à
    **1,3** : rien n'est coupé, les pastilles passent à la ligne, et
    le papier des post-it reste clair avec du texte foncé en mode
    sombre, comme le veut le système de design.
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
