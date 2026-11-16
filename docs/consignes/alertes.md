# Kultiva : alertes (numéros 0 à 17)

> Texte déplacé tel quel depuis `CLAUDE.md` le 16 novembre 2026, pour alléger les consignes lues à chaque session. Rien n'a été réécrit.

## ⚠️ Alertes

À signaler à l'utilisateur / à traiter dans un futur ticket :

0. ~~**Actions manuelles Supabase avant publication**~~ — ✅ **FAIT
   (vérifié le 24/08/2026 par appels API)** : migrations 012 → 016
   appliquées (`preferences.country`, `preferences.climate_zone`,
   `challenge_posts.country`, FK feed→profiles, RPC `sync_xp`) et edge
   function `delete-account` déployée.

1. **Pas de test d'intégration** — 1 183 tests au 09/11/2026, dont une
   première couche de widgets : `text_scale_test.dart` monte dix écrans
   sur un iPhone SE à police normale puis 1,3 ;
   `ipad_landscape_test.dart` fait de même aux dimensions d'un iPad en
   portrait et en paysage, **et** vérifie que grilles et colonnes de
   texte sont rangées chacune dans son camp ;
   `assets_exist_test.dart` vérifie qu'une image déclarée existe **et**
   qu'une image embarquée sert à quelqu'un ;
   `accessibilite_test.dart` compte les zones tactiles nues sans
   étiquette VoiceOver.
   Aucun parcours complet n'est joué de bout en bout, et **rien n'a
   encore été essayé avec VoiceOver réellement activé** : un compte
   voit qu'une étiquette existe, pas qu'un écran est agréable à
   écouter.
2. ~~**L'`anonKey` Supabase est committée**~~ — sans objet depuis le
   retrait des comptes (30/10/2026) : `lib/config/supabase_config.dart`
   est supprimé.
3. ~~**Fichiers volumineux restants**~~ — ✅ **FAIT le 02/11/2026.**
   Les trois derniers fichiers au-dessus de 1 000 lignes sont
   découpés, et **plus aucun fichier de `lib/` hors données ne
   dépasse 723 lignes** (`plantation_detail_sheet.dart`).

   | Avant | Après |
   | --- | --- |
   | `vegetable_detail_screen.dart` 1 357 | l'écran 342 + cinq fichiers dans `vegetable_detail/` (header, calendar, culture, voisins, recettes) |
   | `badge_card.dart` 1 097 | le point d'entrée 212 + trois dans `badge_card/` (recto, verso, déblocage) |
   | `sow_screen.dart` 1 051 | l'écran 478 + deux dans `accueil/` (cartes, diapos) |

   Même patron que le potager carré : un fichier par sujet, les
   classes privées deviennent publiques puisqu'elles changent de
   fichier, et le fichier d'origine **réexporte** pour que les imports
   existants continuent de marcher.

   ⚠️ **Deux pièges du découpage**, tous deux attrapés par `analyze` :
   un import relatif sans `../` pointe sur le dossier du fichier, donc
   il casse dès qu'on descend d'un cran ; et `dart fix --apply` a
   retiré un import devenu « inutile » dans `challenges_grid.dart`
   alors qu'il servait à joindre une fonction déplacée — c'est
   l'export du point d'entrée qui le rattrape. `vegetables_base.dart` (4 281) et
   `west_africa.dart` (945) sont des fichiers de données, ils ne sont
   pas concernés.
   `vegetables_base.dart` (4 306) et `west_africa.dart` (945) sont des
   fichiers de données, ils ne sont pas concernés. **Mesurer avant de
   citer** : les chiffres du 30/10 (1 740 / 1 777) étaient périmés, ces
   fichiers avaient déjà été découpés.
4. ~~**Connexion obligatoire au premier lancement**~~ — ✅ **RÉSOLU
   (24/08/2026, commit d60b962)** : mode invité livré. Bouton
   « Continuer sans compte » sur l'écran de connexion,
   `PrefsService.guestMode` persisté, levé à la connexion comme à
   l'inscription. Vérifié sur simulateur iPhone 17.

5. **Le feed communautaire a été retiré de la v1 (24/08/2026).**
   `PoussidexFeed` n'avait jamais été branché à l'interface, alors que
   les défis téléversaient quand même les photos vers `challenge_posts` :
   du contenu que personne ne voyait, sans bouton de signalement, contre
   une promesse de communauté modérée dans la fiche et la landing —
   risque de rejet guideline 1.2. Décision de Jean : couper pour la v1.
   Supprimés : `poussidex_feed.dart`, `feed_service.dart`,
   `feed_post.dart` ; l'appel `publishChallengePost` est retiré des
   défis (les photos restent locales, et dans le cloud **privé** du
   compte). Fiche App Store, `store-listings.md`, les deux privacy
   policies et la landing alignées. Conséquence utile : plus de contenu
   généré par les utilisateurs → **classification 4+ au lieu de 13+**.

   **Pour le rétablir** : le code est dans l'historique git (avant
   `main`@24/08/2026) et les tables Supabase (`challenge_posts`,
   `post_likes`) sont intactes. Il faudra alors brancher l'écran,
   ajouter le **blocage d'utilisateur** (guideline 1.2 exige signalement
   ET blocage), repasser le questionnaire d'âge en CGU/13+ et remettre
   les mentions dans les fiches et les privacy policies.

6. ~~**Liens stores dans `landing/index.html`**~~ — ✅ **SANS OBJET
   (vérifié le 03/11/2026).** Les deux boutons ne sont plus des liens
   morts : ce sont des `<span class="btn disabled">Bientôt sur l'App
   Store</span>`, changés par le commit `a68ae1f`. Un `href="#"`
   renvoie en haut de la page, ce qui est pire qu'un bouton inerte, et
   le commentaire du fichier le dit.

   ⚠️ **Cette alerte a survécu une semaine à sa correction**, et je
   l'ai reproposée à Jean comme travail à faire sans ouvrir le
   fichier. Une alerte qu'on ne referme pas devient une fausse
   information de plus. **Mesurer avant de citer** vaut aussi pour sa
   propre liste de tâches.

   **Reste vrai** : au moment de la publication, remettre de vrais
   `<a href>` vers les fiches des boutiques.

8. ~~**Le Poussidex « collection de plants » n'existait pas dans l'app**~~ —
   ✅ **RÉSOLU (30/10/2026)**. Diagnostic : 2 168 lignes écrites et
   injoignables (`plantation_detail_sheet.dart`, `poussidex_card.dart`,
   `poussidex_journal.dart`, `poussidex_podium.dart`,
   `poussidex_stats.dart`, plus `share_card.dart` par ricochet) ; aucune
   interface ne créait de `Plantation`, dont le seul producteur était la
   migration unique de l'ancienne grille — donc **0 plant à vie** pour
   une nouvelle installation, et des médailles éternellement `none`.
   Risque de rejet guideline 2.3.1, la fiche App Store promettant la
   collection en titre.

   **Ce qui a été fait** : nouveau `PlantationService`, propriétaire
   unique des mutations (ajout, arrosage, récolte, clôture, note,
   photos, suppression), local d'abord puis cloud en arrière-plan, et
   recalé sur `plantationsVersion` pour reprendre une fusion cloud.
   Nouvel onglet **🪴 Mes plants** (`AlbumFilter.collection`) qui relie
   les quatre écrans existants derrière un sélecteur
   Grille / Journal / Podium / Stats — **supprimé le 31/10/2026**, voir
   l'historique. Entrée unique : le bouton flottant
   **« Je l'ai planté »** sur une fiche légume (masqué pour les
   accessoires). 13 tests (`test/plantation_service_test.dart`).

   ⚠️ **Correction d'un diagnostic erroné** : j'avais écrit que
   `_onWater()` (`my_garden_screen.dart`) « n'enregistre rien ». C'est
   faux — c'est le bouton de soin de **Tamassi**, et
   `TamassiView.triggerEffect` enregistre bien le jour, incrémente la
   stat et donne +1 XP une fois par jour. Il n'a simplement rien à voir
   avec l'arrosage d'un *plant*, qui lui n'avait aucun moyen d'être
   enregistré.

   ⚠️ **Ce paragraphe disait faux (corrigé le 31/10/2026).** Il
   annonçait que `CultureEntry.linkedPlantationId` était « écrite et
   lue nulle part » et que les deux arrosages vivaient dans des
   registres séparés. C'était vrai avant le 30/10 et plus après : le
   même chantier a branché `CultureService.wateringsFor`, qui lit la
   plantation liée, et `CultureService.water*`, qui délègue à
   `PlantationService`. Un arrosage saisi depuis le potager carré et
   un arrosage saisi depuis le Poussidex atterrissent au même endroit.
   **Mesurer avant de citer**, ici comme pour les tailles de fichiers.

   **Reste ouvert** : les trois modèles se recouvrent toujours
   (`Plantation`, `PlannedCell`, `CultureEntry`) pour « un légume
   planté à une date ». Ils ne divergent plus, mais trois classes pour
   un concept, ça reste trois endroits où se tromper.

7. ~~**Projet Supabase en pause**~~ — ✅ **SANS OBJET (30/10/2026)** :
   les comptes ont été retirés de la v1, l'app ne contacte plus aucun
   backend. Le projet reste en pause chez Supabase, ses données et ses
   migrations conservées un an ; **ne pas le supprimer**, mais il ne
   bloque plus rien.

8. **Décision du 30/10/2026 : pas de comptes en v1.** Le jardin vit sur
   l'appareil. Raison : l'app n'avait aucun utilisateur, et le backend
   gratuit de Supabase se met en pause après une semaine sans trafic —
   une app non publiée ne peut donc pas le garder éveillé. Supprimés :
   `lib/screens/auth/`, `auth_service.dart`, `cloud_sync_service.dart`,
   `supabase_config.dart`, les dépendances `supabase_flutter`,
   `google_sign_in`, `sign_in_with_apple`, `crypto` (−36 paquets, −70
   lignes de `Podfile.lock`), l'entitlement Apple Sign-In et le schéma
   d'URL Google.

   **Conséquences voulues** : plus d'obligation Apple de suppression de
   compte, questionnaire de confidentialité réduit à 2 types
   (localisation, plantages), guideline 4.8 sans objet, et les deux
   politiques de confidentialité réécrites — rien ne quitte plus
   l'appareil hors Open-Meteo et Sentry.

   **Conséquence à assumer** : changer de téléphone fait perdre le
   jardin. Décision du 30/10/2026 : **pas d'export/import de
   fichier** — une sauvegarde manuelle ne protège que ceux qui y
   pensent avant de casser leur téléphone. Si la portabilité redevient
   un besoin, elle passera par la synchro (voir ci-dessous).

   **Pour rétablir la synchro** : ne pas reprendre Supabase. La piste
   retenue est **Cloudflare** (Worker + D1 + R2, gratuit, ne s'endort
   jamais, juridiction EU disponible), avec Google + Apple **seulement**
   — le Worker n'a alors qu'à vérifier le jeton d'identité, sans jamais
   manipuler de mot de passe.

9. ~~**Il n'y a plus de simulateur iOS du tout**~~ — ✅ **RÉSOLU le
   02/11/2026, et deux diagnostics à corriger avec.**

   `xcodebuild -downloadPlatform iOS` (~8,3 Go, lancé par Jean) a
   réinstallé le runtime **iOS 27.2**. Depuis : `flutter build ios
   --simulator --debug` passe en 129 s, l'app s'installe, se lance, et
   **`simctl io screenshot` rend l'écran pour de vrai**. Tout ce qui
   suit a été fait ce jour-là sur un iPhone 17 — démarrage, onboarding,
   tableau de bord, recettes en espagnol, tuto en espagnol dans la
   WebView.

   ⚠️ **J'avais écrit deux fois une cause fausse.** La première était
   « un nettoyage de disque » (c'était la mise à jour de Xcode, Jean
   l'a corrigée). La seconde, plus coûteuse, était d'affirmer que
   **`Simulator.app` manquant rendrait les captures noires de toute
   façon** — j'avais conclu que seule une réinstallation complète de
   Xcode débloquerait les fiches stores. C'est faux : `Simulator.app`
   est **toujours** absent, Xcode.app pèse toujours 4,0 Go, et les
   captures marchent. `simctl io screenshot` parle directement à
   `CoreSimulator`, pas à l'interface graphique ; l'app Simulator ne
   sert qu'à **regarder** avec ses yeux. Les captures étaient noires
   parce qu'il n'y avait **pas de runtime**, point. Une seule cause,
   pas deux. **Mesurer avant de citer**, y compris quand la mesure
   coûte une commande de dix secondes.

   **La recette qui marche**, sans Simulator.app :

   ```bash
   xcrun simctl boot "iPhone 17" && xcrun simctl bootstatus "iPhone 17"
   flutter build ios --simulator --debug
   xcrun simctl install booted build/ios/iphonesimulator/Runner.app
   xcrun simctl launch booted com.toa.kultiva
   xcrun simctl io booted screenshot ecran.png
   ```

   Le premier démarrage d'un device neuf prend ~90 s et montre le logo
   Apple : ne pas conclure « écran noir » sur la première capture.

   ⚠️ **Le premier lancement après un `simctl install` est lent**, une
   à trois minutes, et l'app reste sur son splash pendant ce temps.
   Les lancements suivants affichent l'écran en dix secondes. Je m'y
   suis fait prendre deux fois le 02/11, et la seconde j'ai conclu à
   une régression du code puis attribué le déblocage à une correction
   de mise en page faite entre-temps. **C'était faux** : la correction
   était bonne en soi — un titre tronqué — mais elle n'a rien débloqué.
   Avant de diagnostiquer un blocage au démarrage : relancer sans
   réinstaller, et vérifier le CPU du processus (`ps -o %cpu`). À 0 %
   il attend, et attendre un `Future` n'est pas boucler.
   Pour piloter (taper, glisser), l'outil `Claude_Code_iOS_Simulator`
   prend des **points** (ici 402 × 874 pour 1206 × 2622 pixels, donc
   diviser par 3).

   **Garnir une installation sans un seul tap (03/11/2026).** Les
   captures des boutiques demandent un jardin peuplé, et le peupler à
   la main coûte une cinquantaine de gestes — dont chacun passe par
   l'autorisation d'accès au simulateur, qui se **redemande dès que
   l'appareil change d'identifiant** (c'est ce qui arrive après un
   `killall CoreSimulatorService`). Tout le cahier tient pourtant dans
   trois chaînes JSON de NSUserDefaults :
   `kultiva.plantations.v1`, `kultiva.cultures.v1` et
   `garden_plans_v1`, toutes préfixées `flutter.`.
   `tool/garnir_simulateur.py` les écrit — 6 plants, 6 cases, 6
   cultures, 13 badges débloqués — et porte la marche à suivre.

   ⚠️ **Le redémarrage du simulateur est obligatoire, pas prudent.**
   `cfprefsd` sert le plist depuis son cache : sans
   `shutdown` + `boot`, l'app relit ce qu'elle avait avant et on croit
   que l'écriture n'a rien fait. C'est exactement la cause de
   l'avertissement ci-dessous sur la langue, et le redémarrage est ce
   qui le lève — vérifié dans les deux sens le 03/11.

   **Changer la langue de l'app** : écrire la préférence dans le plist
   ne marche pas — `shared_preferences` le réécrit au lancement. Deux
   voies : le réglage « Langue » de l'app, ou la langue du **device**,
   que `effectiveLanguage` suit :

   ```bash
   xcrun simctl shutdown "iPhone 17"
   plutil -replace AppleLanguages -json '["es-ES"]' \
     ~/Library/Developer/CoreSimulator/Devices/<UDID>/data/Library/Preferences/.GlobalPreferences.plist
   xcrun simctl boot "iPhone 17"
   ```

   ⚠️ **`plutil` coupe les clés sur les points.** Une clé
   `flutter.kultiva.language` doit s'écrire `'flutter\.kultiva\.language'`,
   sinon c'est « Key path not found ».

   ⚠️ **Le disque.** Un build iOS debug laisse 1 Go dans `build/` et
   370 Mo dans `~/Library/Developer/Xcode/DerivedData` ; le runtime
   iOS pèse ~8 Go. Il restait **15 Go libres** après installation du
   runtime le 02/11 — surveiller, et `flutter clean` après une session
   de builds iOS.

   **Reste vrai** : personne n'a **vu** l'app bouger en vidéo, et un
   test golden rend toujours n'importe quel widget en PNG sans
   appareil (charger Nunito depuis `assets/google_fonts/` avec un
   `FontLoader`, sinon le texte sort en rectangles ; ne pas committer
   un tel test, le rendu diffère en CI). C'est comme ça qu'ont été
   trouvés le débordement de 15 px de la légende du calendrier et
   l'aperçu de grille resté blanc.

10. **Le build Android ne marche qu'avec le JDK d'Android Studio** —
    le `java` du PATH est un OpenJDK 25 (Homebrew) que Gradle 8.14 ne
    supporte pas. Préfixer :

    ```bash
    JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home" flutter build apk --release
    ```

11. **Les planches 4K d'origine** (294 crédits OpenART) sont hors du
    dépôt, dans `~/Dev/apps/kultiva-planches-sources/`. Le découpeur,
    lui, est versionné : `assets/images/vegetables_kawaii/_split.py`.

12. ~~**La fiche App Store et les fiches par pays parlent encore de
    Tamassi**~~ — ✅ **FAIT (31/10/2026)** : les 53 mentions sont
    réécrites, et les décomptes de caractères recalculés sur le texte
    réel (sept étaient déjà faux avant).

13. ~~**Quatre médaillons de badge contredisent leur badge**~~ — ✅
    **FAIT (31/10/2026, 42 crédits OpenArt, accord de Jean).** Refaits
    dans le style actuel des badges : parterre surélevé pour « Premier
    jardin », cinq légumes pour « Cinq espèces », trois parterres pour
    « Trois jardins », appareil photo pour « Album ». Recette et mise
    en garde dans `assets/images/vegetables_kawaii/README.md`.

    **Comment le problème était né** : la réécriture des badges a gardé
    les 50 identifiants, donc les 50 images, qui sont nommées d'après
    eux. La plupart tombaient juste par chance (une pousse pour
    « 5 plants », une licorne pour « rare »), mais quatre montraient
    la créature supprimée ou un objet sans rapport — deux créatures qui
    se saluent pour « Créer ton premier jardin », une foule pour
    « Créer 3 jardins », cinq créatures pour « Planter 5 espèces », un
    cœur rose pour « 10 photos ». **Vérifier les images quand le sens
    d'un badge change** : `flutter analyze` ne voit rien, et
    `assets_exist_test.dart` non plus — le fichier existe, il raconte
    simplement autre chose.

    **Restent discutables, sans être faux** : `first_pet`
    (main + cœur → « mettre en favori », le cœur sauve la mise),
    `first_fertilize`, `fertilize_20` et `fertilize_100` (sacs
    d'engrais → cases de potager carré).

    Régénérables en une planche OpenArt, **42 crédits** — à demander à
    Jean avant de dépenser (règle permanente). Garder les noms de
    fichiers : `assets/images/badges/<id>.webp`.

14. ~~**Le tuto animé du dashboard est périmé**~~ — ✅ **FAIT
    (31/10/2026).** Refait par une session design à partir de
    `docs/prompt-tuto-dashboard.md`, puis mis en conformité ici.

    **Le changement qui compte** : il ne contient plus **aucune
    capture d'écran**. L'interface est redessinée en HTML/CSS, donc
    le tuto ne dépend plus d'un simulateur et ne peut plus devenir
    faux parce qu'un écran a bougé d'un pixel. Les dix captures de
    `assets/tutos/screens/` (1,3 Mo) sont supprimées avec leurs deux
    entrées de `pubspec.yaml` ; le fichier passe de 1,4 Mo à 110 Ko.

    **Deux corrections apportées à la livraison** : elle chargeait
    GSAP depuis cdnjs et Nunito depuis Google Fonts. Les 33 autres
    tutos n'ont **aucun** appel réseau, et l'ancien dashboard
    embarquait déjà GSAP en dur. GSAP est donc inliné et la police
    est la pile système (`-apple-system, SF Pro Rounded…`), comme
    partout ailleurs. ⚠️ **Ne pas réintroduire de CDN ni de Google
    Fonts dans un tuto** : ils doivent tourner hors ligne.

    Vérifié dans le navigateur à 375 × 812 : les dix scènes
    s'enchaînent, le halo désigne le bon élément, la barre d'onglets
    suit, et le bouton pause répond.

15. **ML Kit a été essayé puis retiré (01/11/2026)** — décision de
    Jean, le même jour : « Franchement ça sert a rien du tt. Ça
    reconnais juste un fruit. » Il avait raison, et c'était aussi ma
    recommandation.

    **Ne pas le reproposer sans lire ceci.** Le code est dans
    l'historique git (commits `f6371ef` → `4973a21`, branche
    `essai/mlkit-stade`), avec sa logique pure et ses 19 tests.

    **Ce que l'essai a appris, et qui vaut pour n'importe quelle
    solution de vision :**

    - **Le prix, mesuré** sur deux builds release arm64 du même commit :
      **+12,8 Mio au téléchargement**, l'app passant de 48,6 à 61,4 Mio
      (+26 %). Dont 10,5 Mio de bibliothèque native, 2,9 Mio de modèle,
      1,2 Mio de dex.
    - ⚠️ **Comment mesurer sans se tromper** : `--target-platform
      android-arm64` ne filtre que les libs **de Flutter**. Celles des
      dépendances Android sont embarquées pour les trois architectures
      (28,7 Mio à elles trois), d'où un APK complet à +31 Mio qui
      **surestime** ce qu'un utilisateur télécharge, puisque Play
      découpe par ABI. Sommer les tailles **compressées** du zip en
      excluant `lib/x86_64/` et `lib/armeabi-v7a/`.
    - **Firebase entrait dans l'app** côté Android : le plugin tire
      `com.google.mlkit:linkfirebase`, l'APK déclarait
      `FirebaseInitProvider` et **trois permissions** nouvelles, dont
      `com.google.android.c2dm.permission.RECEIVE` (recevoir les push
      Google). Rien ne partait — sans `google-services.json` Firebase
      s'arrête au démarrage — mais dans une app qui promet qu'aucune
      donnée ne quitte le téléphone, c'était à déclarer aux boutiques.
      Côté iOS, Firebase est opt-in dans le Podfile : il n'y était pas.
    - **La raison du refus, et c'est la bonne** : le modèle générique ne
      reconnaît ni l'espèce (l'utilisateur l'a déjà choisie), ni les
      maladies, ni l'âge, et ne distingue pas une plantule d'un plant
      adulte. Il ne savait dire que « fleur », « fruit », « feuillage ».

    **Pourquoi la logique pure est partie aussi** : `stage_vision.dart`
    était bon et testé, mais plus rien ne l'appelait. La règle 10 est
    explicite, et ce projet s'est fait prendre quatre fois à garder du
    code « prêt pour plus tard » que personne n'atteignait.

    **Si la vision revient**, viser un modèle qui sait quelque chose que
    la date ignore — le stade sur les quatre phases, ou l'état sanitaire
    — et pas un étiqueteur généraliste. Pistes relevées le 01/11/2026 :
    un CNN sur photos iNaturalist atteint **86,4 %** sur exactement nos
    quatre stades (végétatif / bourgeons / floraison / fructification),
    et le papier dit que le point dur est la **qualité des photos**, pas
    le modèle ; `PlantNet-300K ResNet18` est publié en LiteRT sous
    Apache-2.0 (~16 ms sur un Pixel 8a) mais fait de l'**espèce**, ce
    dont on n'a pas besoin. Le prompt de discussion est dans
    `docs/prompt-modele-stade-plant.md`.

16. **L'onglet Photo a été ajouté puis retiré le 01/11/2026** —
    décision de Jean : « Non mais trop compliqué on retire le module
    photo. » Il avait raison sur le fond : l'onglet **doublait** le
    cahier de culture, qui portait déjà les photos d'un plant.

    **Ce qui est parti** : `lib/screens/home/photos/` (5 fichiers,
    dont la fiche conseil), `models/garden_photo.dart`,
    `services/photo_library_service.dart`, le libellé `tabPhoto` des
    deux ARB, et `Plantation.observedPhase` / `observedPhaseAt` avec
    `setObservedPhase` — ce champ n'était écrit que par la fiche
    conseil, il serait devenu un champ que rien ne remplit. Safe à
    retirer : il datait du jour même et n'a jamais été publié.

    **Ce qui reste, et qu'il ne faut pas confondre avec ce module** :
    les photos d'un plant dans le **cahier de culture**
    (`PlantationService.addPhoto`, `plantation_photo.dart`) et les
    **50 défis photo**, dont dépendent des badges. Le module retiré
    n'était qu'une **vue** par-dessus.

    ⚠️ **Conséquence sur les index d'onglets** : Recettes est repassé
    de 5 à 4. La route `kultiva://photos` survit pour les anciens liens
    et mène au cahier (index 1).

    **Une conséquence restée ouverte** : plus aucun écran ne permet à
    l'utilisateur de corriger le stade d'un plant. `AdviceService`
    le déduit de la date, et `planner_advice.dart` l'affiche dans le
    potager carré. Si la correction doit revenir, sa place est le
    dossier du plant (`showPlantationSheet`), pas un onglet.

17. ~~**Le tuto du dashboard montre quatre onglets**~~ — ✅ **FAIT le
    02/11/2026.** Le cinquième onglet (🫙 Conservation) est dans la
    barre, et son libellé est traduit dans les dictionnaires de tutos. Les
    scènes n'utilisaient que les index 0 à 2, donc l'ordre n'a pas
    bougé.

    **Deux choses ont suivi**, trouvées en regardant la page traduite :

    - les **noms et initiales de mois** du tuto venaient de son propre
      JavaScript, donc restaient français : il affichait « Novembre »
      et un « J » pour janvier sous une interface espagnole. Ils
      viennent maintenant de Dart (`__KULTIVA_MOIS__` et
      `__KULTIVA_MOIS1__`) ;
    - ses cartes avaient une **hauteur fixe de 104 px** : « Retos e
      insignias » passait sur deux lignes et chevauchait la pastille.
      `min-height` et une réserve de 34 px sous la pastille.

    ⚠️ `docs/prompt-tuto-dashboard.md` dit encore « quatre onglets » :
    à corriger avant de régénérer le tuto depuis ce prompt.
