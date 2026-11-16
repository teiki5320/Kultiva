# Kultiva : design, UX et génération d'images

> Texte déplacé tel quel depuis `CLAUDE.md` le 16 novembre 2026, pour alléger les consignes lues à chaque session. Rien n'a été réécrit.

## 🎨 Design / UX

- **Style** : pastel kawaii japonais, lignes arrondies (cards 18, chips 20,
  boutons 20), ombres douces, emojis parcimonieux mais bienvenus.
- **Font** : Nunito (bold pour les titres, regular pour le corps).
- **Palette claire** : `#F5FAF8` (fond), `#4A9B5A` (primaire vert),
  `#A8D5A2` (vert clair), `#E8A87C` (terracotta), `#2A4A3A` (texte).
- **Palette sombre** : `#0F1F18`, `#5ABD6A`, `#1A2E22`, `#1F3528`.
- **Gradients saisonniers** : printemps rose-vert, été jaune-vert, automne
  orange, hiver bleu-gris.
- **Animations** : pétales qui tombent, papillons, feuilles, flocons selon la
  saison.
- **Tone of voice** : chaleureux, ludique, enfantin. Exemples : « Kultiva
  utilise ta localisation pour afficher la météo de ton jardin », « Le potager
  kawaii dans ta poche 🌱 ».
- **Localisation** : **français (source), anglais, espagnol**.
  Depuis le 02/11/2026, le **contenu** est complet dans les trois
  langues — 130 cultures, 736 recettes, 33 tutos (1 267 phrases),
  maladies, lexique, badges, défis (780 phrases). Soit ≈ 2 900 chaînes
  par langue, écrites par huit agents Sonnet et validées par les tests
  de nombres.
  **L'interface aussi**, depuis le 02/11/2026 : 772 chaînes par
  langue, branchées par 718 appels `trUi()` dans 53 fichiers. Vérifié
  à l'écran dans les trois langues. ⚠️ Les mois, les jours et les
  73 noms de pays passent par des **tables indexées** et non par le
  dictionnaire — voir la section « Traduire l'interface » plus bas, et
  l'avertissement en tête de `ui_i18n.dart`.
  Les neuf méthodes de conservation, les unités de durée et les
  libellés du lecteur sont traduits aussi — un test refuse une langue
  qui aurait les recettes sans eux. Voir
  « Traduire le contenu » plus bas. ⚠️ **La note du réglage « Langue »
  vit dans les trois ARB** (`settingsLanguagePartial`) et change avec
  la langue : chacune n'est pas au même stade. Elle était écrite en
  dur dans le widget et disait faux dès que l'anglais a été fini. Les chaînes passent par
  `lib/l10n/*.arb` (`flutter gen-l10n`), les noms de légumes par
  `lib/data/names_en.dart` et `v.displayName`. **`v.name` reste le nom
  français** : c'est la source de vérité des clés, de la recherche
  sans accent et des tests.

### 🎨 Génération d'images

> ⚠️ **Changement de style décidé le 30/10/2026** : tous les visuels du
> catalogue (130 légumes, 50 badges) passent au **kawaii peint**,
> générés sur **OpenArt** (GPT Image 2, image-to-image avec une planche
> de référence). Le chantier est en cours dans
> `assets/images/vegetables_kawaii/`, dont le README porte la recette,
> l'avancement et la marche à suivre pour basculer.
>
> La formule ComfyUI ci-dessous décrit l'**ancien** style plat, celui
> des 122 légumes et 38 accessoires encore en place. Elle interdit le
> mot « kawaii » — c'était cohérent pour du logo plat, ça ne l'est plus
> pour le nouveau style. Les deux ne se mélangent pas : conservée ici
> tant que l'ancien style est à l'écran.

### 🎨 Ancienne formule ComfyUI (style plat)

Format retenu pour générer les visuels kawaii des plantes et accessoires —
même style que les 38 accessoires existants. Les images générées sont
le style des 38 accessoires existants, qu'il faut conserver pour que le
catalogue reste homogène.

**Formule retenue (validée Apr 2026) :**

```
a [SUBJECT] icon, simple flat 2D vector design, solid [COLOR] color, [DETAILS], minimalist app icon, plain cream beige background, centered, 1:1 square
```

Exemple validé sur tomate :

```
a tomato icon, simple flat 2D vector design, solid red color, small green stem on top, minimalist app icon, plain cream beige background, centered, 1:1 square
```

⚠️ **Pourquoi cette formule** :
- `icon` + `vector design` + `minimalist app icon` → ancrent fort vers du logo plat
- `solid [color] color` → empêche le mélange de couleurs (sinon le modèle hésite)
- **NE PAS** ajouter « kawaii », « cute », « illustration », « character », « chibi »,
  « smiling face » — ces mots tirent vers du personnage anthropomorphisé,
  surtout sur les checkpoints anime/character (ex. `sdxl_afrotok_final`).
- Si le modèle reste biaisé character : baisser `cfg` à 4.5 sur le KSampler,
  ou désactiver les LoRAs actifs (clic-droit → Bypass).

**Format de sortie attendu** : TSV (tabulation entre prompt et filename),
copiable dans Numbers/Sheets ou un node ComfyUI batch :

```
<prompt complet sujet + style>	<id>.png
<prompt complet sujet + style>	<id>.png
```

Le filename = `{Vegetable.id}.png` (ex. `cornichon.png`, `pommier.png`).

Destination : `assets/images/vegetables/<id>.png`.

**Poids** : les visuels actuels sont des PNG 512 px en palette 8 bits,
≈ 29 Ko. Le nouveau lot est en **WebP 512 px qualité 80, ≈ 8,5 Ko** —
Flutter lit le WebP nativement, et le catalogue s'allège, ce qui compte
pour l'Afrique de l'Ouest.
