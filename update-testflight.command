#!/bin/bash
set -e
cd "$(dirname "$0")"

PUBSPEC="pubspec.yaml"

if [ ! -f "$PUBSPEC" ]; then
  echo "❌ pubspec.yaml introuvable. Lance ce script depuis ~/Code/kultiva"
  exit 1
fi

CURRENT_LINE=$(grep "^version:" "$PUBSPEC")
CURRENT_VERSION=$(echo "$CURRENT_LINE" | sed -E 's/version: ([0-9.]+)\+[0-9]+.*/\1/')
CURRENT_BUILD=$(echo "$CURRENT_LINE" | sed -E 's/version: [0-9.]+\+([0-9]+).*/\1/')
NEW_BUILD=$((CURRENT_BUILD + 1))
NEW_LINE="version: ${CURRENT_VERSION}+${NEW_BUILD}"

echo "🌱 Kultiva → TestFlight"
echo ""
echo "Version actuelle : $CURRENT_LINE"
echo "Nouvelle version : $NEW_LINE"
echo ""
read -p "Confirmer ? (y/N) " -n 1 CONFIRM
echo ""
if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
  echo "Annulé."
  exit 1
fi

sed -i '' "s/^version:.*/$NEW_LINE/" "$PUBSPEC"

echo ""
echo "→ flutter clean"
flutter clean

echo ""
echo "→ flutter pub get"
flutter pub get

echo ""
echo "→ flutter build ipa --release (3-10 min)"
flutter build ipa --release

echo ""
echo "✅ IPA prêt dans build/ios/ipa/"
echo ""
echo "J'ouvre le dossier et Transporter pour l'upload."
open build/ios/ipa/
open -a Transporter 2>/dev/null || echo "⚠️  Transporter non installé — télécharge-le sur le Mac App Store, ou upload via Xcode → Organizer."

echo ""
echo "Après upload, check le statut sur App Store Connect → TestFlight → Builds (processing 10-30 min)."
