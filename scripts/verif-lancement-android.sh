#!/usr/bin/env bash
# Ouvre l'APK release deux fois de suite sur l'émulateur : la première ouverture
# (installation propre) puis une seconde (reprise avec les données déjà créées).
# Échec si l'appli plante ou ne reste pas ouverte. À lancer dans emulator-runner.
set -euo pipefail

APK="${1:?chemin de l'APK}"
PAQUET="com.toa.kultiva"
ACTIVITE="$PAQUET/.MainActivity"

adb install -r "$APK"

for essai in 1 2; do
  echo "=== Ouverture $essai sur 2 ==="
  adb logcat -c
  adb shell am start -W -n "$ACTIVITE"
  sleep 20
  if ! adb shell pidof "$PAQUET" > /dev/null; then
    echo "L'appli n'est plus ouverte après 20 s (ouverture $essai)."
    adb logcat -d | tail -n 80
    exit 1
  fi
  if adb logcat -d | grep -E "FATAL EXCEPTION|Process: $PAQUET.*(died|crash)|ANR in $PAQUET" ; then
    echo "Plantage détecté dans le journal (ouverture $essai)."
    adb logcat -d | tail -n 80
    exit 1
  fi
  echo "Ouverture $essai : l'appli tourne sans planter."
  adb shell am force-stop "$PAQUET"
  sleep 3
done
echo "Les deux ouvertures se sont bien passées."
