# Traduire les recettes de Kultiva

> Fiche de passation pour une session de traduction (agent
> `direction-contenu` ou autre). Tout ce qu'il faut est ici ; inutile
> d'explorer le dépôt.
> Écrite le 2 novembre 2026.

## Ce qu'il y a à traduire

**736 recettes**, dont 369 conservations et 448 déroulées étape par
étape, réparties sur **123 légumes**. Environ 57 000 mots par langue.

La tomate est **déjà traduite en anglais** : ses trois conservations
servent de modèle de ton et de niveau de détail. Lis-les avant de
commencer (`lib/data/recipes_en.dart`).

## La règle qui compte avant toutes les autres

**Les nombres ne se traduisent pas. Jamais.**

Les grammes de sel, les degrés, les pourcentages de vinaigre et les
temps de stérilisation sont des **règles de sécurité alimentaire**, pas
du style :

- une saumure à **3 %** (30 g de sel par litre) devenue 2 % ne conserve
  plus, elle fait pousser autre chose ;
- un vinaigre à **6 %** dilué ne protège plus d'un botulisme ;
- une stérilisation de **30 minutes** réduite à 20 laisse un bocal qui
  a l'air bon.

Donc : **les unités se traduisent, les valeurs se recopient.**

| Français | ✅ Bon | ❌ Refusé |
| --- | --- | --- |
| `30 g de sel` | `30 g of salt` | `1 oz of salt` |
| `Four à 90 °C` | `Oven at 90 °C` | `Oven at 200 °F` |
| `Stérilise 30 minutes` | `Sterilise for 30 minutes` | `Sterilise for half an hour` |
| `1,5 kg` | `1.5 kg` | `3 lb` |

Pas de conversion impériale, pas de Fahrenheit, pas de nombre écrit en
lettres quand le français l'écrit en chiffres.

`test/recipes_i18n_test.dart` compare les nombres de chaque chaîne
traduite à ceux du français et **refuse le fichier** s'ils ont bougé.
L'erreur nomme la recette et l'étape.

## Ce qu'on ne touche pas non plus

- **les clés**, à gauche du `:`. Ce sont des noms **français**, exprès :
  ils ne changent pas quand on traduit. `'tomate/Coulis de tomates en
  bocaux'` reste tel quel dans le fichier espagnol ;
- **l'ordre et le nombre des étapes.** Neuf étapes françaises donnent
  neuf étapes traduites. Un décalage ferait répondre l'étape 4 à
  l'étape 5, et la traduction serait ignorée en entier ;
- **les emoji et les minuteurs.** Ils ne sont pas dans le squelette :
  ils restent dans le catalogue français. Un emoji choisit la scène
  animée du lecteur, un minuteur fait sonner le téléphone ;
- **les `**astérisques**`** autour d'un mot : ils le mettent en gras
  dans le lecteur. Garde-les autour du mot équivalent.

## La marche à suivre

### 1. Voir le découpage

```bash
cd ~/Dev/apps/kultiva
dart run tool/exporter_recettes.dart --lots
```

123 légumes, **7 lots de 20**, environ 120 recettes par lot. Chaque lot
se traduit indépendamment des autres : deux sessions peuvent travailler
en parallèle sans se gêner.

### 2. Sortir le squelette d'un lot

```bash
dart run tool/exporter_recettes.dart --squelette --langue=en --lot=3 > /tmp/lot3.dart
```

Il sort du Dart **déjà valide**, avec le français en commentaire
au-dessus de chaque chaîne vide :

```dart
  'carotte/Carottes lacto-fermentées': RecipeText(
    // FR: Carottes lacto-fermentées
    name: '',
    // FR: Trois semaines dans leur saumure, et elles deviennent...
    description: '',
    // FR: 1 an au frais
    keeps: '',
    ingredients: <String>[
      '', // FR: 1 kg de carottes
      '', // FR: 30 g de sel pour 1 litre d'eau
    ],
    steps: <String>[
      // FR: Lave les carottes sans les peler...
      '',
    ],
  ),
```

Tu ne remplis que les `''`. Rien d'autre.

### 3. Remplir, puis coller

Colle le bloc rempli dans le fichier de la langue :

- anglais → `lib/data/recipes_en.dart`
- une langue nouvelle → crée `lib/data/recipes_<code>.dart` sur le même
  modèle, et ajoute une ligne à `recipeTextsByLanguage` dans
  `lib/data/recipes_i18n.dart`. **Rien d'autre à brancher** : les
  écrans lisent déjà la surcouche.

Le code de langue doit aussi être ajouté à
`PrefsService.supportedLanguages`, sinon l'interface ne proposera pas
la langue — et les ARB correspondants doivent exister.

### 4. Vérifier

```bash
flutter analyze
flutter test test/recipes_i18n_test.dart
```

Les deux doivent passer. Le second est celui qui compte.

## Le ton

Kultiva parle **chaleureusement, simplement, au tutoiement** en
français. Dans les autres langues : direct, concret, sans jargon de
cuisine professionnelle. Des phrases courtes — elles sont lues sur un
téléphone, debout dans une cuisine, les mains sales.

Garde ce qui rend une étape utile : la raison derrière le geste.
« Inutile de les peler : la passoire le fera » est plus utile que
« ne pas peler ». Traduis la raison, pas seulement l'ordre.

## Ce qui est déjà traduit, et ce qui attend

| Contenu | État |
| --- | --- |
| Interface (ARB) | ✅ français + anglais |
| Noms des 130 cultures | ✅ français + anglais (`names_en.dart`) |
| 9 méthodes de conservation | ✅ français + anglais |
| Durées (« 3 semaines ») | ✅ français + anglais |
| Libellés du lecteur animé | ✅ français + anglais (`playerUiFor`) |
| Recettes — les 736 | ✅ anglais, 123 légumes |
| Tutos — les 33 | ✅ anglais, 1 266 phrases |
| Maladies, badges, défis, lexique, conseils | ✅ anglais, 784 phrases |
| Espagnol — 130 cultures | ✅ `names_es.dart` |
| Espagnol — recettes, tutos, contenu | ✅ 736 + 1 266 + 784, comme l'anglais |
| Interface — 773 chaînes | ✅ `ui_en.dart`, `ui_es.dart` |
| Portugais | ⬜ à faire — `--langue=pt` |

**Le prix réel d'un lot de recettes, mesuré** : 190 000 jetons sur
Sonnet pour 20 légumes et 120 recettes — soit ≈ 1,3 million de jetons
par langue. L'agent lit, vérifie et réfléchit en plus d'écrire. Les
huit agents du 2 novembre (6 lots + tutos + contenu espagnols) ont
coûté **1,67 million de jetons** en sept minutes de temps réel.

## L'interface (02/11/2026)

**773 chaînes par langue**, branchées par **722 appels** `trUi()` dans
53 fichiers. Le chantier s'est fait en deux vagues : sept agents pour
**brancher** (envelopper les littérales, sans traduire), puis six pour
**traduire** les squelettes.

### Pourquoi un dictionnaire et pas les ARB

Le réflexe serait `flutter gen-l10n`. Trois raisons l'écartent, et
elles sont dans `lib/data/ui_i18n.dart` :

1. **La moitié de ces chaînes vit hors d'un widget.** `phenology.dart`,
   `country.dart`, `notification_service.dart`, `advice_service.dart` et
   `watering_advisor.dart` en portent plus de 150 et n'ont aucun
   `BuildContext`. Un ARB se lit par `AppLocalizations.of(context)` : il
   aurait fallu faire descendre un contexte dans des services, donc
   mélanger présentation et logique métier.
2. **Il aurait fallu nommer 773 clés**, qui mentent dès la première
   retouche de style. La clé est la phrase française elle-même.
3. **C'est le patron des trois autres surcouches.** Un seul modèle
   mental pour toute la traduction du projet.

Les ARB gardent ce qu'ils font mieux : les cinq libellés d'onglets et
la note du réglage « Langue ». Les **33 clés orphelines ont été
retirées** — 17 `photos*` mortes depuis le retrait de l'onglet Photo,
8 `recipes*` et 8 `common*` jamais branchées.

### Les chaînes composées : des trous numérotés

107 chaînes étaient écrites par interpolation. Elles portent maintenant
des trous :

```dart
trUiArgs('{0} ans avant de replanter au même endroit', <Object?>[3])
```

**La place d'un trou est libre dans la traduction** — c'est tout
l'intérêt par rapport à une concaténation. Un trou oublié ferait
disparaître la valeur en silence ; le test le refuse.

### Ce qui échappe au dictionnaire, et pourquoi

⚠️ **Les mois, les jours et les noms de pays** sont des tables
indexées, pas des clés. Deux collisions l'ont imposé pendant le
branchement :

- « juin » est à la fois le mois court et le mois long. En anglais ils
  diffèrent (« jun » / « june ») : **une clé devrait rendre deux
  valeurs**. Idem « août », « Juin », « Août » ;
- « Mar » est à la fois **mardi** et **mars**. Une seule clé pour deux
  sens sans rapport : le mardi de la météo serait devenu un mois.

Les noms de pays, eux, sont des champs `final String` d'un enum `const`
qui ne peut pas appeler de fonction. Ils passent par un getter
`displayLabel`, comme `Vegetable.displayName`.
`tool/exporter_enums.dart` les sort pour le squelette, et
`test/ui_i18n_test.dart` les lit **dans l'enum**, ce qui est exact par
construction.

### L'outillage

```bash
python3 tool/exporter_interface.py --compte
flutter test tool/exporter_enums.dart        # les libellés d'enum
python3 tool/exporter_interface.py --squelette --langue=es --part=2/3
```

⚠️ **L'exportateur lit du code, pas des données.** Il lui faut donc un
vrai lecteur de chaînes Dart : une expression régulière se fait piéger
par `'l\'ail'` et par les littérales adjacentes que Dart colle en une
seule. Le test embarque le même lecteur, et il ignore les commentaires
— un commentaire qui cite `trUi()` avait été pris pour un appel.

### Les dix tests

`test/ui_i18n_test.dart` : couverture par langue, aucune clé
orpheline, les trous du français se retrouvent tous, les nombres ne
bougent pas, aucune valeur vide, le français et une langue inconnue
ressortent inchangés, et **chaque appel enveloppe une littérale** — sauf
les trois getters d'enum, seuls tolérés.

⚠️ **Les tests qui comparent du français doivent forcer la langue.**
L'environnement de test tourne en `en-US`, donc `trUi()` rend de
l'anglais. Vingt tests sont tombés d'un coup en remplissant les
dictionnaires. Deux choses à faire, pas une :

```dart
setUpAll(() => PrefsService.instance.language.value = 'fr');
// …et, si le test appelle PrefsService.load(), semer la langue :
SharedPreferences.setMockInitialValues(<String, Object>{
  'flutter.kultiva.language': 'fr',
});
```

Sans la seconde, `load()` relit les préférences et écrase la première.

## Traduire un tuto

```bash
python3 tool/exporter_tutos.py --compte
python3 tool/exporter_tutos.py --squelette --langue=en --tuto=paillage
```

La clé est la **phrase française exacte**. Les 34 fichiers HTML ne sont
jamais modifiés : le dictionnaire est injecté dans la page et appliqué
dans le DOM au chargement. Colle le résultat dans
`lib/data/tutos_en.dart`, puis `flutter test test/tutos_i18n_test.dart`.

## Deux choses encore en français dans l'écran Recettes

Elles ne sont pas dans les recettes mais dans l'interface, donc elles
passeront par les ARB, pas par ce chantier :

- « Il te faut » et « Une idée pour ta récolte de… » (partage) ;
- « Pour 4 personnes · écrite pour 4 » (choix des parts).
