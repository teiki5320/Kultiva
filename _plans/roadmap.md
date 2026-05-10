# 🗺️ Kultiva — Roadmap

> Dernière mise à jour : **2026-05-09**
> Statut global : **en bêta TestFlight (build 51)**

## 🎯 Vision

Le potager kawaii dans la poche : un compagnon de jardinage francophone qui combine calendrier régional, créature évolutive, météo, défis communautaires et cahier de culture pleine terre, pour la France métropolitaine et l'Afrique de l'Ouest. Pensé pour les amateurs et pour faire jardiner les enfants.

## 🏁 Jalons

### ✅ Fait

- [x] Calendrier mensuel de semis et de récolte adapté à la région (France métropolitaine + Afrique de l'Ouest)
- [x] Catalogue de 120+ légumes, aromates, tubercules et accessoires avec fiches détaillées
- [x] Poussidex : collection chronologique des plants avec photos, notes, historique d'arrosage et compteur de récoltes
- [x] Tamassi : créature virtuelle animée qui évolue avec l'activité, avec XP, niveaux, émotions et visiteurs
- [x] Météo intégrée via Open-Meteo (sans clé d'API) avec alertes d'arrosage et fallback Paris si la géoloc est refusée
- [x] Feed communautaire de défis photo avec likes, badges, médailles bronze/argent/or
- [x] Connexion Supabase email + Google + Apple, et synchronisation cloud facultative des plantations, préférences, badges et XP
- [x] Cahier de culture pleine terre multi-jardins avec placement par glisser-déposer, suivi par plant (arrosage, phase de croissance auto, photos)
- [x] Étapes phénologiques auto-suggérées sur chaque plant, alertes canicule personnalisées et avertissement de rotation
- [x] Tutoriel de bienvenue parent-enfant et conseils contextuels selon la météo
- [x] CI iOS via Xcode Cloud + CI GitHub Actions (`flutter analyze` + `flutter test` sur chaque push), signing release Android et conformité Amazon Associates en place
- [x] Retrait complet de la feature hydroponie (sauvegardée sur la branche `archive/hydroponie-2026-05-03` pour réintégration future) + migration Supabase 008 prête
- [x] Harmonisation du bleu d'arrosage (`KultivaColors.waterBlue` partout) + design dashboard 6 cartes 3×2
- [x] Onglet « Actualités » → lien direct Instagram (au lieu d'un feed maison côté app)
- [x] Suppression de la dépendance morte `go_router` et nettoyage des imports
- [x] Tests pleine terre (`culture_entry`, `phenology`, `garden_plan`) — 988 LoC, 8 fichiers
- [x] Réactivation de l'Afrique de l'Ouest dans l'onboarding
- [x] Ménage tutos HTML (orphelin `reussir_semis.pdf` retiré)
- [x] Landing marketing en ligne et site Kultivaprix (comparateur de prix) lié depuis l'app
- [x] README réécrit pour refléter la v2 réelle (Supabase, Poussidex, Tamassi, météo, feed, cahier de culture, parent-enfant)
- [x] Sync unidirectionnelle du catalogue Kultiva vers Kultivaprix via edge function Supabase et workflow GitHub Actions sur push main
- [x] Gros ménage de lint : 308 substitutions `withOpacity` → `withValues` sur 38 fichiers
- [x] Repo `dash` (admin web) branché sur Supabase pour publier les actualités sans toucher au dashboard SQL
- [x] **🚀 Premier build TestFlight (1.0.0+51) en bêta interne — 9 mai 2026**

### 🔥 En cours

- [ ] Validation sur device de la V1 sur TestFlight (recueil de feedback testeurs internes + correction des bugs visibles)
- [ ] Refonte du tutoriel HTML « Découvrir le dashboard » pour intégrer les nouveaux écrans (Mes jardins, Cahier de culture pleine largeur, axe parent-enfant)

### 📋 À faire avant publication App Store / Play

- [ ] Captures stores — Apple : 6.7" + 6.5" + 5.5", Google : ≥ 2 captures + 1 feature graphic
- [ ] Politique de confidentialité hébergée + lien dans App Store Connect / Play Console
- [ ] Métadonnées de listing (description, mots-clés, catégorie, support URL, marketing URL, age rating)
- [ ] Compte Instagram Kultiva créé + URL définitive remplacée dans `_kInstagramUrl` (`lib/screens/home/sow_screen.dart:31`)
- [ ] Migration Supabase `008_drop_hydro_tables.sql` appliquée en production
- [ ] Optimisation taille du bundle (260 Mo actuels) — compresser les PNG kawaii en WebP
- [ ] Soumission App Store + Google Play

### 📋 À faire après publication

- [ ] Étendre la couverture de tests vers les widgets et un parcours d'intégration
- [ ] Déplacer la modération du feed et le comptage de likes côté serveur via des edge functions Supabase
- [ ] Transmettre `docs/kultivaprix-handoff.md` à l'équipe Kultivaprix pour brancher la consommation du catalogue

### 💡 Idées

- [ ] **À discuter** : reconnaissance de plante par photo (style PlantNet / Picture This), avec écran de scan caméra et conseils photo (cadrage, netteté, mono-espèce). Captures d'inspiration vues 2026-04-27.
- [ ] Internationalisation avec extraction des strings et ajout de l'anglais
- [ ] Mode hors ligne complet avec assets météo et tutoriels téléchargeables
- [ ] Réintroduire l'hydroponie en mode simplifié (le code complet est conservé sur `archive/hydroponie-2026-05-03`)
- [ ] Comparatif inter-saisons avec stats partageables
- [ ] Marketplace de semences paysannes au-delà du programme Amazon Associates
- [ ] Groupes privés famille ou voisins avec défis locaux et classements géographiques
- [ ] Mode « parent-enfant » avec profils enfants, défis adaptés et badges spéciaux
- [ ] Apple Watch companion (consultation rapide météo + arrosage du jour)
