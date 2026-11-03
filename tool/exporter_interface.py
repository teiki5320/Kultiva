#!/usr/bin/env python3
"""Sort les chaînes d'interface à traduire, lues dans les appels trUi().

Les trois autres exportateurs lisent des **données** — un catalogue de
recettes, des pages HTML, des listes de maladies. Celui-ci lit du
**code** : les 541 chaînes d'interface sont des arguments d'appel, pas
des entrées de table.

Il ne devine donc rien. Il cherche `trUi(` et `trUiArgs(`, et prend la
chaîne littérale qui suit. Une chaîne qu'aucun appel n'enveloppe n'est
pas dans la liste : c'est voulu, c'est la définition même de « branché ».

⚠️ **Il faut un vrai lecteur de chaînes Dart.** Une expression
régulière se fait piéger par `'l\\'ail'` et par les littérales
adjacentes que Dart colle :

    trUi('Le potager kawaii dans ta poche. Calendrier de semis, '
        'suivi de tes plants.')

...qui est **une** clé, pas deux. Le lecteur ci-dessous suit les
échappements et recolle les littérales adjacentes, comme le
compilateur.

Usage :
    python3 tool/exporter_interface.py --compte
    python3 tool/exporter_interface.py --squelette --langue=en > lot.dart
    python3 tool/exporter_interface.py --squelette --langue=es --part=1/3
"""

import argparse
import os
import sys

RACINE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LIB = os.path.join(RACINE, 'lib')

ECHAPPEMENTS = {
    'n': '\n', 't': '\t', 'r': '\r', "'": "'", '"': '"',
    '\\': '\\', '$': '$', '0': '\0',
}


def lit_chaine(src, i):
    """Lit une littérale Dart à partir du guillemet en `i`.

    Rend (valeur décodée, index après la littérale), ou None si `i`
    n'ouvre pas une chaîne simple. Les chaînes à triple guillemet et
    les `r'...'` brutes sont ignorées : l'app n'en a aucune en texte
    visible, et les reconnaître à moitié serait pire que pas du tout.
    """
    if i >= len(src) or src[i] not in '"\'':
        return None
    q = src[i]
    if src[i:i + 3] == q * 3:
        return None
    out = []
    j = i + 1
    while j < len(src):
        c = src[j]
        if c == '\\':
            nxt = src[j + 1] if j + 1 < len(src) else ''
            out.append(ECHAPPEMENTS.get(nxt, nxt))
            j += 2
            continue
        if c == q:
            return ''.join(out), j + 1
        if c == '\n':          # littérale non terminée : on abandonne
            return None
        out.append(c)
        j += 1
    return None


def lit_chaine_collee(src, i):
    """Lit une suite de littérales adjacentes, comme Dart les colle."""
    morceaux = []
    while True:
        while i < len(src) and src[i] in ' \t\n\r':
            i += 1
        r = lit_chaine(src, i)
        if r is None:
            break
        morceaux.append(r[0])
        i = r[1]
    return (''.join(morceaux), i) if morceaux else None


def appels(chemin):
    """Les clés enveloppées par trUi/trUiArgs dans un fichier."""
    src = open(chemin, encoding='utf-8').read()
    trouves = []
    for nom in ('trUiArgs(', 'trUi('):
        depuis = 0
        while True:
            k = src.find(nom, depuis)
            if k < 0:
                break
            depuis = k + len(nom)
            # Pas un appel si collé à un identifiant (trUiArgsIn…).
            avant = src[k - 1] if k else ' '
            if avant.isalnum() or avant == '_':
                continue
            # Un commentaire qui cite `trUi()` n'est pas un appel.
            debut_ligne = src.rfind('\n', 0, k) + 1
            commentaire = src.find('//', debut_ligne, k)
            if commentaire >= 0:
                continue
            r = lit_chaine_collee(src, k + len(nom))
            if r is None:
                trouves.append(('⚠️ argument non littéral', k))
            else:
                trouves.append((r[0], k))
    return trouves


def balaye():
    """{fichier: [clés]}, dans l'ordre des fichiers puis des appels."""
    out = {}
    for racine, dossiers, fichiers in os.walk(LIB):
        dossiers[:] = [d for d in dossiers if d != 'l10n']
        for f in sorted(fichiers):
            if not f.endswith('.dart'):
                continue
            p = os.path.join(racine, f)
            if os.path.sep + 'data' + os.path.sep in p:
                continue
            t = appels(p)
            if t:
                rel = os.path.relpath(p, RACINE)
                out[rel] = [c for c, _ in sorted(t, key=lambda x: x[1])]
    return out


def esc(s):
    return (s.replace('\\', '\\\\').replace("'", "\\'")
             .replace('$', '\\$').replace('\n', '\\n'))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--compte', action='store_true')
    ap.add_argument('--squelette', action='store_true')
    ap.add_argument('--langue', default='en')
    ap.add_argument('--part', default=None,
                    help='n/total — découpe la liste en n parts égales')
    a = ap.parse_args()

    par_fichier = balaye()
    vues, ordre = set(), []
    for cles in par_fichier.values():
        for c in cles:
            if c not in vues:
                vues.add(c)
                ordre.append(c)

    # Les libellés qui vivent dans un champ d'enum `const` ne sont pas
    # des littérales d'appel : `Country.label` est traduit par
    # `trUi(label)`. `tool/exporter_enums.dart` les écrit ici.
    enums = os.path.join(RACINE, 'build/traduction/cles_enum.txt')
    nb_enums = 0
    if os.path.exists(enums):
        for ligne in open(enums, encoding='utf-8'):
            c = ligne.rstrip('\n')
            if c and c not in vues:
                vues.add(c)
                ordre.append(c)
                nb_enums += 1
    else:
        print('  ⚠️  build/traduction/cles_enum.txt absent : lance '
              'd\'abord `flutter test tool/exporter_enums.dart`, '
              'sinon les 73 pays manqueront.', file=sys.stderr)

    if a.compte or not a.squelette:
        total = sum(len(v) for v in par_fichier.values())
        for p, cles in par_fichier.items():
            print(f'  {len(cles):4}  {p}')
        mots = sum(len(c.split()) for c in ordre)
        print(f'\n  {total} appels, {len(ordre)} clés distinctes '
              f'(dont {nb_enums} venues des enums), {mots} mots')
        # ⚠️ On compte les **appels**, pas les clés : tous les
        # arguments non littéraux tombent sur la même clé, donc
        # `ordre` n'en contient qu'une seule. Le message disait « 1
        # appels » alors qu'il y en a trois.
        suspects = {
            p: sum(1 for c in cles if c.startswith('⚠️'))
            for p, cles in par_fichier.items()
        }
        suspects = {p: n for p, n in suspects.items() if n}
        if suspects:
            n = sum(suspects.values())
            print(f'  ⚠️  {n} appel(s) dont l\'argument n\'est pas une '
                  f'littérale. Les attendus sont les getters d\'enum '
                  f'(`trUi(label)`, `trUi(capitalName)`) ; tout autre '
                  f'est un branchement à reprendre.')
            for p, k in suspects.items():
                print(f'       {k}  {p}')
        if not a.squelette:
            return

    lot = ordre
    if a.part:
        n, total = (int(x) for x in a.part.split('/'))
        taille = (len(ordre) + total - 1) // total
        lot = ordre[(n - 1) * taille:n * taille]

    out = sys.stdout
    out.write(f"// Interface de Kultiva à traduire en « {a.langue} ».\n")
    out.write('//\n')
    out.write("// Remplace chaque '' par la traduction. Le français est la\n")
    out.write('// clé, à gauche du `:` — ne le touche pas : si tu le\n')
    out.write('// modifies, la traduction ne sera jamais trouvée et la\n')
    out.write("// phrase restera en français, sans que rien n'échoue.\n")
    out.write('//\n')
    out.write('// ⚠️ Les trous {0}, {1}… reçoivent une valeur calculée.\n')
    out.write('//    Ils doivent **tous** se retrouver dans la traduction,\n')
    out.write('//    mais leur place est libre : une langue qui met le\n')
    out.write("//    nombre à la fin l'y met. Un trou oublié fait\n")
    out.write('//    disparaître la valeur, et un test le refuse.\n')
    out.write('//\n')
    out.write('// ⚠️ Les nombres ne se traduisent pas. Les unités, si.\n')
    out.write('\n')
    for c in lot:
        if c.startswith('⚠️'):
            continue   # le marqueur de l'extracteur n'est pas une clé
        out.write(f"  '{esc(c)}':\n      '',\n")


if __name__ == '__main__':
    main()
