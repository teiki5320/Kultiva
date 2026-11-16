# Kultiva : émulateur Android, iPad et iPhone Duo

> Texte déplacé tel quel depuis `CLAUDE.md` le 16 novembre 2026, pour alléger les consignes lues à chaque session. Rien n'a été réécrit.

## 🤖 L'émulateur Android (03/11/2026)

Installé pour les captures Google Play, qui exigent un ratio **sous
2,0** — l'iPhone 6,9″ est à 2,17 et ne passe pas. L'AVD `kultiva_play`
est un **1080 × 1920** (exactement le 9:16 recommandé), densité 420,
image `system-images;android-36;google_apis;arm64-v8a`.

```bash
export ANDROID_HOME="$HOME/Library/Android/sdk"
export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
"$ANDROID_HOME/emulator/emulator" -avd kultiva_play -no-window -no-audio \
  -no-boot-anim -gpu swiftshader_indirect &
adb wait-for-device && adb root
flutter build apk --release --target-platform android-arm64
adb install -r build/app/outputs/flutter-apk/app-release.apk
python3 tool/garnir_simulateur.py --android /tmp/FlutterSharedPreferences.xml
adb push /tmp/FlutterSharedPreferences.xml /data/local/tmp/
adb shell am force-stop com.toa.kultiva
adb shell cp /data/local/tmp/FlutterSharedPreferences.xml \
  /data/data/com.toa.kultiva/shared_prefs/
adb shell chown u0_a214:u0_a214 \
  /data/data/com.toa.kultiva/shared_prefs/FlutterSharedPreferences.xml
adb shell am start -n com.toa.kultiva/.MainActivity
adb exec-out screencap -p > capture.png
```

⚠️ **Le garnissage a un seul propriétaire** :
`tool/garnir_simulateur.py` sort le plist iOS **et** le XML Android
depuis la même donnée, préfixe `flutter.` compris — c'est le plugin
qui le pose, pas nous. Un jardin corrigé sort juste des deux côtés.

⚠️ **Pas de `shutdown`/`boot` ici, contrairement à iOS** : Android ne
cache pas les préférences dans un démon, le `force-stop` suffit.
Mais il faut **lancer l'app une fois avant** d'écrire, sinon
`shared_prefs/` n'existe pas encore. Et le propriétaire du fichier
change à chaque réinstallation (`u0_a213`, `u0_a214`…) : le lire sur
un fichier voisin plutôt que l'écrire en dur.

⚠️ **Deux boîtes de dialogue bloquent tout** si on ne les désamorce
pas : celle de la permission de localisation, et celle de « Location
Accuracy » de Google Play Services, qui reste au premier plan et
empêche l'app de démarrer. Les taps `adb input` ne les atteignent pas
de façon fiable. La parade est de **fixer la permission comme refusée
par l'utilisateur**, ce qui supprime la demande :

```bash
adb shell pm set-permission-flags com.toa.kultiva \
  android.permission.ACCESS_FINE_LOCATION user-set user-fixed
```

L'app retombe alors sur Paris, comme le prévoit le repli documenté.

⚠️ **Le coût en disque, mesuré, et il est brutal.** L'émulateur et
l'image système pèsent ~3 Go, l'AVD en prend 1,9 de plus en
tournant — mais le vrai consommateur est le **swap** : lui donner
4 Go de RAM a fait monter le fichier d'échange à **16 Go**, et le Mac
est passé de 13 Go libres à **900 Mo** en une session. Rester à 2 Go
de RAM, et surveiller `df` entre deux captures.

⚠️ **Le premier tap après une pause est avalé.** Pas seulement au
lancement : chaque fois qu'on laisse l'émulateur tranquille une
minute, le tap suivant sur la barre d'onglets ne fait rien, et le
second passe. **Taper deux fois** et vérifier par capture ; enchaîner
à l'aveugle fait atterrir les taps sur le lanceur, et on croit à un
plantage de l'app.

⚠️ **`adb screencap` rend du PNG RGBA**, et Google Play veut du
« PNG 24 bits sans canal alpha ». `tool/sans_alpha.py` retire le
canal sans recompresser. Ne pas contourner par du JPEG : le texte est
ce qu'une capture de boutique montre le plus.

⚠️ **Deux boîtes de Google Play Services, pas une**, et la seconde ne
se ferme pas. Accorder la localisation déclenche
`LocationSettingsCheckerActivity` (« Location Accuracy »), que
`adb input tap` n'atteint pas et que `BACK` ne ferme pas : elle se
recrée en boucle. D'où le choix de **refuser** la localisation pour
les captures. Conséquence : l'écran Météo 7 jours est inaccessible en
émulateur, puisqu'il ne s'ouvre que si la météo a chargé.

⚠️ **`du` traverse les points de montage, et ça fait mentir une
mesure de disque.** `~/Library/Developer/CoreDevice/DeviceFS` est un
montage `devicefs` : `du -sh` y annonce **82 Go**, qui sont le
contenu des iPhone vus à travers lui ; le dossier réel pèse **4 Ko**.
J'ai proposé à Jean d'effacer ces 82 Go, ce qui n'aurait rien
libéré. **Mesurer avec `du -x`** — qui reste sur un système de
fichiers — et vérifier avec `mount` avant de parler d'un gros
dossier.

## 📐 L'iPad : les grilles prennent la largeur (03/11/2026)

**Ce qui a été regardé** : l'app, écran par écran, sur un **iPad Pro
13″** en simulateur. C'est la première fois — jusqu'ici seuls des tests
widget disaient qu'une boîte ne débordait pas, ce qui ne dit rien de
l'allure.

**Ce qu'on y voyait.** Les six cartes du tableau de bord faisaient
510 points de large pour 138 de haut — des bandes, là où le téléphone
montre des tuiles presque carrées. Le sous-titre de l'onboarding tenait
sur une seule ligne de 130 caractères. Dans l'onglet Conservation, le
signet d'une recette était à 1 400 points de son titre. Une feuille
modale occupait toute la largeur.

**Le premier correctif, et sa honte** : `ReadableWidth` existait
**depuis le 30/10/2026**, avec un commentaire qui décrivait exactement
ce problème — et il était branché sur **un** écran sur trente-trois.
Encore un widget écrit et non relié (règle 10, cinquième fois).

⚠️ **Et j'ai corrigé trop fort.** Tout borner à 720 laissait 150 points
vides de chaque côté, et à l'intérieur les tuiles des tutos — larges de
90 points dans une liste horizontale — n'en remplissaient pas la
moitié. Jean a regardé l'écran et dit ce qui s'y voyait : « ça ne prend
pas toute la place ». **La règle juste n'est pas « borner », c'est
« borner le texte »** :

| Contenu | Traitement | Pourquoi |
| --- | --- | --- |
| Grille de tuiles | prend toute la largeur | une tuile de plus par ligne, c'est une tuile de plus qu'on voit sans défiler |
| Colonne de texte | garde sa mesure | au-delà, l'œil perd le début de la ligne suivante |

**Ce qui prend la largeur** : le tableau de bord (trois colonnes au
lieu de deux, via `GrilleAdaptative`), l'Étal (huit colonnes de
vignettes), les tutos (quatre tuiles par ligne au lieu d'une liste qui
défile). **Ce qui reste borné** : Conservation (760 — trois lignes de
description par recette et un signet au bout), le cahier (900), les
écrans poussés, la diapositive du conseil du jour (620 — une phrase
n'a pas besoin de 908 points), et **toutes** les feuilles modales d'un
coup par `bottomSheetTheme.constraints` dans `app_theme.dart`.

⚠️ **`GrilleAdaptative` se règle par la largeur *souhaitée* d'une
tuile**, pas par un nombre de colonnes. Et la valeur se vérifie des
deux côtés : une cible de 200 donnait **une seule colonne** sur un
iPhone de 375 points — l'inverse du défaut qu'on corrigeait. C'est
160. Un test monte la grille à 343 et à 1 000 points et compte les
colonnes.

⚠️ **Et une tuile large ne se remplit pas en grandissant.** Sur un
téléphone, la carte du tableau de bord fait 165 × 138 et une icône
posée au-dessus d'un titre remplit la boîte. Sur un iPad elle fait
492 × 260, et la même disposition laisse **86 points de vide** au
milieu — mesurés à l'écran le 03/11/2026. Au-delà de 220 points de
large, la carte range donc son contenu **en ligne**
(`KawaiiCard.enLignePour`) : icône à gauche, titre et sous-titre à
droite.

⚠️ **Le remède n'était pas de raccourcir la carte.** Sa hauteur est
ce qui fait que six cartes remplissent l'écran : mesuré, trois
colonnes de 202 points laissent 594 points nus sous la grille, deux
colonnes de 260 n'en laissent que 206. C'est le contenu qui devait
occuper la surface, pas la surface se réduire au contenu.

⚠️ **Et le passage en ligne n'a pas suffi du premier coup** : sans
`Center`, le `Row` prend la hauteur de son plus grand enfant et le
`Stack` le colle en haut — les deux tiers bas de la carte restaient
nus. Vu à l'écran juste après avoir cru le problème réglé. Deux tests
de `ipad_landscape_test.dart` regardent maintenant **où les choses
sont dessinées** (l'icône est-elle à gauche du titre, et sur la même
ligne), pas ce qu'une fonction renvoie ; vérifiés en recassant
`enLignePour`.

⚠️ **Un diagnostic faux, corrigé par la mesure** : j'avais annoncé à
Jean que le carrousel du tableau de bord était « décalé » sur iPad,
une diapositive dépassant à gauche. C'est le comportement normal d'un
`PageView` à `viewportFraction: 0.88` **sur sa dernière page** : il ne
peut plus montrer de suivante, donc seul le bord de la précédente
reste visible. Identique sur iPhone. Rien à corriger.

⚠️ **Une tuile de hauteur fixe redevient une bande dès qu'elle
s'élargit.** `KawaiiCard.hauteurPour()` fait suivre la hauteur
(0,62 × largeur, entre 138 et 190) : à 325 de large sur iPad, la carte
fait 190 de haut et non 138.

⚠️ **En dessous de la borne, rien ne change.** Sur un téléphone,
l'affichage est identique au pixel près — un test le vérifie à 390
points, et les deux colonnes du tableau de bord sont retombées sur
leurs 165 points d'avant.

**Le splash suit aussi.** Le logo mesurait 256 points sur tous les
appareils : 65 % de la largeur d'un iPhone, 25 % de celle d'un iPad
13 pouces. `LaunchScreen.storyboard` lui donne maintenant 65 % de la
largeur, entre 256 et 384 points — 384 étant la taille à laquelle
l'image @3x de 768 px reste nette sur un écran @2x.
⚠️ **`flutter_native_splash` réécrit ce storyboard** s'il est relancé :
la contrainte est à reposer après coup.

**Ce qui reste, non bloquant** : le bas de l'écran est vide sur les
pages courtes.

## 📱 L'iPhone Duo : une encoche sur le côté (09/11/2026)

Premier pliable d'Apple, en vente depuis le 23/10/2026. **Les deux
tailles sont mesurées, pas déduites** : simulateur `iPhone Duo`
(iPhone19,4) créé sous iOS 27.2, app installée, et un point d'entrée
jetable a lu `MediaQuery` à l'écran.

| État | Points | Pixels | Pouces |
| --- | --- | --- | --- |
| Fermé, écran externe | **466 × 678** | 1398 × 2034 | 5,4″ |
| Ouvert, écran interne | **669 × 951** | 2007 × 2853 | 7,6″ |

Densité 3 pour les deux. Les pouces se recalculent à 460 ppi, celle
des iPhone : 1398 × 2034 donne 5,37″ de diagonale et 2007 × 2853 en
donne 7,58″. Les deux chiffres annoncés par Apple tombent, ce qui
confirme quelle dalle est laquelle.

⚠️ **Ce que l'écran fermé n'est pas : un petit écran.** À 466 points
il est plus **large** que tous les iPhone — 402 pour un 17, 440 pour
un 17 Pro Max. J'avais annoncé à Jean trois défauts probables avant de
mesurer ; **deux étaient faux**, et pour la même raison : j'avais
supposé un écran étroit.

| Annoncé | Mesuré |
| --- | --- |
| le tableau de bord retomberait à une colonne | **non** — il en garde deux, de 169 points, comme un iPhone 17 |
| le logo du splash serait démesuré | **non** — 65 % de 466 font 303, dans les bornes 256-384 posées pour l'iPad |
| la barre à cinq onglets serait tronquée | **oui, mais pas pour cette raison** — voir plus bas |

### Le seul vrai défaut, et il est neuf

`padding` vaut, écran fermé, **`top 0, bottom 34, left 0, right 84`**.
iOS dessine sa barre d'état **verticalement, sur le côté droit**.
Aucun appareil Apple n'avait eu de marge horizontale de cette taille,
et **aucun test du dépôt n'en posait** : ils montent tous un
`MediaQueryData` dont le `padding` est nul.

Or un `Scaffold` descend sa marge **basse** jusqu'à la barre
d'onglets, jamais les latérales. « Tutos » était donc peint à
**435 points** sur un bord sûr qui s'arrête à 382 — trouvé par le
test, et visible sur la capture.

`_sousEncoche()` (`root_tabs.dart`) range le **contenu** de la barre
et laisse le **fond pleine largeur** : une barre rétrécie laisserait
voir le fond de l'app dans les 84 points, ce qui se verrait bien plus
qu'un libellé décalé. Vérifié au pixel sur le simulateur — le fond est
uniforme d'un bord à l'autre.

⚠️ **Le correctif ne s'applique qu'en présence d'une encoche
latérale** : à marges nulles la fonction rend la barre telle quelle,
sans `ColoredBox` ni `Padding` de zéro. `iphone_duo_test.dart` le
vérifie **dans les deux sens** — sinon un correctif qui ne
s'appliquerait jamais passerait le test de non-régression.

### Ce qui n'a pas pu être vérifié

- **L'état ouvert sur l'appareil.** Le pliage se commande depuis
  `Simulator.app`, absent de ce Mac (alerte 9), et `simctl ui` n'a que
  `appearance`, `increase_contrast` et `content_size`. Flutter ne voit
  d'ailleurs qu'**un seul écran** à la fois (`displays.length == 1`).
  La taille ouverte est donc jouée en test, pas à l'écran, et sa marge
  n'est **pas** mesurée — le test joue la géométrie seule plutôt que
  d'inventer un chiffre.
- **Les autres écrans à l'écran.** Une alerte système de notification,
  restée sans réponse, bloque toute interaction : `simctl` ne sait pas
  la fermer, et l'outil de pilotage demande une autorisation que
  personne n'était là pour donner. Les cinq onglets sont quand même
  couverts par le test : `RootTabs` est un `IndexedStack`, qui
  **dispose** ses cinq pages même s'il n'en peint qu'une.

⚠️ **Le dépliage est un redimensionnement, pas un relancement** : la
même fenêtre passe de 466 × 678 à 669 × 951. Rien ne casse par
construction — aucun `initState` de `lib/` ne lit `MediaQuery`,
vérifié au peigne.

⚠️ **CocoaPods est tombé sur l'encodage du terminal** avant de pouvoir
construire quoi que ce soit : Ruby 4.0 refuse `unicode_normalize` sur
de l'ASCII-8BIT. Préfixer `LANG=en_US.UTF-8`. Et après une mise à jour
d'Xcode, un `pod install` périmé donne un
« `Flutter/Flutter.h` file not found » dans `VerifyModule` qui ne dit
pas son vrai nom : `flutter clean` + suppression du `DerivedData` du
projet + `pod install`.
