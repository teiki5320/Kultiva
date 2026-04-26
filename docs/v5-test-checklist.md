# ✅ Checklist de validation V5 — Cahier de culture

> À faire sur device après la sortie de la V5 du cahier de culture (10 batchs, branche `claude/init-project-docs-hzSyH` à merger sur `main`). Coche au fur et à mesure.

## 🌐 Préparation

- [ ] App lancée en mode release (`flutter run --release`) sur iPhone connecté
- [ ] Compte Supabase connecté (email ou Google ou Apple) pour tester la sync et le partage de builds
- [ ] Localisation autorisée (ou tester explicitement le fallback Paris)
- [ ] Une culture pleine terre déjà démarrée et une culture hydroponique déjà démarrée pour gagner du temps sur les premiers tests

## 💧 Onglet Hydroponie

### Démarrage de culture
- [ ] Bouton "Démarrer une culture" → la sheet s'ouvre
- [ ] Choix d'un légume (ex. tomate)
- [ ] Sélection du type de lumière (naturelle / LED / mixte)
- [ ] Saisie heures/jour, watts, distance LED, température couleur
- [ ] La culture apparaît dans la liste après création

### Mesures pH/EC/température/niveau
- [ ] Tap sur la chip 🧪 pH → la sheet s'ouvre
- [ ] Saisie d'une valeur dans la zone idéale (ex. 6.0) → indicateur **vert**
- [ ] Saisie d'une valeur en bordure (ex. 5.4) → indicateur **orange**
- [ ] Saisie d'une valeur critique (ex. 4.5) → indicateur **rouge**
- [ ] Idem ⚡ EC, 🌡️ température eau, 💧 niveau réservoir
- [ ] Après plusieurs mesures (>= 2), une **sparkline 14 jours** apparaît sous chaque valeur
- [ ] Couleur des chips correspond bien au statut de la dernière valeur

### Phase de croissance + DLI
- [ ] Tap sur la chip "Phase : ..." → sheet de sélection (semis, végétative, floraison, fructification)
- [ ] Changement de phase → les **fourchettes pH/EC se mettent à jour** (vérifier avec une mesure)
- [ ] Si la culture a une config LED complète : chip **DLI** affiché, couleur selon la cible
- [ ] Distance LED actuelle vs reco affichée (ex. "40 cm (reco. 45)")

### Calculateur nutriments
- [ ] Long press / menu → "🧪 Calculer nutriments"
- [ ] Saisie du volume (ex. 20L)
- [ ] Toggle 3 parts / 2 parts → la dose C apparaît/disparaît
- [ ] Toggle Cal-Mag → la ligne apparaît/disparaît
- [ ] Changement de phase via la chip → recalcul cohérent
- [ ] Note pédagogique cohérente avec la phase (cul noir en fructification, etc.)

### Rinçage du réservoir
- [ ] Menu "🪣 Marquer rinçage du réservoir" → snackbar de confirmation
- [ ] Subtitle "Dernier : il y a Xj" mis à jour
- [ ] Pour tester l'alerte : changer la date système iPhone à +15j, rouvrir l'app
- [ ] Bandeau orange "Réservoir à rincer (dernier il y a 15j)" visible sur la card
- [ ] Bouton "Fait" du bandeau → l'alerte disparaît

### Tip algues
- [ ] Menu "🦠 Conseils anti-algues" → sheet avec 5 réflexes
- [ ] Lecture cohérente, pas de typo

### Partage de build hydro
- [ ] CTA "Builds de la communauté" en bas de l'onglet → ouvre la liste
- [ ] FAB "Partager mon build" → formulaire complet
- [ ] Sélection système (DWC, NFT, etc.), légume cultivé optionnel
- [ ] Ajout d'équipement à la liste (Pompe air, LED, etc.) avec suppression possible
- [ ] Choix d'une photo depuis la galerie
- [ ] Saisie d'une description
- [ ] Publication → retour à la liste, build visible
- [ ] Tap sur ❤️ → like incrémenté, action persistée
- [ ] Filtre par type de système (chips en haut) fonctionnel
- [ ] Pull-to-refresh OK

## 🌻 Onglet Pleine terre

### Démarrage + rotation
- [ ] Démarrer une culture (ex. tomate sur la parcelle X)
- [ ] Démarrer une 2e culture du même légume (ex. autre tomate) → **bandeau orange "Rotation : attention"** doit apparaître dans la sheet de démarrage
- [ ] Démarrer une autre Solanacée (aubergine ou poivron) après tomate → même alerte rotation (famille)

### Étapes phénologiques
- [ ] Sur une culture jeune (<= 7 jours) : chip "Étape : Germination attendue"
- [ ] Tap sur la chip → sheet avec emoji + détail
- [ ] Sur une culture plus avancée (semis bidons : changer la date de démarrage à -50j) : étape "Croissance végétative" ou "Floraison/Fructification" selon la catégorie
- [ ] Cohérent : pour une fruits → "Floraison/nouaison", pour une racine → "Grossissement", etc.

### Arrosage
- [ ] Menu "💧 Marquer arrosé aujourd'hui" → snackbar de confirmation
- [ ] **Mini-barres 14 jours** sous la card mises à jour (barre haute aujourd'hui)
- [ ] Texte "Arrosé aujourd'hui" / "Il y a Xj" actualisé
- [ ] Au bout de 5 jours sans arrosage : passage en orange du badge "Il y a Xj"

### Suggestion arrosage adaptative (Open-Meteo)
- [ ] Bandeau de conseil sous la card visible si la météo est chargée
- [ ] Cas pluie prévue : bandeau bleu "Pas besoin d'arroser"
- [ ] Cas sécheresse : bandeau orange "Pas d'arrosage depuis Xj..."
- [ ] Cas canicule (Tmax >= 30°C) : bandeau rouge avec "Arrose tôt le matin..."

### Alerte canicule push
- [ ] Si la prévision météo annonce 30°C+ sur 2j d'affilée dans les 4 prochains jours :
  - [ ] Notification iOS reçue avec emoji 🥵 et conseil légume-spécifique
  - [ ] Conseil cohérent avec la catégorie majoritaire des cultures actives (tomates → paillage, salades → ombrage, etc.)
- [ ] Pas reçue plus d'une fois par 7 jours (throttle)

### Récap saison PDF
- [ ] CTA "Récap saison 2026" en bas de l'onglet (visible si au moins une culture terminée)
- [ ] Tap → ouverture du viewer PDF natif
- [ ] PDF contient : 3 stat-cards (cultures, arrosages, durée moy.), top 5 légumes, répartition par famille, détail chronologique des cultures
- [ ] Export possible (partager, imprimer, sauvegarder)

## 🔄 Cross-fonctionnalités

### Rétro-compatibilité
- [ ] Une culture créée avant V5 (sans phase, sans wateredAt) s'ouvre sans crash
- [ ] Phase par défaut = "Semis / plantule"
- [ ] Pas d'arrosages historiques perdus

### Mode offline
- [ ] Couper le wifi + données mobiles
- [ ] Killer + relancer l'app
- [ ] Le cahier (cultures, mesures, builds en cache) doit être lisible
- [ ] Démarrage d'une nouvelle culture, ajout d'une mesure, marquage d'arrosage → fonctionnent
- [ ] Pas de crash sur les écrans météo / feed / partage de builds (juste loading vide ou message clair)
- [ ] Réactiver le réseau → la sync cloud des plantations (Poussidex) reprend en arrière-plan

### Sync Supabase
- [ ] Une mesure ajoutée sur device A apparaît-elle sur device B après login ? (Note : V5 ne sync pas encore les `culture_readings` cloud — c'est attendu, à valider que c'est bien local-only)
- [ ] Un build hydro publié apparaît sur le feed Builds de la communauté (même utilisateur, autre device)

## 🐛 Bugs à signaler si rencontrés

Format à utiliser pour chaque bug :

> **Écran** : ...
> **Repro** : 1. ... 2. ... 3. ...
> **Attendu** : ...
> **Constaté** : ...
> **Device** : iPhone X / iOS Y / build N

Documenter les bugs dans `_plans/v5-bugs.md` (à créer si nécessaire), un par section.

## ✅ Validation finale

Quand toutes les cases ci-dessus sont cochées (sauf bugs documentés à corriger plus tard) :

- [ ] Merger `claude/init-project-docs-hzSyH` sur `main`
- [ ] Bumper le build number dans `pubspec.yaml`
- [ ] Push (déclenche Xcode Cloud → TestFlight)
- [ ] Mettre à jour la roadmap (`_plans/roadmap.md`) : déplacer "Validation V5" de "En cours" à "Fait"
