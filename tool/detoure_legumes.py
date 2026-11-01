"""Détoure les légumes peints pour le lecteur de recettes.

Lit   assets/images/vegetables_kawaii/<id>.webp   (fond crème, 512 px)
Écrit assets/images/vegetables_kawaii/detoure/<id>.webp   (fond transparent, 200 px max)

Le lecteur (assets/recipes/recipe_player.html) fait jouer le légume dans
ses scènes animées ; recipe_player_screen.dart lui envoie l'image
détourée en data:URI.

Méthode : rembg, modèle « isnet-general-use ». Comparé le 01/11/2026 à un
remplissage depuis les bords (ombres beiges restées collées, ail et
champignons rongés) et au modèle u2net (halo gris autour des herbes fines) :
isnet est le seul à rendre à la fois les ombres effacées et les parties
blanches entières.

Usage :  python3 tool/detoure_legumes.py            (tous)
         python3 tool/detoure_legumes.py tomate ail (quelques-uns)
Dépendances : pip install "rembg[cpu]" pillow
(le modèle, 179 Mo, se télécharge au premier lancement)
"""
import sys
from pathlib import Path

from PIL import Image
from rembg import new_session, remove

RACINE = Path(__file__).resolve().parent.parent
SOURCE = RACINE / 'assets/images/vegetables_kawaii'
SORTIE = SOURCE / 'detoure'


def detoure(nom, session):
    image = Image.open(SOURCE / f'{nom}.webp').convert('RGB')
    sortie = remove(image, session=session)
    sortie = sortie.crop(sortie.getbbox())
    sortie.thumbnail((200, 200), Image.LANCZOS)
    sortie.save(SORTIE / f'{nom}.webp', 'WEBP', quality=80, method=6)


if __name__ == '__main__':
    SORTIE.mkdir(exist_ok=True)
    session = new_session('isnet-general-use')
    noms = sys.argv[1:] or sorted(p.stem for p in SOURCE.glob('*.webp') if not p.stem.startswith('_'))
    for n in noms:
        detoure(n, session)
        print(n)
