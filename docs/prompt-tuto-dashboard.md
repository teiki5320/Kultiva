# Prompt — refaire le tuto animé « Découvrir l'application »

> À coller tel quel dans une session Claude orientée design. Il est
> autonome : la session d'en face n'a pas le dépôt.
>
> Pourquoi ce prompt existe : le tuto actuel
> (`assets/tutos/decouvrir_dashboard.html`) est une timeline GSAP posée
> sur dix **captures d'écran** prises le 22 août 2026. Elles montrent
> une barre d'onglets qui n'existe plus et trois scènes d'un Poussidex
> supprimé le 31 octobre. Les refaire demande un simulateur qui
> affiche quelque chose, et `Simulator.app` manque à l'installation de
> Xcode de la machine.
>
> **La consigne contourne le problème** : le nouveau tuto ne contient
> aucune capture. L'interface est redessinée en HTML/CSS. Il ne
> pourra donc plus jamais être périmé par un changement d'écran sans
> qu'on s'en aperçoive — et il pèsera quelques kilo-octets au lieu de
> 1,4 Mo de JPEG.

---

Tu dois produire **un seul fichier HTML autonome** : un tutoriel animé
qui fait visiter une application mobile de jardinage. Il sera affiché
dans une WebView à l'intérieur de l'app elle-même, en portrait.

## L'application

**Kultiva**, app de jardinage en français, pour la France
métropolitaine et huit pays d'Afrique de l'Ouest. Style **pastel
kawaii japonais** : coins très arrondis (cartes 18 px, pastilles
20 px), ombres douces, illustrations tendres, emoji présents mais
sobres. Police **Nunito** (Google Fonts).

Palette, à respecter exactement :

| Rôle | Hex |
| --- | --- |
| Fond de page | `#F5FAF8` |
| Vert primaire | `#4A9B5A` |
| Vert clair | `#A8D5A2` |
| Terracotta | `#E8A87C` |
| Texte | `#2A4A3A` |
| Texte secondaire | `#8AAB8A` |
| Bleu arrosage | `#4A9BBF` |
| Or des badges | `#E8B923` |
| Rose des défis | `#FF8FAB` |

Ton de voix : chaleureux, tutoiement, enfantin sans être niais.
« Le potager kawaii dans ta poche 🌱 ».

## La barre d'onglets, en bas, cinq onglets

1. 🏠 **Home** — le tableau de bord
2. 📔 **Cahier** — le cahier de culture (l'onglet qu'on ouvre chaque jour)
3. 🛒 **Étal** — le catalogue
4. 🍴 **Recettes** — « Garder ta récolte », les conservations
5. 🎓 **Tutos** — les tutoriels

⚠️ Ce prompt disait « quatre onglets » jusqu'au 02/11/2026, et le tuto
produit avec lui en montrait quatre alors que l'app en avait cinq
depuis le 01/11. Un prompt périmé regénère un tuto périmé : le
corriger **avant** de relancer une session design.

L'onglet actif est vert `#4A9B5A`, les autres gris-vert.

## Ce que montre chaque écran

**Home.** Un bandeau illustré de saison en haut (dégradé + nom de la
saison + mois en gros + température), puis six cartes pastel sur deux
colonnes : « Semer · 74 légumes », « Récolter · 39 légumes »,
« Calendrier · Vue annuelle », « Légume du jour · Mâche »,
« Défis & badges · 50 défis photo, 50 badges », « Actualités ·
Suis-nous sur Instagram ».

**Cahier.** Bandeau « 📔 Cahier de culture » avec en sous-titre
« 2 jardins · 6 cases occupées · 4 plants suivis ». Puis, dans
l'ordre : une carte blanche **« À faire aujourd'hui »** qui liste
« 💧 Arroser : tomate, basilic » avec un bouton **Arroser**, et
« 🧺 À récolter : laitue » ; une section **Mes jardins** avec deux
cartes vertes portant chacune la miniature de sa grille (des
pastilles colorées, une par case) ; une section **Au jardin en ce
moment** qui liste les plants avec leur âge et leur dernier arrosage ;
une section **Journal**.

**Journal.** Une suite datée, du plus récent au plus ancien :
« AUJOURD'HUI — 💧 Arrosé · tomate », « HIER — 🧺 Récolté · radis ·
📷 Photo · courgette », « 12 MAI — 🌱 Planté · 3 tomates ».

**Étal.** Une barre de recherche, une rangée de pastilles de familles
(Toutes, Fleurs, Feuilles, Fruits, Bulbes…) et une grille de cartes de
légumes avec leur illustration.

**Calendrier annuel.** Une ligne par légume : son nom au-dessus, et en
dessous une barre de douze segments — vert pour un mois de semis,
terracotta pour un mois de récolte, coupée en deux quand les deux
tombent le même mois. Une bande verte translucide marque la colonne du
mois en cours.

**Défis & badges.** Deux onglets. Une grille de défis photo, et une
grille de médaillons ronds à cadre ouvragé bronze, argent et or.

## Les scènes, dans cet ordre

Une par écran, 2,5 s chacune, environ 25 s en tout, en boucle.
Chaque scène : un halo pulsé qui désigne l'élément dont on parle, puis
une légende qui apparaît par le bas.

1. **Home** — « Ton tableau de bord » / « Tout ce qu'il y a à faire aujourd'hui, en un coup d'œil. »
2. **Semer** — « Que semer ce mois-ci ? » / « La liste change avec ta région et la saison. »
3. **Récolter** — « Et que récolter » / « Ce qui est prêt, maintenant, chez toi. »
4. **Calendrier** — « Toute l'année d'un seul regard » / « Une ligne par légume, douze mois, rien à faire défiler de côté. »
5. **Cahier → À faire aujourd'hui** — « Ton cahier de culture » / « Qui a soif, qui est mûr, et s'il va faire trop chaud. »
6. **Cahier → Mes jardins** — « Dessine tes carrés » / « Place tes plants par glisser-déposer, chaque case se souvient. »
7. **Journal** — « Ta saison, jour par jour » / « Chaque semis, chaque arrosage, chaque récolte s'inscrit à sa date. »
8. **Étal** — « L'Étal, ton marché kawaii » / « 130 cultures en fiches détaillées, plus les accessoires. »
9. **Défis & badges** — « 50 défis photo, 50 badges » / « Les badges récompensent ce que tu fais vraiment au jardin. »
10. **Final** — « 🎒 En résumé » / « Semer, récolter, suivre et apprendre — tout tient dans ta poche. »

## Le contrat technique

- **Un seul fichier `.html`**, tout en ligne : CSS et JS dedans.
- **Aucune image externe, aucune capture d'écran.** Tu redessines les
  écrans en HTML/CSS. C'est le point important : le tuto doit rester
  juste même si l'app change de pixels.
- Animation avec **GSAP 3**, chargé depuis
  `https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/gsap.min.js`,
  qui est le seul réseau autorisé.
- **Portrait**, cadre de téléphone centré, tout doit tenir sans
  défilement sur un écran de 390 × 844 points.
- Boucle infinie, avec un bouton pause/lecture discret.
- Textes **en français**, tutoiement.
- `prefers-reduced-motion` : si l'utilisateur l'a demandé, pas
  d'animation — on affiche les dix scènes à la suite, en liste.
- Accessibilité : les légendes sont du vrai texte, lisible par
  VoiceOver, pas des images.
- Pas de police distante autre que Nunito via Google Fonts ; prévois
  une pile de repli système.

Le fichier remplacera `assets/tutos/decouvrir_dashboard.html`.
