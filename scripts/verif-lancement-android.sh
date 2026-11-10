#!/usr/bin/env bash
# Ouvre l'APK release deux fois de suite sur l'émulateur : la première ouverture
# (installation propre) puis une seconde (reprise avec les données déjà créées).
# Échec si l'appli plante ou ne reste pas ouverte. À lancer dans emulator-runner.
set -euo pipefail

APK="${1:?chemin de la fiche APK}"
PAQUET="com.toa.kultiva"
ACTIVITE="$PAQUET/.MainActivity"

# -g : accorde d'emblée les autorisations (notifications…), sinon la fenêtre Android
# d'autorisation reste au premier plan et avale la 2e ouverture.
adb install -r -g "$APK"

for essai in 1 2; do
  echo "=== Ouverture $essai sur 2 ==="
  adb logcat -c
  adb shell input keyevent KEYCODE_HOME
  sortie=$(adb shell am start -W -n "$ACTIVITE")
  echo "$sortie"
  if echo "$sortie" | grep -q "Activity not started"; then
    echo "L'appli n'a pas été lancée (une autre fenêtre est au premier plan)."
    exit 1
  fi
  sleep 20
  if ! adb shell pidof "$PAQUET" > /dev/null; then
    echo "L'appli n'est plus ouverte après 20 s (ouverture $essai)."
    adb logcat -d | grep -E "kultiva|AndroidRuntime|FATAL|ActivityManager|DEBUG|libc|flutter" | tail -n 120
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
