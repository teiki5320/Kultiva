# Kultiva : les 39 fiches d'accessoires

> Texte déplacé tel quel depuis `CLAUDE.md` le 16 novembre 2026, pour alléger les consignes lues à chaque session. Rien n'a été réécrit.

## 🧰 Les 39 fiches d'accessoires ont un mode d'emploi (02/11/2026)

**Demande de Jean** : « les fiches accessoires doivent être plus
fournies en contenu ». Mesuré avant d'écrire : elles ne portaient qu'un
nom, un emoji, une ligne de note et deux phrases de description. Pas de
calendrier, pas de maladies, pas de recettes, pas de médaille — c'étaient
les plus vides de l'app, et de loin.

`lib/data/accessory_guide.dart` porte **177 phrases** en cinq champs :

- `when` — le moment de l'année ou du cycle ;
- `how` — le geste, et la faute qu'on fait sans le savoir ;
- `howMuch` — la quantité, à l'échelle d'un carré de 1,20 m ;
- `care` — entretien, rangement, durée de vie ;
- `diy` — ce qu'on peut fabriquer à la place. **Nullable** : on ne forge
  pas un sécateur. 22 accessoires sur 39 en ont un, et un test exige au
  moins la moitié — une app qui ne sait que renvoyer vers Amazon ne
  tient pas sa promesse de potager débrouillard.

⚠️ **Un fichier à part, pas cinq champs sur `Vegetable`** : les 130
cultures n'ont que faire d'un « combien il en faut pour un carré », et
le modèle porte déjà vingt champs. C'est le patron de
`local_names.dart` et `market_buying_tips.dart`.

⚠️ **Pas de gras Markdown** : `LexiconText` ne le rend pas, les
astérisques s'afficheraient en clair. J'en avais écrit 26 avant de m'en
apercevoir ; un test les refuse maintenant.

⚠️ **Les nombres sont des doses** : 5 g/m² de phosphate de fer, maille
de 0,8 mm contre la mouche de la carotte, saumure, profondeurs de bac,
2 L/h par goutteur. Ils passent par `content_i18n`, donc le test des
nombres les protège en traduction.

**Le contenu ne bloque pas les tests tant qu'il n'est pas traduit** :
`content_i18n_test` n'exige pas la couverture, seulement qu'aucune
traduction ne soit orpheline. Le français atterrit seul, et les cinq
langues suivront d'un coup. ⚠️ **L'interface, elle, exige la
couverture** : les cinq libellés de la carte ont dû être traduits dans
la foulée en anglais et en espagnol.

**Deux défauts trouvés en regardant la grille**, tous deux invisibles au
compilateur :

- la tuile affichait **`v.name`**, le nom français, alors que la vue
  liste juste à côté affichait `v.displayName`. Douzième endroit où
  `name` servait d'affichage, après les onze de la veille ;
- un nom sur deux lignes **débordait de 1,5 px** et son second mot était
  rogné — « Activateur de » puis rien. La colonne n'avait pas de
  `Flexible`, donc elle dépassait la tuile carrée. Visible sur la
  moitié des accessoires, dont les noms sont plus longs que ceux des
  légumes.
