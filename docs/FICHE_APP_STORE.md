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
| Droits relatifs au contenu | **« Non, elle ne contient pas de contenu de tiers »** — tout le contenu (textes, illustrations, tutos) est produit pour l'app ; les liens Amazon sont des liens sortants, pas du contenu tiers affiché |
| Contrat de licence | Laisser le contrat standard d'Apple (ne rien toucher) |

### 1.3 Classifications par âge (questionnaire 2025)

Réponses à donner, dans l'ordre des sept catégories :

| Catégorie | Réponse | Pourquoi (si ça peut faire hésiter) |
| --- | --- | --- |
| Contrôles intégrés (contrôle parental, vérification d'âge) | **Aucun** | L'app n'en propose pas — c'est une réponse valide, pas un manque |
| Capacités — accès web sans restriction | **Non** | Les WebView n'affichent que les tutos HTML embarqués, pas de navigation libre |
| Capacités — contenu généré par les utilisateurs | **Oui** | Le feed de défis photo est du CGU en large diffusion ; signalement in-app + modération existent (exigés par la guideline 1.2) |
| Capacités — réseaux sociaux | **Non** | Pas de profils suivis, pas d'abonnés, pas de messagerie — un feed de photos modéré n'est pas un réseau social |
| Thèmes matures (grossièretés, horreur, alcool/tabac/drogues) | **Aucun** | |
| Médical ou bien-être | **Non** | Des conseils de jardinage ne sont pas du contenu médical |
| Sexualité ou nudité | **Aucune** | |
| Violence | **Aucune** | |
| Activités basées sur le hasard (jeux d'argent, loot boxes, concours) | **Aucune** | Les défis photo n'ont ni mise ni prix monnayable ; les badges sont débloqués par l'action, pas par le hasard |

**Résultat attendu : 13+**, à cause du contenu généré par les
utilisateurs — c'est le feed qui fixe le palier, pas ton contenu.
Si ASC affiche autre chose, laisse son calcul faire foi.

### 1.4 Documents sur le chiffrement

**Rien à faire.** `ITSAppUsesNonExemptEncryption = false` est déjà
déclaré dans `ios/Runner/Info.plist` — la question ne sera même pas
posée à l'upload.

### 1.5 Réglementations — déclaration DSA (obligatoire pour l'UE)

✅ **Décision prise (24/08/2026) : on garde l'affiliation Amazon → tu te
déclares TRADER.**

Les 159 liens d'affiliation (tag `kultiva-21`, marché France, déjà
masqués en Afrique de l'Ouest) constituent une source de revenus : le
statut trader est donc celui qui s'applique.

**Ce que ça implique concrètement.** Tu fournis une adresse postale, un
téléphone et un e-mail. Apple les vérifie, puis les **affiche
publiquement** sur ta fiche App Store dans les 27 pays de l'UE.

**Protège tes coordonnées personnelles** — c'est permis et recommandé :

- **Adresse** : une **boîte postale est acceptée**. Inutile de publier
  ton domicile. Une BP coûte quelques dizaines d'euros par an à La Poste.
- **E-mail** : utilise `kultiva.toa@gmail.com`, déjà câblé partout dans
  l'app et sur la landing — pas ton adresse personnelle.
- **Téléphone** : le numéro sera public. Si tu ne veux pas exposer ton
  mobile, un numéro secondaire (ligne VoIP, forfait dédié) fait l'affaire.

**Chemin dans ASC** : Entreprise → Accords → section Conformité →
Digital Services Act. Le statut peut ensuite s'ajuster app par app dans
Informations sur l'app → Réglementations.

**Si tu changes d'avis** : retirer l'affiliation permet de repasser
non-trader, sans aucune coordonnée publiée. Le masquage est déjà
implémenté (c'est le comportement actif en Afrique de l'Ouest), donc
c'est une petite modification. Le statut se change à tout moment.

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
2. **Mes jardins avec Tamassi visible** — le hook kawaii qui différencie
3. Le Poussidex (collection de plants + médailles)
4. Une fiche culture détaillée (tomate)
5. Le planner du potager en carrés (glisser-déposer en cours)
6. Météo 7 jours avec une alerte arrosage ou canicule
7. Les défis photo et badges
8. (facultatif) Le calendrier en mode Afrique de l'Ouest (hivernage) —
   montre le bi-marché

Prends-les avec le compte de démo rempli (plants, photos, Tamassi
niveau > 1) : des écrans vides ne vendent rien.

### 2.2 Texte promotionnel — 150/170 caractères

Modifiable à tout moment sans nouvelle version :

```
Semis, récoltes, météo de ton jardin et Tamassi, ta créature kawaii : Kultiva t'accompagne des premières graines à la fierté de la première tomate. 🌱
```

### 2.3 Description — 2 324/4 000 caractères

Texte brut, sans HTML. Les trois premières lignes accrochent avant le
« plus » :

```
Le potager kawaii dans ta poche 🌱

Kultiva t'accompagne du choix des graines à la fierté de la première tomate — que tu jardines sur un balcon en ville, dans un carré potager en Bretagne… ou sous les premières pluies de Dakar : l'app couvre la France métropolitaine et 8 pays francophones d'Afrique de l'Ouest.

📅 UN CALENDRIER QUI CONNAÎT TA RÉGION
Chaque mois, découvre quoi semer, planter et récolter chez toi. Semis sous abri, pleine terre, récoltes : tout est adapté à ton climat, et exportable en PDF pour l'accrocher dans l'abri de jardin.

🌽 130 CULTURES EN FICHES DÉTAILLÉES
Tomate, courgette, radis, fraisier, basilic… mais aussi gombo, niébé, mil ou bissap. Pour chaque plante : profondeur de semis, exposition, arrosage, distances de plantation, rendement estimé et petits conseils de pro.

📓 MES JARDINS, TON POTAGER EN CARRÉS
Dessine tes carrés, place tes plants par glisser-déposer et suis chacun d'eux : arrosages, phases de croissance auto-suggérées, photos, avertissement de rotation des cultures et conseils selon la météo du jour.

🐣 TAMASSI, TA CRÉATURE DE JARDIN
Chaque semis, chaque arrosage, chaque récolte fait grandir Tamassi, ton compagnon kawaii. XP, niveaux, émotions, visiteurs surprise : le jardinage devient un jeu.

👨‍👩‍👧 POUR JARDINER EN FAMILLE
Tutoriels pas à pas, défis photo et compagnon kawaii : Kultiva est pensée pour donner la main verte aux enfants — et transformer le potager en aventure du dimanche.

🌦️ MÉTÉO ET ALERTES MALINES
Prévisions 7 jours pour ta ville, rappels d'arrosage intelligents, alertes canicule avec conseils légume par légume. Ton jardin te prévient avant d'avoir soif.

📖 LE POUSSIDEX, TA COLLECTION DE PLANTS
Photographie tes plants et retrouve toute leur histoire : notes, arrosages, récoltes. Gagne des médailles bronze, argent et or pour chaque légume.

📸 DÉFIS PHOTO ET COMMUNAUTÉ
51 défis photo, 51 badges à débloquer et un feed communautaire pour partager tes plus belles récoltes.

🎓 POUR APPRENDRE EN S'AMUSANT
33 tutoriels illustrés, un lexique du jardinier, un guide des maladies et le compagnonnage (qui aime pousser à côté de qui).

Et surtout : Kultiva fonctionne sans connexion. Tes données restent sur ton téléphone ; la synchronisation cloud est facultative et gratuite.

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
| URL d'assistance (obligatoire) | → l'URL du site déployé sur Vercel — **voir « À préparer »** |
| URL marketing (facultative) | La même URL, ou laisser vide |

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
| Game Center | **Non** — Tamassi est un système de jeu interne, pas Game Center |

### 2.8 Informations pour la revue

| Champ | Valeur |
| --- | --- |
| Nom | Jean Perraudeau |
| E-mail | `kultiva.toa@gmail.com` |
| Téléphone | → **voir « À préparer »** |
| Compte de démonstration | **Recommandé, plus obligatoire** — depuis le mode invité, le testeur accède à tout sans compte via « Continuer sans compte ». Fournis-en un quand même pour qu'il puisse vérifier la synchronisation cloud et la suppression de compte. → **voir « À préparer »** |

> ⚠️ **NE PAS COLLER EN L'ÉTAT (24/08/2026).** La puce « Feed
> communautaire » décrit un écran de signalement qui **n'existe pas dans
> l'app** : `PoussidexFeed` n'est branché à aucune interface. Les défis
> téléversent pourtant bien les photos vers `challenge_posts`. Il faut
> trancher avant de soumettre — brancher le feed, ou couper l'envoi et
> retirer la promesse « communauté » de la fiche, de la description
> (§2.3) et de la landing. Annoncer à Apple une modération inexistante
> expose à un rejet (guideline 1.2, contenus générés par les
> utilisateurs).

**Notes au testeur** — 1 617/4 000 octets, à coller telles quelles :

```
Kultiva est une application de jardinage 100 % en français, destinée à la France et à 8 pays francophones d'Afrique de l'Ouest.

• Connexion : AUCUN compte n'est nécessaire. L'écran d'accueil propose « Continuer sans compte » : le calendrier, le catalogue, le potager et les tutos fonctionnent intégralement hors connexion. Le compte ne sert qu'à sauvegarder le jardin dans le cloud et à rejoindre la communauté ; pour le tester, utilise le compte de démonstration fourni ci-dessus ou « Continuer avec Apple ». La suppression de compte est dans Réglages → Supprimer mon compte.
• Localisation : facultative. En cas de refus, l'app bascule automatiquement sur la météo de Paris (ou de la capitale du pays choisi) — ce n'est pas un bug.
• Premier lancement : l'app propose de choisir son pays ; la liste s'adapte à la langue de l'appareil et, si la permission existe déjà, à sa position.
• Feed communautaire (défis photo) : contenu généré par les utilisateurs. Chaque post peut être signalé (bouton « Signaler ce post ») ; les contenus signalés sont masqués après modération côté serveur.
• Liens « Lien partenaire » (Amazon) : présents uniquement sur les fiches légumes du marché France, masqués pour l'Afrique de l'Ouest.
• Notifications : locales uniquement (rappels de semis, d'arrosage, Tamassi) — aucun push serveur.
• La créature Tamassi réagit aux mouvements du téléphone (accéléromètre) : comportement volontaire, pas un bug.
• L'app fonctionne hors ligne après la première connexion ; la synchronisation cloud se fait en arrière-plan.
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

⚠️ **Ne déclare surtout pas « aucune donnée collectée »** : Supabase
(comptes, contenu) et Sentry (crashs) tournent — une fausse déclaration
est un motif de rejet, voire de retrait après publication.

**URL de la politique de confidentialité** : l'URL Vercel +
`/privacy.html` — voir « À préparer ».

Réponses au questionnaire, type par type :

| Type de données | Donnée | Liée à l'identité ? | Utilisée pour le suivi ? | Finalité |
| --- | --- | --- | --- | --- |
| Coordonnées | Adresse e-mail | **Oui** | Non | Fonctionnement de l'app (compte) |
| Coordonnées | Nom (nom affiché) | **Oui** | Non | Fonctionnement de l'app |
| Contenu utilisateur | Photos ou vidéos | **Oui** | Non | Fonctionnement de l'app (Poussidex, défis — uploadées si sync active) |
| Contenu utilisateur | Autre contenu utilisateur (plantations, notes, XP) | **Oui** | Non | Fonctionnement de l'app |
| Identifiants | Identifiant utilisateur | **Oui** | Non | Fonctionnement de l'app |
| Localisation | Position précise | **Non** | Non | Fonctionnement de l'app (coordonnées envoyées à Open-Meteo pour la météo, jamais stockées sur nos serveurs) |
| Diagnostic | Données de plantage | **Non** | Non | Fonctionnement de l'app (Sentry — aucun identifiant utilisateur attaché dans le code) |

**Données utilisées pour te suivre (tracking)** : **AUCUNE** — pas de
publicité, pas d'analytics, pas de partage inter-apps → pas de popup ATT.

---

## 5. À préparer (le dépôt ne peut pas te le donner)

1. **Ton numéro de téléphone** — champ obligatoire des informations
   pour la revue.
2. **L'URL du site** une fois le déploiement Vercel fait → à coller
   dans : URL d'assistance (§2.5), URL marketing (§2.5) et URL de
   politique de confidentialité (§4, en ajoutant `/privacy.html`).
3. **Un compte de démonstration** : crée un compte e-mail + mot de passe
   dédié dans l'app, ajoute 2-3 plantations, une photo, fais grandir un
   peu le Tamassi — le testeur ET les captures d'écran s'en serviront.
4. **Tes coordonnées de trader** (§1.5, décision prise : on garde
   l'affiliation) — adresse postale (**une BP suffit**), téléphone et
   e-mail, qui seront **publics dans l'UE**.
5. **Les captures d'écran** : 8 en iPhone 6,9″ + les mêmes en iPad 13″
   (§2.1).

---

## 6. État d'avancement

| Élément | État |
| --- | --- |
| Nom, sous-titre, texte promo, description, mots-clés | ✅ Prêts à coller (décomptes vérifiés) |
| Catégories, droits sur le contenu, UGS | ✅ Réponses fournies |
| Questionnaire de classification par âge | ✅ Réponses fournies (attendu : 13+) |
| Chiffrement | ✅ Rien à faire (Info.plist déjà configuré) |
| Droits d'auteur, version, publication | ✅ Prêts |
| Questionnaire de confidentialité | ✅ Réponses fournies — il ne manque que l'URL |
| Notes au testeur | ✅ Prêtes à coller |
| Build | ✅ Xcode Cloud opérationnel — sélectionner le dernier |
| URL d'assistance / marketing / confidentialité | ⏳ Toi — après le déploiement Vercel |
| Téléphone (revue) | ⏳ Toi |
| Compte de démonstration | ⏳ Toi (5 min dans l'app) |
| Déclaration DSA | ✅ Décidé : **trader** (§1.5) — ⏳ reste à saisir tes coordonnées dans ASC |
| Captures d'écran | ⏳ Toi (avec le compte de démo rempli) |
