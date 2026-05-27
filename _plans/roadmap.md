# 🗺️ Kultiva — Roadmap

> Dernière mise à jour : **2026-05-27**
> Statut global : **prête à publier (v1.0.0+5)**

## 🎯 Vision

Le potager kawaii dans la poche : un compagnon de jardinage francophone qui combine calendrier régional, créature évolutive, météo, défis communautaires et cahier de culture pleine terre, pour la France métropolitaine et l'Afrique de l'Ouest. Pensé pour les amateurs et pour faire jardiner les enfants.

## 🚀 IL NE RESTE QUE 3 CHOSES À FAIRE

1. **Soumettre sur App Store et Google Play** — listing, captures d'écran, descriptions, politique de confidentialité (privacy policy HTML déjà dans l'app)
2. **Remplacer les `href="#"` dans `landing/index.html`** — par les vrais liens stores une fois les fiches publiées
3. **Transmettre `docs/kultivaprix-handoff.md`** à l'équipe Kultivaprix pour brancher la consommation du catalogue

Tout le reste est terminé.

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
- [x] CI GitHub Actions en place (`ci.yml` : `flutter analyze` + `flutter test` sur push main et PR)
- [x] Retrait complet de la feature hydroponie (sauvegardée sur `archive/hydroponie-2026-05-03`)
- [x] Landing marketing en ligne et site Kultivaprix lié depuis l'app
- [x] Sync unidirectionnelle du catalogue Kultiva vers Kultivaprix via edge function Supabase et workflow GitHub Actions
- [x] Documentation de passation pour Kultivaprix (schéma, RLS, exemples curl/JS) et checklist de test V5
- [x] Branche V5 mergée sur `main`, première synchro catalogue déclenchée
- [x] Gros ménage de lint : 308 substitutions `withOpacity` → `withValues`, zéro API dépréciée restante
- [x] Audit pré-publication mai 2026 : extraction 6 modèles, Sentry, in_app_review, splash natif, privacy policy RGPD, migrations 009-011, ~600 lignes de code mort supprimées, 10 deprecated APIs corrigés, 38 images accessoires kawaii, version 1.0.0+5
- [x] Découpe des fichiers volumineux : `tamassi_view.dart` (1 740 → 1 205 + 544) et `garden_planner_screen.dart` (1 778 → 503 + 1 298)
- [x] Modération du feed : likes côté serveur (trigger PostgreSQL), signalements câblés côté client (migration 010 + FeedService.reportPost + UI "Signaler" + auto-hide à 3 signalements)

### 📋 Nice-to-have (post-publication)

- [ ] Étendre la couverture de tests vers les widgets, les services et un parcours d'intégration (actuellement : 129 tests sur modèles + `watering_advisor` uniquement)

### 💡 Idées futures

- [ ] **À discuter** : reconnaissance de plante par photo (style PlantNet / Picture This), avec écran de scan caméra et conseils photo
- [ ] Internationalisation avec extraction des strings et ajout de l'anglais
- [ ] Mode hors ligne complet avec assets météo et tutoriels téléchargeables
- [ ] Réintroduire l'hydroponie en mode simplifié (code archivé sur `archive/hydroponie-2026-05-03`)
- [ ] Comparatif inter-saisons avec stats partageables
- [ ] Marketplace de semences paysannes au-delà du programme Amazon Associates
- [ ] Groupes privés famille ou voisins avec défis locaux et classements géographiques
- [ ] Mode « parent-enfant » avec profils enfants, défis adaptés et badges spéciaux
