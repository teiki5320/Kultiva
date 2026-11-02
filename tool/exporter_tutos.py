#!/usr/bin/env python3
"""Sort les textes des 34 tutos HTML, pour les faire traduire.

Les tutos sont des pages autonomes : chacune porte son CSS, parfois son
JavaScript, et aucune n'a jamais été pensée pour être traduite. Les
dupliquer par langue, ce serait 34 fichiers x n langues qui divergent à
la première correction — le raisonnement qui a déjà produit
`zone_shift.dart` plutôt que quatre calendriers recopiés.

On ne touche donc pas aux fichiers. On extrait leurs **textes**, et
l'app les remplace au chargement, dans le DOM, côté WebView.

La clé d'une traduction est le texte français lui-même : si le français
change, la clé ne correspond plus et la phrase reste en français. Pas
de traduction fantôme qui survit à une correction.

Usage :
    python3 tool/exporter_tutos.py --compte
    python3 tool/exporter_tutos.py --squelette --langue=en > lot.dart
    python3 tool/exporter_tutos.py --squelette --langue=en --tuto=paillage
"""

import argparse
import glob
import os
import re
import sys
from html.parser import HTMLParser

RACINE = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                      'assets', 'tutos')

# Ce qui n'est pas du texte lisible, et ne doit jamais partir en
# traduction : du code s'y casserait.
BALISES_MUETTES = {'script', 'style', 'noscript'}

# Les attributs qui portent du texte lu à voix haute ou affiché.
ATTRS_TEXTE = ('alt', 'title', 'aria-label', 'placeholder')


class Extracteur(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.pile = []
        self.textes = []

    def handle_starttag(self, tag, attrs):
        self.pile.append(tag)
        for nom, valeur in attrs:
            if nom in ATTRS_TEXTE and valeur and valeur.strip():
                self.textes.append(valeur.strip())

    def handle_startendtag(self, tag, attrs):
        for nom, valeur in attrs:
            if nom in ATTRS_TEXTE and valeur and valeur.strip():
                self.textes.append(valeur.strip())

    def handle_endtag(self, tag):
        while self.pile and self.pile.pop() != tag:
            pass

    def handle_data(self, data):
        if any(b in BALISES_MUETTES for b in self.pile):
            return
        t = ' '.join(data.split())
        # Une chaîne sans lettre est de la ponctuation ou un nombre :
        # rien à traduire, et une clé de plus à maintenir.
        if t and re.search(r'[A-Za-zÀ-ÿ]', t):
            self.textes.append(t)


def textes_de(chemin):
    """Les textes d'un tuto, dans l'ordre, sans doublon."""
    with open(chemin, encoding='utf-8') as f:
        e = Extracteur()
        e.feed(f.read())
    vus, out = set(), []
    for t in e.textes:
        if t not in vus:
            vus.add(t)
            out.append(t)
    return out


def esc(s):
    """Échappe une chaîne Dart entre apostrophes simples."""
    return s.replace('\\', '\\\\').replace("'", "\\'").replace('$', '\\$')


def tutos(filtre=None):
    for c in sorted(glob.glob(os.path.join(RACINE, '*.html'))):
        nom = os.path.splitext(os.path.basename(c))[0]
        if nom == 'privacy_policy':
            continue  # page légale, traduite séparément si besoin
        if filtre and nom != filtre:
            continue
        yield nom, c


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--compte', action='store_true')
    p.add_argument('--squelette', action='store_true')
    p.add_argument('--langue', default='en')
    p.add_argument('--tuto', default=None)
    a = p.parse_args()

    if a.compte:
        total_cles = 0
        total_mots = 0
        vus = set()
        for nom, c in tutos():
            ts = textes_de(c)
            mots = sum(len(t.split()) for t in ts)
            total_cles += len(ts)
            total_mots += mots
            vus.update(ts)
            print(f'  {nom:28s} {len(ts):4d} textes  {mots:5d} mots')
        print(f'\n  total : {total_cles} textes ({len(vus)} distincts), '
              f'{total_mots} mots')
        return

    if not a.squelette:
        print('Rien demandé. --compte ou --squelette.', file=sys.stderr)
        sys.exit(2)

    out = []
    out.append(f"// Textes des tutos à traduire en « {a.langue} ».")
    out.append('//')
    out.append("// Remplace chaque '' par la traduction. Le français est la clé,")
    out.append('// à gauche du `:` — ne le touche pas : si tu le modifies, la')
    out.append('// traduction ne sera jamais trouvée et la phrase restera en')
    out.append('// français, sans que rien n\'échoue.')
    out.append('//')
    out.append("// ⚠️ Les nombres ne se traduisent pas : « 30 cm » reste")
    out.append('//    « 30 cm », jamais « 12 in ». Un test le vérifie.')
    out.append('//')
    out.append('// Une clé laissée vide reste en français : on peut traduire')
    out.append('// par morceaux.')
    out.append('')

    vus = set()
    for nom, c in tutos(a.tuto):
        ts = [t for t in textes_de(c) if t not in vus]
        if not ts:
            continue
        vus.update(ts)
        mots = sum(len(t.split()) for t in ts)
        out.append(f'  // ─── {nom} ({len(ts)} textes, {mots} mots) ───')
        for t in ts:
            out.append(f"  '{esc(t)}':")
            out.append("      '',")
        out.append('')
    print('\n'.join(out))


if __name__ == '__main__':
    main()
