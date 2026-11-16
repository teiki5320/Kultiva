# Kultiva : ménage des images (03/11/2026) et alertes 23 à 26

> Texte déplacé tel quel depuis `CLAUDE.md` le 16 novembre 2026, pour alléger les consignes lues à chaque session. Rien n'a été réécrit.

## 🧹 3,2 Mo d'images que personne n'affichait (03/11/2026)

**Ce qui partait dans chaque téléchargement sans jamais s'afficher** :
les quatre fonds par moment de la journée
(`assets/images/backgrounds/`, 2,3 Mo) — ils servaient à la créature
supprimée le 31/10 — plus `potager.png`, `potager_bg.png` et
`onboarding_5.png` (864 Ko). Le dossier `backgrounds/` était déclaré
dans `pubspec.yaml`, donc bel et bien embarqué.

**Pourquoi aucun test ne le voyait** : `assets_exist_test.dart` ne
regardait que dans un sens — qu'un chemin déclaré par le catalogue
existe. Jamais qu'un fichier présent serve à quelqu'un. Le test
inverse existe maintenant, et il ne regarde **que ce que
`pubspec.yaml` déclare** : les dossiers `*_png_v1` qui traînent sur le
disque depuis la bascule vers le WebP ne sont ni suivis par git ni
déclarés, les signaler serait du bruit. Les dossiers adressés par
identifiant (badges, légumes, accessoires) sont exclus par leur nom.

**Deux dépendances sont parties avec** : `sensors_plus`
(accéléromètre, pour les animations de la créature — plus aucun
`import` depuis le 31/10, mais du code natif dans chaque build) et
`cupertino_icons`, qui venait du gabarit Flutter et n'a jamais servi.

23. ~~**Trois images du catalogue montrent le mauvais légume**~~ — ✅
    **FAIT le 03/11/2026, une planche 2×2, 37 crédits, accord de
    Jean.** Trouvées en garnissant une installation pour les captures
    des boutiques, pas en lisant le code.

    | Fichier | Ce qu'il montre | Ce qu'il devrait montrer |
    | --- | --- | --- |
    | `haricot.webp` | une courgette | une gousse de haricot vert |
    | `navet.webp` | un radis (le même dessin que `radis.webp`) | un navet blanc et violet |
    | `concombre.webp` | un troisième rendu de la même courgette | un concombre |

    ⚠️ **Aucun test ne pouvait le voir.** `assets_exist_test` vérifie
    qu'un fichier existe, et depuis ce matin qu'un fichier embarqué
    sert à quelqu'un. Ni l'un ni l'autre ne regarde **ce que l'image
    montre**. C'est exactement l'angle mort des quatre médaillons de
    badge du 31/10 : le fichier existe, il raconte autre chose.

    `test/images_distinctes_test.dart` compare les 130 images deux à
    deux. Sa liste de dette est **vide** depuis la correction : la
    paire la plus proche est maintenant `haricot_beurre` et
    `salsifis` à 7,21 — deux sujets pâles et allongés, légitimement
    voisins. Le test refuse toute paire sous 7.

    ⚠️ **Et une empreinte en noir et blanc ne marche pas** : ces
    images sont toutes « un objet centré sur fond crème », donc elles
    se ressemblent toutes en luminance — ma première version trouvait
    qu'une carotte orange et une aubergine violette étaient la même
    image. C'est la couleur qui sépare. Seuil retenu : 7, parce que
    les doublons avérés sont entre 4 et 6 et que la première paire
    légitimement proche — panais et salsifis, deux racines pâles — est
    à 7,6.

    **Ce que la correction a coûté, mesuré** : une planche 2×2 en
    image-to-image sur GPT Image 2, 1:1, 2k, qualité moyenne —
    **37 crédits**, une seule génération. Trois images séparées en
    auraient coûté 126. La quatrième case a servi à un second essai du
    haricot vert, le sujet le plus dur : une gousse plate se confond
    vite avec une courgette, et c'est précisément celui qui tombait
    dans la capture de boutique.

    ⚠️ **Un légume repeint demande sa version détourée** :
    `python3 tool/detoure_legumes.py haricot navet concombre`, sinon
    `recipe_player_test` tombe. rembg n'est pas sur le système — venv
    jetable, et le modèle `isnet-general-use` pèse 179 Mo au premier
    lancement.

24. ~~**« Légume du jour · Arachide » à un jardinier français**~~ — ✅
    **FAIT le 03/11/2026.** Vu à l'écran en prenant la capture du
    tableau de bord pour les boutiques, pas en lisant le code.

    `vegetableOfTheDay()` tirait dans les **130 cultures** sans
    regarder le calendrier de l'utilisateur. Mesuré avant de corriger :
    **19 cultures sur 130** sont impossibles en France, soit **un jour
    sur sept** — dix n'ont aucune entrée au calendrier français (mil,
    fonio, moringa, aubergine africaine, corète, célosie, baselle,
    citronnelle, papayer, bananier plantain), neuf y sont marquées
    `shelterOnly` (patate douce, gombo, pastèque, igname, manioc,
    arachide, bissap, sésame, taro). Côté tropical, quatorze cultures
    ont des mois vides — pommier, cassissier, kiwi.

    **Deux exclusions, et elles ne disent pas la même chose** : une
    culture **sans mois** au calendrier d'ici ne s'y cultive pas, c'est
    la convention que la base tropicale appliquait déjà ; une culture
    `shelterOnly` s'y cultive, mais sa note dit « culture
    expérimentale » ou « résultats aléatoires en plein air ». Elle
    **reste au catalogue avec sa pastille** — montrer plutôt que
    cacher, décision de Jean le 02/11. Mais une **mise en avant** est
    une recommandation, pas un inventaire.

    ⚠️ **Le paramètre `calendar` est obligatoire exprès.** Avec une
    valeur par défaut, l'appelant qui l'oublie ramène le défaut sans
    qu'`analyze` ni aucun test ne voient rien passer. C'est la même
    précaution que `displayName` contre `v.name`.

    ⚠️ **Et un test par calendrier ne suffit pas** : chacun vérifie le
    sien, donc un paramètre purement ignoré les passerait tous les
    deux. Un quatrième test exige que France et Afrique de l'Ouest ne
    mettent pas en avant la même culture plus de 266 jours sur 366.
    Vérifié en recassant volontairement la ligne : le test nomme les
    coupables, arachide comprise.

    ⚠️ **Et le même écran portait le défaut deux fois.** Une heure
    après la correction, le tableau de bord conseillait « 🍌 Bananier
    plantain adore pousser à côté de 🟤 Taro ! » à la même
    installation française : `_tipOfTheDay` composait ses conseils sur
    les 130 cultures — compagnonnage, rotation, maladies — sans
    regarder le calendrier non plus. **Une règle écrite dans une
    fonction se corrige une fois ; une règle nommée se corrige
    partout.** D'où `cultivablesEnPleineTerre()`, que les deux
    appellent maintenant.

    ⚠️ **Pour le compagnonnage, les deux cultures doivent pousser
    ici** : un filtre posé sur la seule culture de gauche aurait laissé
    « tomate adore pousser à côté de taro ».

    Le conseil du jour vivait dans l'état de `SowScreen`, donc aucun
    test ne pouvait l'atteindre. Il est parti dans
    `lib/utils/conseil_du_jour.dart` — c'est de la logique métier, et
    la règle 10 dit où elle vit. `conseilsPossibles()` et
    `culturesCiteesParLesConseils()` existent pour que le test lise les
    **identifiants** plutôt que de relire la phrase à l'envers avec une
    expression régulière.

    **Troisième fois que cette famille de défaut sort** — après le
    manioc semé à Lyon (02/11) et les trois images du catalogue
    (alerte 23). À chaque fois, l'information existait et le code ne
    la lisait pas, et à chaque fois c'est l'écran qui l'a dit.

25. ~~**La description d'un badge était coupée en plein milieu d'une
    ligne**~~ — ✅ **FAIT le 03/11/2026.** Vu en prenant la capture
    « Défis & badges » pour les boutiques : « Planter ton premier »
    suivi de la moitié haute des lettres de « légume ».

    **Ce n'est pas l'ellipse qui manquait, c'est qu'elle ne partait
    pas.** Le `Text` portait `maxLines: 4` dans un `Expanded` qui
    n'offrait la place que d'**une** ligne (mesuré). Le paragraphe se
    croyait donc dans les clous, aucune ellipse n'était demandée, et
    c'est la **boîte** qui tranchait. ⚠️ Un `RenderParagraph` plus
    haut que sa boîte ne déclenche **pas** la bande jaune : il est
    simplement rogné. Ni `analyze` ni les tests de débordement ne
    pouvaient le voir.

    **Un `maxLines` doit valoir ce que la boîte peut montrer**, pas ce
    que l'auteur espère. `lignesQuiTiennent()` (`utils/text_scale.dart`)
    le calcule depuis la hauteur disponible, **échelle de police
    comprise** — sans ça le compte retomberait faux dès que
    l'utilisateur agrandit le texte, soit exactement le cas que ce
    fichier existe pour couvrir. La tuile passe de 145 à 175 points :
    trois lignes pour un badge débloqué, deux pour un badge verrouillé
    (le cadenas prend la troisième).

    ⚠️ **Le premier test était aveugle au défaut** : il filtrait les
    `Text` sur `maxLines != 1`, c'est-à-dire précisément la valeur que
    le défaut produisait. Il échouait, mais en disant « aucune tuile
    rendue » au lieu de « une description n'a qu'une ligne ». Un test
    qui échoue pour la mauvaise raison passera le jour où la mauvaise
    raison disparaît.

26. **L'app Android plantait au lancement en release** — ✅ **CORRIGÉ
    le 03/11/2026**, trouvé en installant le premier émulateur Android
    du projet pour les captures Google Play. **Aucun humain n'avait
    jamais lancé l'app sur Android.**

    ```
    FATAL EXCEPTION: main
    Unable to start receiver ScheduledNotificationBootReceiver
    Caused by: java.lang.RuntimeException: Missing type parameter.
      at FlutterLocalNotificationsPlugin.loadScheduledNotifications
    ```

    **La cause** : `flutter_local_notifications` relit ses
    notifications programmées avec Gson, qui a besoin du type
    générique de la liste. R8 — que Flutter active **en release
    seulement** — efface l'attribut `Signature`, donc `TypeToken` ne
    trouve plus rien. `android/app/proguard-rules.pro` le garde
    maintenant.

    ⚠️ **Trois raisons pour lesquelles rien ne pouvait le voir** :
    R8 ne tourne pas en debug, donc tout le développement se fait du
    bon côté du défaut ; `flutter analyze` et les 1 154 tests ne
    regardent que du Dart, et celui-ci est entièrement correct ; et la
    CI **construit** l'appbundle sans jamais le lancer. Un build qui
    réussit ne dit pas qu'une app démarre.

    ⚠️ **Il se déclenche au deuxième lancement, pas au premier** : il
    faut que `scheduled_notifications.xml` existe déjà pour qu'il y
    ait quelque chose à relire. Une installation neuve ouverte une
    seule fois ne le montre pas — c'est exactement ce que fait un test
    manuel rapide.

    ⚠️ **Et `-keepattributes Signature` seul ne suffit pas**, mesuré :
    R8 en « full mode » (le défaut depuis AGP 8) efface quand même la
    signature des sous-classes **anonymes** de `TypeToken`, que le
    plugin utilise. Il faut les règles officielles de Gson, qui sont
    dans le fichier.

    **Ce qu'il reste à faire** : la seule garde aujourd'hui est
    d'avoir lancé l'app deux fois à la main. Un émulateur en CI
    coûterait cher ; à défaut, **lancer deux fois un build release sur
    un appareil Android avant chaque soumission**.
