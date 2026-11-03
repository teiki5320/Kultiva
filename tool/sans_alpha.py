"""Convertit un PNG RGBA en PNG RGB, sans perte.

Pourquoi : `adb exec-out screencap -p` rend du **RGBA**, et Google Play
veut « JPEG ou PNG 24 bits (sans canal alpha) ». Une capture d'écran
n'a aucune transparence à porter — le canal est opaque de bout en
bout — mais il est là, et la console peut refuser le fichier pour ça.

⚠️ **Pas de recompression** : on relit les pixels, on retire le
quatrième octet et on ré-encode en PNG. Passer par du JPEG pour
contourner le problème abîmerait le texte, qui est ce qu'une capture
de boutique montre le plus.

⚠️ **Le script refuse un fichier dont l'alpha n'est pas opaque
partout** : retirer un vrai canal alpha changerait l'image, et ce
serait silencieux.

    python3 tool/sans_alpha.py build/captures/play/*.png
"""

import struct
import sys
import zlib


def lire(chemin):
    """Rend (largeur, hauteur, lignes de pixels brutes) d'un PNG RGBA 8 bits."""
    with open(chemin, 'rb') as f:
        data = f.read()
    if data[:8] != b'\x89PNG\r\n\x1a\n':
        raise ValueError('%s : pas un PNG' % chemin)
    i = 8
    entete = None
    morceaux = []
    while i < len(data):
        taille, = struct.unpack('>I', data[i:i + 4])
        genre = data[i + 4:i + 8]
        corps = data[i + 8:i + 8 + taille]
        if genre == b'IHDR':
            entete = struct.unpack('>IIBBBBB', corps)
        elif genre == b'IDAT':
            morceaux.append(corps)
        elif genre == b'IEND':
            break
        i += 12 + taille
    largeur, hauteur, profondeur, couleur, _, _, entrelace = entete
    if (profondeur, couleur, entrelace) != (8, 6, 0):
        raise ValueError('%s : attendu RGBA 8 bits non entrelacé' % chemin)
    return largeur, hauteur, zlib.decompress(b''.join(morceaux))


def defiltrer(largeur, hauteur, brut, canaux=4):
    """Annule les filtres par ligne du PNG et rend les pixels à plat."""
    pas = largeur * canaux
    sortie = bytearray()
    precedente = bytearray(pas)
    pos = 0
    for _ in range(hauteur):
        filtre = brut[pos]
        ligne = bytearray(brut[pos + 1:pos + 1 + pas])
        pos += 1 + pas
        for x in range(pas):
            a = ligne[x - canaux] if x >= canaux else 0
            b = precedente[x]
            c = precedente[x - canaux] if x >= canaux else 0
            if filtre == 1:
                ligne[x] = (ligne[x] + a) & 0xFF
            elif filtre == 2:
                ligne[x] = (ligne[x] + b) & 0xFF
            elif filtre == 3:
                ligne[x] = (ligne[x] + (a + b) // 2) & 0xFF
            elif filtre == 4:
                p = a + b - c
                pa, pb, pc = abs(p - a), abs(p - b), abs(p - c)
                pred = a if (pa <= pb and pa <= pc) else (b if pb <= pc else c)
                ligne[x] = (ligne[x] + pred) & 0xFF
        sortie += ligne
        precedente = ligne
    return sortie


def morceau(genre, corps):
    return (struct.pack('>I', len(corps)) + genre + corps
            + struct.pack('>I', zlib.crc32(genre + corps) & 0xFFFFFFFF))


def ecrire(chemin, largeur, hauteur, pixels):
    lignes = bytearray()
    pas = largeur * 3
    for y in range(hauteur):
        lignes += b'\x00' + pixels[y * pas:(y + 1) * pas]
    with open(chemin, 'wb') as f:
        f.write(b'\x89PNG\r\n\x1a\n')
        f.write(morceau(b'IHDR',
                        struct.pack('>IIBBBBB', largeur, hauteur, 8, 2, 0, 0, 0)))
        f.write(morceau(b'IDAT', zlib.compress(bytes(lignes), 9)))
        f.write(morceau(b'IEND', b''))


def convertir(chemin):
    largeur, hauteur, brut = lire(chemin)
    rgba = defiltrer(largeur, hauteur, brut)
    if any(rgba[i] != 255 for i in range(3, len(rgba), 4)):
        raise ValueError('%s : alpha non opaque, conversion refusée' % chemin)
    rgb = bytearray(largeur * hauteur * 3)
    for i in range(largeur * hauteur):
        rgb[i * 3:i * 3 + 3] = rgba[i * 4:i * 4 + 3]
    ecrire(chemin, largeur, hauteur, rgb)
    print('%s : RGBA → RGB (%d×%d)' % (chemin, largeur, hauteur))


if __name__ == '__main__':
    for c in sys.argv[1:]:
        convertir(c)
