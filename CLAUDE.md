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

## 📚 Consignes détaillées (à lire quand le sujet se présente)

Le détail a été rangé par sujet dans `docs/consignes/`. Avant de toucher à un de ces sujets, lis le fichier correspondant : il contient les décisions de Jean, les mesures et les pièges déjà rencontrés.

- Pour la stack technique, les dépendances et l'architecture des dossiers : lis `docs/consignes/architecture.md`.
- Pour le design, l'UX et la génération d'images (dont l'ancienne formule ComfyUI) : lis `docs/consignes/design-et-images.md`.
- Pour l'historique technique et les décisions passées : lis `docs/consignes/historique-technique.md`.
- Pour les alertes numérotées 0 à 17 (tests, simulateur iOS, JDK Android, ML Kit retiré, onglet Photo retiré… ; les alertes 18-19 sont dans garder-ta-recolte.md, 20-22 dans zones-et-calendriers.md, 23-26 dans menage-images.md) : lis `docs/consignes/alertes.md`.
- Pour les images embarquées, le ménage du 03/11/2026 et les alertes 23 à 26 (dont le plantage Android en release) : lis `docs/consignes/menage-images.md`.
- Pour l'émulateur Android (captures Google Play), l'iPad et l'iPhone Duo : lis `docs/consignes/appareils.md`.
- Pour Sentry : lis `docs/consignes/sentry.md`.
- Pour la compatibilité avec d'anciennes données (décision « zéro installation ») : lis `docs/consignes/zero-installation.md`.
- Pour les zones climatiques, les régions, les calendriers de semis et la vérification des 73 pays (alertes 20 à 22) : lis `docs/consignes/zones-et-calendriers.md`.
- Pour la traduction (catalogue, recettes, tutos, interface) et pour voir un écran HTML sans le simulateur : lis `docs/consignes/traduction.md`.
- Pour les fiches d'accessoires : lis `docs/consignes/accessoires.md`.
- Pour l'onglet « Garder ta récolte », les recettes et le lecteur de recettes (alertes 18 et 19) : lis `docs/consignes/garder-ta-recolte.md`.

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
  avant tout commit (commit et push directs sur `main`, sans pull request).
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
6. **Avant tout push** (commit et push directs sur `main`, sans pull request) : `flutter analyze` + `flutter test` doivent passer.
7. **Tests** : pour un nouveau modèle, ajouter `test/<nom>_test.dart` sur le
   pattern existant (voir `vegetable_test.dart`).
8. **Navigation** : rester sur `Navigator.push` / `showModalBottomSheet`. Pas
   de package de routing.
9. **Services externes** : privilégier les APIs gratuites sans clé (cf
   Open-Meteo) quand c'est possible.
10. **Brancher ce qu'on écrit** : un écran, un service ou un conseiller
    qu'aucun chemin de l'app n'atteint est un bug, pas une avance. Quatre
    fonctionnalités annoncées ont déjà été livrées sans être reliées.

## Fiches à jour à chaque changement (règle de Jean, 22 octobre 2026)

Le Studio de Jean affiche les fiches de ce dépôt (docs/INFRA.md, docs/MARKETING.md, docs/PUBLICATION.md) et le README. Elles doivent toujours dire la vérité d'aujourd'hui.

- Dès qu'un travail change un fait affiché par ces fiches — version envoyée ou en ligne (App Store, Google Play, site), date de mise en ligne, hébergement ou domaine, service ajouté ou retiré, code Amazon Partenaires, état AdSense ou Pinterest, monétisation, nombre de contenus publiés —, mets à jour **dans le même envoi** toutes les phrases concernées des trois fiches (En bref, Parcours, Boutiques, Vue d'ensemble, Ce qui reste…) et du README.
- Une ancienne valeur ne reste qu'au passé, datée (« la 1.0.4 a été mise en ligne le 15 octobre »).
- Ne recopie jamais de secret ni de clé dans ces fichiers.
- Chaque matin, la tâche « Fiches Mes Apps » du Studio vérifie derrière toi, compare les versions avec ce que servent réellement les boutiques et signale toute phrase fausse.

## Garde-fou de version (depuis le 10 novembre 2026)

Même mécanisme que dans Erea : Apple ferme une version approuvée à tout
nouveau build (ITMS-90186 et ITMS-90062), et chaque poussée suivante finit en
build Xcode Cloud échoué. Deux hooks git versionnés dans `.githooks/`, qui
s'appuient sur `scripts/garde-version.sh` et sur
[`version-approuvee.txt`](version-approuvee.txt) (dernière version de Kultiva
approuvée par Apple ou Google, et son numéro de build).

- **`pre-commit`** : si `pubspec.yaml` porte une version égale ou plus
  ancienne que celle de `version-approuvee.txt`, ou un numéro de build qui ne
  la dépasse pas, il la monte lui-même (patch +1, build +1) **dans le même
  commit**.
  Il recopie aussi la nouvelle version dans `lib/config/app_info.dart`
  (`AppInfo.version`, copie volontaire de `pubspec.yaml`) et l'ajoute au
  commit, pour que l'écran des réglages ne devienne pas faux.
- **`pre-push`** : filet de sécurité. Il refuse de pousser sur `main` un
  commit dont la version est périmée et indique la commande de correction :
  `scripts/garde-version.sh --corriger`, puis commit et nouvelle poussée.

**À faire une fois par clone** : `scripts/installer-hooks.sh` (règle
`core.hooksPath` sur `.githooks`).

**Le déclencheur est `version-approuvee.txt`** : le hook ne sait pas qu'Apple
a approuvé une version, il faut le lui dire. **Quand une version est
approuvée (ou publiée sur Google Play), mets ce fichier à jour dans le même
commit que les fiches** : le hook monte alors la version dans ce commit. Après
une montée automatique, saisis la nouvelle version dans App Store Connect
avant de soumettre : elle doit être identique à celle de `pubspec.yaml`.

*État au 10 novembre 2026 : `version-approuvee.txt` vaut `1.0.0` (build 5) : la 1.0.0 est validée par Apple depuis le 6 novembre, publication en attente. Le prochain commit monte donc `pubspec.yaml` en `1.0.1+6`, sans toucher à la 1.0.0 qui attend sa publication dans App Store Connect.*

Limites : les hooks tournent sur la machine qui commit, pas sur Xcode Cloud ni
sur l'interface web de GitHub ; `git commit --no-verify` contourne le
`pre-commit`, `git push --no-verify` le `pre-push`. Pendant un rebase, un
merge ou un cherry-pick, le `pre-commit` ne touche à rien.
