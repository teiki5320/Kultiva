# Prompt — entraîner notre propre modèle de reconnaissance du stade

> À coller tel quel dans une nouvelle conversation Claude. Il est
> autonome : celle-ci n'aura pas le contexte de Kultiva.
>
> Écrit le 1er novembre 2026.

---

Je développe **Kultiva**, une app Flutter de jardinage (iOS + Android),
et je veux explorer avec toi l'entraînement d'un modèle de vision
embarqué. Je ne cherche pas encore du code : je veux qu'on réfléchisse
ensemble à la faisabilité, au coût réel et à la bonne séquence, et que
tu me contredises là où je me trompe.

## Le problème exact

L'utilisateur prend une photo d'un de ses plants. **L'espèce est déjà
connue** — c'est lui qui l'a saisie en plantant, l'app n'a pas à la
deviner. Ce que je veux lire sur la photo, c'est :

1. **le stade de croissance**, parmi quatre : semis/plantule,
   croissance végétative, floraison, fructification ;
2. si possible, **l'état sanitaire** : feuillage sain, jaunissant,
   taché, flétri.

Aujourd'hui, le stade est **déduit de la date de plantation** par une
heuristique (germination + catégorie du légume), et l'utilisateur peut
le corriger à la main sur une fiche. Ça marche, mais ça se trompe dès
qu'un semis a mal levé ou qu'un été pourri décale tout.

## Les contraintes, non négociables sauf si tu me démontres le contraire

- **Tout tourne sur l'appareil.** L'app n'a aucun backend, c'est une
  promesse écrite dans sa politique de confidentialité : rien ne quitte
  le téléphone sauf deux appels non bloquants (météo Open-Meteo,
  rapports de plantage Sentry). Une API de vision dans le cloud est
  donc exclue, à moins que tu m'expliques comment la rendre compatible
  avec cette promesse.
- **Hors ligne obligatoire.** L'app doit marcher sans réseau, y compris
  pour cette fonctionnalité.
- **Le poids compte.** Les assets font 36 Mo aujourd'hui. Un modèle de
  5 Mo passe, un de 50 Mo non.
- **iOS 15.0 minimum**, Android minSdk 24. Je ne veux pas relever ces
  bornes sans raison forte.
- Flutter / Dart, pas de framework d'état externe.

## Ce que je teste déjà en parallèle

Le modèle de base de **ML Kit** (Google), embarqué, gratuit, hors
ligne, ~400 étiquettes génériques dont « Flower », « Fruit » et
« Vegetable ». Comme l'espèce est connue, ces trois étiquettes
pourraient suffire à trancher le stade. C'est mon plan A parce qu'il ne
demande aucun entraînement.

**Pars du principe que ce plan A sera insuffisant** — c'est pour ça que
je veux parler d'un modèle à nous.

## Le problème dur, et je veux ton avis franc dessus

**Je n'ai pas de jeu de données, et je ne peux pas en collecter
facilement.** Les photos des utilisateurs sont privées et le restent :
les récupérer pour entraîner un modèle trahirait l'engagement de l'app.

L'app vient d'être modifiée pour enregistrer, à chaque fois que
quelqu'un corrige le stade à la main, le couple
(photo, stade corrigé, espèce, jours depuis plantation) — **localement
et localement seulement**. C'est un jeu d'exemples étiquetés qui se
construit, mais il est sur les téléphones, pas chez moi.

Les questions que ça pose et sur lesquelles j'attends que tu me
pousses :

- Existe-t-il des **jeux de données publics** exploitables ? Je connais
  PlantVillage (maladies foliaires, ~54 000 images, 38 classes, 14
  espèces) et PlantNet-300K (identification d'espèces sauvages). Aucun
  ne porte sur le **stade de croissance** à ma connaissance — dis-moi
  si je me trompe, et cite tes sources.
- Un **opt-in explicite** pour contribuer ses photos à l'entraînement
  est-il acceptable, et à quelles conditions ? Qu'est-ce que ça
  implique côté RGPD, App Store (questionnaire de confidentialité) et
  rédaction de la politique ?
- L'**apprentissage fédéré** ou l'entraînement sur l'appareil ont-ils
  un sens à cette échelle, ou est-ce un mirage pour une app sans
  backend ?
- Peut-on **fabriquer** un jeu de données : photographier soi-même un
  potager sur une saison, acheter des images, générer des images
  synthétiques ? Quel volume minimum pour 4 classes ?

## Ce que j'attends de la conversation

Dans cet ordre, et une chose à la fois :

1. **Un avis tranché sur la faisabilité.** Si ta réponse est « ne fais
   pas ça, l'heuristique par date suffit », dis-le et défends-le — je
   préfère ça à un plan qui échoue dans six mois.
2. **Les options d'architecture**, avec leurs coûts réels : transfert
   d'apprentissage sur MobileNet/EfficientNet-Lite quantifié ? Quelle
   taille finale ? Quelle précision espérer sur 4 classes avec N
   images par classe, pour N = 100, 500, 2000 ?
3. **Le chemin du jeu de données**, c'est le point qui décide de tout.
4. **Comment évaluer honnêtement** : quelle précision minimale avant
   d'oser afficher un résultat à l'utilisateur, et que faire en
   dessous de ce seuil (se taire plutôt que se tromper).
5. **Comment l'embarquer** dans Flutter, et ce que ça coûte en poids et
   en temps de démarrage.

Pose-moi des questions si quelque chose te manque. Ne me donne pas de
code tant qu'on n'est pas d'accord sur la direction.

## Un détail qui compte

C'est une app de jardinage qui conseille des gens sur leur nourriture.
**Une réponse fausse avec assurance est pire que pas de réponse.** Si
le modèle hésite, je veux qu'il se taise. Garde ça en tête dans tout ce
que tu me proposeras.
