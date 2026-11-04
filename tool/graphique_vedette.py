"""Compose le graphique de mise en avant de Google Play (1024 x 500).

Play l'exige pour toute fiche, et il n'en existait aucun : c'était le
seul visuel obligatoire qui manquait. Il est composé en HTML plutôt que
généré par un modèle d'image, pour trois raisons mesurables — il ne
coûte aucun crédit, il se recompose en une seconde quand un mot change,
et il réemploie les vrais visuels de l'app (l'icône, les légumes
détourés), donc la boutique montre ce que l'utilisateur verra.

Tout est inliné en base64 : la page ne fait aucun appel réseau et ne
dépend d'aucun chemin relatif, donc Chrome la rend à l'identique où
qu'elle soit posée.
"""

import base64
import pathlib
import sys

RACINE = pathlib.Path('/Users/jeanperraudeau/Dev/apps/kultiva')
DETOURE = RACINE / 'assets/images/vegetables_kawaii/detoure'


def b64(chemin, mime):
    return 'data:%s;base64,%s' % (
        mime, base64.b64encode(pathlib.Path(chemin).read_bytes()).decode())


def legume(nom, css):
    return '<img class="l" style="%s" src="%s" alt="">' % (
        css, b64(DETOURE / ('%s.webp' % nom), 'image/webp'))


POLICE = b64(RACINE / 'assets/google_fonts/Nunito-ExtraBold.ttf', 'font/ttf')
ICONE = b64(RACINE / 'assets/images/app_icon.png', 'image/png')

# Les légumes les plus reconnaissables du catalogue, en grappe à droite.
LEGUMES = [
    ('potiron', 'left:596px; top:250px; width:186px; transform:rotate(-8deg)'),
    ('tomate', 'left:742px; top:96px; width:168px; transform:rotate(7deg)'),
    ('courgette', 'left:636px; top:92px; width:132px; transform:rotate(-24deg)'),
    ('carotte', 'left:784px; top:268px; width:152px; transform:rotate(18deg)'),
    ('fraise', 'left:902px; top:214px; width:106px; transform:rotate(-12deg)'),
    ('basilic', 'left:900px; top:48px; width:118px; transform:rotate(10deg)'),
]

HTML = """<!doctype html>
<meta charset="utf-8">
<style>
  @font-face {
    font-family: 'Nunito'; font-weight: 800; font-style: normal;
    src: url('%(police)s') format('truetype');
  }
  * { margin: 0; padding: 0; box-sizing: border-box; }
  html, body { width: 1024px; height: 500px; overflow: hidden; }
  body {
    position: relative;
    font-family: 'Nunito', -apple-system, sans-serif;
    font-weight: 800;
    background: linear-gradient(118deg, #FCF4E1 0%%, #F5FAF8 46%%, #DCEEDA 100%%);
  }
  .bulle { position: absolute; border-radius: 50%%; }
  .texte { position: absolute; left: 62px; top: 136px; }
  .ligne { display: flex; align-items: center; gap: 26px; }
  .icone {
    width: 116px; height: 116px; border-radius: 28px;
    box-shadow: 0 10px 26px rgba(74,155,90,.28);
  }
  h1 {
    font-size: 84px; line-height: .92; color: #2A4A3A;
    letter-spacing: -2px;
  }
  .accroche {
    margin-top: 26px; font-size: 31px; color: #4A9B5A; line-height: 1.22;
  }
  .pied {
    margin-top: 18px; font-size: 19px; letter-spacing: .4px;
    color: rgba(42,74,58,.5);
  }
  .l { position: absolute; filter: drop-shadow(0 8px 14px rgba(42,74,58,.18)); }
</style>

<div class="bulle" style="width:300px;height:300px;left:-70px;top:-110px;
     background:rgba(168,213,162,.30)"></div>
<div class="bulle" style="width:170px;height:170px;left:452px;top:356px;
     background:rgba(232,168,124,.20)"></div>
<div class="bulle" style="width:112px;height:112px;left:538px;top:-26px;
     background:rgba(168,213,162,.34)"></div>
<div class="bulle" style="width:62px;height:62px;left:86px;top:404px;
     background:rgba(232,168,124,.22)"></div>

<div class="texte">
  <div class="ligne">
    <img class="icone" src="%(icone)s" alt="">
    <h1>Kultiva</h1>
  </div>
  <div class="accroche">Le potager kawaii dans ta poche 🌱</div>
  <div class="pied">SANS COMPTE &nbsp;·&nbsp; HORS LIGNE &nbsp;·&nbsp; 73 PAYS</div>
</div>

%(legumes)s
"""


if __name__ == '__main__':
    sortie = pathlib.Path(sys.argv[1])
    sortie.write_text(HTML % {
        'police': POLICE,
        'icone': ICONE,
        'legumes': '\n'.join(legume(n, c) for n, c in LEGUMES),
    }, encoding='utf-8')
    print('%s : %.1f Ko' % (sortie, sortie.stat().st_size / 1024))
