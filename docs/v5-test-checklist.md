# ✅ Checklist de validation pré-publication

> À faire sur device avant de pousser un build sur TestFlight / Play Internal Track. Coche au fur et à mesure.

## 🌐 Préparation

- [ ] App lancée en mode release (`flutter run --release`) sur iPhone connecté
- [ ] Localisation autorisée (ou tester explicitement le fallback Paris)
- [ ] Au moins un jardin pleine terre créé avec quelques plants placés

## 🌻 Onglet Mes jardins (cahier de culture pleine terre)

### Création de jardin
- [ ] Bouton « + Nouveau jardin » → la sheet de configuration s'ouvre
- [ ] Saisie nom + dimensions cm/pieds + localisation
- [ ] Le jardin apparaît dans la liste après création

### Placement des plants
- [ ] Choix d'une plante dans le picker en bas (filtres saison, catégorie, favoris)
- [ ] Drag & drop sur une case → emoji + nombre s'affichent
- [ ] Tap sur une case occupée → la fiche détaillée s'ouvre
- [ ] La fiche affiche : nom, image, phase de croissance déduite, conseils, historique d'arrosage

### Date de plantation modifiable
- [ ] Tap sur la date dans la fiche → date picker FR
- [ ] Changer la date à -50j → la phase recalcule (croissance / floraison selon catégorie)

### Arrosage par plant + bandeau
- [ ] Bouton « Arroser » bleu eau dans la fiche → snackbar de confirmation
- [ ] Bandeau météo+arrosage en haut du jardin → bouton « Arroser tout » fonctionne
- [ ] Cas pluie prévue : conseil bleu « Pas besoin d'arroser »
- [ ] Cas sécheresse : conseil orange « Pas d'arrosage depuis Xj »
- [ ] Cas canicule (Tmax >= 30°C) : conseil rouge « Arrose tôt le matin »

### Étapes phénologiques
- [ ] Sur un plant jeune : « Germination attendue »
- [ ] Sur un plant avancé (date à -50j) : « Croissance végétative » ou « Floraison/Fructification »
- [ ] Cohérent : fruits → « Floraison/nouaison », racines → « Grossissement », etc.

### Compagnonnage
- [ ] Placement de 2 plants compagnes voisines → ring vert sur les cases
- [ ] Placement de 2 plants ennemis → ring rouge

### Rotation
- [ ] Replanter une tomate là où il y en avait il y a moins de 3 ans → bandeau orange « Rotation : attention »
- [ ] Replanter une autre Solanacée (aubergine) après tomate → même alerte (famille)

### Récap saison PDF
> Le bouton n'a été branché que le 31/10/2026 : `printSeasonRecap`
> existait depuis six mois sans être appelée nulle part.

- [ ] CTA « Récap de la saison 2026 » en bas du cahier de culture
      (visible dès qu'une culture a démarré cette année, absent sinon)
- [ ] Tap → ouverture du viewer PDF natif
- [ ] PDF contient stats cultures, arrosages, top légumes, détail chronologique
- [ ] Export possible (partager, imprimer, sauvegarder)

## 🪴 Poussidex

> Tamassi, la créature virtuelle, a été supprimée le 31/10/2026 avec
> ses trois starters, son XP et ses visiteurs. Les 50 badges ont été
> réécrits sur ce qu'on fait au jardin.

- [ ] Fiche légume → bouton « Je l'ai planté » → le plant apparaît
      dans 🪴 Mes plants
- [ ] Photo d'un plant → elle s'affiche dans son dossier
- [ ] Arroser, récolter, clore un plant → chaque geste laisse une trace
      datée dans l'historique
- [ ] Les badges se débloquent sur des gestes de jardin (premier plant,
      trois jours d'arrosage d'affilée, jardin complet)
- [ ] Aucune mention de créature, de starter ni de niveau nulle part
- [ ] Alertes canicule push reçues si météo annonce 30°C+ sur 2j
      d'affilée (40°C en Afrique de l'Ouest)

## 📔 Cahier de culture

- [ ] L'onglet s'ouvre sur le bandeau de saison, pas sur une AppBar grise
- [ ] « À faire aujourd'hui » : arrosages dus, récoltes mûres, canicule
- [ ] Bouton « Arroser » → tous les plants concernés sont notés arrosés
- [ ] Chaque carte de jardin montre l'aperçu de **sa** grille
- [ ] « Au jardin en ce moment » liste les plants des jardins **et**
      ceux ajoutés depuis une fiche légume
- [ ] Tap sur un plant → son dossier (le même que depuis le Poussidex)

## 📅 Calendrier + 🛒 Étal

- [ ] Calendrier mensuel adapté à la région choisie
- [ ] Calendrier annuel : les douze mois tiennent dans la largeur, aucun
      défilement latéral, une ligne par légume
- [ ] Tap sur une initiale de mois → filtre ; tap sur une ligne → fiche
- [ ] Aucun bouton « Acheter » ni mention « Lien partenaire » sur la fiche légume (liens Amazon retirés le 20/10/2026)

## 🔄 Cross-fonctionnalités

### Rétro-compatibilité
- [ ] Une culture créée avant la suppression de l'hydroponie (entrée JSON `method='hydroponic'`) → ignorée silencieusement, pas de crash
- [ ] Une culture pleine terre existante s'ouvre sans crash
- [ ] Phase par défaut = « Semis / plantule »

### Mode offline
> L'app n'a ni compte ni serveur depuis le 30/10/2026 : **tout** doit
> fonctionner hors ligne, sauf la météo. Ce n'est plus un cas limite,
> c'est le fonctionnement normal.

- [ ] Couper le wifi + données mobiles
- [ ] Killer + relancer l'app
- [ ] Mes jardins, plantations, photos lisibles
- [ ] Création d'un nouveau jardin, ajout d'un plant, marquage arrosé → fonctionnent
- [ ] Ajout d'un plant depuis une fiche légume (« Je l'ai planté »), arrosage, récolte → fonctionnent
- [ ] Météo : message clair ou dernières valeurs en cache, pas de crash
- [ ] Aucun écran de connexion, aucune mention de compte nulle part

## 🐛 Bugs à signaler si rencontrés

Format à utiliser pour chaque bug :

> **Écran** : ...
> **Repro** : 1. ... 2. ... 3. ...
> **Attendu** : ...
> **Constaté** : ...
> **Device** : iPhone X / iOS Y / build N

## ✅ Validation finale

Quand toutes les cases ci-dessus sont cochées (sauf bugs documentés à corriger plus tard) :

- [ ] Bumper le build number dans `pubspec.yaml`
- [ ] Push sur `main` (déclenche Xcode Cloud → TestFlight)
- [ ] Build Android `flutter build appbundle --release` puis upload Play Console
- [ ] Mettre à jour la roadmap (`_plans/roadmap.md`)
