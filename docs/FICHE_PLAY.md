# FICHE_PLAY.md — remplir la fiche Google Play de Kultiva

> Réponses prêtes à coller dans la Play Console, page par page, dans
> l'ordre où la console les demande.
> Dernière mise à jour : 2026-11-04 — v1.0.0 (`versionCode` 5).
>
> Pendant du `docs/FICHE_APP_STORE.md` côté Apple. Les deux fiches
> doivent dire la même chose : une déclaration de confidentialité qui
> diffère d'une boutique à l'autre est un signal d'alerte pour les deux.

---

## 0. Ce qui a été mesuré dans la console le 4 novembre 2026

| Fait | Valeur |
| --- | --- |
| Compte développeur | **Toa** — ID `4741246028443998966` |
| Type de compte | **Compte personnel** (écrit sous le nom, pas déduit) |
| Applis déjà présentes | `com.beiki.eewa` (Erea, **en production**) et `sn.palabre.app` (Palabre, brouillon) |
| Fiche Kultiva | **n'existait pas** — à créer |
| `com.toa.kultiva` | ✅ « Nom de package disponible » |

⚠️ **Le délai des douze testeurs est peut-être déjà purgé.** La règle
de Google — douze testeurs pendant quatorze jours avant l'accès à la
production — vise le **compte**, pas l'application, et une seule fois.
Or **Erea est déjà en production sur ce compte personnel**. Soit le
compte est antérieur au 13 novembre 2023, soit l'accès a déjà été
accordé : dans les deux cas Kultiva n'aurait rien à attendre.
**C'est une déduction, pas une mesure** : elle se confirmera d'un coup
d'œil sur la page *Production* de Kultiva, qui affiche la condition
quand elle s'applique. Ne pas replanifier la sortie avant de l'avoir vu.

---

## 1. Page « Créer une application »

| Champ | Valeur |
| --- | --- |
| Nom de l'application | `Kultiva : potager kawaii` — **24/30** |
| Nom du package | `com.toa.kultiva` |
| Langue par défaut | **Français (France) – fr-FR** |
| Application ou jeu | **Appli** |
| Gratuite ou payante | **Sans frais** |

⚠️ **Le nom n'est pas « Kultiva » tout court, et c'est voulu.** Play
n'a pas de sous-titre : le titre est le seul champ court indexé, donc
il porte le mot que les gens tapent. C'est l'équivalent du sous-titre
App Store « Ton potager kawaii de poche ». Il se change à tout moment
dans *Fiche principale du Play Store*.

⚠️ **« Sans frais » est irréversible après publication** — la console
le dit elle-même. Aucun risque ici : il n'y a ni prix ni achat intégré.

### Les deux déclarations

Elles ne sont pas des cases administratives : ce sont des attestations
signées par le développeur. **À cocher par Jean lui-même.**

1. *Confirmer que l'application respecte le Règlement du programme pour
   les développeurs.*
2. *Accepter les lois américaines sur l'exportation* — l'app n'embarque
   aucun chiffrement propriétaire, seulement HTTPS standard, ce qui est
   exactement le cas prévu par l'exemption déjà déclarée côté Apple.

---

## 2. Fiche principale du Play Store

*Croissance → Présence sur le Play Store → Fiche principale du Play Store.*

| Champ | Où le prendre | Longueur |
| --- | --- | --- |
| Nom de l'application | § 1 | 24/30 |
| Description courte | `docs/store-listings.md` § 1 | 75/80 |
| Description longue | `docs/store-listings.md` § 1 — **le même texte que la description App Store** | 2 630/4 000 |

### Les visuels, tous produits et prêts

| Élément | Fichier | Format exigé |
| --- | --- | --- |
| Icône | `captures/play-assets/icone-512.png` | 512 × 512, 32 bits, < 1 Mo → **376 Ko, sans alpha** ✅ |
| Bannière (*feature graphic*) | `captures/play-assets/graphique-vedette-1024x500.png` | 1024 × 500, sans alpha → **404 Ko** ✅ |
| Captures téléphone | `captures/play/` — dix fichiers | 1080 × 1920, ratio **1,78** (Play exige < 2,0), 24 bits sans alpha ✅ |

⚠️ **La bannière n'existait pas**, et c'était le seul visuel obligatoire
qui manquait. Elle est composée en HTML par
`tool/graphique_vedette.py` plutôt que générée par un modèle d'image :
zéro crédit, elle se recompose en une seconde quand un mot change, et
elle réemploie les **vrais** visuels de l'app — l'icône et six légumes
détourés du catalogue. La boutique montre donc ce que l'utilisateur
verra.

⚠️ **Play n'en prend que huit sur les dix captures.** L'ordre est
l'ordre d'affichage et les trois premières font la conversion ; ordre
conseillé dans `docs/store-listings.md` § 3.3. L'Étal et « au jardin en
ce moment » sont les deux de réserve.

⬜ **Il manque la météo 7 jours.** Elle n'est pas prenable sur
l'émulateur : l'écran exige la localisation, et l'accorder déclenche en
boucle la boîte « Location Accuracy » de Google Play Services. À
prendre sur un vrai téléphone Android.

---

## 3. Paramètres de la fiche Play Store

| Champ | Valeur |
| --- | --- |
| Catégorie de l'application | ✅ **Style de vie**, posée le 4 novembre 2026. ⚠️ Cette fiche disait « Maison et loisirs » : cette entrée n'existe pas dans la liste de Play. Les deux voisines sont **Style de vie** et **Maison et intérieur** — la seconde vise la décoration et l'immobilier |
| Tags | potager, jardinage, plantes, calendrier, hors ligne |
| E-mail | ✅ `kultiva@toakeur.com`, posée le 4 novembre 2026 |
| Site Web | ✅ `https://kultiva.toakeur.com`, posé le 4 novembre 2026 |
| Téléphone | ⏳ **Toi** — facultatif côté Play, laissé vide ; obligatoire côté Apple |

---

## 4. Contenu de l'application

C'est la page la plus longue de la console, et la seule qui puisse
faire rejeter l'app sans qu'on touche au code.

### 4.1 Règles de confidentialité

`https://kultiva.toakeur.com/privacy.html`, tenue identique à la
politique embarquée (`assets/tutos/privacy_policy.html`).

✅ **En ligne**, vérifiée le 4 novembre 2026 (200, titre « Politique de
confidentialité — Kultiva »). Elle avait répondu 404 du 3 au 4
novembre : passer le dépôt en privé ne suspend pas GitHub Pages, il
**supprime** le site. Le domaine vit maintenant dans `landing/CNAME`,
donc il revient tout seul à la prochaine publication.

### 4.2 Accès à l'application

**« Toutes les fonctionnalités sont accessibles sans restriction. »**
Il n'y a ni compte, ni identifiant, ni contenu réservé depuis le retrait
des comptes le 30 octobre 2026 — donc aucun identifiant de test à
fournir.

### 4.3 Annonces

⚠️ **C'est la seule réponse qui se discute vraiment, et je recommande
« Oui ».**

L'app n'affiche aucune publicité : pas de SDK, pas de bannière, pas
d'interstitiel, et le manifeste livré ne demande **pas** `AD_ID`
(mesuré, § 6). Mais elle porte 159 boutons « Acheter » vers Amazon sous
le tag `kultiva1-21`, qui rapportent une commission. Google définit une
annonce comme « du contenu promotionnel pour les produits d'un tiers
pour lequel vous êtes rémunéré » : des liens d'affiliation entrent dans
cette phrase.

⚠️ **Recommandation inversée le 4 novembre 2026, après avoir lu la
page elle-même.** Elle définit ce qu'elle demande : « Dites-nous si
votre application contient des annonces. **Cela comprend les annonces
diffusées par des réseaux publicitaires tiers.** » Kultiva n'en
diffuse aucune. Déclarer « Contient des annonces » collerait sur la
fiche une étiquette durable et fausse, qui déprime les installations
d'une app qui n'a pas de publicité. **Réponse posée : Non.**

Ce qui subsiste du raisonnement inverse : le statut de **trader** au
sens du DSA, lui, s'applique bel et bien, et c'est par là que
l'affiliation est déclarée — pas par cette case.

### 4.4 Classification du contenu

Catégorie : **Utilitaire, productivité, communication ou autre**.

Toutes les réponses sont **Non** : pas de violence, pas de contenu
sexuel, pas de grossièreté, pas de drogue, pas de jeu d'argent, pas de
contenu généré par les utilisateurs, aucun échange entre utilisateurs,
aucun partage de position entre utilisateurs.

Résultat attendu : **PEGI 3 / Tout public**, cohérent avec le 4+
obtenu côté Apple depuis le retrait du feed communautaire.

⚠️ **« Les utilisateurs peuvent-ils acheter des biens physiques ? »
→ Non.** Les boutons Amazon ouvrent le **navigateur** ; la question
porte sur un achat dans l'application.

### 4.5 Public cible et contenu

**Tranches d'âge : 13-15, 16-17, 18 et plus. Ne pas cocher sous 13 ans.**

⚠️ **Et il y a une phrase de la description à revoir avant d'envoyer.**
Cocher une tranche sous 13 ans soumettrait l'app à la *Politique
Familles*, qui encadre durement la collecte de **position précise**
chez les mineurs — or l'app envoie bien des coordonnées à Open-Meteo.
On reste donc à 13+. Mais Google relit la description pour vérifier
qu'elle ne contredit pas la cible déclarée, et la nôtre dit :

> « Kultiva est pensée pour donner la main verte aux enfants »

C'est une revendication d'app pour enfants sous une déclaration 13+.
Proposition de réécriture, qui garde la promesse en s'adressant au
parent :

> « Tutoriels pas à pas, défis photo et badges à collectionner : de quoi
> embarquer toute la famille au potager — et transformer le jardin en
> aventure du dimanche. »

À changer **dans les trois langues** si elle est retenue (le même
paragraphe existe en anglais et en espagnol dans
`docs/FICHE_APP_STORE.md` § 7).

### 4.6 Sécurité des données

⚠️ **Ne pas répondre « aucune donnée collectée ».** Il n'y a plus ni
compte ni serveur, mais deux choses quittent encore l'appareil, et les
deux sont déjà déclarées à Apple. Une déclaration qui diffère d'une
boutique à l'autre se voit.

| Type | Collectée | Partagée | Finalité | Obligatoire ? |
| --- | --- | --- | --- | --- |
| **Position** (approximative **et** précise) | Oui | **Oui** — les coordonnées partent vers Open-Meteo | Fonctionnalité de l'application | Non — refus possible, l'app retombe sur Paris |
| **Journaux de plantage** | Oui | **Oui** — Sentry | Fonctionnalité + analyse | Oui, automatique |

Pour les deux : **chiffrées en transit** (HTTPS), **non utilisées pour
le suivi publicitaire**, et **aucune suppression à proposer** puisque
rien n'est conservé côté Kultiva.

⚠️ **Deux nuances que la console demande et que cette fiche n'avait
pas** : la position est déclarée **traitée de manière éphémère** (les
coordonnées servent à la requête et ne sont pas conservées), les
journaux de plantage **non** ; et la position est **facultative**
(l'app retombe sur Paris), les plantages **obligatoires** (aucun
réglage ne les coupe).

⚠️ **Et l'ordre des déclarations n'est pas libre.** « Sécurité des
données » refuse d'être envoyée tant que « Cible et contenu » n'est
pas rempli, qui lui-même attend la **classification IARC**. La chaîne
est donc : IARC → Cible → Sécurité des données. Les réponses sont
enregistrées en brouillon en attendant.

⚠️ **« Partagée » plutôt que « collectée seulement »**, et c'est
délibéré : Open-Meteo et Sentry sont des tiers, pas des sous-traitants
agissant pour le compte de Kultiva. Sur-déclarer ne coûte rien ;
sous-déclarer est un motif de retrait.

**Ne rien déclarer d'autre.** Photos, plantations, notes, arrosages,
badges : tout vit dans `shared_preferences` et
`app documents/plant_photos/`, et rien ne sort. Play ne considère comme
collectée qu'une donnée transmise hors de l'appareil.

### 4.7 Les autres déclarations

| Question | Réponse |
| --- | --- |
| Application financière | Non |
| Application de santé | Non |
| Application d'actualités | Non |
| COVID-19 / traçage de contacts | Non |
| Application gouvernementale | Non |
| Identifiant publicitaire | **Non utilisé** — `AD_ID` absent du manifeste livré (§ 6) |

⚠️ **Les alarmes exactes.** Le manifeste demande
`SCHEDULE_EXACT_ALARM` (apporté par `flutter_local_notifications`, pour
les rappels d'arrosage à l'heure dite). Le formulaire de déclaration de
Play vise `USE_EXACT_ALARM`, que l'app ne demande pas — il ne devrait
donc rien y avoir à remplir. **À vérifier dans la console** : si une
déclaration apparaît quand même, la justification est « rappels
programmés par l'utilisateur ».

### 4.8 Commerçant (DSA)

**Tu es trader**, et il n'y a rien à trancher : l'affiliation Amazon est
revenue le 30 octobre 2026 sous le tag `kultiva1-21`, donc l'app tire un
revenu. Même raisonnement et mêmes précautions que
`docs/FICHE_APP_STORE.md` § 1.5 — **boîte postale** plutôt que domicile,
`kultiva@toakeur.com` plutôt que l'adresse personnelle, numéro
secondaire plutôt que le mobile. Les coordonnées seront **publiques**
dans l'UE.

---

## 5. Pays et versions

| Champ | Valeur |
| --- | --- |
| Pays de distribution | **Tous** — l'app couvre 73 pays sur six continents depuis le 1er novembre 2026. A minima : France, Belgique, Suisse, Luxembourg, Canada, et les 8 pays d'Afrique de l'Ouest |
| Fichier à téléverser | `build/app/outputs/bundle/release/app-release.aab` |
| Notes de version | « Première version de Kultiva. » |

⚠️ **Activer la signature d'application par Play.** Sans elle, perdre
`android/key.properties` ou le `.jks` rendrait toute mise à jour
impossible à jamais. Avec elle, Google détient la clé de signature et
la nôtre ne sert plus qu'à l'envoi.

---

## 6. Le bundle, mesuré le 4 novembre 2026

Construit avec le JDK d'Android Studio (le `java` du PATH est un
OpenJDK 25 que Gradle 8.14 refuse) :

```bash
JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home" flutter build appbundle --release
```

| Mesure | Valeur |
| --- | --- |
| Poids du `.aab` | 92 Mio sur disque (96,9 Mo décimaux) — toutes architectures et densités confondues. Un utilisateur télécharge ~48 Mio, Play découpant par appareil |
| `versionCode` / `versionName` | 5 / 1.0.0 |
| `minSdk` / `targetSdk` | 24 / **36** — au-delà du minimum exigé par Play |
| Signature | `jarsigner -verify` : **jar verified**, `CN=Perraudeau Jean, O=Kultiva`, auto-signé, valable jusqu'au 6 septembre 2053 |

**Les sept permissions du bundle livré**, lues dans son propre
manifeste et non dans le source :

`INTERNET`, `VIBRATE`, `POST_NOTIFICATIONS`, `RECEIVE_BOOT_COMPLETED`,
`SCHEDULE_EXACT_ALARM`, `ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION`.

⚠️ **Aucune permission `AD_ID`** — c'était une supposition de
`docs/PUBLICATION.md` (« ne devrait pas figurer »), c'est maintenant une
mesure.

⚠️ **`android.permission.DUMP` apparaît dans le manifeste sans être
demandée.** Ce n'est pas un `uses-permission` : c'est la permission qui
**protège** le `ProfileInstallReceiver` d'AndroidX, présent dans toutes
les apps Flutter. Rien à déclarer. Le noter parce qu'un `strings` sur le
manifeste la fait remonter et qu'on croit à une fuite.

⚠️ **Ce bundle est le premier à contenir le correctif R8 du
3 novembre.** Sans lui l'app plante au deuxième lancement en release —
voir l'en-tête de `android/app/proguard-rules.pro`. Le bundle construit
le 23 août 2026 ne l'avait pas : **ne pas le téléverser.**

---

## 7. Ce que le dépôt ne peut pas te donner

1. **Les deux cases de déclaration** à la création de l'app (§ 1).
2. **Tes coordonnées de trader** : adresse postale (une BP suffit),
   téléphone, e-mail — **publiques dans l'UE**.
3. **La capture météo**, sur un vrai téléphone Android (§ 2).
4. **La décision sur les annonces** (§ 4.3) et sur la phrase
   « main verte aux enfants » (§ 4.5).

---

## 8. État d'avancement

> **Au soir du 4 novembre 2026 : les 11 tâches de configuration de
> l'application sont terminées.** Ne restent que le test fermé
> (12 testeurs × 14 jours) et le statut de professionnel.

| Élément | État |
| --- | --- |
| Nom, description courte, description longue | ✅ Prêts à coller, décomptes vérifiés |
| Icône 512 × 512 | ✅ Produite |
| Bannière 1024 × 500 | ✅ Produite (`tool/graphique_vedette.py`) |
| Captures téléphone | ✅ Dix, au format Play — ⬜ la météo manque |
| App Bundle signé | ✅ Construit et **téléversé le 4 novembre 2026**, correctif R8 inclus — 96,9 Mo d'AAB, mais **31,7 Mo à l'installation** et 17 s de téléchargement après découpe par Play |
| Permissions / `AD_ID` | ✅ Mesurées dans le bundle |
| Catégorie, coordonnées, URL | ✅ Réponses fournies |
| Classification du contenu | ✅ Réponses fournies (attendu : tout public) |
| Sécurité des données | ✅ Réponses fournies, alignées sur Apple |
| Public cible | ✅ 13+ — ⬜ une phrase de description à revoir |
| Annonces | ⏳ Toi — recommandation : **Oui** (§ 4.3) |
| Déclaration DSA | ⏳ Toi — **trader** |
| Page de confidentialité en ligne | ✅ Rétablie le 4 novembre 2026 (§ 4.1) |
| Création de l'app dans la console | ✅ **Faite le 4 novembre 2026** — `Kultiva : potager kawaii`, `com.toa.kultiva` |
| Test fermé | ⏳ **Obligatoire, et les 14 jours s'appliquent** (§ 0) — canal **Alpha** créé le 4 novembre 2026, **178 pays** ciblés, release « 1.0.0 (5) — premier test fermé » **avec son bundle** ; reste l'envoi pour examen et les **testeurs** |

### Les douze testeurs : ce qui a marché pour Erea

**Ne pas chercher douze volontaires.** Erea est passé par le service
payant **Testers Community** (<https://testerscommunity.com>), plan
**Starter à 14 €**, 15 testeurs, souscrit le 8 septembre 2026 à 22 h.
Il fournit un **groupe Google** — `testers-community@googlegroups.com`
— qu'on ajoute comme liste de testeurs du canal fermé.

**Le calendrier mesuré sur Erea** : souscription le 8 septembre,
« 12 testeurs inscrits » au compteur de Google **le 10**, quatorze
jours tenus **du 8 au 22 septembre 2026**, accès à la production
accordé le 17 octobre.

**Ce que le service dit lui-même**, lu sur son site le 4 novembre 2026 :
testeurs au travail « sous 6 heures », la fenêtre de 14 jours démarre
**quand ils acceptent l'invitation**, le test est mené sur **16 jours**
pour garder de la marge, et la demande d'accès production se fait au
jour 14. Environ **15 jours** entre la soumission et la demande.

⚠️ **L'ordre est l'inverse de l'intuition : on paie d'abord.** Le
tableau de bord ne donne l'adresse du groupe Google **qu'après
l'achat**, et le site ne la publie nulle part. L'adresse utilisée ici
vient des fiches d'Erea : **à comparer avec celle du tableau de bord**
et à corriger dans la console si elle diffère.

⚠️ **Le lien d'inscription est prévisible**, et il n'y a pas à
attendre que la console l'affiche. La console dit « Le lien sera
affiché ici quand vous publierez votre application », mais l'adresse
est toujours `https://play.google.com/apps/testing/<package>` — pour
Kultiva, `https://play.google.com/apps/testing/com.toa.kultiva`, qui
répondait déjà **200** le 4 novembre 2026, release encore en examen.

**Formulaire du service, ce qu'il demande** : nom de l'app, plan, le
lien ci-dessus, une icône carrée (≤ 5 Mo — `captures/play-assets/icone-512.png`)
et des notes facultatives aux testeurs. Il pose aussi une question
piège : « votre app a-t-elle été faite avec PWABuilder ou Bubblewrap ? »
— **non** pour une app Flutter, et leur propre encadré le dit.

⚠️ **Le compteur part au douzième inscrit, pas à la souscription.**
Et s'inscrire veut dire **ouvrir le lien et accepter**, pas figurer
sur une liste. C'est le seul délai qu'aucune décision ne raccourcit :
à lancer en parallèle de l'examen, pas après.

⚠️ **Le bundle ne se téléverse pas depuis le navigateur piloté.** L'App
Bundle pèse **92 Mo** et le pont du navigateur plafonne à 10 Mo : le
fichier doit être **glissé à la main** dans la zone « Déposez ici les
app bundles à importer ». Il est dans
`build/app/outputs/bundle/release/app-release.aab`.
| Fiche Play Store | ✅ **Remplie et enregistrée le 4 novembre 2026** — nom, brève description (75/80), description complète (2 698/4 000), icône 512, bannière 1024 × 500, **8 captures** 1080 × 1920, déclaration IA : *ne pas signaler* (choix de Jean) |
| Règles de confidentialité | ✅ `https://kultiva.toakeur.com/privacy.html` |
| Informations de connexion | ✅ « Aucune section de l'appli n'est limitée » |
| Annonces | ✅ **Non** — voir § 4.3, la recommandation a changé après lecture de la console |
| Classification du contenu | ✅ **Envoyée par Jean le 4 novembre 2026 à 16 h 54** — examen IARC *Terminée*, **PEGI 3 / ESRB Everyone / USK 0 / IARC 3+** |
| Cible | ✅ **Validée le 4 novembre 2026** |
| Sécurité des données | ✅ **Enregistrée le 4 novembre 2026** (position approximative, position exacte, journaux de plantage), une fois « Cible » validée |
| Applis gouvernementales, finance, santé | ✅ **Non** aux trois, le 4 novembre 2026 |
| Identifiant publicitaire | ✅ **Non utilisé** — mesuré dans le bundle (§ 6) |
| Statut de professionnel | ⏳ **Toi** — « Action requise », échéance **février 2027**, sans quoi le profil développeur et les applis sont retirés |
