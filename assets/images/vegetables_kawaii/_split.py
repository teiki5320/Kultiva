#!/usr/bin/env python3
"""Découpe une planche kawaii en icônes carrées, une par sujet.

Deux pièges que le découpage naïf ne voit pas :

1. Le modèle ne centre pas exactement ses sujets dans les cellules
   théoriques : couper sur la grille rogne les sujets décalés.
2. Prendre la boîte de tout ce qui n'est pas le fond, dans une zone
   élargie, capture des bouts des sujets voisins.

On part donc du centre de la cellule, on trouve le dessin le plus
proche, et on propage de proche en proche sur les pixels non-fond —
avec un rayon de connexion assez large pour relier les morceaux d'un
même sujet (un tas de graines, trois haricots) mais trop court pour
sauter jusqu'à la cellule voisine. La boîte obtenue est celle du sujet
seul.

Usage : split.py <planche.png> <colonnes> <lignes> <id1> <id2> ...
"""
import sys, os, subprocess
from collections import deque
from PIL import Image

sheet_path, cols, rows = sys.argv[1], int(sys.argv[2]), int(sys.argv[3])
names = sys.argv[4:]
base = os.path.dirname(os.path.abspath(sheet_path))
out = os.path.join(base, 'out')
os.makedirs(out, exist_ok=True)

sheet = Image.open(sheet_path).convert('RGB')
W, H = sheet.size
cw, ch = W // cols, H // rows
bg = sheet.getpixel((4, 4))
STEP = 4          # grille d'analyse, en pixels
LINK = 4          # rayon de connexion, en cases (= 16 px)
TOL  = 14         # écart au fond à partir duquel c'est du dessin

px = sheet.load()
gw, gh = W // STEP, H // STEP
ink = bytearray(gw * gh)
for gy in range(gh):
    y = gy * STEP
    row = gy * gw
    for gx in range(gw):
        p = px[gx * STEP, y]
        if (abs(p[0]-bg[0]) > TOL or abs(p[1]-bg[1]) > TOL
                or abs(p[2]-bg[2]) > TOL):
            ink[row + gx] = 1
print(f'planche {W}x{H} → {cols}x{rows} cellules de {cw}x{ch}, fond {bg}')

def subject_box(cx, cy):
    """Boîte du dessin connexe le plus proche de (cx, cy), en pixels."""
    gcx, gcy = cx // STEP, cy // STEP
    seed = None
    for radius in range(0, max(gw, gh)):          # spirale grossière
        for dy in range(-radius, radius + 1):
            for dx in range(-radius, radius + 1):
                if max(abs(dx), abs(dy)) != radius:
                    continue
                x, y = gcx + dx, gcy + dy
                if 0 <= x < gw and 0 <= y < gh and ink[y * gw + x]:
                    seed = (x, y)
                    break
            if seed: break
        if seed: break
    if not seed:
        return None
    seen = {seed}
    q = deque([seed])
    minx = maxx = seed[0]; miny = maxy = seed[1]
    while q:
        x, y = q.popleft()
        if x < minx: minx = x
        if x > maxx: maxx = x
        if y < miny: miny = y
        if y > maxy: maxy = y
        for dy in range(-LINK, LINK + 1):
            for dx in range(-LINK, LINK + 1):
                nx, ny = x + dx, y + dy
                if (0 <= nx < gw and 0 <= ny < gh and (nx, ny) not in seen
                        and ink[ny * gw + nx]):
                    seen.add((nx, ny))
                    q.append((nx, ny))
    return (minx * STEP, miny * STEP, (maxx + 1) * STEP, (maxy + 1) * STEP)

i = 0
for r in range(rows):
    for c in range(cols):
        if i >= len(names):
            break
        name = names[i]; i += 1
        if name == '-':
            continue
        box = subject_box(c * cw + cw // 2, r * ch + ch // 2)
        if box is None:
            print(f'  ⚠ {name} : rien trouvé dans la cellule')
            continue
        subject = sheet.crop(box)
        sw, sh = subject.size
        side = int(max(sw, sh) * 1.16)            # 8 % de marge
        canvas = Image.new('RGB', (side, side), bg)
        canvas.paste(subject, ((side - sw)//2, (side - sh)//2))
        canvas = canvas.resize((512, 512), Image.LANCZOS)
        tmp = os.path.join(out, f'.{name}.png')
        canvas.save(tmp)
        subprocess.run(['cwebp', '-q', '80', '-quiet', tmp,
                        '-o', os.path.join(out, f'{name}.webp')], check=True)
        os.remove(tmp)
        size = os.path.getsize(os.path.join(out, f'{name}.webp'))
        print(f'  {name:<16} {sw}x{sh} → 512  {size} o')
