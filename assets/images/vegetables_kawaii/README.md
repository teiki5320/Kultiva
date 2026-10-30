# Visuels kawaii — chantier en cours

Refonte de tous les visuels du catalogue dans le style kawaii peint,
décidée le 30 octobre 2026. **Ce dossier n'est pas déclaré dans
`pubspec.yaml` : rien d'ici n'est embarqué dans l'app.**

Pourquoi : mélanger ces icônes avec les 122 PNG plats actuels donnerait
un catalogue mi-plat mi-peint. On bascule quand la série est complète.

## État

| Lot | Fait | Reste |
| --- | ---- | ----- |
| Légumes (`assets/images/vegetables/`) | 130 | 1 |
| Badges (`assets/images/badges/`) | 0 | 50 |

Faits : les 130 cultures du catalogue. Seul `_inconnu`, la sentinelle « Légume inconnu », garde son emoji ❓.

## Style

`_reference-style.webp` est la planche qui sert de référence à chaque
génération — c'est elle qui tient le style d'une image à l'autre.

⚠️ Ce style **remplace** la formule ComfyUI plate documentée dans
`CLAUDE.md`, qui interdisait justement le mot « kawaii ». Les deux ne
se mélangent pas.

## ⚠️ Générer par PLANCHES, pas une par une

Une génération coûte **le même prix quel que soit le nombre de sujets
dedans**. Les 30 premières icônes ont été faites une par une, à 42
crédits pièce : **1 260 crédits**. Les mêmes en planches de six
auraient coûté **200**.

| Méthode | Prix l'unité | 131 légumes + 50 badges |
| ------- | ------------ | ----------------------- |
| Une image par sujet | 42 crédits | ≈ 7 600 |
| Planche de 6 | 6,7 crédits | ≈ 1 200 |
| **Planche de 20** | **2,1 crédits** | **≈ 380** |

La planche de 20 est la bonne : grille 5×4 en `aspectRatio: "5:4"` et
`resolutionTier: "4k"`, ce qui donne 2560×2048 — des cellules de
512×512 pile, la taille finale des icônes. Elle met deux à trois
minutes à se générer, bien plus qu'une image seule, mais c'est vingt
sujets d'un coup et d'un style rigoureusement identique.

Une planche garantit en prime que les six sujets partagent exactement
le même rendu.

Découpe : `_split.py`, à lancer avec Pillow (absent du système, à
installer dans un venv jetable : `python3 -m venv venv &&
venv/bin/pip install Pillow`).

```
venv/bin/python _split.py planche.png 5 4 id1 id2 ... id20
```

Il ne découpe **pas** sur la grille théorique : le modèle ne centre pas
exactement ses sujets dans les cellules, et couper au carré rogne les
dessins décalés. Il part du centre de chaque cellule, trouve le dessin
le plus proche et le suit de proche en proche — avec un rayon de
connexion assez large pour garder ensemble les morceaux d'un même sujet
(trois haricots, un tas de graines de sésame) mais trop court pour
sauter sur la cellule voisine. Chaque sujet est ensuite recentré dans
un carré avec 8 % de marge, ramené à 512 px et converti en WebP.

## Recette

Modèle **GPT Image 2** sur OpenArt, en image-to-image, avec
`_reference-style.webp` passée en référence visuelle, 1:1, 1k, qualité
moyenne (42 crédits l'image).

```
A single <SUJET> icon, alone and centred on a plain cream beige
background, filling most of the square. Copy EXACTLY the art style of
the reference sheet: soft hand-painted kawaii illustration, smooth
pastel gradients, gently rounded organic shapes, a soft drop shadow
underneath, a tiny simple face made only of two small black dot eyes, a
small smile and round pink blush cheeks. No outlines, no text, no
labels, no border, no frame, nothing else in the image.
```

## Poids

512 px en WebP qualité 80 : **8,5 Ko en moyenne**, contre 29 Ko pour
les PNG palette actuels. Les 130 légumes passeraient donc de 3,8 Mo à
environ 1,1 Mo — le catalogue s'allège en gagnant du détail.

Le passage en `.webp` demandera de changer les extensions des
`imageAsset` dans `lib/data/vegetables_base.dart`.

## Basculer

1. Compléter les 122 légumes et les 50 badges.
2. Déplacer les fichiers vers `assets/images/vegetables/` et
   `assets/images/badges/`.
3. Remplacer `.png` par `.webp` dans `vegetables_base.dart` et
   `badges.dart`.
4. Supprimer ce dossier et son entrée de README.
