# Prompt — entraîner un modèle de reconnaissance du stade d'une plante

> À coller dans une nouvelle conversation Claude. Volontairement
> **général** : il parle du sujet, pas de Kultiva, pour qu'on puisse
> explorer librement avant de décider quoi que ce soit côté app.
>
> Écrit le 1er novembre 2026.

---

Je veux qu'on réfléchisse ensemble à l'entraînement d'un modèle de
vision pour reconnaître **le stade de croissance d'une plante
potagère** sur une photo prise au téléphone. Je ne cherche pas du code :
je veux comprendre la faisabilité, le coût réel et la bonne séquence.
Contredis-moi là où je me trompe.

## Le problème

Une photo d'un plant, prise par un jardinier amateur, en extérieur, en
lumière quelconque, cadrage quelconque. **L'espèce est connue** — elle
est donnée par ailleurs, le modèle n'a pas à la deviner. Ce qu'il doit
lire :

1. **le stade** parmi quatre : semis/plantule, croissance végétative,
   floraison, fructification ;
2. si possible, **l'état sanitaire** : feuillage sain, jaunissant,
   taché, flétri.

Savoir l'espèce à l'avance devrait simplifier beaucoup. Dis-moi si
c'est vrai, et comment en tirer parti : un modèle par espèce ? un
modèle unique avec l'espèce en entrée auxiliaire ? un modèle générique
dont on interprète la sortie différemment selon l'espèce ?

## Les contraintes

- **Inférence sur l'appareil**, hors ligne, sans serveur.
- **Léger** : quelques mégaoctets, pas des dizaines.
- **Rapide** : une réponse quasi immédiate sur un téléphone d'entrée de
  gamme de plusieurs années.
- Déployable dans une app mobile multiplateforme.

## Le point dur : les données

Je n'ai pas de jeu de données et je ne sais pas comment en obtenir un
proprement. Les photos des utilisateurs sont privées, et je ne veux pas
construire un produit qui dépend de leur captation.

- Existe-t-il des **jeux publics** utilisables ? Je connais
  PlantVillage (maladies foliaires, ~54 000 images, 38 classes, 14
  espèces) et PlantNet-300K (identification d'espèces). Ni l'un ni
  l'autre ne porte sur le **stade de croissance**, sauf erreur — corrige-moi,
  et cite tes sources.
- Peut-on **fabriquer** le jeu : photographier soi-même sur une saison,
  acheter des images, en générer ? Quel volume minimum viable pour
  4 classes ? Que vaut l'augmentation de données ici ?
- Un **opt-in explicite** de contribution est-il une voie honnête, et à
  quelles conditions juridiques et éthiques ?
- L'**apprentissage fédéré** ou l'entraînement sur l'appareil ont-ils un
  sens à cette échelle, ou est-ce un mirage sans infrastructure ?

## Ce que je veux savoir, dans cet ordre

1. **Un avis tranché sur la faisabilité.** Si la réponse est « ce
   problème est plus dur qu'il n'en a l'air, voilà pourquoi », dis-le et
   défends-le. Je préfère ça à un plan qui échoue dans six mois.
2. **Les options d'architecture** et leur coût : transfert
   d'apprentissage sur MobileNet / EfficientNet-Lite quantifié ? Quelle
   taille finale, quelle précision espérer sur 4 classes avec N images
   par classe, pour N = 100, 500, 2000 ?
3. **Le chemin des données**, puisque c'est lui qui décide de tout.
4. **Comment évaluer honnêtement** : quelle précision minimale avant
   d'oser montrer un résultat, et que faire en dessous de ce seuil.
5. **Ce que l'embarquement coûte** en poids, en démarrage et en
   maintenance.

## Un repère sur l'existant

Les modèles d'étiquetage générique embarqués (type ML Kit de Google)
reconnaissent quelques centaines de concepts dont « fleur », « fruit »,
« légume ». Comme l'espèce est déjà connue, ces étiquettes grossières
pourraient suffire à trancher le stade sans rien entraîner. Dis-moi
franchement si c'est une bonne première marche, ou une fausse piste qui
fera perdre du temps avant un vrai modèle.

## Ce qui compte le plus

Le résultat sert à conseiller quelqu'un sur sa nourriture. **Une
réponse fausse donnée avec assurance est pire que pas de réponse.** Si
le modèle hésite, je veux qu'il se taise. Garde ce principe dans tout
ce que tu proposeras — y compris dans le choix de la métrique
d'évaluation.

Pose-moi des questions si quelque chose te manque, et traite les points
un à la fois.
