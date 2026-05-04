# ✅ Checklist de validation pré-publication

> À faire sur device avant de pousser un build sur TestFlight / Play Internal Track. Coche au fur et à mesure.

## 🌐 Préparation

- [ ] App lancée en mode release (`flutter run --release`) sur iPhone connecté
- [ ] Compte Supabase connecté (email ou Google ou Apple) pour tester la sync et le feed
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
- [ ] CTA « Récap saison 2026 » accessible (visible si au moins une culture terminée)
- [ ] Tap → ouverture du viewer PDF natif
- [ ] PDF contient stats cultures, arrosages, top légumes, détail chronologique
- [ ] Export possible (partager, imprimer, sauvegarder)

## 🐣 Poussidex + Tamassi

- [ ] Onboarding du Poussidex propose les 3 starters
- [ ] Photo d'un plant → entrée créée
- [ ] Tamassi gagne de l'XP au fil des actions
- [ ] Alertes canicule push reçues si météo annonce 30°C+ sur 2j d'affilée

## 📅 Calendrier + 🛒 Étal

- [ ] Calendrier mensuel adapté à la région choisie
- [ ] Lien « Acheter » (Amazon Associates) fonctionnel sur la fiche légume
- [ ] Mention « Lien partenaire » bien visible

## 🔄 Cross-fonctionnalités

### Rétro-compatibilité
- [ ] Une culture créée avant la suppression de l'hydroponie (entrée JSON `method='hydroponic'`) → ignorée silencieusement, pas de crash
- [ ] Une culture pleine terre existante s'ouvre sans crash
- [ ] Phase par défaut = « Semis / plantule »

### Mode offline
- [ ] Couper le wifi + données mobiles
- [ ] Killer + relancer l'app
- [ ] Mes jardins, plantations, photos lisibles
- [ ] Création d'un nouveau jardin, ajout d'un plant, marquage arrosé → fonctionnent
- [ ] Pas de crash sur météo / feed / Tamassi visiteurs (juste loading vide ou message clair)
- [ ] Réactiver le réseau → la sync cloud reprend en arrière-plan

### Sync Supabase
- [ ] Plantations Poussidex syncées entre devices
- [ ] Likes feed comptés correctement (côté serveur via trigger)
- [ ] Photos uploadées dans le bucket `plant-photos`

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
