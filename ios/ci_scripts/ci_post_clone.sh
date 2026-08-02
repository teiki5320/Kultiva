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
FLUTTER_VERSION="3.41.6"

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
