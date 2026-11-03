# FICHE_APP_STORE.md — remplir la fiche App Store de Kultiva

> Tout est prêt à copier-coller, dans l'ordre exact des écrans
> d'App Store Connect. Généré le 2026-08-04 par scan du dépôt
> (v1.0.0+5, bundle `com.toa.kultiva`, team `K597U7X3FZ`).
> Les décomptes sont calculés pour de vrai (les mots-clés en octets).
> Ce qui dépend de toi est dans la liste « À préparer » en fin de
> document — rien d'inventé, aucun faux exemple.

---

## 1. Page « Informations sur l'app »

### 1.1 Informations localisables (français)

**Nom** — 7/30 caractères :

```
Kultiva
```

Si « Kultiva » est déjà pris par une autre app (ça se découvre au moment
de créer l'app dans ASC), plan B — 24/30 :

```
Kultiva : potager kawaii
```

⚠️ Si tu utilises le plan B, retire `potager` et `kawaii` des mots-clés
(section 2.4) : Apple indexe déjà le nom.

**Sous-titre** — 27/30 caractères :

```
Ton potager kawaii de poche
```

### 1.2 Informations générales

| Champ | Valeur |
| --- | --- |
| Identifiant de lot | `com.toa.kultiva` (proposé automatiquement si le build est uploadé) |
| UGS (SKU) | `kultiva-ios-001` — identifiant interne, jamais public, n'importe quelle chaîne unique convient |
| Catégorie principale | **Style de vie** |
| Catégorie secondaire | **Éducation** (tutoriels, lexique, guide des maladies) |
| Droits relatifs au contenu | **« Non, elle ne contient pas de contenu de tiers »** — tout le contenu (textes, illustrations, tutos) est produit pour l'app |
| Contrat de licence | Laisser le contrat standard d'Apple (ne rien toucher) |

### 1.3 Classifications par âge (questionnaire 2025)

Réponses à donner, dans l'ordre des sept catégories :

| Catégorie | Réponse | Pourquoi (si ça peut faire hésiter) |
| --- | --- | --- |
| Contrôles intégrés (contrôle parental, vérification d'âge) | **Aucun** | L'app n'en propose pas — c'est une réponse valide, pas un manque |
| Capacités — accès web sans restriction | **Non** | Les WebView n'affichent que les tutos HTML embarqués, pas de navigation libre |
| Capacités — contenu généré par les utilisateurs | **Non** | Aucune photo n'est partagée ni affichée à d'autres utilisateurs. Tout reste sur l'appareil : l'app n'a ni compte, ni serveur, ni feed |
| Capacités — réseaux sociaux | **Non** | Pas de profils, pas d'abonnés, pas de messagerie, pas de feed |
| Thèmes matures (grossièretés, horreur, alcool/tabac/drogues) | **Aucun** | |
| Médical ou bien-être | **Non** | Des conseils de jardinage ne sont pas du contenu médical |
| Sexualité ou nudité | **Aucune** | |
| Violence | **Aucune** | |
| Activités basées sur le hasard (jeux d'argent, loot boxes, concours) | **Aucune** | Les défis photo n'ont ni mise ni prix monnayable ; les badges sont débloqués par l'action, pas par le hasard |

**Résultat attendu : 4+.** Le feed communautaire ayant été retiré de
la v1, plus rien ne relève du contenu généré par les utilisateurs — le
palier 13+ tombe. Si ASC affiche autre chose, laisse son calcul faire
foi.

⚠️ Si le feed revient dans une version ultérieure, il faudra repasser
« contenu généré par les utilisateurs » à **Oui**, remonter au palier
13+, et livrer signalement **et** blocage d'utilisateur (guideline 1.2).

### 1.4 Documents sur le chiffrement

**Rien à faire.** `ITSAppUsesNonExemptEncryption = false` est déjà
déclaré dans `ios/Runner/Info.plist` — la question ne sera même pas
posée à l'upload.

### 1.5 Réglementations — déclaration DSA (obligatoire pour l'UE)

⚠️ **Cette section a dit faux pendant deux semaines (corrigé le
03/11/2026).** Elle annonçait que l'app ne tirait plus aucun revenu et
que le statut **non-trader** redevenait possible. C'était vrai le
21/10, et faux dès le 30/10 : les 159 liens d'affiliation sont
**revenus** sous le tag `kultiva1-21`, vérifié dans le code
(`kAmazonAffiliateTag` et 159 `amazonQuery` dans
`lib/data/vegetables_base.dart`).

**Tu es donc trader**, et il n'y a rien à trancher : l'app tire un
revenu de l'affiliation en France, le statut s'applique. La question
ne se rouvrirait que si l'affiliation repartait.

**Si tu restes trader, ce que ça implique concrètement.** Tu fournis une adresse postale, un
téléphone et un e-mail. Apple les vérifie, puis les **affiche
publiquement** sur ta fiche App Store dans les 27 pays de l'UE.

**Protège tes coordonnées personnelles** — c'est permis et recommandé :

- **Adresse** : une **boîte postale est acceptée**. Inutile de publier
  ton domicile. Une BP coûte quelques dizaines d'euros par an à La Poste.
- **E-mail** : utilise `kultiva@toakeur.com`, déjà câblé partout dans
  l'app et sur la landing — pas ton adresse personnelle.
- **Téléphone** : le numéro sera public. Si tu ne veux pas exposer ton
  mobile, un numéro secondaire (ligne VoIP, forfait dédié) fait l'affaire.

**Chemin dans ASC** : Entreprise → Accords → section Conformité →
Digital Services Act. Le statut peut ensuite s'ajuster app par app dans
Informations sur l'app → Réglementations.

**Si tu passes non-trader** : aucune coordonnée n'est publiée. Le
statut se change à tout moment.

Ceci n'est pas un avis juridique — en cas de doute réel, vérifie avec un
professionnel.

---

## 2. Page de la version « iOS 1.0 »

### 2.1 Captures d'écran

Deux tailles à fournir, 3 à 10 captures chacune, PNG ou JPEG **sans
transparence**, l'app étant verrouillée portrait :

- **iPhone 6,9″** : 1320 × 2868 px (simulateur iPhone 16 Pro Max)
- **iPad 13″** : 2064 × 2752 px (simulateur iPad Pro 13″) —
  **obligatoire** car l'app cible aussi l'iPad
  (`TARGETED_DEVICE_FAMILY = 1,2`)

Ordre conseillé — rappel : **seules les deux premières sont visibles
sans défilement**, elles font la décision :

1. **Le calendrier du mois** — la promesse de l'app (« que semer en ce
   moment ») avec le bandeau de saison
2. **Le cahier de culture** — « à faire aujourd'hui » et l'aperçu des
   jardins : ce que l'app fait pour toi chaque matin
3. Le journal du jardin (la saison jour par jour)
4. Une fiche culture détaillée (tomate)
5. Le planner du potager en carrés (glisser-déposer en cours)
6. Météo 7 jours avec une alerte arrosage ou canicule
7. Les défis photo et badges
8. (facultatif) Le calendrier en mode Afrique de l'Ouest (hivernage) —
   montre le bi-marché

✅ **Les 1 à 7 sont prises** (03/11/2026), dans les deux tailles, sur
une installation garnie — 6 plants suivis, un potager 4×4 à six
cases, 13 badges débloqués. Elles sont dans `build/captures/` :
`iphone69/` et `ipad13/`, nommées dans l'ordre ci-dessus. La 8 reste
à faire, et elle est facultative.

⚠️ **`build/` n'est pas suivi par git** : ces fichiers vivent sur le
Mac de Jean et disparaîtront à un `flutter clean`. Les déposer dans
App Store Connect, ou les copier ailleurs, avant d'y toucher.

Pour les refaire : `tool/garnir_simulateur.py` écrit le jardin dans
les préférences du simulateur, sans un seul geste à l'écran. Des
écrans vides ne vendent rien, et les garnir à la main coûtait une
cinquantaine de gestes.

### 2.2 Texte promotionnel — 125/170 caractères

Modifiable à tout moment sans nouvelle version :

```
Semis, récoltes, météo et cahier de culture : Kultiva t'accompagne des premières graines à la fierté de la première tomate. 🌱
```

### 2.3 Description — 2 697/4 000 caractères

Texte brut, sans HTML. Les trois premières lignes accrochent avant le
« plus » :

```
Le potager kawaii dans ta poche 🌱

Kultiva t'accompagne du choix des graines à la fierté de la première tomate — que tu jardines sur un balcon en ville, dans un carré potager en Bretagne… ou sous les premières pluies de Dakar : l'app couvre 73 pays sur six continents, en français, en anglais et en espagnol.

📅 UN CALENDRIER QUI CONNAÎT TA RÉGION
Chaque mois, découvre quoi semer, planter et récolter chez toi. Semis sous abri, pleine terre, récoltes : tout est adapté à ton climat, et exportable en PDF pour l'accrocher dans l'abri de jardin.

🌽 130 CULTURES EN FICHES DÉTAILLÉES
Tomate, courgette, radis, fraisier, basilic… mais aussi gombo, niébé, mil ou bissap. Pour chaque plante : profondeur de semis, exposition, arrosage, distances de plantation, rendement estimé et petits conseils de pro.

🫙 GARDER TA RÉCOLTE
736 recettes, et les trois premières de chaque légume sont des façons de le conserver : bocal, congélation, séchage, lacto-fermentation, confiture. Chacune dit combien de temps ça se garde, et 448 se déroulent pas à pas, hors ligne, minuteur compris.

📓 MES JARDINS, TON POTAGER EN CARRÉS
Dessine tes carrés, place tes plants par glisser-déposer et suis chacun d'eux : arrosages, phases de croissance auto-suggérées, photos, avertissement de rotation des cultures et conseils selon la météo du jour.

📔 CHAQUE MATIN, CE QU'IL Y A À FAIRE
Ton cahier de culture répond à la seule question qui compte au réveil : qui a soif, qui est mûr, et s'il va faire trop chaud aujourd'hui. Un geste pour noter l'arrosage de tout le jardin.

👨‍👩‍👧 POUR JARDINER EN FAMILLE
Tutoriels pas à pas, défis photo et badges à collectionner : Kultiva est pensée pour donner la main verte aux enfants — et transformer le potager en aventure du dimanche.

🌦️ MÉTÉO ET ALERTES MALINES
Prévisions 7 jours pour ta ville, rappels d'arrosage intelligents, alertes canicule avec conseils légume par légume. Ton jardin te prévient avant d'avoir soif.

📖 LE JOURNAL DE TON JARDIN
Chaque plantation, chaque arrosage, chaque récolte et chaque photo s'inscrit à sa date. Relis ta saison jour par jour, et gagne des médailles bronze, argent et or pour chaque légume cultivé.

📸 DÉFIS PHOTO ET BADGES
50 défis photo et 50 badges à débloquer. Les badges récompensent ce que tu fais vraiment : ton premier plant, trois jours d'arrosage d'affilée, un carré entièrement rempli.

🎓 POUR APPRENDRE EN S'AMUSANT
33 tutoriels illustrés, un lexique du jardinier, un guide des maladies et le compagnonnage (qui aime pousser à côté de qui).

Et surtout : Kultiva fonctionne sans connexion et sans compte. Tes données restent sur ton téléphone, et nulle part ailleurs.

Télécharge Kultiva et fais pousser ton premier bonheur. 🌸
```

> Cette fiche fr-FR est **mondiale** côté App Store (une seule fiche par
> langue). Les variantes Afrique de l'Ouest de
> `docs/store-listings.md` serviront sur la **Play Console** (fiches
> personnalisées par pays), pas ici.

### 2.4 Mots-clés — **98/100 octets** (calculé en UTF-8, accents = 2 octets)

Sans espaces après les virgules, et **sans répéter** les mots du nom et
du sous-titre (`Kultiva`, `potager`, `kawaii`, `poche`) qu'Apple indexe
déjà séparément :

```
jardinage,semis,jardin,légumes,calendrier,récolte,plantes,graines,balcon,météo,arrosage,tomate
```

### 2.5 URLs

| Champ | Valeur |
| --- | --- |
| URL d'assistance (obligatoire) | `https://kultiva.toakeur.com` |
| URL marketing (facultative) | `https://kultiva.toakeur.com` (la même), ou laisser vide |

### 2.6 Version

```
1.0.0
```

(Le champ « Nouveautés de cette version » n'apparaît qu'à partir de la
version 2 — rien à écrire pour une première soumission.)

### 2.7 Informations générales sur l'app (sur la page de version)

**Droits d'auteur** — c'est ICI qu'il se remplit, format « année nom »
sans le symbole © (Apple l'ajoute) — 20 caractères :

```
2026 Jean Perraudeau
```

| Champ | Valeur |
| --- | --- |
| Build | Sélectionner le dernier build Xcode Cloud uploadé |
| Game Center | **Non** — badges et médailles sont internes à l'app, aucun classement en ligne |

### 2.8 Informations pour la revue

| Champ | Valeur |
| --- | --- |
| Nom | Jean Perraudeau |
| E-mail | `kultiva@toakeur.com` |
| Téléphone | → **voir « À préparer »** |
| Compte de démonstration | **Sans objet** — l'app ne propose pas de compte. Laisse la case « Connexion requise » décochée. |

**Notes au testeur** — 1 156/4 000 caractères, à coller telles quelles :

```
Kultiva est une application de jardinage 100 % en français, destinée à la France et à 8 pays francophones d'Afrique de l'Ouest.

• Aucun compte : l'app n'a pas d'écran de connexion et ne demande aucune donnée personnelle. Elle s'ouvre directement sur son contenu. Il n'y a donc ni inscription, ni mot de passe, ni suppression de compte à tester.
• Localisation : facultative. En cas de refus, l'app bascule automatiquement sur la météo de Paris (ou de la capitale du pays choisi) — ce n'est pas un bug.
• Premier lancement : l'app propose de choisir son pays ; la liste s'adapte à la langue de l'appareil et, si la permission existe déjà, à sa position.
• Défis photo : les photos restent sur l'appareil, dans le stockage privé de l'app. Elles ne sont jamais envoyées, publiées ni montrées à d'autres utilisateurs — l'app ne contient aucun feed ni contenu généré par les utilisateurs.
• Notifications : locales uniquement (rappels de semis, d'arrosage, alertes canicule) — aucun push serveur.
• Badges et médailles sont calculés sur l'appareil à partir des gestes de jardinage enregistrés : aucun classement en ligne, aucune comparaison entre utilisateurs.
```

### 2.9 Publication

**Manuelle** — tu contrôles le moment de la mise en ligne (utile pour
caler le lancement sur le calendrier marketing, cf.
`docs/MARKETING.md` : février-mars en France).

---

## 3. Page « Tarifs et disponibilité »

| Champ | Valeur |
| --- | --- |
| Prix | **Gratuit** (palier 0,00 €) |
| Achats intégrés | Aucun — rien à créer |
| Disponibilité | **Tous les pays** (recommandé : la langue filtre naturellement, et la diaspora francophone est partout). A minima : France, Belgique, Suisse, Luxembourg, Canada, Sénégal, Côte d'Ivoire, Mali, Burkina Faso, Bénin, Togo, Niger, Guinée |

---

## 4. Page « Confidentialité de l'app »

⚠️ **Ne déclare pas « aucune donnée collectée » trop vite.** L'app n'a
plus ni compte ni serveur depuis le 30/10/2026, mais **Sentry** remonte
toujours les plantages et la **position** part vers Open-Meteo : il reste
donc deux types à déclarer. Une fausse déclaration est un motif de rejet,
voire de retrait après publication.

**URL de la politique de confidentialité** :
`https://kultiva.toakeur.com/privacy.html`

Réponses au questionnaire, type par type :

| Type de données | Donnée | Liée à l'identité ? | Utilisée pour le suivi ? | Finalité |
| --- | --- | --- | --- | --- |
| Localisation | Position précise | **Non** | Non | Fonctionnement de l'app (coordonnées envoyées à Open-Meteo pour la météo, jamais enregistrées) |
| Diagnostic | Données de plantage | **Non** | Non | Fonctionnement de l'app (Sentry — aucun identifiant utilisateur attaché dans le code) |

**Ne déclare rien d'autre.** Les photos, les plantations, les notes et
la créature ne quittent jamais l'appareil : Apple ne considère comme
« collectées » que les données transmises hors de l'appareil. Et il n'y a
plus ni adresse e-mail, ni nom, ni identifiant utilisateur à déclarer
depuis le retrait des comptes.

**Données utilisées pour te suivre (tracking)** : **AUCUNE** — pas de
publicité, pas d'analytics, pas de partage inter-apps → pas de popup ATT.

---

## 5. À préparer (le dépôt ne peut pas te le donner)

1. **Ton numéro de téléphone** — champ obligatoire des informations
   pour la revue.
2. ~~**Une installation garnie pour les captures**~~ — ✅ **fait le
   03/11/2026.** `tool/garnir_simulateur.py` écrit le jardin
   directement dans les préférences du simulateur : 6 plants avec
   leurs arrosages et récoltes datés, un potager 4×4 à six cases,
   13 badges débloqués. ⚠️ Redémarrer le simulateur après l'écriture,
   sinon iOS sert ses préférences depuis son cache.
3. **Tes coordonnées de trader** (§1.5 — tu l'es, l'affiliation est
   revenue le 30/10/2026) : adresse postale (**une BP suffit**),
   téléphone et e-mail, qui seront **publics dans l'UE**.

---

## 6. État d'avancement

| Élément | État |
| --- | --- |
| Nom, sous-titre, texte promo, description, mots-clés | ✅ Prêts à coller (décomptes vérifiés) |
| Catégories, droits sur le contenu, UGS | ✅ Réponses fournies |
| Questionnaire de classification par âge | ✅ Réponses fournies (attendu : **4+** depuis le retrait du feed, §1.3) |
| Chiffrement | ✅ Rien à faire (Info.plist déjà configuré) |
| Droits d'auteur, version, publication | ✅ Prêts |
| Questionnaire de confidentialité | ✅ Réponses fournies (§4) — réduit à 2 types depuis le retrait des comptes |
| Notes au testeur | ✅ Prêtes à coller |
| Build | ✅ Xcode Cloud opérationnel — sélectionner le dernier |
| URL d'assistance / marketing / confidentialité | ✅ `kultiva.toakeur.com` en ligne (§2.5, §4) — ⏳ Toi : les coller dans ASC |
| Téléphone (revue) | ⏳ Toi |
| Compte de démonstration | ✅ Sans objet — l'app n'a pas de compte (§2.8) |
| Déclaration DSA | ⏳ Toi — **trader** (§1.5), l'affiliation est revenue le 30/10/2026 |
| Captures d'écran | ⏳ Toi (sur une installation garnie, §5) |

---

## 7. Localisations anglaise et espagnole

> ⚠️ **Ajoutées le 2 novembre 2026.** Cette fiche était écrite pour une
> app française seule, alors que l'application parle les trois langues
> depuis le même jour — 4 894 chaînes par langue. Une fiche App Store
> est **par langue** : sans ces deux-là, un anglophone qui cherche
> « gardening calendar » ne trouve rien.
>
> Dans App Store Connect : page de la version → menu de langue en haut
> à droite → **Ajouter une langue** → English (U.S.) puis
> Spanish (Spain). Les captures peuvent être les mêmes qu'en français
> tant qu'elles ne portent pas de texte incrusté.

### 7.1 English (U.S.)

**Name** — 7/30 :

```
Kultiva
```

**Subtitle** — 25/30 :

```
Your pocket kawaii garden
```

**Promotional text** — 128/170 :

```
Sowing, harvests, weather and a growing journal: Kultiva walks with you from the first seeds to the pride of the first tomato. 🌱
```

**Description** — 2616/4 000 :

```
The kawaii vegetable garden in your pocket 🌱

Kultiva walks with you from choosing the seeds to the pride of the first tomato — whether you garden on a city balcony, in a raised bed in Brittany, or under the first rains of Dakar: the app covers 73 countries on six continents, in French, English and Spanish.

📅 A CALENDAR THAT KNOWS WHERE YOU LIVE
Every month, find out what to sow, plant and harvest where you are. Under cover, in open ground, harvests: everything follows your climate — nine climate zones and both hemispheres — and it exports to PDF to pin up in the shed.

🌽 130 CROPS IN DETAILED CARDS
Tomato, courgette, radish, strawberry, basil… and also okra, cowpea, millet and hibiscus. For each plant: sowing depth, aspect, watering, spacing, expected yield and the small things that make the difference.

🫙 KEEPING YOUR HARVEST
736 recipes, and the first three for every vegetable are ways to keep it: jars, freezing, drying, lacto-fermentation, jam. Each one says how long it keeps, and 448 walk you through step by step, offline, with a timer.

📓 MY GARDENS, YOUR BED BY BED
Draw your beds, place your plants by dragging them, and follow each one: watering, growth stages suggested for you, photos, a crop-rotation warning and advice based on today's weather.

📔 EVERY MORNING, WHAT NEEDS DOING
Your growing journal answers the only question that matters when you wake up: who is thirsty, what is ripe, and whether it will be too hot today. One tap logs the watering for the whole garden.

👨‍👩‍👧 FOR GARDENING AS A FAMILY
Step-by-step tutorials, photo challenges and badges to collect: Kultiva is built to give children green fingers — and turn the garden into a Sunday adventure.

🌦️ WEATHER AND SMART ALERTS
A 7-day forecast for your town, sensible watering reminders, heatwave alerts with advice crop by crop. Your garden warns you before it gets thirsty.

📖 YOUR GARDEN'S DIARY
Every planting, every watering, every harvest and every photo is written down on its date. Read your season back day by day, and earn bronze, silver and gold medals for each vegetable you grow.

📸 PHOTO CHALLENGES AND BADGES
50 photo challenges and 50 badges to unlock. The badges reward what you actually do: your first plant, three days of watering in a row, a bed filled right to the edges.

🎓 LEARNING WHILE HAVING FUN
33 illustrated tutorials, a gardener's glossary, a guide to diseases and companion planting (who likes growing next to whom).

And above all: Kultiva works with no connection and no account. Your data stays on your phone, and nowhere else.

Download Kultiva and grow your first small happiness. 🌸
```

**Keywords** — **96/100 bytes** :

```
gardening,sowing,garden,vegetables,calendar,harvest,plants,seeds,balcony,weather,watering,tomato
```

### 7.2 Spanish (Spain)

**Nombre** — 7/30 :

```
Kultiva
```

**Subtítulo** — 28/30 :

```
Tu huerto kawaii de bolsillo
```

**Texto promocional** — 126/170 :

```
Siembras, cosechas, tiempo y cuaderno de cultivo: Kultiva te acompaña de las primeras semillas al orgullo del primer tomate. 🌱
```

**Descripción** — 2709/4 000 :

```
El huerto kawaii en tu bolsillo 🌱

Kultiva te acompaña desde la elección de las semillas hasta el orgullo del primer tomate — cultives en un balcón de ciudad, en un bancal en Bretaña o bajo las primeras lluvias de Dakar: la app cubre 73 países en seis continentes, en francés, inglés y español.

📅 UN CALENDARIO QUE CONOCE TU ZONA
Cada mes, descubre qué sembrar, plantar y cosechar donde vives. Siembra protegida, plena tierra, cosechas: todo se adapta a tu clima — nueve zonas climáticas y los dos hemisferios — y se exporta en PDF para colgarlo en la caseta.

🌽 130 CULTIVOS EN FICHAS DETALLADAS
Tomate, calabacín, rábano, fresa, albahaca… y también quimbombó, judía de ojo negro, mijo o hibisco. De cada planta: profundidad de siembra, exposición, riego, marco de plantación, rendimiento estimado y los pequeños trucos que marcan la diferencia.

🫙 GUARDAR LA COSECHA
736 recetas, y las tres primeras de cada hortaliza son formas de conservarla: tarros, congelación, secado, fermentación, mermelada. Cada una dice cuánto se guarda, y 448 te llevan paso a paso, sin conexión y con temporizador.

📓 MIS HUERTOS, BANCAL A BANCAL
Dibuja tus bancales, coloca las plantas arrastrándolas y sigue cada una: riegos, fases de crecimiento sugeridas, fotos, aviso de rotación de cultivos y consejos según el tiempo de hoy.

📔 CADA MAÑANA, LO QUE HAY QUE HACER
Tu cuaderno de cultivo responde a la única pregunta que importa al despertar: quién tiene sed, qué está maduro y si hoy hará demasiado calor. Un gesto para anotar el riego de todo el huerto.

👨‍👩‍👧 PARA CULTIVAR EN FAMILIA
Tutoriales paso a paso, retos fotográficos e insignias para coleccionar: Kultiva está pensada para dar buena mano a los niños — y convertir el huerto en la aventura del domingo.

🌦️ TIEMPO Y AVISOS ÚTILES
Previsión de 7 días para tu ciudad, recordatorios de riego con cabeza, avisos de ola de calor con consejos hortaliza por hortaliza. Tu huerto te avisa antes de tener sed.

📖 EL DIARIO DE TU HUERTO
Cada plantación, cada riego, cada cosecha y cada foto queda anotada en su fecha. Relee tu temporada día a día y gana medallas de bronce, plata y oro por cada hortaliza cultivada.

📸 RETOS FOTOGRÁFICOS E INSIGNIAS
50 retos fotográficos y 50 insignias por desbloquear. Las insignias premian lo que haces de verdad: tu primera planta, tres días de riego seguidos, un bancal lleno hasta el borde.

🎓 APRENDER DISFRUTANDO
33 tutoriales ilustrados, un léxico del hortelano, una guía de enfermedades y el compañerismo vegetal (a quién le gusta crecer al lado de quién).

Y sobre todo: Kultiva funciona sin conexión y sin cuenta. Tus datos se quedan en tu teléfono, y en ningún otro sitio.

Descarga Kultiva y haz crecer tu primera alegría. 🌸
```

**Palabras clave** — **94/100 bytes** (les accents comptent double
en UTF-8) :

```
jardinería,siembra,huerto,hortalizas,calendario,cosecha,plantas,semillas,balcón,riego,tomate
```

### 7.3 Ce qui ne se traduit pas

- Les **URL** d'assistance et marketing : la landing est en français.
  ⚠️ À revoir si elle est traduite un jour.
- La **politique de confidentialité** : même page pour les trois.
- Les **informations pour la revue** : Apple les lit en anglais.
- Le **questionnaire de confidentialité** et la **déclaration DSA** :
  ils ne sont pas localisables.
