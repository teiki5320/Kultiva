# 🌱 Kultiva

> Le potager kawaii dans ta poche.

Une app Flutter de jardinage au style pastel kawaii japonais, en **français et en anglais**. Pensée d'abord pour les jardiniers amateurs de **France métropolitaine**, et ouverte depuis le 1er novembre 2026 à **73 pays sur six continents**. Du balcon au plein champ — des semis aux récoltes, du choix des graines à la fierté de la première tomate.

![Aperçu Kultiva](assets/images/onboarding_1.png)

## ✨ Ce qu'on y trouve

- 📅 **Calendrier de semis et de récolte**, mois par mois, adapté à ta région ; vue annuelle d'une ligne par légume, douze segments, sans défilement latéral
- 🌽 **Catalogue de 169 légumes, aromates, tubercules et accessoires** — fiches détaillées (semis, exposition, arrosage, rendement, conseils)
- 📷 **Onglet Photo** : toutes les photos du jardin par mois, et l'évolution de chaque plant — sa première photo et la dernière côte à côte, avec les jours qui les séparent. Photographier un plant ouvre sa **fiche conseil** : où il en est, et quoi faire maintenant. Depuis le 1er novembre 2026 — **à l'essai** — un modèle embarqué y cherche une fleur, un fruit ou du feuillage pour *proposer* le stade ; il ne décide jamais à ta place, et la photo ne quitte pas le téléphone
- 🍽️ **Onglet Recettes** : 340 recettes, trois par récolte, dont huit déroulées pas à pas en animation ; les légumes de ton jardin passent en tête
- 📔 **Cahier de culture** (2ᵉ onglet) : « à faire aujourd'hui » — qui a soif, qui est mûr, s'il va faire trop chaud — puis les jardins pleine terre, placement des plants par glisser-déposer, suivi par plant (arrosage, phase de croissance auto, photos), avertissement de rotation
- 📖 **Journal du jardin** : plantations, arrosages, récoltes et photos inscrits à leur date, jour par jour, dans le cahier de culture
- 🌦️ **Météo + alertes d'arrosage** géolocalisées (via Open-Meteo, sans clé d'API)
- 🏅 **Défis photo** : 50 défis, 50 badges et médailles bronze / argent / or (les photos restent privées)
- 👨‍👩‍👧 **Pensé parent-enfant** : tutoriels, défis et badges adaptés à un usage en famille
- 🎓 **33 tutoriels HTML embarqués**, lexique technique, guide des maladies et compagnonnage
- 📴 **Aucun compte, aucun serveur** : tout reste sur l'appareil (comptes et synchronisation Supabase retirés le 30 octobre 2026)

L'app est **locale** : aucun compte, aucun serveur, rien ne quitte le téléphone. Les deux seuls appels sortants sont Open-Meteo (météo) et Sentry (plantages), tous deux non bloquants.

## 🌍 Pays supportés

**73 pays, six continents** depuis le 1er novembre 2026. Deux bases de
calendrier — tempérée et tropicale — qu'une **zone climatique** affine
et qu'un **hémisphère** retourne :

- 🇫🇷 **France métropolitaine** — le calendrier de référence, climat tempéré
- 🌍 **Afrique de l'Ouest** (8 pays) — saisons sèches et pluies, légumes
  tropicaux (gombo, niébé, manioc, taro, igname, sorgho, bissap…), noms
  locaux, maraîchage en FCFA, conseils d'achat au marché
- 🇪🇺 **Europe, Maghreb, Proche-Orient** — zones méditerranéenne,
  continentale et océanique
- 🌎 **Amériques, Asie, Océanie** et l'**outre-mer français** (Réunion,
  Antilles, Guyane, Mayotte, Nouvelle-Calédonie, Polynésie)

Au sud de l'équateur, les calendriers sont décalés de six mois.

⚠️ Les calendriers des zones ajoutées en novembre 2026 sont **dérivés**
de la base tempérée par décalage, pas écrits un par un. L'app le dit
sous chaque calendrier concerné et invite à ajuster sur les gelées
locales. Les affiner culture par culture reste à faire.

Le pays se choisit au premier lancement (avec recherche) et se modifie
à tout moment dans les paramètres.

## 🗣️ Langues

- 🇫🇷 **Français** — la source, tout y est
- 🇬🇧 **Anglais** — l'interface et les noms des 130 cultures

Les 33 tutos, les 340 recettes, les conseils, les maladies, les badges
et les défis restent en français. Le réglage **Langue** des paramètres
le dit, et permet de revenir au français même sur un téléphone
anglophone.

## 🛠️ Stack technique

- **Flutter ≥ 3.47** / **Dart ^3.5** (canal stable) — borne relevée le
  30 octobre 2026 ; sous 3.41.6 le service PDF ne compile plus
- **Aucun backend** depuis le 30 octobre 2026 : les comptes ont été
  retirés de la v1, avec Supabase, Google Sign-In et Apple Sign-In
- **Open-Meteo** pour la météo (gratuit, sans clé)
- **Sentry** pour les plantages — le seul autre appel sortant
- **ML Kit** (`google_mlkit_image_labeling`) pour lire le stade d'un
  plant sur sa photo — modèle embarqué, sur l'appareil, hors ligne,
  sans clé. ⚠️ **À l'essai** depuis le 1er novembre 2026 : +12,8 Mio au
  téléchargement et iOS 15.5 exigé ; l'adopter n'est pas tranché
- Material3 + thèmes clair/sombre, `google_fonts` (Nunito), `flutter_local_notifications`, `geolocator`, `image_picker`, `audioplayers`, `pdf` + `printing`, `webview_flutter`
- **Auth** : aucune (comptes retirés le 30 octobre 2026)
- **iOS** : Xcode Cloud (`ios/ci_scripts/ci_post_clone.sh`), cible
  minimale **iOS 15.5** depuis le 1er novembre 2026
- **Android** : Gradle 8.14, signing release via `key.properties`, core library desugaring activé

## 🚀 Démarrage rapide

```bash
git clone https://github.com/teiki5320/Kultiva.git
cd Kultiva
flutter pub get
flutter run               # debug
flutter run --release     # mode release sur device
```

Pour iOS (après `pub get`) :

```bash
cd ios && pod install --repo-update && cd ..
```

Routine quotidienne sur le Mac de Jean après une modif côté Claude Code (branche `main`) :

```bash
cd ~/Dev/apps/kultiva && git stash && git pull origin main && flutter pub get && flutter run --release
```

## 📦 Build de release

```bash
# Android — Google Play
flutter build appbundle --release

# iOS — TestFlight (signer ensuite via Xcode)
flutter build ios --release
```

L'app ID Android est `com.toa.kultiva`. Le signing release nécessite `android/key.properties` (non commité).

## ✅ Vérifs avant push

À chaque commit, la CI GitHub Actions lance automatiquement `flutter analyze` et `flutter test`. Pour les vérifier en local :

```bash
flutter analyze
flutter test
```

## 📐 Architecture

Voir **`CLAUDE.md`** à la racine pour le détail :

- arborescence complète de `lib/`
- conventions de code (state via `ValueNotifier`, pas de Provider/Riverpod)
- contrat local-only (aucun réseau bloquant)
- migrations Supabase, conservées à titre d'historique seulement
- pièges à éviter (versions pinées, assets à déclarer dans `pubspec.yaml`…)

Le **catalogue d'espèces** vit entièrement dans l'app. Source de vérité : `lib/data/vegetables_base.dart` (169 entrées : 130 cultures + 39 accessoires).

## 🤝 Contribuer

Les chantiers en cours et à venir sont listés dans **`_plans/roadmap.md`**.

Le **français est la source** : toute chaîne nouvelle s'écrit en français d'abord, dans `lib/l10n/app_fr.arb`, puis se traduit dans `app_en.arb` (`flutter gen-l10n`). Les noms des cultures passent par `lib/data/names_en.dart` et `v.displayName` — **`v.name` reste le nom français**, c'est la source de vérité des clés, de la recherche sans accent et des tests. Tutos, recettes, conseils, maladies, badges et défis sont encore en français seulement. Les commentaires de code peuvent être en français ou en anglais selon le pattern dominant du fichier.

## 🌐 Sites compagnons

- **Landing marketing** — `landing/index.html` (site HTML statique)

## 📜 Licence

© Jean Perraudeau, 2026. Tous droits réservés. Pas (encore) de licence open-source explicite — pour toute utilisation au-delà du fork de découverte, contacte le mainteneur.
