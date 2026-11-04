# PUBLICATION — état des boutiques

> Mis à jour le 4 novembre 2026. Pour mettre à jour :
> relancer ce même prompt.
>
> **Aucun secret ici** — uniquement des références publiques :
> identifiants d'app, numéros de version, liens de console.
>
> ⚠️ **Établi depuis le dépôt, pas depuis les consoles.** La session qui a
> produit cette fiche n'avait accès ni à App Store Connect ni à la Play
> Console. Tout ce qui figure ci-dessous vient du code, des fichiers de
> configuration et des documents du dépôt. Chaque ligne marquée
> « à vérifier dans la console » attend ta confirmation — aucun statut de
> boutique n'a été deviné.

## En bref

- **Version commune** : `1.0.0+5` (`pubspec.yaml`), jamais soumise
- **Identifiant de bundle** : `com.toa.kultiva` (iOS et Android)
- **Monétisation** : gratuite ; ni pub ni achat intégré, mais affiliation Amazon en France (liens remis le 30 octobre 2026, tag `kultiva1-21`)
- **Comptes** : **aucun** depuis le 30 octobre 2026 — ni connexion, ni serveur, ni synchronisation
- **Confidentialité** : <https://kultiva.toakeur.com/privacy.html> — **en ligne** (200, vérifié le 4 novembre 2026) ; exigée par les deux boutiques
- **Contact** : `kultiva@toakeur.com`

## Boutiques

| | 🍎 App Store | 🤖 Google Play |
|---|---|---|
| État | [en cours] ⭐ **première soumission : version 1.0.0 (build 231) envoyée à la vérification d'Apple le 4 novembre 2026 à 17 h 39**, statut « En attente de vérification », jusqu'à 48 h | [en cours] ⭐ **première soumission : 13 modifications envoyées à l'examen Google le 4 novembre 2026 à 17 h 20**, test fermé Alpha compris |
| Construction | [ok] Xcode Cloud (`ci_post_clone.sh`, Flutter 3.47.3) : **build 220 réussi le 3 novembre 2026 au soir**, disponible en TestFlight (vérifié le 4 novembre 2026 dans les mails d'Apple) ; le build 195 avait réussi dans la nuit du 2 au 3 novembre 2026 ; tous les builds du 2 novembre, du 166 au 195, ont réussi ; le build 165 avait échoué le 1er novembre 2026 au soir dans `ci_post_clone.sh`, les autres builds du 1er novembre (dont le 152 et le 164) avaient réussi, comme ceux depuis le 31 octobre (dont le 134) ; build 127 réussi le 30 octobre 2026, après deux échecs le même soir (122 et 125, pin Flutter devenu plus ancien que le code). Auparavant : builds 95 et 96 réussis le 25 octobre 2026, build 97 le 27 octobre, avec l'étape « TestFlight internes - iOS » (vérifié le 28 octobre 2026) ; le build 94 avait échoué le 24 octobre | [ok] App Bundle construit par la CI GitHub Actions ; plantage au lancement en release corrigé le 3 novembre 2026 |
| Signature | [ok] gérée par Xcode Cloud, équipe `K597U7X3FZ` | [ok] keystore local, valable jusqu'en 2053 |
| Classification | [ok] **4+**, questionnaire de confidentialité rempli le 4 novembre 2026 (position approximative, position exacte, données de pannes — fonctionnalité de l'app, sans lien avec l'identité, sans suivi) ; reste à publier les étiquettes | [ok] **PEGI 3 / ESRB Everyone / USK 0 / IARC 3+** — questionnaire IARC envoyé par Jean le 4 novembre 2026 à 16 h 54 |
| Tarifs et disponibilité | [ok] **gratuite dans 175 pays**, pays de base France (EUR), réglé le 4 novembre 2026 | [ok] test fermé **Alpha** ciblant **178 pays** ; release « 1.0.0 (5) — premier test fermé » avec son bundle, **31,7 Mo à l'installation**, en attente d'envoi (13 modifications en file) |
| Cible | [ok] iOS 15.0 et plus (depuis le 25 octobre 2026 : Xcode et les pods, dont Sentry, l’exigent ; avant : 13.0), iPhone en portrait, iPad dans les quatre sens | [ok] valeurs par défaut de Flutter, rien de figé dans le dépôt |
| Permissions | [ok] caméra, photos, localisation en français ; clé `NSLocationAlwaysAndWhenInUseUsageDescription` ajoutée le 30 octobre 2026 (fin de l'avertissement ITMS-90683) | [ok] localisation, notifications, alarmes exactes |
| Poids | [pas encore] à mesurer au premier envoi (21 Mo d'assets depuis le ménage du 2 novembre 2026, contre 37 Mo avant) | [ok] 48,6 Mio au téléchargement (release arm64, mesuré le 1er novembre 2026, avant l'ajout des 130 légumes détourés et le retrait de 16 Mo d'images inutilisées, tous deux le 2 novembre) |

## Vue d'ensemble

- **État du projet** : ⭐ **soumise aux deux boutiques le 4 novembre 2026** — Google Play à 17 h 20, Apple à 17 h 39. ⭐ **Google Play a reçu la première soumission de Kultiva le 4 novembre 2026 à 17 h 20** — 13 modifications en examen, test fermé Alpha compris, puis **2 de plus à 17 h 29** (groupe de testeurs `testers-community@googlegroups.com` et adresse de retour). L'app a été soumise au service **Testers Community**, plan Starter 14 €, le 4 novembre 2026. Côté Apple, la fiche est complète et le build rattaché ; restent la publication des étiquettes de confidentialité et l'envoi en vérification
- **iOS** : jamais soumise — la fiche App Store Connect existe (Apple ID `6762550020`), ses textes sont rédigés et l'URL de confidentialité répond de nouveau (vérifiée le 4 novembre 2026) ; le build Xcode Cloud 94 a échoué le 24 octobre 2026 (cible iOS trop basse), corrigé le 25 octobre ; les builds 95 et 96 ont réussi le 25 octobre 2026, le build 97 le 27 octobre 2026, le build 127 le 30 octobre 2026, le build 134 le 31 octobre 2026, le build 152 le 1er novembre 2026, le build 166 le 2 novembre 2026, le build 195 dans la nuit du 2 au 3 novembre 2026 et le **build 220 le 3 novembre 2026 au soir**, disponible en TestFlight (le 165 avait échoué le 1er novembre au soir). La clé de localisation que réclamait Apple (ITMS-90683) a été ajoutée le 30 octobre 2026
- **Android** : jamais envoyée à Play. Vérifié dans la console le 4 novembre 2026 : **aucune fiche Kultiva n'existait**, et `com.toa.kultiva` est disponible. Le formulaire de création est rempli, il reste les deux cases de déclaration, que seul Jean peut cocher. App Bundle signé reconstruit le 4 novembre 2026 — premier à porter le correctif du plantage au lancement en release ; icône 512, bannière 1024 × 500 et dix captures produites. Marche à suivre complète : `docs/FICHE_PLAY.md`
- **Web** : site de présentation <https://kultiva.toakeur.com>, en ligne depuis le 7 octobre 2026. Il a répondu **404 du 3 au 4 novembre 2026**, le dépôt étant passé en privé : GitHub avait alors **supprimé** le site Pages. Dépôt repassé en public et site recréé le 4 novembre 2026 ; `/privacy.html` répond aussi (200, vérifié)
- **Backend** : **aucun**. Les comptes ont été retirés de la v1 le 30 octobre 2026 — le jardin vit sur l'appareil. Le projet Supabase reste inactif (vérifié le 4 novembre 2026), inutilisé, et ne bloque plus rien
- **Monétisation** : affiliation Amazon en France. Les 159 liens, retirés le 20 octobre 2026 (compte fermé le 18), sont **revenus le 30 octobre 2026** sous le tag `kultiva1-21`. ⚠️ Le statut **trader** au sens du DSA, décidé le 24 août 2026 à cause de ces liens, redevient donc applicable : à déclarer dans App Store Connect et Play Console avant soumission
- **Classification attendue** : **4+** depuis le retrait du feed communautaire — plus aucun contenu généré par les utilisateurs
- **Chemin critique (4 novembre 2026, fin de journée)** — côté **Apple**, il reste trois choses : publier les étiquettes de confidentialité (un clic, réservé à Jean), remplir **Tarifs et disponibilité**, puis **Ajouter pour vérification**. Tout le reste est fait : 16 captures, textes, les trois URL, version 1.0.0, classification 4+, notes au testeur, publication manuelle, téléphone de revue, et le **build 231 rattaché**. Côté **Play**, les 11 tâches de configuration sont terminées ; il reste le **test fermé de 12 testeurs pendant 14 jours**, qu'aucune décision ne raccourcit, et le **statut de professionnel** (action requise avant février 2027)

- ⛔ **Pourquoi la console refusait le build, et ce n'était pas la version.** Les 230 builds Xcode Cloud étaient grisés dans le sélecteur de la version alors qu'ils étaient sains en TestFlight. Cause trouvée le 4 novembre 2026 : l'action *Archiver — iOS* du processus `Default` avait **« Préparation de la distribution : TestFlight (tests internes uniquement) »**. Un build archivé ainsi ne peut pas être soumis à l'App Store, et rien ne le dit sur la page de version. Le réglage est passé à **App Store Connect**, le build **231** lancé dans la foulée, et il est le seul sélectionnable — les précédents gardent leur marque. ⚠️ **Un build déjà produit ne se rattrape pas** : le drapeau est posé à l'archivage, il faut en relancer un

Aucune boutique n'a reçu de soumission : côté Apple, seuls des builds
TestFlight internes sont arrivés dans la fiche ; côté Google, rien n'a
été téléversé. Ce n'est pas le code qui retient la soumission — l'app compile,
passe l'analyse et ses tests sont verts. L'URL de confidentialité est
revenue en ligne le 4 novembre 2026 ; les captures Google Play sont
prises, celles d'Apple sont à reprendre (voir plus bas) ;
restent des champs de formulaire (le backend ne bloque plus rien depuis le 30 octobre 2026).

---

### 1. iOS · App Store

| | |
|---|---|
| État | **Jamais soumise** — captures Apple refaites le 4 novembre 2026 (10 iPhone + 6 iPad) ; restent les champs de la fiche (le projet Supabase, inactif, ne bloque plus rien depuis le retrait des comptes le 30 octobre 2026) |
| Console | <https://appstoreconnect.apple.com> |
| Version publiée | aucune — l'app n'est jamais sortie |
| Version en cours | `1.0.0` — fiche App Store Connect créée (Apple ID `6762550020`), builds Xcode Cloud 95, 96, 97, 127 (30 octobre 2026), 134 (31 octobre 2026), 152 (1er novembre 2026), 166 (2 novembre 2026), 195 (nuit du 2 au 3 novembre 2026) puis **220 (3 novembre 2026 au soir)** reçus ; aucune soumission |
| Distribution | Xcode Cloud, script `ios/ci_scripts/ci_post_clone.sh` — équipe `K597U7X3FZ` ; build 94 en échec le 24 octobre 2026, cible iOS relevée à 15.0 le 25 octobre ; builds 95 et 96 réussis le 25 octobre 2026, build 97 le 27 octobre, builds 122 et 125 en échec le 30 octobre (pin Flutter périmé), build 127 réussi le 30 octobre 2026, build 134 le 31 octobre 2026, build 152 le 1er novembre 2026, build 165 en échec le 1er novembre au soir (`ci_post_clone.sh`), build 166 réussi le 2 novembre 2026, build 195 dans la nuit du 2 au 3 novembre 2026 et **build 220 réussi le 3 novembre 2026 au soir**, disponible en TestFlight |
| Familles d'appareils | `TARGETED_DEVICE_FAMILY = "1,2"` → iPhone **et** iPad |
| Orientation | iPhone en portrait seul ; iPad dans les quatre sens depuis le 30 octobre 2026 ; `UIRequiresFullScreen = true` (renonce au multitâche iPad) |

**Ce qui est prêt.** Le texte de la fiche est écrit et les décomptes sont
vérifiés : nom, sous-titre, texte promotionnel, description
(2 341/4 000 caractères), mots-clés (98/100 octets), notes au testeur
(1 510/4 000 caractères). Le questionnaire de confidentialité, celui de
la classification par âge et la déclaration de chiffrement ont leurs
réponses. Tout est rassemblé dans `docs/FICHE_APP_STORE.md`, prêt à
coller champ par champ.

**Ce qui bloque, dans l'ordre (au soir du 4 novembre 2026).** Il reste
**trois** choses : publier les étiquettes de confidentialité (le
questionnaire est rempli, le bouton *Publier* est une déclaration
réservée à Jean), remplir **Tarifs et disponibilité**, puis **Ajouter
pour vérification**. Les trois URL de la fiche — assistance et
marketing `https://kultiva.toakeur.com`, confidentialité
`https://kultiva.toakeur.com/privacy.html` — répondent et sont
collées. Le testeur Apple n'a plus ni connexion ni suppression de compte à
essayer : l'app n'en a plus depuis le 30 octobre 2026. Les **captures d'écran** sont faites
**refaites le 4 novembre 2026** : 10 en iPhone 6,9″ (1320 × 2868)
et 6 en iPad 13″ (2064 × 2752), dans `captures/`. Les 14 du
3 novembre avaient été effacées le matin même par un `flutter clean`,
qui vide `build/`. Restent
le **numéro de téléphone** des informations de revue et la
déclaration DSA dans *Entreprise → Accords → Digital Services Act* :
le statut de trader, choisi pour les liens d'affiliation, s'applique
puisque ces liens sont revenus le 30 octobre 2026, et les coordonnées
seront publiques dans les 27 pays de l'UE (une boîte postale est
acceptée).

**Sur l'iPad.** L'app se lance en plein écran portrait sur iPadOS 26.5 et
produit des captures au format exact attendu par Apple. Les mises en page
s'adaptent — le catalogue passe à 8 colonnes au-delà de 900 points, les
grilles de badges et de défis se dimensionnent seules.

Les écrans ont été **regardés sur un iPad Pro 13″ le 3 novembre 2026**,
et l'ergonomie y a été corrigée le même jour. Avant : les six cartes du
tableau de bord mesuraient 510 points de large pour 138 de haut, une
phrase traversait l'écran d'un bord à l'autre, et une feuille modale
occupait les 1 032 points. Depuis : le contenu est borné et centré
(720 points, 560 pour le tableau de bord et les feuilles modales), avec
**une exception voulue**, l'Étal, dont la grille se répartit toute seule
et profite de la largeur. Le bandeau de saison reste dans la colonne.

Restent deux défauts d'allure, connus et non bloquants : le logo du
splash natif s'affiche à sa taille de téléphone au milieu d'un écran de
13 pouces, et le bas de l'écran est vide sur les pages courtes.

**Compte de démonstration.** Sans objet depuis le retrait des comptes :
laisse la case « Connexion requise » décochée dans App Store Connect.

**Garnir une installation pour les captures** ne se fait plus à la
main : `tool/garnir_simulateur.py` écrit le jardin dans les
préférences du simulateur — 6 plants avec leurs arrosages et récoltes
datés, un potager 4×4 à six cases, 13 badges débloqués. ⚠️ Redémarrer
le simulateur après l'écriture, sinon iOS sert ses préférences depuis
son cache et rien ne change à l'écran.

~~Il n'était plus obligatoire depuis le mode
invité livré le 24 août 2026 : le testeur accède à tout via « Continuer
sans compte ».~~

**Avertissement d'Apple corrigé.** Les builds 95, 96 et 97 ont été
acceptés, mais Apple signalait à chaque envoi l'erreur ITMS-90683 : la
clé `NSLocationAlwaysAndWhenInUseUsageDescription` manquait dans
`ios/Runner/Info.plist`. Elle a été ajoutée le 30 octobre 2026 —
`geolocator` embarque les APIs « Always » même si l'app ne s'en sert
pas, d'où la réclamation. Les builds 127, 134 et suivants (jusqu'au 220) ont été envoyés après
l'ajout de la clé.

**Vérifié le 1er novembre 2026** (mails d'Apple) : la fiche existe pour
`com.toa.kultiva` (Apple ID `6762550020`) et reçoit les builds de Xcode
Cloud. **À vérifier dans la console** : l'état du contrat *Contenu
payant* si la distribution doit couvrir tous les pays.

---

### 2. Android · Google Play

| | |
|---|---|
| État | **Jamais envoyée.** App créée le 4 novembre 2026 (`Kultiva : potager kawaii`) ; fiche Play Store remplie — nom, descriptions, icône, bannière, 8 captures, catégorie Style de vie, coordonnées |
| Console | <https://play.google.com/console> — compte **Toa**, ID `4741246028443998966`, **compte personnel** (lu dans la console le 4 novembre 2026) |
| Version publiée | aucune |
| Version en cours | App Bundle `1.0.0` (`versionCode 5`) — construit par la CI à chaque envoi, et **reconstruit en local le 4 novembre 2026** : c'est le premier à porter le correctif R8 du 3 novembre, qui répare le plantage au lancement en release. ⚠️ Celui du 23 août 2026 ne l'a pas : ne pas le téléverser |
| Distribution | App Bundle signé localement via `android/key.properties` (non commité, ignoré par git) |
| Signature | certificat RSA 2048 / SHA384 au nom de l'organisation `Kultiva`, créé le 21 avril 2026, valable jusqu'au **6 septembre 2053** |
| Niveaux d'API | valeurs par défaut de Flutter, lues dans le bundle livré le 4 novembre 2026 : `minSdk` **24**, `targetSdk` **36** — au-delà du minimum exigé par Play |
| Poids | 48,6 Mio au téléchargement (release arm64, mesuré le 1er novembre 2026, avant l'ajout des 130 légumes détourés du 2 novembre) ; 21 Mo d'assets depuis le retrait de 16 Mo d'images inutilisées le 2 novembre 2026 (37 Mo avant) ; la CI produit aussi des APK `--split-per-abi` |

**Ce qui est prêt.** Le build release fonctionne : il était cassé et a été
réparé le 23 août 2026 (Kotlin 2.1.20), puis vérifié par un
`flutter build appbundle --release` complet qui passe. Le *core library
desugaring* est actif, nécessaire à `flutter_local_notifications`. La CI
GitHub Actions construit l'App Bundle et les APK découpés par
architecture à chaque passage. Le `targetSdk` suit la version de
Flutter : à vérifier au premier envoi qu'il atteint le minimum exigé
par Play pour les nouvelles applications.

**Les textes existent déjà.** `docs/store-listings.md` contient la
description longue, la description courte (78/80 caractères) et des
variantes d'accroche par pays pour les storefronts d'Afrique de l'Ouest.

**Ce qui bloque (au soir du 4 novembre 2026).** Plus rien dans les
formulaires : les **11 tâches de configuration sont terminées** —
règles de confidentialité, informations de connexion, annonces (non),
classification du contenu (**PEGI 3 / ESRB Everyone / USK 0**, envoyée
par Jean à 16 h 54), cible et contenu, sécurité des données, applis
gouvernementales, fonctionnalités financières, santé, catégorie et
coordonnées, fiche Play Store. Restent **le test fermé — 12 testeurs
inscrits pendant 14 jours consécutifs** — et le **statut de
professionnel** (action requise avant février 2027), plus les
coordonnées de trader au titre du DSA.

⚠️ **L'ordre des déclarations n'est pas libre** : *Sécurité des
données* refuse d'être enregistrée tant que *Cible et contenu* est
vide, qui attend lui-même la **classification IARC**, laquelle exige
d'accepter les conditions d'un tiers — donc Jean. La chaîne est
IARC → Cible → Sécurité des données.

⚠️ **L'identifiant publicitaire est réglé, et c'est une mesure.** Cette
fiche disait qu'aucune permission `AD_ID` « ne devrait » figurer. Le
manifeste du bundle livré le 4 novembre 2026 a été lu : il demande
exactement sept permissions — `INTERNET`, `VIBRATE`,
`POST_NOTIFICATIONS`, `RECEIVE_BOOT_COMPLETED`, `SCHEDULE_EXACT_ALARM`,
`ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION` — et **pas `AD_ID`**.

**Le délai à anticiper.** Le compte **est** personnel (lu dans la
console le 4 novembre 2026), et Google impose alors **douze testeurs
pendant quatorze jours consécutifs** avant toute mise en production.

⚠️ **Et ce n'est pas purgé — ma déduction était fausse.** J'avais
écrit que l'obligation visant le compte et non l'application, Erea
étant déjà en production, Kultiva n'aurait rien à attendre. Le
tableau de bord de Kultiva dit le contraire, noir sur blanc :
« Publier une version de test fermé », « Avoir au moins 12 testeurs
inscrits — *0 testeur actuellement inscrit* », « Exécuter votre test
fermé avec au moins 12 testeurs pour au moins 14 jours ».
**Mesurer avant de citer** : la page existait, il suffisait de
l'ouvrir. Le décompte
ne démarre qu'au douzième inscrit, et s'inscrire veut dire ouvrir le lien
reçu et l'accepter — pas figurer sur une liste. C'est le seul délai
qu'aucune décision ne raccourcit : il mérite d'être lancé tôt, en
parallèle de la soumission iOS.

**Vérifié dans la console le 4 novembre 2026** : aucune fiche
`com.toa.kultiva` n'existait (le compte ne portait qu'Erea, en
production, et Palabre, en brouillon), le compte est **personnel**, et
l'identifiant de package est disponible. **Reste à vérifier** : que la
signature d'application par Play soit activée à la création de la
première version — sans elle, perdre le keystore rendrait toute mise à
jour impossible.

---

### 3. Web · site de présentation

| | |
|---|---|
| Production | **En ligne** — <https://kultiva.toakeur.com> et `/privacy.html` répondent 200 (vérifié le 4 novembre 2026). Interruption du 3 au 4 novembre 2026, le temps que le dépôt soit repassé en public |
| Domaine & SSL | `kultiva.toakeur.com`, DNS chez Cloudflare (proxy actif), HTTPS valide ; le domaine est porté par **`landing/CNAME`** depuis le 4 novembre 2026, et non plus par un réglage de la console ; contact du site `kultiva@toakeur.com` (dans `landing/`) |
| Visibilité | publié par GitHub Pages via `.github/workflows/site.yml` (dossier `landing/`) depuis le 7 octobre 2026. ⚠️ Passer le dépôt en **privé** ne suspend pas le site : GitHub le **supprime** (l'API `/pages` répondait 404). Il a fallu repasser le dépôt en public et recréer le site, le 4 novembre 2026 |

**Ce n'est pas une version web de l'app.** Le projet ne comporte que les
cibles `android` et `ios`. Le site compte parce qu'il fournit les URL
d'assistance, marketing et de confidentialité exigées par les boutiques.
`privacy.html` est tenue identique à la politique embarquée dans l'app
(`assets/tutos/privacy_policy.html`).

**Ce qui reste.** Remplacer
les deux boutons *Télécharger* de `landing/index.html`, inertes
(« Bientôt sur l'App Store » / « Bientôt sur Google Play »), par les
liens des boutiques une fois l'app publiée.

---

## Backend · aucun (décision du 30 octobre 2026)

**L'app ne contacte plus aucun serveur.** Les comptes ont été retirés de
la v1 : le jardin, les photos et les badges vivent uniquement sur
l'appareil. Les deux seuls appels sortants sont Open-Meteo
(météo, sans clé) et Sentry (plantages).

Le motif est factuel : le plan Supabase gratuit met en pause tout projet
après **une semaine sans trafic**. Une app non publiée n'a aucun trafic,
donc le projet se rendormait chaque semaine. Payer 25 $/mois pour zéro
utilisateur, ou passer deux jours à construire un backend que personne
n'utilise encore, n'avait pas de sens.

**Ce que ça débloque pour la soumission** : plus d'obligation Apple de
suppression de compte in-app, questionnaire de confidentialité réduit à
deux types (localisation, plantages), guideline 4.8 sans objet, et plus
de clés Google « Se connecter » à recréer.

**Ce que ça coûte** : changer de téléphone fait perdre le jardin.
Décision du 30 octobre : **pas d'export/import de fichier** — une
sauvegarde manuelle ne protège que ceux qui y pensent avant de casser
leur téléphone. Si la portabilité redevient un besoin, elle passera par
la synchro (Cloudflare, ci-dessous).

| | |
|---|---|
| Projet Supabase | `vkiwkeknfzwdvufcqbrp` — **inactif, inutilisé** (vérifié le 4 novembre 2026). Données et migrations conservées un an : **ne pas le supprimer**, il ne bloque plus rien |
| Retiré de l'app | `supabase_flutter`, `google_sign_in`, `sign_in_with_apple`, `crypto` (−36 paquets), l'entitlement Apple Sign-In et le schéma d'URL Google |
| Si la synchro revient | **Cloudflare** (Worker + D1 + R2) plutôt que Supabase : gratuit, ne s'endort jamais, juridiction EU disponible. Avec Google + Apple seulement, le Worker se contente de vérifier le jeton d'identité — aucun mot de passe à manipuler |

---

## Ce qui reste, dans l'ordre

1. ✅ **Site et confidentialité** : remis en ligne le 4 novembre 2026 — dépôt repassé en public, site Pages recréé, et le domaine fixé dans `landing/CNAME` pour qu'il ne se reperde plus.
2. ✅ **Adresse de contact** : `kultiva@toakeur.com` sur le site, la confidentialité et les textes des fiches.
3. ✅ **Backend supprimé** : les comptes ont été retirés de la v1 le 30 octobre 2026. Plus rien à rallumer, plus de clés Google à recréer.
4. **Compléter la fiche App Store** : très avancée au 4 novembre 2026 — URL, textes, 16 captures, classification 4+, notes au testeur, publication manuelle, et la **déclaration DSA était déjà faite**. Restent le **téléphone de revue**, le questionnaire de confidentialité, les tarifs, et le **build** (bloqué).
5. ✅ **Garnir une installation pour les captures** : fait, et outillé — `tool/garnir_simulateur.py`.
6. ✅ **Captures d'écran Apple — refaites le 4 novembre 2026.**
    **10 en iPhone 6,9″** (1320 × 2868) : tableau de bord, cahier de
    culture, potager carré, Étal, fiche tomate, Garder ta récolte,
    **météo**, à semer en novembre, badges, journal. **6 en
    iPad 13″** (2064 × 2752) : tableau de bord, cahier, potager
    carré, Étal, Garder ta récolte, tutos. Dans `captures/`.

    Les 14 du 3 novembre étaient dans `build/captures/`, qu'un
    `flutter clean` a vidé le matin du 4. ⚠️ **`build/` est le
    dossier de travail du compilateur** : une livraison n'y a rien à
    faire. `captures/` est ignoré par git mais hors de portée d'un
    `clean`.

    ⚠️ **Et les simulateurs avaient disparu avec**, tous :
    `~/Library/Developer/CoreSimulator` pesait 0 octet, les appareils
    étaient déclarés par `simctl` sans données sur le disque. Le
    runtime iOS 27.2, lui, était intact — deux appareils neufs
    recréés en une commande.

    ⚠️ **Deux pièges du pilotage par `simctl`**, tous deux rencontrés :
    le **collage de texte échoue en silence** (la recherche d'un
    légume est donc inatteignable, il faut filtrer par catégorie), et
    une **fiche poussée n'a pas de barre d'onglets** — taper à
    l'emplacement habituel touche le bouton flottant « Je l'ai
    planté », ce qui ajoute un plant et fausse les captures
    suivantes.
6 bis. ✅ **Captures d'écran Google Play — faites le 4 novembre 2026.** Dix captures en **1080 × 1920** (dossier non suivi par git ; ⚠️ à sortir de `build/`, voir le point 6) : tableau de bord, « à semer en novembre », cahier de culture, potager carré, journal, « Garder ta récolte », fiche tomate, badges, plus l'Étal et « au jardin en ce moment » en réserve. Play en accepte huit par type d'appareil.

    **Pourquoi il a fallu un émulateur Android** : aucune des 14 captures Apple ne convenait. Play exige que le côté le plus long fasse **moins du double** du côté le plus court, et l'iPhone 6,9″ est à 2,17 (1320 × 2868). Celles-ci sont à **1,78**, le 9:16 que Play recommande.

    ⚠️ **L'alpha** : `adb screencap` rend du PNG **RGBA**, que Play peut refuser (« PNG 24 bits sans canal alpha »). `tool/sans_alpha.py` le retire sans recompresser — passer par du JPEG abîmerait le texte, qui est ce qu'une capture de boutique montre le plus.

    ⬜ **Il manque l'écran Météo 7 jours**, qui était prévu. Il ne s'ouvre que si la météo a chargé, donc il faut la localisation ; et l'accorder dans l'émulateur déclenche en boucle la boîte « Location Accuracy » de Google Play Services, qui reste au premier plan. À prendre sur un vrai téléphone Android.

    ✅ **Et cette installation a servi à autre chose** : elle a trouvé que l'app **plantait au lancement en release sur Android**, pour tout le monde. Corrigé le 3 novembre 2026 (`android/app/proguard-rules.pro`), détail dans l'alerte 26 de `CLAUDE.md`.
7. ✅ **Liens Amazon remis** : ôtés le 20 octobre 2026 (compte fermé), les 159 liens sont revenus le 30 octobre 2026 sous le tag `kultiva1-21`. ⚠️ Pense au statut trader (DSA) à la soumission.
8. ✅ **Clé de localisation** : `NSLocationAlwaysAndWhenInUseUsageDescription` ajoutée le 30 octobre 2026 (avertissement ITMS-90683) ; builds 127 à 220 envoyés depuis.
9. **Soumettre iOS** : le build 220 (3 novembre 2026 au soir, en TestFlight) depuis `docs/FICHE_APP_STORE.md`.
10. **Créer la fiche Google Play** : le formulaire de création est
    rempli et attend ses **deux cases de déclaration**, que seul Jean
    peut cocher (règlement du programme, lois d'exportation). Tout le
    reste — textes, icône 512, bannière 1024 × 500, dix captures, bundle
    signé, réponses aux questionnaires — est prêt dans
    `docs/FICHE_PLAY.md`. Lancer le test fermé dans la foulée ;
    ses quatorze jours ne s'appliquent peut-être même pas (§ Android).
11. **Relier les boutons « Télécharger »** : le site n'a plus de `href="#"` — les deux boutons sont inertes et disent « Bientôt sur l'App Store » / « Bientôt sur Google Play ». À remplacer par de vrais liens une fois l'app en ligne.
12. ⬜ **Le disque du Mac est plein** : **5 Go libres** le 4 novembre 2026, et l'émulateur refuse de démarrer sous 1 Go. Le swap monte à 16 Go pendant une session d'émulateur, puis se résorbe.

    ⚠️ **Correction d'une erreur de cette fiche** : elle annonçait 82 Go récupérables dans `~/Library/Developer/CoreDevice/DeviceFS`. C'est **faux**. Ce chemin est un **point de montage** (`devicefs`), pas un dossier : `du` y mesure le contenu des iPhone vus à travers le montage. Le dossier réel pèse **4 Ko**, et l'effacer n'aurait rien libéré. Mesuré avec `mount` et `du -x`, qui ne traverse pas les montages.

    **Les vrais gros postes, mesurés** : `~/Library/Developer/CoreSimulator` 11 Go (les runtimes et appareils iOS), `~/Dev` 18 Go, `~/Pictures` 9,7 Go. Rien n'a été supprimé.


---

## Ce qui a été réglé depuis

- **Builds iOS reçus par App Store Connect** (25, 27, 30, 31 octobre et
  1er, 2 et 3 novembre) — les builds Xcode Cloud 95, 96, 97, 127, 134, 152, 166 puis 195 sont
  arrivés dans la fiche `6762550020`, puis le 220 le 3 novembre au soir,
  disponible en TestFlight.
- **Liens Amazon remis** (30 octobre) — sous le tag `kultiva1-21`.
- **Site en ligne** (7 octobre) — `landing/` publié sur GitHub Pages à
  l'adresse `kultiva.toakeur.com`. Coupé du 3 au 4 novembre (dépôt
  privé), rétabli le 4 novembre.
- **Adresse de contact** (7 octobre) — `kultiva@toakeur.com` partout
  (site, confidentialité, fiches des stores) à la place de l'ancienne
  adresse Gmail.
- **Liens Amazon retirés** (20 octobre) — le tag `kultiva-21` dépendait
  du compte Amazon Partenaires fermé le 18 octobre : les 159 liens
  « Acheter » ont été ôtés du catalogue, le bouton ne s'affiche plus.
- **Mention « Partenaire Amazon » ôtée du site** (21 octobre) — dernière
  trace de l'affiliation, dans le pied de page de `landing/index.html`.

## Ce qui a été réglé fin août 2026

- **Mode invité** (24 août) — l'app exigeait un compte au premier
  lancement alors que le calendrier, le catalogue, le potager et les
  tutos n'en ont pas besoin : rejet probable au titre de la
  guideline 5.1.1. « Continuer sans compte » est livré et vérifié sur
  simulateur, persistance comprise.
- **Feed communautaire retiré** (24 août) — l'écran n'avait jamais été
  branché, mais les défis téléversaient quand même les photos. Personne
  ne les voyait et aucun signalement n'existait, contre une promesse de
  communauté modérée dans la fiche et les deux politiques de
  confidentialité : rejet probable au titre de la guideline 1.2. Les
  photos restent désormais locales, ou dans le cloud privé du compte.
  Conséquence utile : classification **4+ au lieu de 13+**.
- **Réglage de debug masqué** (24 août) — « Heure de test (debug) »
  n'avait aucun garde `kDebugMode` et serait apparu à tous les
  utilisateurs.
- **Build Android réparé** (23 août) — Kotlin 2.1.20 ; vérifié par un
  `flutter build appbundle --release` complet.
- **Décision DSA** (24 août) — les liens d'affiliation sont conservés,
  donc statut **trader**. Ces liens, retirés le 20 octobre 2026, sont
  revenus le 30 octobre 2026 : le statut de trader reste celui à déclarer.
- **Chiffres marketing corrigés** (24 août) — une passe antérieure avait
  gonflé défis et badges de 50 à 51 dans toutes les fiches. Le catalogue
  en contient bien 50 et 50. Le chiffre de 33 tutoriels, lui, était
  juste.
