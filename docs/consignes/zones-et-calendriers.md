# Kultiva : zones climatiques et calendriers (alertes 20 à 22)

> Texte déplacé tel quel depuis `CLAUDE.md` le 16 novembre 2026, pour alléger les consignes lues à chaque session. Rien n'a été réécrit.

## 🌴 Le manioc ne se sème pas à Lyon (02/11/2026)

**Signalé par Jean** : « certains produits ne devraient pas être en
Europe ». En mai, l'écran Semer d'un jardinier lyonnais comptait le
**manioc, le taro, l'igname, le bissap, l'arachide et le sésame**
parmi les légumes à semer.

⚠️ **L'information existait, mais en prose.** Vingt-six notes
régionales disaient « non adapté au climat français hors DOM-TOM » ou
« besoin de froid hivernal » — et le code n'en savait rien. Une
donnée que seul un humain peut lire n'est pas une donnée.

⚠️ **Et la base tropicale, elle, réglait déjà le problème** : pommier,
cassissier et kiwi y ont des mois **vides**, donc ils n'apparaissent
jamais dans Semer à Dakar. La convention existait ; elle n'était
appliquée que d'un côté. C'est le genre d'asymétrie qu'on ne voit
qu'en comparant les deux fichiers.

**`RegionData.shelterOnly`**, posé sur les neuf cultures françaises
dont la note le disait. La vignette porte une pastille **« Sous
serre »**, dans le catalogue et dans le calendrier mensuel.

⚠️ **Choix de Jean : montrer, pas cacher.** Trois options lui ont été
proposées — faire disparaître de Semer, afficher avec une pastille,
retirer du catalogue. Il a pris la pastille : un jardinier qui a une
serre cherche ces cultures, et les cacher serait décider à sa place.

⚠️ **C'est une propriété du couple culture + zone, pas de la
culture.** La pastèque est sous serre à Lille et en pleine terre à
Séville : `deriveTemperate` **ne reprend pas** le drapeau quand la
zone a son calendrier écrit à la main, et le reprend sinon. Donc le
manioc reste marqué à Varsovie et à Tokyo sans qu'on l'écrive.

`test/sous_serre_test.dart` verrouille, et son test le plus utile est
celui qui refuse la **contradiction** : une note qui dit « non adapté »
sous un drapeau qui dit le contraire. C'est exactement ce qui avait
laissé passer le manioc.

### 💰 Le bloc Maraîchage est retiré

`market_data.dart` donnait un rendement et un **prix de détail au kg
en FCFA** pour 45 légumes, affiché dans les 8 pays d'Afrique de
l'Ouest. Il venait du virage AO du 03/08/2026.

Décision de Jean le 02/11/2026 : **il disparaît**. C'est une
fonctionnalité de maraîcher professionnel dans une app de jardiniers
amateurs, et les prix dataient de 2025 — vieux d'un an dans une app
qui promet de ne rien dire de faux.

Partis avec : `lib/data/market_data.dart`, `_MarketSection`,
`_MarketRow`, le test « données marché » et sept clés d'interface
devenues orphelines. ⚠️ **« Rendement » est restée** : elle sert aussi
à la fiche du catalogue.

⚠️ **Ne pas confondre avec `market_buying_tips.dart`**, qui reste : ce
sont les conseils pour **choisir** au marché, pas pour vendre. Ils
remplacent le bouton Amazon là où Amazon ne livre pas.

## 🌾 La neuvième zone, et le climat qui suit enfin la zone (02/11/2026)

**`ClimateZone.coolWinter` — tropical à hiver frais.** Mousson de juin à
septembre, puis une saison sèche et fraîche de novembre à mars où l'on
cultive les légumes tempérés. Plaine du Gange, nord du Viêt Nam.

**Pourquoi elle manquait** : les huit autres zones n'avaient pas
d'hiver. Hanoï cultive chou et carotte en décembre à 16 °C, et le
maraîchage de Delhi est le *rabi*, de novembre à mars. Les calendriers
guinéen et soudanien passaient cette saison entière sous silence — la
moitié de l'année agricole de deux pays qui pèsent un milliard et demi
d'habitants.

`coolWinterCalendar` (`west_africa_zones.dart`) porte **55 cultures** en
trois saisons : le *rabi* d'octobre-novembre (choux, racines,
légumineuses, bulbes, feuilles), le *kharif* de juin-juillet, et le
*zaid* de février-mars pour les cucurbitacées.
`test/cool_winter_test.dart` verrouille, et deux de ses règles ont
attrapé mes propres erreurs : le panais répétait la base à l'identique
(surcharge inutile, donc bruit), et ma première formulation interdisait
les semis avant septembre alors que **la pépinière de chou-fleur part
en août**, fin de mousson. La règle juste est « pas d'avril à
juillet », pas « après septembre ».

**Inde** et **Viêt Nam** la portent, affinées par latitude : au sud de
24° N l'Inde redevient soudanienne puis guinéenne, au sud de 16° N le
Viêt Nam redevient guinéen.

### Le climat ne lit plus la région

Le même défaut que le calendrier du matin, dans cinq autres endroits.
Une **région** ne dit plus que le contenu (ouest-africain ou non) ; le
climat est une propriété de la **zone**.

| Ce qui lisait la région | Ce que ça donnait |
| --- | --- |
| `Season.of` | Darwin voyait les quatre saisons européennes, São Paulo un hivernage là où il gèle |
| `heatwaveThresholdFor` | Darwin alertait dès 30 °C — presque tous les jours ; São Paulo attendait 40 °C, jamais atteints |
| `computeMedalTier` | São Paulo n'avait que deux saisons à collectionner au lieu de quatre, son podium plafonnait |
| `checkAndNotifyFirstRains` | l'alerte « premières pluies » ne partait pas à Darwin, et partait à São Paulo |
| `Country.isTropical` | répondait d'après la région du pays |

`heatwaveThresholdFor(Region)` devient `heatwaveThresholdForZone(ClimateZone?)`,
plus `currentHeatwaveThreshold()` pour les quatre appelants.
`Region.isTropicalBase` **reste**, mais son seul usage légitime est
désormais de **choisir une zone par défaut** quand aucune n'est connue.
Trois endroits le font, et ils le disent.

⚠️ **Une huitième saison, et pourquoi pas une des sept** :
`Season.coolDry`, « Saison fraîche ». Elle ne pouvait pas être
`harmattan`, qui désigne un vent sahélien dont personne n'a entendu
parler à Delhi, ni `winter`, dont les particules sont des **flocons** —
il ne neige pas à Hanoï. Dégradé bleu pâle, brume et feuillage :
c'est la saison où le potager est le plus vert, pas la plus morte.

## 🌍 Les calendriers écrits à la main (02 et 03/11/2026)

**Ce que le décalage uniforme ratait.** `zone_shift.dart` dérivait ces
deux zones de la base française par un décalage d'un mois. Pour un
pommier, bonne approximation. Pour une laitue, faux de six mois : en
climat méditerranéen, **l'été est la saison morte** des
légumes-feuilles, pas leur pic. Une laitue semée en juillet à Séville
monte en graine avant de pommer. Salades, choux, radis et légumineuses
s'y sèment à l'**automne** et se récoltent en **hiver et au
printemps** — l'inverse du rythme français.

En continental, le problème est à l'autre bout : le sol gèle de
novembre à mars. Le poireau, la mâche, le chou pommé et le panais, que
la France récolte tout l'hiver, doivent y être **arrachés avant les
gelées**. Le décalage les laissait récolter en janvier, sous la neige.

**`lib/data/regions/temperate_zones.dart`** porte 51 calendriers
méditerranéens et 48 continentaux, écrits culture par culture, chacun
avec une note qui explique l'écart — sans elle, un jardinier français
installé en Espagne croit à une erreur.

**Ça ne remplace pas la dérivation, ça la corrige où elle se trompe.**
Une culture absente du fichier garde son calendrier dérivé et sa note
qui le dit. `deriveTemperate()` consulte la surcharge en premier, puis
applique l'hémisphère. Même principe que les surcouches de traduction.

`test/temperate_zones_test.dart` (16 tests) verrouille : aucune clé
inventée, mois valides, une note partout, **rien d'identique à ce que
le décalage dirait** (une surcharge inutile est du bruit), pas de
salade semée en plein été au sud, rien semé ni récolté dans le sol
gelé au nord — sauf l'ail, parce que c'est le froid qui fait diviser
la tête, et sauf les semis marqués « à l'abri ».

⚠️ **Deux anciens tests ont dû changer** : ils vérifiaient le décalage
uniforme sur la **tomate**, qui a maintenant un calendrier écrit. Ils
portent désormais sur le sarrasin, qui n'a pas de surcharge.

### Le subtropical humide (03/11/2026)

**Ce n'est pas un méditerranéen un peu plus chaud**, et c'est l'erreur
que faisait la dérivation. Les deux ont un hiver doux, mais le
méditerranéen a un été **sec** et celui-ci un été **lourd** : 30 à
35 °C avec de l'humidité et des orages. Une tomate n'y souffre pas de
la soif, elle attrape le mildiou ; une laitue n'y grille pas, elle
pourrit du collet.

**La dérivation subtropicale élargissait** : semis = base ∪ base−1,
récolte = base ∪ base+1. Elle ajoutait donc des mois de part et
d'autre sans jamais rien retirer — une laitue restait semable en
juillet à Atlanta comme à Buenos Aires.

`subtropicalCalendar` porte **58 cultures**, et sa signature est le
**double semis** : une récolte de printemps et une d'automne, de part
et d'autre du creux humide de juillet-août. Tomate, courgette,
concombre, maïs et pomme de terre se sèment deux fois ; le
méditerranéen, lui, n'a qu'une saison.

⚠️ **Trois détails qui ne se devinent pas** :

- **la fraise s'y mène en annuelle** — plants à l'automne, récolte
  d'hiver, puis on arrache : un pied laissé en place ne passe pas
  l'été humide ;
- **le chou de Bruxelles est possible sans être confortable** : les
  pommes ne se serrent qu'au froid, et l'hiver est doux. Sa note le
  dit, plutôt que de le faire disparaître ;
- **semer en août est normal ici** pour les choux, les racines et le
  poireau : c'est la pépinière de la récolte d'hiver. Le test
  n'interdit l'été lourd qu'aux salades, parce que c'est pour elles
  seules que c'est faux.

Zones concernées : sud-est des États-Unis, Argentine, Uruguay, sud du
Brésil, Japon, est de l'Australie, haut plateau sud-africain. Quatre
sur sept sont dans l'**hémisphère sud** : les calendriers s'écrivent
en mois du nord, et `deriveTemperate` applique le retournement après
la surcharge. Un test le vérifie nommément sur l'Argentine.

⚠️ **Restent des moyennes de zone.** Le méditerranéen de Marrakech
n'est pas celui de Zagreb, et le subtropical de Tokyo n'est pas celui
de Houston. Les affiner pays par pays reste à faire.

20. ~~**L'interface n'est pas traduite**~~ — ✅ **FAIT le
    02/11/2026.** 772 chaînes par langue, 718 appels `trUi()` dans
    53 fichiers, et les 33 clés ARB orphelines retirées. Treize agents
    en deux vagues : sept pour **brancher** (envelopper les littérales
    sans traduire), six pour **traduire**.

    **Ce que le branchement a appris, et qui resservira :**

    - ⚠️ **Deux collisions de clés**, trouvées seulement parce qu'un
      agent a su les nommer. « juin » est à la fois le mois court et le
      mois long — en anglais « jun » et « june », donc **une clé
      devrait rendre deux valeurs**. Et « Mar » est à la fois **mardi**
      et **mars**. Les mois et les jours sont donc des **tables
      indexées** dans `ui_i18n.dart`, pas des phrases. Un ensemble
      fermé et ordonné n'est pas du texte libre.
    - ⚠️ **Un champ d'enum `const` ne peut pas appeler de fonction.**
      `Country.label`, `Country.capitalName` et `Region.label` passent
      par un getter `displayLabel`, comme `Vegetable.displayName`.
      `tool/exporter_enums.dart` les sort pour le squelette, et le test
      les lit **dans l'enum**.
    - ⚠️ **Le tri et la recherche suivent la langue.** Le catalogue
      espagnol commence à Alemania, et une recherche répond aux deux
      langues — la clé reste le nom français, mais un hispanophone tape
      « zanahoria ».
    - ⚠️ **`v.name` affiché, c'était du français partout.** Onze
      endroits l'utilisaient au lieu de `v.displayName` : notifications,
      PDF, potager carré, dossier de plant. Et `advice_service`
      affichait des **identifiants bruts** de compagnonnage.
    - ⚠️ **Un `Spacer` vole l'espace d'un `Flexible`.** Les deux sont
      flexibles, donc ils se partagent l'espace libre à parts égales :
      le titre de la carte du dashboard n'obtenait qu'une ligne, et
      « Challenges & badges » s'affichait « Challenges & ». Le
      français, qui tient sur une ligne, ne montrait rien. La carte est
      passée à 138 px et sa colonne à `spaceBetween`.
      **Une traduction est un test de mise en page** : les autres
      langues sont plus longues, et c'est l'écran qui le dit, pas le
      compilateur.
    - ⚠️ **Vingt tests sont tombés d'un coup** en remplissant les
      dictionnaires : ils comparaient du français alors que
      l'environnement de test tourne en `en-US`. Il faut **deux**
      choses, pas une — `setUpAll(() => PrefsService.instance
      .language.value = 'fr')` **et** semer
      `'flutter.kultiva.language': 'fr'` dans
      `setMockInitialValues`, sinon `load()` écrase la première.
    - ⚠️ **Un seul propriétaire par chaîne.** Les sept conseils
      canicule ont été enveloppés par erreur dans `trUi` alors que
      leurs trois appelants font déjà `tr(…)` : ils auraient été
      traduits deux fois, et leurs entrées de `content_en.dart`
      seraient devenues orphelines. `heatwave_tips.dart` rend donc du
      français, et son commentaire dit pourquoi.

21. ~~**Des textes citent encore le Poussidex**~~ — ✅ **FAIT le
    02/11/2026.** Les quatre derniers endroits visibles sont réécrits :
    le sous-titre « Le tour complet — dashboard, Cahier, Étal,
    Recettes », le dialogue de suppression d'un plant (« de ton cahier
    de culture »), le texte de partage (« dans mon jardin Kultiva ») et
    le dos de la carte de badge (« BADGES » au lieu de
    « POUSSIDEX »).

    **Deux entrées de lexique sont parties avec** — « poussidex » et
    « streak » définissaient des notions supprimées le 31/10, et la
    définition de « streak » citait un badge « Fidèle » qui n'existe
    pas dans les 50. Le contenu passe de 784 à **780 phrases**, et le
    test des clés orphelines a réclamé leurs traductions tout seul.

    **Au passage** : « Apprends à jardiner en vidéo » devient
    « Apprends à jardiner, fiche par fiche » — les tutos sont des
    fiches HTML, pas des vidéos. Et les deux dernières notifications
    qui vouvoyaient (« Vos légumes ont soif ») tutoient comme le reste
    de l'app.

    ⚠️ **`kultiva.gridMigratedToPoussidex` reste**, et doit rester :
    c'est une **clé de préférence** déjà écrite sur les téléphones. La
    renommer relancerait la migration de l'ancienne grille chez tous
    ceux qui l'ont déjà faite.

22. **La passe de vérification des 73 pays (02/11/2026)** — demandée
    par Jean après la Nouvelle-Calédonie : « si tu en as loupé un il y
    en a peut-être d'autres ». Il y en avait. Fiche publiée :
    `https://claude.ai/artifact/Dpxa9TsY3QQ4Au3L56cLgF`.

    ✅ **Le défaut structurel, et c'est le plus grave** : la base de
    calendrier suivait la **région**, et `Country.zoneAt(latitude)`
    peut rendre une zone de l'**autre** base. Le répartiteur retombait
    alors sur la base brute — sans note, sans erreur, sans test.
    Quatre pays le subissaient, dont le plus peuplé :

    - **Brésil** au sud de 23° S (São Paulo, Curitiba, Porto Alegre) :
      zone subtropicale demandée, calendrier tropical non élargi ;
    - **Australie** au nord de 24° S (Darwin, Cairns) : zone
      soudanienne demandée, calendrier français retourné de six mois ;
    - **Maroc** et **Algérie** au sud de 31° N : zone sahélienne
      demandée, calendrier français brut.

    `regionalCalendar()` teste maintenant `zone.isTropical` et non
    `region.isTropicalBase`. **Le climat est une propriété de la zone,
    pas du pays** ; une région ne dit plus que le contenu
    (ouest-africain ou non).

    ⚠️ **Pourquoi aucun test ne l'avait vu** : `country_test` vérifiait
    la zone **déclarée** d'un pays, jamais celle que `zoneAt()` rend à
    une latitude donnée. Le nouveau test balaie −60° à +72° par
    demi-degré pour les 73 pays. Un test qui vérifie la donnée au
    repos ne dit rien de la fonction qui la transforme.

    ✅ **Cinq zones corrigées**, chacune avec le fait qui contredisait
    l'ancienne, écrit dans `country.dart` :

    | Pays | Était | Est | Le fait |
    | --- | --- | --- | --- |
    | Croatie | méditerranéen | continental | Zagreb : pluies maximales en juin, janvier à 1 °C |
    | Égypte | sahel (tropical) | méditerranéen (tempéré) | 25 mm de pluie par an, maraîchage irrigué d'hiver |
    | Nouvelle-Calédonie | subtropical (tempéré) | soudanien (tropical) | 22° sud, pluies décembre-mars |
    | Afrique du Sud | méditerranéen | subtropical | Pretoria : pluies d'octobre à mars, gelées en juin |
    | Australie | méditerranéen | subtropical | Canberra : pluie toute l'année, gelées en juillet |

    ⚠️ **Deux échanges assumés** : l'Afrique du Sud gagne le Gauteng et
    perd le Cap, seul vrai méditerranéen du pays ; l'Australie gagne
    Sydney-Melbourne-Canberra et perd Perth-Adélaïde. Distinguer Perth
    de Sydney demanderait la **longitude**, que `zoneAt` n'a pas.

    ⚠️ **Corriger une zone déclarée ne suffit pas** : j'ai mis
    l'Australie en subtropical et Canberra recevait encore le
    méditerranéen, parce que `zoneAt` le rendait toujours. **Une zone
    vit à deux endroits** — le champ de l'enum et l'affinage par
    latitude.

    ✅ **Le libellé nomme le pays** : `placeLabelFor(region, country)`
    remplace `region.displayLabel` dans les trois titres de la fiche
    légume et l'en-tête du PDF. Un jardinier allemand lisait
    « Semis — France ».

    ✅ **La deuxième porte du lien Amazon**, oubliée le matin même : le
    panier des accessoires testait encore la région, donc s'affichait
    dans les 36 pays de la base tempérée. **Une règle à deux endroits
    se corrige à deux endroits** — et c'est `grep` qui le dit, pas la
    mémoire.

    ⬜ **Reste ouvert** : les saisons (`Season.of`), le seuil de
    canicule (`climate.dart`), les médailles, les notifications et les
    animations de pétales lisent encore `region.isTropicalBase`. Ils
    diront donc autre chose que le calendrier à Darwin et à São Paulo.
    Le test `zoneAt` garde la donnée cohérente en attendant, en
    exemptant nommément le Brésil et l'Australie, qui chevauchent
    vraiment les deux bases.

    ⬜ **Reste ouvert** : Hanoï et Delhi réclament une **neuvième
    zone**, « hiver frais sous les tropiques ». Hanoï cultive chou et
    carotte en décembre à 16 °C ; le maraîchage de Delhi est le
    *rabi*, de novembre à mars. Les calendriers guinéen et soudanien
    ignorent cette saison entière.

    ⬜ **Reste ouvert** : Lima est un désert côtier classé tropical
    d'altitude, Antananarivo est à 1 280 m classée soudanienne — les
    deux inversées. Sans effet sur le calendrier (`sudan` et
    `highland` en produisent un identique, vérifié : 14 calendriers
    distincts pour 32 combinaisons), mais les saisons et les conseils
    mentent. Ankara et Abuja sont à confirmer.
