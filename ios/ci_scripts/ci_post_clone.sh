#!/bin/sh
# ci_post_clone.sh — Xcode Cloud build prep for Flutter apps
#
# Xcode Cloud clone le repo puis lance direct `xcodebuild archive`. Sans
# intervention, ça échoue car Flutter n'a pas tourné : Generated.xcconfig,
# GeneratedPluginRegistrant et les Pods n'existent pas.
#
# Ce script tourne juste après le clone (hook "ci_post_clone") :
#  1. Installe Flutter à la version ÉPINGLÉE (la même que ci.yml —
#     un `stable` flottant a déjà cassé le Build 61 : le runner peut
#     récupérer un Flutter plus récent que celui validé, avec une
#     gestion des plugins iOS différente → « Module 'app_links' not
#     found »)
#  2. Lance `flutter precache --ios`
#  3. Lance `flutter pub get`
#  4. Lance `flutter build ios --config-only` (génère Generated.xcconfig,
#     GeneratedPluginRegistrant et la liste de plugins exactement comme
#     un vrai build)
#  5. Lance `pod install` (génère les xcfilelist)
#
# Doit vivre dans `ios/ci_scripts/` (même niveau que Runner.xcodeproj)
# pour que Xcode Cloud le trouve automatiquement.

set -e

# ⚠️ Garder synchronisé avec FLUTTER_VERSION dans .github/workflows/ci.yml
# et avec le Flutter installé sur le Mac. Le 30/10/2026, ce pin était
# resté en 3.41.6 alors que le code avait avancé : `pdf_service.dart`
# n'y compile plus (13 erreurs d'évaluation de constantes), ce qui
# faisait échouer la phase de script du Runner — builds 122 et 125
# rouges, sans rapport apparent avec la cause. Un pin trop vieux casse
# aussi sûrement qu'un `stable` flottant.
FLUTTER_VERSION="3.47.3"

echo "🦋 Xcode Cloud — Flutter setup start"

# Xcode Cloud fournit $CI_PRIMARY_REPOSITORY_PATH = racine du repo.
cd "$CI_PRIMARY_REPOSITORY_PATH"

FLUTTER_DIR="$HOME/flutter"

# Clone (ou met à jour) Flutter à la version épinglée. Le dossier peut
# être en cache sur le runner avec une AUTRE version : on force le
# checkout du tag voulu dans tous les cas.
if [ ! -d "$FLUTTER_DIR" ]; then
  echo "📥 Installing Flutter $FLUTTER_VERSION..."
  git clone https://github.com/flutter/flutter.git --depth 1 \
    -b "$FLUTTER_VERSION" "$FLUTTER_DIR"
else
  echo "♻️  Flutter dir en cache — checkout $FLUTTER_VERSION"
  git -C "$FLUTTER_DIR" fetch --depth 1 origin tag "$FLUTTER_VERSION" || true
  git -C "$FLUTTER_DIR" checkout "$FLUTTER_VERSION" || {
    echo "⚠️  Checkout impossible, re-clone propre"
    rm -rf "$FLUTTER_DIR"
    git clone https://github.com/flutter/flutter.git --depth 1 \
      -b "$FLUTTER_VERSION" "$FLUTTER_DIR"
  }
fi

export PATH="$FLUTTER_DIR/bin:$PATH"

echo "ℹ️  Flutter version:"
flutter --version

# Le projet iOS est intégré via CocoaPods : on désactive explicitement
# le mode Swift Package Manager (activé par défaut sur les Flutter
# récents) pour que les plugins passent bien par `pod install`.
#
# ⚠️ À rouvrir un jour. Des plugins commencent à abandonner CocoaPods :
# `sentry_flutter` 10 ne fournit plus de podspec, seulement un
# `Package.swift`. Avec SPM désactivé, un tel plugin disparaît
# silencieusement du build iOS — le `Podfile.lock` n'en porte plus
# trace et le crash reporting cesse d'être embarqué, sans qu'aucune
# étape n'échoue. C'est pour cela que le projet est resté en
# sentry_flutter 9 (voir `pubspec.yaml`).
#
# Basculer demande trois choses ensemble : passer cette ligne à
# `--enable-swift-package-manager`, laisser `flutter build ios` migrer
# `project.pbxproj` et le scheme, puis **vérifier un vrai build iOS**.
# Essayé le 30/10/2026, annulé : la machine de développement n'a aucun
# runtime iOS installé, donc rien n'était vérifiable, et migrer un
# système de build à l'aveugle avant une soumission n'a pas de sens.
flutter config --no-enable-swift-package-manager || true

echo "📦 flutter precache --ios"
flutter precache --ios

echo "📦 flutter pub get"
flutter pub get

echo "📦 flutter build ios --config-only"
flutter build ios --config-only --no-codesign

echo "📦 pod install"
cd ios
pod install --repo-update

echo "✅ Xcode Cloud setup complete"
