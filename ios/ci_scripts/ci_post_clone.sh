#!/bin/sh
# ci_post_clone.sh — Xcode Cloud build prep for Flutter apps
#
# Xcode Cloud clone le repo puis lance direct `xcodebuild archive`. Sans
# intervention, ça échoue car Flutter n'a pas tourné : Generated.xcconfig
# et Pods-Runner-*.xcfilelist n'existent pas.
#
# Ce script tourne juste après le clone (hook "ci_post_clone") :
#  1. Installe Flutter stable dans $HOME/flutter
#  2. Lance `flutter precache --ios` (télécharge le framework engine iOS)
#  3. Lance `flutter pub get` (génère Generated.xcconfig)
#  4. Lance `pod install` (génère les xcfilelist)
#
# Doit vivre dans `ios/ci_scripts/` (même niveau que Runner.xcodeproj)
# pour que Xcode Cloud le trouve automatiquement.

set -e

echo "🦋 Xcode Cloud — Flutter setup start"

# Xcode Cloud fournit $CI_PRIMARY_REPOSITORY_PATH = racine du repo.
cd "$CI_PRIMARY_REPOSITORY_PATH"

FLUTTER_DIR="$HOME/flutter"

# Clone Flutter stable si pas déjà présent (cache runner-local).
if [ ! -d "$FLUTTER_DIR" ]; then
  echo "📥 Installing Flutter stable..."
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable "$FLUTTER_DIR"
fi

export PATH="$FLUTTER_DIR/bin:$PATH"

echo "ℹ️  Flutter version:"
flutter --version

echo "📦 flutter precache --ios"
flutter precache --ios

echo "📦 flutter pub get"
flutter pub get

echo "📦 pod install"
cd ios
pod install --repo-update

echo "✅ Xcode Cloud setup complete"
