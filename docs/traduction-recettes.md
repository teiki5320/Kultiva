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
| Recettes — 21 légumes sur 123 | ✅ anglais (tomate = le modèle, + lot 1) |
| Recettes — les 102 légumes restants | ⬜ à faire, 6 lots |
| Tutos — mécanisme | ✅ dictionnaire injecté dans le DOM |
| Tutos — `conserver_legumes` | ✅ anglais, **le modèle** |
| Tutos — les 32 autres | ⬜ à faire (`tool/exporter_tutos.py`) |
| Maladies, badges, défis, lexique, conseils | ⬜ structure pas encore faite |

**Le prix réel d'un lot de recettes, mesuré** : 190 000 jetons sur
Sonnet pour 20 légumes et 120 recettes — soit ≈ 1,3 million de jetons
par langue. L'agent lit, vérifie et réfléchit en plus d'écrire.

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
