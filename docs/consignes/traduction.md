# Kultiva : traduction du catalogue, du contenu et de l'interface

> Texte déplacé tel quel depuis `CLAUDE.md` le 16 novembre 2026, pour alléger les consignes lues à chaque session. Rien n'a été réécrit.

## 🗂️ Le catalogue n'était pas traduit du tout (02/11/2026)

**Trouvé en regardant le catalogue espagnol à l'écran**, pas en lisant
le code : les chips de sous-catégorie disaient « Herramientas » au-dessus
de vignettes nommées « Binette / serfouette ». Seul le **nom** des 130
cultures passait par `names_{en,es}.dart`. La note, la description et
les neuf champs techniques des 169 fiches restaient en français, dans
une interface par ailleurs entièrement traduite — **1 032 chaînes,
8 324 mots**, depuis l'ouverture mondiale.

| Ce qui ne l'était pas | Chaînes distinctes |
| --- | --- |
| Descriptions | 169 |
| Notes (la ligne sous le nom) | 169 |
| Durées de récolte par saison | 200 |
| Technique de semis | 83 |
| Sol | 78 |
| Rendement | 67 |
| Arrosage | 65 |
| Espacement | 62 |
| Noms des 39 accessoires | 39 |
| Exposition, température, profondeur, levée | 98 |

**La surcouche** : `displayNote`, `displayDescription` et neuf getters
sur `Vegetable` (`content_i18n.dart`), branchés dans la fiche, la
vignette du catalogue et l'écran Semer. Les noms d'accessoires, eux,
rejoignent `names_{en,es}.dart` avec les cultures — `displayName` les
lisait déjà.

⚠️ **Composer plutôt qu'écrire, partout où c'est possible.** Six des
dix jeux ont été **générés par règle** et non traduits à la main :

- les chiffres (température, profondeur, levée, espacement) par un
  patron, parce qu'une profondeur de semis est une **consigne** ;
- le **sol** par segments — 52 segments couvrent 78 phrases, séparés
  par des virgules ;
- le **rendement** par chiffre + unité + dénominateur ;
- les **durées de récolte** par durée + précision — 91 parenthèses et
  44 phrases libres couvrent les 200.

C'est plus sûr que la main, et ça garde la même formulation d'une
fiche à l'autre. Le poseur (`scratchpad/poser.py`, hors dépôt) refuse
d'écrire si un chiffre bouge.

⚠️ **Quatre pièges rencontrés, tous attrapés par le test des nombres
ou par le mien :**

- le « 1 » de « 1ère récolte » compte comme un nombre : « first
  harvest » le perdait, d'où « 1st harvest » et « 1.ª cosecha » ;
- le « 2 » de « Vaporisation 2× par jour » disparaissait dans « Mist
  twice a day » ;
- « 3 000 ans » devenu « 3,000 years » : la virgule anglaise des
  milliers casse la comparaison ;
- « humifère » et « riche en humus » traduits pareil donnaient
  « rich, humus-rich » dans la même ligne.

### ⚠️ `v.name` affiché : le défaut qui est revenu treize fois

`Vegetable.name` est le nom **français** — la clé des données, de la
recherche sans accent et des tests. Ce qui s'affiche, c'est
`displayName`. Onze endroits les confondaient le 01/11, un douzième le
02/11 (la vignette du catalogue, qui disait « Chou kale » à un
anglophone alors que la vue liste juste à côté traduisait) et un
treizième le même jour : les pastilles de **compagnonnage et de
rotation**, vues en espagnol à l'écran — « Fraise », « Carotte »,
« Haricot vert » sous une fiche entièrement castillane.

`flutter analyze` ne peut rien dire : les deux sont des `String`.
`test/noms_affiches_test.dart` cherche donc les expressions qui
**affichent** un nom (`Text(v.name)`, `label: Text(…)`, un trou de
`trUiArgs`) et laisse tranquilles la recherche et les clés, qui s'en
servent à bon droit. Vérifié en recassant volontairement une ligne.

**L'état, mesuré le 02/11/2026** : **4 894 chaînes par langue** —
1 943 de contenu, 1 267 de tutos, 779 d'interface, 736 de recettes,
169 de noms. Couverture **complète** en anglais et en espagnol. Les
six noms identiques au français (Melon, Taro, Cosmos, Zinnia, Fonio,
Moringa) le sont parce que c'est le même mot.

## 🗣️ Traduire le contenu (structure posée le 02/11/2026)

**Le problème que ça règle.** L'app avait une interface anglaise posée
sur 736 recettes françaises. Un anglophone lisait « Recipes », cliquait,
et tombait sur « Coulis de tomates en bocaux ». Ce n'était pas une
traduction à venir, c'était une traduction cassée, déjà livrée.

**Pourquoi il fallait une structure avant de traduire.** Les 57 000 mots
de recettes sont en dur dans `lib/data/recipes.dart`, 11 821 lignes de
Dart avec apostrophes et dollars échappés. Il n'existait **aucun endroit
où une deuxième langue puisse atterrir**. Faire éditer ce fichier par un
agent de traduction, c'était risquer la compilation sur un `\'` oublié.

**Le patron retenu** est celui de `names_en.dart`, qui marche depuis le
01/11 : **une surcouche, pas un second catalogue.**

- `lib/data/recipes_i18n.dart` — le mécanisme. `RecipeText` (name,
  description, keeps, ingredients, steps), la table
  `recipeTextsByLanguage`, les fonctions pures `recipeNameIn`,
  `recipeStepsIn`… et l'extension `display*` qui lit la langue dans
  `PrefsService`. Y vivent aussi les neuf méthodes de conservation
  traduites (`methodLabelIn`) et `dureeLisibleIn` — sans quoi un écran
  anglais affichait « 3 semaines » sous un titre anglais.
- `lib/data/recipes_en.dart` — la surcouche anglaise. Clé =
  `légume/nom français`, celle des favoris. **Le nom français sert de
  clé même dans un fichier étranger** : il ne change pas quand on
  traduit, alors qu'une clé anglaise aurait obligé à renommer les sept
  lots à la première retouche de style.
- `tool/exporter_recettes.dart` — sort les lots à traduire. Il
  **importe** le catalogue au lieu de le lire : pas d'expression
  régulière, donc pas de casse sur un nom contenant une apostrophe.
- `test/recipes_i18n_test.dart` — 10 tests, dont celui qui compte.

**Ce qui ne voyage pas dans une traduction, exprès** : l'emoji d'une
étape (il choisit la scène animée du lecteur), son minuteur, les
minutes, les parts, la méthode. Ce qui n'a pas de langue reste dans le
catalogue, donc ne peut pas se perdre en route.

**Le repli est par champ.** Une recette dont le nom est traduit mais pas
les étapes affiche un nom anglais et des étapes françaises. C'est ce qui
permet de traduire par morceaux sans jamais casser l'app — et c'est
pourquoi une liste d'étapes de longueur différente est refusée **en
entier** plutôt que mélangée.

⚠️ **Le test des nombres est le garde-fou du chantier.** Il compare les
chiffres de chaque chaîne traduite à ceux du français. Une saumure à
3 % devenue 2 % ne conserve plus, elle fait pousser autre chose ; un
vinaigre dilué ne protège plus d'un botulisme. Vérifié en cassant
volontairement une étape : l'erreur nomme le fichier, la recette et
l'étape.

**L'état réel (02/11/2026)** : **les 736 recettes sont traduites en
anglais et en espagnol**, les 123 légumes, plus les 33 tutos
(1 267 phrases) et les 780 phrases de contenu dans les deux langues.
La tomate a été écrite à la main comme modèle de ton ; le reste a été
traduit par des agents Sonnet en parallèle, puis validé par les trois
suites de tests — aucune clé inventée, comptes d'étapes exacts,
nombres identiques au français. Un test verrouille la **couverture
par langue** : ajouter une recette sans sa traduction, ou enregistrer
une langue à moitié faite, fait échouer la suite.

⚠️ **Le prix réel, mesuré** : 130 000 à 240 000 jetons par lot sur
Sonnet, ≈ **1,5 million pour l'anglais complet** et **1,67 million
pour l'espagnol** (6 lots de recettes + tutos + contenu, huit agents
en parallèle, sept minutes de temps réel). Pas 360 000 comme je
l'avais estimé au départ : l'agent lit, vérifie et réfléchit en plus
d'écrire. Mesurer avant de citer.

⚠️ **Une charte vaut mieux qu'un prompt.** Les huit agents espagnols
ont reçu le même fichier (`build/traduction/CHARTE_ES.md`, hors
dépôt) : les quatre règles qui font échouer un fichier, ce qui ne se
traduit pas (plats ouest-africains, emoji, gras Markdown), le choix du
castillan sans doublet latino, l'échappement Dart, et le format du
rapport. Le prompt de chaque agent ne fait alors que dire quel fichier
remplir. Sept des huit ont écrit leur propre script de vérification
des nombres avant de rendre — parce que la charte disait qu'un test
refuserait le fichier.

⚠️ **`tool/exporter_contenu.dart` lit sa langue dans un fichier.** Ni
l'environnement du shell ni `--dart-define` n'atteignent l'isolat de
`flutter test` :

```bash
mkdir -p build/traduction && echo es > build/traduction/LANGUE
flutter test tool/exporter_contenu.dart   # → build/traduction/contenu_es.dart
```

Sans ce fichier, c'est l'anglais.

**Ajouter une langue** : écrire `lib/data/recipes_<code>.dart`, ajouter
une ligne à `recipeTextsByLanguage`, ajouter le code à
`PrefsService.supportedLanguages` et l'ARB correspondant. Rien d'autre
à brancher — les écrans lisent déjà la surcouche.

**Le lecteur de recettes parle la langue aussi.** `recipe_player.html`
est un document hors ligne : il ne peut pas lire les ARB. Ses propres
libellés — « Ce qu'il te faut », « étape 1 », « C'est parti », les
minuteurs, les mois — voyagent donc dans le JSON, champ `ui`, produit
par `playerUiFor()`. Une clé manquante retombe sur le français côté
JavaScript. Sans ça, une recette anglaise s'ouvrait dans une boîte
française : constaté à l'écran le 02/11/2026, puis corrigé et revérifié
en capture.

⚠️ **Restent en français dans l'écran Recettes**, et relèvent des ARB et
pas de ce chantier : « Il te faut », « Une idée pour ta récolte de… »
(partage) et « Pour 4 personnes · écrite pour 4 » (choix des parts).

### Les tutos : traduits sans être touchés (02/11/2026)

**Le volume, mesuré** : 34 tutos, **1 267 textes distincts, 11 158
mots** — cinq fois moins que les recettes. J'avais raisonné comme si
c'était un second chantier de même taille ; c'était faux.

**Ni copie par langue, ni gabarit.** Dupliquer, c'est 34 fichiers × n
langues qui divergent. Transformer les 34 pages en gabarits demandait
de les réécrire une par une, chacune ayant sa structure. À la place :
on injecte un dictionnaire et dix lignes de JavaScript avant
`</body>`, et le navigateur remplace les textes **dans le DOM**. Les
34 fichiers ne bougent jamais.

- `lib/data/tutos_i18n.dart` — le dictionnaire par langue et
  `tutoTraduit(html, langue)`. En français, le HTML ressort inchangé :
  pas de script inutile.
- `lib/data/tutos_en.dart` — l'anglais. **Clé = la phrase française
  exacte** : si le français est corrigé, la clé ne correspond plus et
  la phrase reste en français. Pas de traduction fantôme.
- `tool/exporter_tutos.py` — extrait les textes (nœuds de texte et
  attributs `alt`/`title`/`aria-label`), jamais le contenu des
  `<script>` ni des `<style>`.
- `test/tutos_i18n_test.dart` — 9 tests : chaque clé existe encore dans
  un tuto, les nombres ne bougent pas, le corps du tuto est intact,
  aucun appel réseau, et le français ressort tel quel.

Le walker ignore `<script>` et `<style>`, et un `MutationObserver`
reprend les textes ajoutés après coup — le tuto du dashboard écrit ses
légendes au fil de l'animation.

**Les 33 tutos sont traduits** — 1 267 phrases. `conserver_legumes` a
été écrit à la main comme modèle et vérifié en capture (mise en page
intacte, 8-12 °C, 3 %, 100 °C préservés) ; les 1 230 autres phrases
viennent d'un agent, validées par le test.

⚠️ **Un piège du test, trouvé le 02/11** : il cherchait la phrase
française dans le HTML brut, donc « Défis & badges » était introuvable
dans un fichier qui écrit « Défis &amp; badges ». Le test décode
maintenant les entités, comme l'extracteur.

⚠️ **Les mois d'un calendrier ne sont pas des phrases.** « J » vaut
janvier, juin et juillet, et vaut « E » en espagnol. Les cases d'un
calendrier portent donc `data-mois="1".."12"`, et le walker les
remplit depuis `__KULTIVA_MOIS1__`, posé par Dart. Les noms longs
voyagent aussi, dans `__KULTIVA_MOIS__`, pour les tutos qui
construisent leur contenu en JavaScript.

⚠️ **Deux blocs injectés, et l'ordre compte.** Les **données** entrent
juste après `<body>`, donc avant le script du tuto — sinon
`decouvrir_dashboard`, qui bâtit son calendrier lui-même, lirait la
table des mois avant qu'elle existe. Le **walker**, lui, passe avant
`</body>`, après que les scripts du tuto ont posé leur contenu. Un
test vérifie l'ordre, et un autre qu'en retirant les deux blocs on
retombe **exactement** sur le fichier d'origine.

⚠️ **« Jamais modifiés » veut dire « jamais dupliqués par langue »**,
pas « intouchables ». Le français d'un tuto reste la source : on le
corrige dans son fichier, comme n'importe quelle donnée. C'est ce qui
a permis de marquer les douze cases de `quand_semer`.

⚠️ **Phrases coupées par une balise.** Certains tutos coupent une
phrase en trois nœuds de texte (« Le » / « calendrier » / « lunaire au
potager »). Chaque morceau est traduit séparément, et la phrase ne se
recolle correctement que si l'ordre des mots le permet. À regarder en
premier si un tuto anglais lit bizarrement.

### Le reste du contenu (02/11/2026)

**780 phrases, 7 248 mots** : maladies et ravageurs (323), lexique
(158), défis (110), badges (100), achat au marché (56), familles
botaniques (26), conseils canicule (7).

Même principe, dictionnaire unique keyé par la phrase française :

- `lib/data/content_i18n.dart` — `tr()`, `trIn()` et les extensions
  `displayName` / `displayRemedy` / `displayDefinition` sur `Disease`,
  `LexiconEntry`, `PoussidexBadge` et `PhotoChallenge`.
- `lib/data/content_en.dart` — l'anglais.
- `tool/exporter_contenu.dart` — ⚠️ tourne sous **`flutter test`** et
  non `dart run` : badges et défis passent par `vegetable_medal.dart`,
  qui importe Flutter. Il écrit dans `build/traduction/contenu_en.dart`.
- `test/content_i18n_test.dart` — 7 tests : aucune clé orpheline, les
  nombres ne bougent pas, le français ressort inchangé.

**Pourquoi un dictionnaire ici et une surcouche par champ pour les
recettes** : une recette est un objet à cinq champs qu'on recouvre
champ par champ ; ici ce sont des phrases isolées, chacune unique. La
clé peut donc être la phrase elle-même, comme pour les tutos.

⚠️ **`LexiconText` souligne les mots en cherchant les termes
français.** Traduire un terme du lexique sans traduire le texte qui le
contient ne soulignerait plus rien : les deux vont ensemble.

⚠️ **Le compagnonnage n'a pas besoin de traduction** : `companions.dart`
ne contient que des identifiants de légumes, déjà traduits par
`Vegetable.displayName`.

⚠️ **`rotation_advisor.dart` compose ses messages par interpolation**
(« il y a 2 ans », « recommande 3 ans d'attente »). Ils ne passent pas
par le dictionnaire et relèvent des ARB. Non fait.

### Ce que la traduction a révélé dans le français

Traduire oblige à relire, et la relecture a trouvé ce que personne
n'avait vu :

- ✅ **Corrigé** : `pommier/Compote de pommes en bocaux`, étape 5,
  disait « stérilise à 100 °C à partir de l'ébullition » **sans
  durée**. Le minuteur de l'étape portait bien 25 minutes, mais la
  fiche courte affiche le texte sans minuteur. Une durée de
  stérilisation muette, c'est une règle sanitaire perdue : la phrase
  le dit maintenant, en français et en anglais.
- ✅ **Sans objet, et c'était une erreur de cette fiche** (vérifié le
  03/11/2026). Elle annonçait que `fraise/Confiture de fraises` disait
  « poids pour poids avec le sucre » tout en donnant 1 kg de fraises
  pour 700 g de sucre. La recette dit « 700 g de sucre par kilo de
  fruits » et liste 1 kg / 700 g : elle est cohérente, en français, en
  anglais et en espagnol. `git log -S'poids pour poids'` ne trouve
  **aucun** commit : la phrase n'a jamais existé dans `recipes.dart`.
  ⚠️ C'est une incohérence inventée, pas corrigée — la fiche a décrit
  de mémoire un fichier qu'elle n'avait pas relu. **Mesurer avant de
  citer**, y compris quand on signale un défaut.
- ⬜ **À trancher** : le lexique définit encore **« poussidex »** et
  **« streak »**, deux notions supprimées le 31/10/2026, et la
  définition de « streak » cite un badge « Fidèle » qui n'existe pas
  dans les 50.
- ⬜ **À faire relire par un jardinier anglophone** : une dizaine de
  noms de ravageurs sans équivalent anglais établi — « Mouche de
  l'ail », « Puceron noir du prunier », « Mouche de la figue »,
  « Charançon de la rhubarbe », « Mouche mineuse du poireau »,
  « Maruca », « Mineuse de l'épi du mil ». **« Mildiou » est une
  seule clé** partagée par neuf cultures, rendue « Late blight /
  downy mildew » : juste pour la tomate et la pomme de terre, approché
  pour les autres. Un nom de maladie faux envoie acheter le mauvais
  traitement.
- ⬜ **Détail de forme** : les heures gardent la notation française en
  anglais (« Water before 9h ») parce que « 9 am » changerait le
  chiffre et ferait échouer le test des nombres. Lisible, mais sec.

### Traduire l'interface (02/11/2026)

**772 chaînes par langue**, 718 appels `trUi()` dans 53 fichiers.
`lib/data/ui_i18n.dart` porte le mécanisme, `ui_en.dart` et
`ui_es.dart` les dictionnaires.

**Pourquoi un dictionnaire et pas les ARB** — la raison est écrite en
tête de `ui_i18n.dart`, en trois points : la moitié de ces chaînes
vivent dans des services sans `BuildContext` (y faire descendre un
contexte, ce serait mélanger présentation et logique métier) ; nommer
772 clés produit 772 noms qui mentent à la première retouche ; et
c'est déjà le patron des trois autres surcouches. Les ARB gardent les
cinq onglets et la note du réglage « Langue ».

**Les chaînes composées ont des trous numérotés** :

```dart
trUiArgs('{0} ans avant de replanter au même endroit', <Object?>[3])
```

La place d'un trou est **libre** dans la traduction — c'est l'intérêt
par rapport à une concaténation, qui fige l'ordre des mots.

**Ce qui n'est pas dans le dictionnaire, et pourquoi** : les mois, les
jours et les 73 noms de pays. Les deux premiers parce qu'une clé ne
peut pas rendre deux valeurs (« juin » court et long, « Mar » mardi et
mars) ; les pays parce qu'un champ d'enum `const` ne peut pas appeler
de fonction — ils passent par `displayLabel`.

**L'outillage** :

```bash
python3 tool/exporter_interface.py --compte
flutter test tool/exporter_enums.dart     # les libellés d'enum
python3 tool/exporter_interface.py --squelette --langue=es --part=2/3
```

⚠️ **L'exportateur lit du code, pas des données**, donc il embarque un
vrai lecteur de chaînes Dart : une expression régulière se fait piéger
par `'l\'ail'` et par les littérales adjacentes que Dart colle en une.
Le test embarque le même lecteur, et tous deux ignorent les
commentaires — un commentaire qui citait `trUi()` avait été pris pour
un appel.

⚠️ **Ajouter une chaîne d'interface fait échouer la suite** jusqu'à ce
qu'elle soit traduite dans les deux langues. C'est voulu : une langue
enregistrée est une langue finie, sinon l'app panache deux langues
dans la même phrase.

### Voir un écran HTML sans le simulateur

Le simulateur rend bien l'écran depuis le 02/11/2026 (alerte 9), mais
pour un tuto ou une recette, qui sont du HTML, Chrome headless reste
plus rapide : pas de build, pas d'installation. ⚠️ À une réserve près,
apprise le 02/11 : **un asset rendu dans une WebView se vérifie dans la
WebView** — Chrome n'a pas de `NavigationDelegate`.

```bash
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  --headless=old --disable-gpu --hide-scrollbars \
  --window-size=500,880 --force-device-scale-factor=2 \
  --screenshot=sortie.png --virtual-time-budget=2500 "file://$PWD/page.html"
```

⚠️ **Trois pièges, tous rencontrés le 01/11/2026 :**

- `--window-size` est **ignoré pour la mise en page** : Chrome rend en
  **500 px** quoi qu'on demande, puis recadre la capture. Demander
  390 px donne une image coupée à droite qu'on prend pour un bug de
  l'app. Capturer en 500 de large.
- **Ne pas forcer `width: 390px` sur `body`** pour compenser : le pied
  de page du lecteur est en `position: fixed`, donc il suit la fenêtre
  et pas le corps — le bouton « Suivant » part hors cadre, et on croit
  qu'il manque.
- Le panneau navigateur de Claude Code **fige** les fichiers hors du
  projet (« static snapshots ») : le JavaScript ne tourne pas, la page
  sort vide. Et il n'a pas réussi à joindre un `http.server` local.
