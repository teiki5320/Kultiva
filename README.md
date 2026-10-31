# 🌱 Kultiva

> Le potager kawaii dans ta poche.

Une app Flutter de jardinage francophone, au style pastel kawaii japonais. Pensée pour les jardiniers amateurs de **France métropolitaine** et d'**Afrique de l'Ouest**, et pour faire jardiner les enfants. Du balcon au plein champ — des semis aux récoltes, du choix des graines à la fierté de la première tomate.

![Aperçu Kultiva](assets/images/onboarding_1.png)

## ✨ Ce qu'on y trouve

- 📅 **Calendrier de semis et de récolte**, mois par mois, adapté à ta région ; vue annuelle d'une ligne par légume, douze segments, sans défilement latéral
- 🌽 **Catalogue de 169 légumes, aromates, tubercules et accessoires** — fiches détaillées (semis, exposition, arrosage, rendement, conseils)
- 📔 **Cahier de culture** (2ᵉ onglet) : « à faire aujourd'hui » — qui a soif, qui est mûr, s'il va faire trop chaud — puis les jardins pleine terre, placement des plants par glisser-déposer, suivi par plant (arrosage, phase de croissance auto, photos), avertissement de rotation
- 📖 **Poussidex** : ta collection chronologique des plants en photos, avec notes, historique d'arrosage et compteur de récoltes
- 🌦️ **Météo + alertes d'arrosage** géolocalisées (via Open-Meteo, sans clé d'API)
- 🏅 **Défis photo** : 50 défis, 50 badges et médailles bronze / argent / or (les photos restent privées)
- 👨‍👩‍👧 **Pensé parent-enfant** : tutoriels, défis et badges adaptés à un usage en famille
- 🎓 **33 tutoriels HTML embarqués**, lexique technique, guide des maladies et compagnonnage
- 📴 **Aucun compte, aucun serveur** : tout reste sur l'appareil (comptes et synchronisation Supabase retirés le 30 octobre 2026)

L'app est **locale** : aucun compte, aucun serveur, rien ne quitte le téléphone. Les deux seuls appels sortants sont Open-Meteo (météo) et Sentry (plantages), tous deux non bloquants.

## 🌍 Régions supportées

- 🇫🇷 **France métropolitaine** — calendrier classique, alertes adaptées au climat tempéré
- 🌍 **Afrique de l'Ouest** — saisons sèches/pluies, légumes tropicaux (gombo, niébé, manioc, taro, igname, sorgho, bissap…)

Le choix se fait au premier lancement et peut être modifié à tout moment dans les paramètres.

## 🛠️ Stack technique

- **Flutter ≥ 3.47** / **Dart ^3.5** (canal stable) — borne relevée le
  30 octobre 2026 ; sous 3.41.6 le service PDF ne compile plus
- **Aucun backend** depuis le 30 octobre 2026 : les comptes ont été
  retirés de la v1, avec Supabase, Google Sign-In et Apple Sign-In
- **Open-Meteo** pour la météo (gratuit, sans clé)
- **Sentry** pour les plantages — le seul autre appel sortant
- Material3 + thèmes clair/sombre, `google_fonts` (Nunito), `flutter_local_notifications`, `geolocator`, `image_picker`, `audioplayers`, `pdf` + `printing`, `webview_flutter`
- **Auth** : aucune (comptes retirés le 30 octobre 2026)
- **iOS** : Xcode Cloud (`ios/ci_scripts/ci_post_clone.sh`)
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

Les strings UI sont **en français** uniquement (l'app est `fr-FR` à 100%). Les commentaires de code peuvent être en français ou en anglais selon le pattern dominant du fichier.

## 🌐 Sites compagnons

- **Landing marketing** — `landing/index.html` (site HTML statique)

## 📜 Licence

© Jean Perraudeau, 2026. Tous droits réservés. Pas (encore) de licence open-source explicite — pour toute utilisation au-delà du fork de découverte, contacte le mainteneur.
