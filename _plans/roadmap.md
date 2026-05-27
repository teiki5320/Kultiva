# 🗺️ Kultiva — Roadmap

> Dernière mise à jour : **2026-05-27**
> Statut global : **pré-publication (v1.0.0+5)**

## 🎯 Vision

Le potager kawaii dans la poche : un compagnon de jardinage francophone qui combine calendrier régional, créature évolutive, météo, défis communautaires et cahier de culture pleine terre, pour la France métropolitaine et l'Afrique de l'Ouest. Pensé pour les amateurs et pour faire jardiner les enfants.

## 🏁 Jalons

### ✅ Fait

- [x] Calendrier mensuel de semis et de récolte adapté à la région (France métropolitaine + Afrique de l'Ouest)
- [x] Catalogue de 158 légumes, aromates, tubercules et accessoires avec fiches détaillées
- [x] Poussidex : collection chronologique des plants avec photos, notes, historique d'arrosage et compteur de récoltes
- [x] Tamassi : créature virtuelle animée qui évolue avec l'activité, avec XP, niveaux, émotions et visiteurs
- [x] Météo intégrée via Open-Meteo (sans clé d'API) avec alertes d'arrosage, canicule et fallback Paris
- [x] Feed communautaire de défis photo avec likes, badges, médailles bronze/argent/or
- [x] Connexion Supabase email + Google + Apple, et synchronisation cloud facultative des plantations, préférences, badges et XP
- [x] Cahier de culture pleine terre multi-jardins avec placement par glisser-déposer, suivi par plant (arrosage, phase de croissance auto, photos)
- [x] Étapes phénologiques auto-suggérées sur chaque plant, alertes canicule personnalisées et avertissement de rotation
- [x] Tutoriel de bienvenue parent-enfant et conseils contextuels selon la météo
- [x] CI iOS via Xcode Cloud, signing release Android et conformité Amazon Associates en place
- [x] Retrait complet de la feature hydroponie (sauvegardée sur la branche `archive/hydroponie-2026-05-03`)
- [x] Landing marketing en ligne et site Kultivaprix (comparateur de prix) lié depuis l'app
- [x] README réécrit pour refléter la v2 réelle (Supabase, Poussidex, Tamassi, météo, feed, cahier de culture)
- [x] Sync unidirectionnelle du catalogue Kultiva vers Kultivaprix via edge function Supabase et workflow GitHub Actions
- [x] Gros ménage de lint : 308 substitutions `withOpacity` → `withValues` sur 38 fichiers, >90 % des avertissements résorbés
- [x] Documentation de passation pour Kultivaprix (schéma, RLS, exemples curl/JS) et checklist de test V5
- [x] CI GitHub Actions en place (`ci.yml` : `flutter analyze` + `flutter test` sur push main et PR)
- [x] Branche V5 mergée sur `main`, première synchro catalogue déclenchée
- [x] Audit pré-publication mai 2026 : extraction 6 modèles, Sentry, in_app_review, splash natif, privacy policy RGPD, migrations 009-011, 3 nouveaux tests, ~600 lignes de code mort supprimées, 10 deprecated APIs corrigés, découpe `my_garden_screen.dart`, 54 légumes `harvestTimeBySeason` complétés, 38 images accessoires kawaii, lien Instagram, version 1.0.0+5

### 📋 À faire — Publication

- [ ] Soumettre l'app sur App Store et Google Play (listing, captures, descriptions, politique de confidentialité)
- [ ] Remplacer les liens `href="#"` dans `landing/index.html` par les vrais liens App Store / Play Store

### 📋 À faire — Qualité / dette technique

- [ ] Étendre la couverture de tests vers les widgets, les services et un parcours d'intégration (actuellement : 129 tests sur modèles + `watering_advisor` uniquement)
- [x] ~~Finir les ~40 avertissements de lint restants~~ — audit mai 2026 : zéro API dépréciée restante
- [x] Découper `tamassi_view.dart` (1 740 → 1 205 + 544) et `garden_planner_screen.dart` (1 778 → 503 + 1 298)

### 📋 À faire — Backend

- [ ] Déplacer la modération du feed et le comptage de likes côté serveur via des edge functions Supabase

### 📋 À faire — Coordination

- [ ] Transmettre `docs/kultivaprix-handoff.md` à l'équipe Kultivaprix pour brancher la consommation du catalogue

### 💡 Idées futures

- [ ] **À discuter** : reconnaissance de plante par photo (style PlantNet / Picture This), avec écran de scan caméra et conseils photo
- [ ] Internationalisation avec extraction des strings et ajout de l'anglais
- [ ] Mode hors ligne complet avec assets météo et tutoriels téléchargeables
- [ ] Réintroduire l'hydroponie en mode simplifié (code archivé sur `archive/hydroponie-2026-05-03`)
- [ ] Comparatif inter-saisons avec stats partageables
- [ ] Marketplace de semences paysannes au-delà du programme Amazon Associates
- [ ] Groupes privés famille ou voisins avec défis locaux et classements géographiques
- [ ] Mode « parent-enfant » avec profils enfants, défis adaptés et badges spéciaux
