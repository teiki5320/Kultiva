"""Garnit une installation Kultiva de simulateur, pour les captures.

Pourquoi : garnir à la main demande une cinquantaine de gestes —
onboarding, création du jardin, six glisser-déposer, arrosages — et
chaque geste passe par l'autorisation d'accès au simulateur, qui se
redemande dès que l'appareil change d'identifiant. Or tout le cahier
tient dans trois chaînes JSON de NSUserDefaults : les écrire donne le
même jardin, sans un seul tap.

**La recette, et ses deux pièges.**

```bash
UDID=...                      # xcrun simctl list devices
PL="$(xcrun simctl get_app_container $UDID com.toa.kultiva data)"
PL="$PL/Library/Preferences/com.toa.kultiva.plist"
xcrun simctl terminate $UDID com.toa.kultiva
python3 tool/garnir_simulateur.py "$PL"
xcrun simctl shutdown $UDID && xcrun simctl boot $UDID
xcrun simctl launch $UDID com.toa.kultiva
```

⚠️ **Le redémarrage n'est pas une précaution, il est obligatoire.**
`cfprefsd` tient le plist en mémoire et sert son cache : sans
shutdown/boot, l'app relit ce qu'elle avait avant et le garnissage
semble n'avoir rien fait. C'est la même cause que l'avertissement de
CLAUDE.md sur la langue (« écrire la préférence dans le plist ne
marche pas »), et le redémarrage est ce qui le lève.

⚠️ **Terminer l'app avant d'écrire**, sinon elle réécrit le plist
depuis sa mémoire en s'arrêtant.
"""
import json
import subprocess
import sys
from datetime import datetime, timedelta
from xml.sax.saxutils import escape

# ⚠️ **Le jour du garnissage, pas une date écrite en dur.** La valeur
# était figée au 03/11/2026 : relancé le lendemain, l'outil produisait
# un cahier dont les arrosages « dus aujourd'hui » l'étaient la veille,
# et la carte du matin ne montrait plus rien. Une capture de boutique
# doit montrer un jardin vivant le jour où on la prend.
AUJOURDHUI = datetime.now().replace(hour=9, minute=0, second=0, microsecond=0)


def jours(n):
    """La date d'il y a n jours, au format que `DateTime.parse` lit."""
    return (AUJOURDHUI - timedelta(days=n)).isoformat()


# ── Les plants du cahier ───────────────────────────────────────────────
# Dates échelonnées pour que le journal ait plusieurs jours à montrer,
# et des arrosages assez nombreux pour débloquer les badges qui les
# comptent.
PLANTS = [
    # (id, légume, planté il y a N jours, jours d'arrosage, récoltes)
    ('p1', 'tomate',   75, [70, 63, 56, 49, 42, 35, 28, 21, 14, 7, 2], 4),
    ('p2', 'fraise',    63, [60, 52, 44, 36, 28, 20, 12, 4], 2),
    ('p3', 'carotte',   49, [45, 38, 31, 24, 17, 10, 3], 0),
    ('p4', 'laitue',    24, [20, 14, 8, 1], 1),
    ('p5', 'radis',      9, [7, 3], 0),
    ('p6', 'basilic',   16, [12, 6, 1], 0),
]

plantations = []
for pid, veg, plante, arrosages, recoltes in PLANTS:
    plantations.append({
        'id': pid,
        'vegetableId': veg,
        'plantedAt': (jours(plante)),
        'harvestedAt': None,
        'harvestCount': recoltes,
        'wateredAt': [(jours(j)) for j in arrosages],
        'note': None,
        'photoPaths': [],
    })

# ── Le potager carré ───────────────────────────────────────────────────
# 4×4 cases, six occupées : assez pour que l'aperçu de grille du cahier
# montre quelque chose, et que la place libre reste visible.
CASES = [
    (0, 0, 'tomate',   1, 75, 'fruiting'),
    (1, 0, 'basilic',  4, 16, 'vegetative'),
    (2, 0, 'laitue',   4, 24, 'vegetative'),
    (0, 1, 'fraise',   4, 63, 'fruiting'),
    (1, 1, 'carotte',  9, 49, 'vegetative'),
    (3, 2, 'radis',   16,  9, 'seedling'),
]

cells = {}
cultures = []
for i, (col, row, veg, count, plante, phase) in enumerate(CASES):
    cid = 'c%d' % (i + 1)
    cells['%d,%d' % (col, row)] = {
        'col': col,
        'row': row,
        'vegetableId': veg,
        'count': count,
        'plantedAt': (jours(plante)),
        'cultureId': cid,
    }
    # La culture est liée au plant du même légume : un arrosage saisi
    # depuis le potager carré doit atterrir dans la même Plantation.
    lien = next((p['id'] for p in plantations if p['vegetableId'] == veg), None)
    cultures.append({
        'id': cid,
        'vegetableId': veg,
        'startedAt': (jours(plante)),
        'endedAt': None,
        'note': None,
        'linkedPlantationId': lien,
        'phase': phase,
        'wateredAt': [],
    })

plan = {
    'id': 'g1',
    'name': 'Jardin 1',
    'location': 'Paris',
    'cols': 4,
    'rows': 4,
    'unit': 'cm',
    'cells': cells,
    'createdAt': (jours(80)),
    'updatedAt': (jours(1)),
}

PREFS = {
    'flutter.kultiva.onboardingDone': ('bool', 'YES'),
    'flutter.kultiva.region': ('string', 'france'),
    'flutter.kultiva.country': ('string', 'FR'),
    'flutter.kultiva.language': ('string', 'fr'),
    'flutter.kultiva.gardenTutorialDone': ('bool', 'YES'),
    'flutter.kultiva.jardinsTutorialDone': ('bool', 'YES'),
    'flutter.kultiva.plantations.v1': ('string', json.dumps(plantations)),
    'flutter.kultiva.cultures.v1': ('string', json.dumps(cultures)),
    'flutter.garden_plans_v1': ('string', json.dumps([plan])),
}


def main(plist):
    for cle, (genre, valeur) in PREFS.items():
        # ⚠️ plutil coupe les clés sur les points : il faut les échapper.
        chemin = cle.replace('.', r'\.')
        subprocess.run(
            ['plutil', '-replace', chemin, '-' + genre, valeur, plist],
            check=True)
    dit(len(PREFS), plist)


def android(fichier):
    """Écrit le même jardin au format que lit `shared_preferences`.

    ⚠️ **Les clés sont identiques aux deux plateformes**, préfixe
    `flutter.` compris : c'est le plugin qui le pose, pas nous. Le
    garnissage a donc **un seul propriétaire de la donnée**, et un
    jardin corrigé ici sort juste sur les deux systèmes.
    """
    lignes = ["<?xml version='1.0' encoding='utf-8' standalone='yes' ?>",
              '<map>']
    for cle, (genre, valeur) in PREFS.items():
        if genre == 'bool':
            lignes.append('    <boolean name="%s" value="%s" />'
                          % (cle, 'true' if valeur == 'YES' else 'false'))
        else:
            lignes.append('    <string name="%s">%s</string>'
                          % (cle, escape(valeur)))
    lignes.append('</map>')
    with open(fichier, 'w', encoding='utf-8') as f:
        f.write('\n'.join(lignes) + '\n')
    dit(len(PREFS), fichier)


def dit(n, ou):
    print('%d clés écrites dans %s' % (n, ou))
    print('%d plants, %d cases, %d cultures'
          % (len(plantations), len(cells), len(cultures)))


if __name__ == '__main__':
    if sys.argv[1] == '--android':
        android(sys.argv[2])
    else:
        main(sys.argv[1])
