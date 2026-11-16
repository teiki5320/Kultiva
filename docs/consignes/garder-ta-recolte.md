# Kultiva : onglet « Garder ta récolte » (alertes 18 et 19)

> Texte déplacé tel quel depuis `CLAUDE.md` le 16 novembre 2026, pour alléger les consignes lues à chaque session. Rien n'a été réécrit.

## 🫙 « Garder ta récolte » (structure arrêtée le 01/11/2026)

**Le top 3 d'un légume est fait de conservations.** Décision de Jean,
et c'est le pivot de tout l'onglet : un jardinier n'a pas une
courgette, il en a quinze d'un coup, et c'est le seul problème qu'un
livre de cuisine ne résout pas.

**Pourquoi c'est tenable.** Une conservation est une **méthode**
appliquée à un légume, pas une recette inventée pour lui.
`PreservationMethod` en compte neuf — congélation, blanchi puis
congelé, transformé puis congelé, bocal stérilisé, lacto-fermentation,
séchage, confiture, dans l'huile, au vinaigre. Neuf procédés écrits une
fois couvrent les 123 cultures comestibles ; 123 recettes sur mesure
auraient demandé quarante fois le travail.

⚠️ **`transformeCongele` est celle qu'on oublie.** J'ai d'abord affirmé
à Jean que les feuilles à salade étaient impossibles à conserver — « ni
congeler, ni sécher, ni mettre en bocal ». Il a répondu qu'un velouté
congelé **est** une conservation. Il avait raison, et c'est ce qui
couvre laitue, mâche, roquette et cresson. **La mâche est dans les
légumes de référence exprès**, pour que ce cas reste vérifié.

**Deux champs portent l'information qui décide** :

- `Recipe.method` — la méthode, ou `null` pour un plat du jour même.
- `Recipe.keeps` — « 1 an au placard », « 8 mois au congélateur ».
  Entre deux conservations, c'est **ça** qui tranche : un congélateur
  plein rend la stérilisation préférable, et inversement. Affiché dans
  la liste, pas seulement dans la fiche.

**Les trois légumes de référence** sont **tomate, fraise et mâche**.
Leurs neuf conservations sont écrites en entier. `recipes_test.dart`
exige pour chacun : trois conservations, chacune avec étapes,
ingrédients, temps, parts et durée de garde ; **au moins deux méthodes
distinctes** (la mâche est le plancher — une feuille tendre ne survit
que cuite puis congelée) ; et **une conservation rapide** (≤ 25 min),
sans quoi la seule réponse à un surplus demanderait deux heures pendant
que la récolte pourrit.

**Les plats à manger le jour même** ne sont pas perdus : ils quittent
le top 3 et vivent sous « N recettes à manger tout de suite », replié.
Un test vérifie que chacun des trois légumes en garde au moins un.

✅ **Les 123 légumes ont leurs trois conservations (01/11/2026).** Les
360 nouvelles ont été écrites sur le modèle de la tomate, de la fraise
et de la mâche, et placées **en tête** de chaque liste : les anciennes
recettes descendent sous « à manger tout de suite ». Le test du top 3
(trois conservations, deux méthodes au moins, une rapide, des étapes
complètes) s'applique désormais à **tous** les légumes, pas aux trois
de référence.

**Les règles de sécurité qu'elles suivent**, à garder pour toute
conservation ajoutée :

- **jamais de bocal stérilisé pour un légume peu acide** (haricot,
  carotte, courge, champignon, oignon, ail…) : risque de botulisme
  sans autoclave. Le bocal stérilisé est réservé aux fruits, à la
  tomate, à la rhubarbe, aux sirops ;
- vinaigre à 6 % minimum (8 % dans les recettes), **au moins autant de
  vinaigre que d'eau** ; pickles gardés au réfrigérateur ;
- saumure à **3 %** (30 g de sel par litre) ou 20 g par kg en sel sec ;
- tout ce qui est **dans l'huile** se garde au réfrigérateur ;
- manioc, taro et igname sont toujours **cuits** avant d'être mangés.

**Le temps d'une conservation compte son attente à température
ambiante** (fermentation, séchage, infusion), pas le temps passé au
réfrigérateur ou au congélateur : des piments séchés en guirlande,
c'est un mois ; des fraises congelées, un quart d'heure. `dureeLisible()` l'affiche en « 3
semaines » plutôt qu'en « 30240 min ». Une étape n'a de minuteur que
jusqu'à 12 h ; au-delà, son texte dit la durée.

### Le mécanisme du top 3 (inchangé)

Contrainte de Jean, et c'est la seule : **un top 3 par légume**. Trois
recettes mises en avant, jamais plus — vingt idées de plat ne se
choisissent pas. Et **une même recette peut servir plusieurs légumes**,
ce qu'il a explicitement autorisé.

**La donnée.** `recipesByVegetable` reste la source, mais une recette
déclare désormais les autres légumes qu'elle emploie (`Recipe.uses`).
Trois fonctions portent la structure, dans `lib/data/recipes.dart` :

- `top3For(id)` — les **trois premières** de la liste du légume.
  L'ordre du catalogue **est** le classement.
- `otherRecipesFor(id)` — ce qui dépasse de sa propre liste, **plus**
  les recettes d'autres légumes qui le citent dans `uses`. Sans ça, une
  recette hors du top 3 ne serait atteignable par aucun chemin : un bug,
  pas une réserve (règle 10). Un test le vérifie pour les 370.
- `ownerOf(recipe)` — le légume sous lequel la recette est rangée. La
  clé des favoris est `légume/nom` : une recette vue depuis un légume
  emprunteur doit garder la clé de son propriétaire, sinon elle
  apparaîtrait deux fois dans les favoris.

**À l'écran.** La fiche légume et l'onglet affichent le top 3, puis
« N autres recettes avec ce légume », replié. Chaque recette ouvre
**une fiche avec l'animation de ses étapes** (`recipe_player.html`, un
seul template nourri par du JSON) — minuteur par étape, ingrédients, et
quantités qui suivent le nombre de convives.

**Tomate et fraise sont les deux légumes de référence** : leurs trois
recettes du top ont étapes, ingrédients, temps et parts. Un test
l'exige, et exige aussi que le top 3 couvre **trois situations** — une
recette rapide (≤ 15 min), une de fond (≥ 55 min), et le surplus à
conserver. Trois recettes qui prennent toutes une heure ne servent à
rien à quelqu'un qui rentre du travail.

**Les plats du jour même** : 288 recettes n'ont pas encore d'étapes.
Elles s'ouvrent en fiche courte, qui dit la vérité au lieu d'afficher
un lecteur vide. Elles ne sont plus dans le top 3 (fait de
conservations) ; les écrire en pas-à-pas reste possible, légume par
légume, sans urgence.

⚠️ **Les chiffres sont verrouillés par deux tests** (`recipes_test.dart`) :
ajouter une recette fait échouer la suite jusqu'à ce que README,
`docs/MARKETING.md` et ce fichier soient corrigés. C'est volontaire :
les fiches ont annoncé « 340 recettes, dont huit animées » pendant une
journée alors qu'il y en avait 369 et 7.

18. **Le lecteur de recettes n'a jamais fonctionné jusqu'au
    01/11/2026** — page blanche sur les 88 recettes « animées ».

    **La cause** : `recipe_player.html` écrivait le marqueur
    `__RECIPE__` **deux fois**, une fois dans son commentaire d'en-tête
    et une fois dans son script. Dart appelle `replaceFirst`, donc
    c'est le **commentaire** qui recevait le JSON ; la ligne
    `var R = __RECIPE__;` restait intacte, le script mourait sur une
    variable inconnue, et il ne restait que les boutons.

    **Pourquoi rien ne l'a vu** : `flutter analyze` ne lit pas le HTML,
    `assets_exist_test.dart` vérifie qu'un fichier existe et pas ce
    qu'il contient, et aucun test ne remplissait le template. Découvert
    en voulant simplement montrer l'animation à Jean.

    `test/recipe_player_test.dart` verrouille maintenant : marqueur
    unique, aucun marqueur résiduel après remplissage, JSON relisible,
    et aucun appel réseau.

    ⚠️ **Leçon générale** : un asset qu'on remplit par substitution doit
    avoir un test qui fait la substitution. Le même piège attend les 33
    tutos si l'un d'eux devient paramétrable.

    ⚠️ **Et ça n'a pas suffi : le lecteur ne s'est ouvert dans l'app
    que le 02/11/2026.** Signalé par Jean — « les animations mettent
    beaucoup trop de temps à charger et d'ailleurs ne chargent même
    pas ». La cause était ailleurs, dans le Dart :

    ```dart
    onNavigationRequest: (_) => NavigationDecision.prevent,
    ```

    Le garde-fou, posé dès le premier commit de l'onglet pour que la
    recette reste un document fermé, refusait **toute** navigation. Or
    `loadHtmlString` **est** une navigation : la WKWebView la présente
    comme un passage vers `about:blank`. Le document était donc refusé
    lui-même, `onPageFinished` ne partait jamais, et l'écran restait
    sur son indicateur de chargement. On ne bloque plus que ce qui sort
    vraiment — `http`, `https`, `mailto`, `tel`.

    ⚠️ **Pourquoi personne ne l'avait vu** : la vérification du 01/11
    s'était faite dans **Chrome headless**, où il n'y a pas de
    `NavigationDelegate`. Le HTML était juste ; son hôte ne l'était
    pas. **Un asset rendu dans une WebView se vérifie dans la
    WebView**, pas dans un navigateur de bureau — et c'est maintenant
    possible, le simulateur rend l'écran.

19. **Le lecteur de recettes a été refait le 01/11/2026 (« Polaroïd »)**
    — choisi par Jean parmi seize maquettes. Toujours **un seul
    fichier**, `assets/recipes/recipe_player.html`, sans réseau, Nunito
    embarquée en base64, thème clair ou sombre lu dans le JSON.

    - Chaque étape est une **carte Polaroïd** (ruban adhésif vert,
      légende), avec au centre une **scène animée** en SVG/CSS : neuf
      gestes (laver, couper, mixer, cuire, attendre, saler, verser,
      mettre en bocal, congeler) choisis d'après l'emoji et le verbe de
      l'étape.
    - **Le légume joue dans la scène.** Dart envoie son image peinte et
      détourée dans le champ `vegetable` du JSON (`{name, emoji,
      image}` en data:URI, ~7 Ko) ; sans image, c'est son emoji.
    - Minuteurs réels, qui continuent quand on change d'étape, avec bip
      et vibration ; l'écran reste allumé.
    - Les sources de construction (moteur, scènes, variantes) ne sont
      pas dans le dépôt : le fichier livré **est** la source. Le
      modifier à la main, puis relancer `test/recipe_player_test.dart`.

    **Les légumes détourés** vivent dans
    `assets/images/vegetables_kawaii/detoure/` (130 WebP, 200 px, fond
    transparent, 1,5 Mo), produits par `tool/detoure_legumes.py`
    (rembg, modèle `isnet-general-use`). Un test exige qu'à chaque
    légume peint corresponde sa version détourée : **en ajoutant un
    légume, relancer l'outil** avec son id.
