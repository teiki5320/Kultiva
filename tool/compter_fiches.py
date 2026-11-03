"""Vérifie les longueurs annoncées dans les fiches des boutiques.

Les fiches annoncent leurs longueurs — « Texte promotionnel — 125/170 »
— et ces nombres servent à décider si un texte tient dans le champ.
Un nombre faux, c'est un texte refusé par la console au moment où on
le colle, ou tronqué sans prévenir.

⚠️ **Les consoles comptent en unités UTF-16, pas en caractères.** Un
emoji hors du plan de base en vaut deux, et une séquence liée comme
👨‍👩‍👧 en vaut huit. Les fiches disaient le savoir — leur en-tête le
dit — mais les 18 décomptes comptaient l'emoji pour un : tous les
textes promotionnels étaient sous-comptés d'exactement 1, puisqu'ils
finissent tous par « 🌱 ». Mesuré et corrigé le 03/11/2026.

Aucun ne dépassait sa limite, donc rien n'était cassé ; mais une fiche
qui se dit vérifiée et ne l'est pas ment sur le seul point où on lui
fait confiance.

⚠️ **Les mots-clés de l'App Store ne se comptent pas comme ça** : ils
sont limités à 100 **octets UTF-8**. Cet outil les laisse tranquilles.

    python3 tool/compter_fiches.py docs/store-listings.md
    python3 tool/compter_fiches.py --corriger docs/FICHE_APP_STORE.md
"""

import re
import sys

# « — 125/170 », « - 2 305/4 000 caractères », « — 27/30 : »
ANNONCE = re.compile(
    r'([—-]\s*)(\d[\d\s ]*)(\s*/\s*\d[\d\s ]*)'
    r'(\s*(caractères|car\.))?\s*:?\s*$')


def longueur(texte):
    """La longueur telle que la compte un formulaire de console."""
    return len(texte.encode('utf-16-le')) // 2


def entier(brut):
    return int(brut.replace(' ', '').replace(' ', ''))


def comme(modele, valeur):
    """Écrit `valeur` avec le séparateur de milliers du modèle."""
    if ' ' in modele:
        sep = ' '
    elif ' ' in modele.strip():
        sep = ' '
    else:
        sep = ''
    s = str(valeur)
    if sep and len(s) > 3:
        s = s[:-3] + sep + s[-3:]
    return s


def blocs(lignes):
    """Rend (index de la ligne, titre, annoncé, limite, texte du bloc)."""
    i = 0
    while i < len(lignes):
        m = ANNONCE.search(lignes[i])
        if m:
            # Le texte est dans le premier bloc ``` qui suit.
            j = i + 1
            while j < len(lignes) and not lignes[j].startswith('```'):
                j += 1
            k = j + 1
            while k < len(lignes) and not lignes[k].startswith('```'):
                k += 1
            if k < len(lignes):
                yield (i, m, '\n'.join(lignes[j + 1:k]))
            i = k
        i += 1


def main(chemin, corriger):
    with open(chemin, encoding='utf-8') as f:
        src = f.read().splitlines(keepends=True)
    nus = [l.rstrip('\n') for l in src]

    faux = 0
    for i, m, texte in blocs(nus):
        dit = entier(m.group(2))
        limite = entier(m.group(3).lstrip(' /'))
        reel = longueur(texte)
        if reel == dit:
            continue
        faux += 1
        alerte = ' ⚠️ DÉPASSE LA LIMITE' if reel > limite else ''
        print('%s\n  annoncé %d, réel %d, limite %d%s'
              % (nus[i].strip('# ').strip(), dit, reel, limite, alerte))
        if corriger:
            src[i] = (nus[i][:m.start(2)] + comme(m.group(2), reel)
                      + nus[i][m.end(2):] + '\n')

    if corriger and faux:
        with open(chemin, 'w', encoding='utf-8') as f:
            f.write(''.join(src))
        print('\n%d décomptes corrigés dans %s' % (faux, chemin))
    elif faux:
        print('\n%d décomptes faux dans %s — relancer avec --corriger'
              % (faux, chemin))
    else:
        print('%s : tous les décomptes sont justes.' % chemin)
    return 1 if (faux and not corriger) else 0


if __name__ == '__main__':
    args = [a for a in sys.argv[1:] if a != '--corriger']
    sys.exit(max(main(a, '--corriger' in sys.argv) for a in args))
