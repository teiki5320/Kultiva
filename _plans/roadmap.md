# 🗺️ Kultiva — Roadmap

> Dernière mise à jour : **2026-04-26**
> Statut global : **actif**

## 🎯 Vision

Le potager kawaii dans la poche : un compagnon de jardinage francophone qui combine calendrier régional, créature évolutive, météo, défis communautaires et cahier de culture sérieux (pleine terre et hydroponie), pour la France métropolitaine et l'Afrique de l'Ouest.

## 🏁 Jalons

### ✅ Fait

- [x] Calendrier mensuel de semis et de récolte adapté à la région (France métropolitaine + Afrique de l'Ouest)
- [x] Catalogue d'une centaine de légumes, aromates, tubercules et accessoires avec fiches détaillées
- [x] Poussidex : collection chronologique des plants avec photos, notes, historique d'arrosage et compteur de récoltes
- [x] Tamassi : créature virtuelle animée qui évolue avec l'activité, avec XP, niveaux, émotions et visiteurs
- [x] Météo intégrée via Open-Meteo (sans clé d'API) avec alertes d'arrosage et fallback Paris si la géoloc est refusée
- [x] Feed communautaire de défis photo avec likes, badges, médailles bronze/argent/or
- [x] Connexion Supabase email + Google + Apple, et synchronisation cloud facultative des plantations, préférences, badges et XP
- [x] Cahier de culture pleine terre et hydroponie avec suivi pH, EC, température, niveau réservoir, phases de croissance et calculateur de nutriments
- [x] Étapes phénologiques auto-suggérées sur la pleine terre, alertes canicule personnalisées et avertissement de rotation
- [x] Partage de builds hydroponiques dans la communauté avec photos, équipement et likes
- [x] CI iOS via Xcode Cloud, signing release Android et conformité Amazon Associates en place
- [x] Landing marketing en ligne et site Kultivaprix (comparateur de prix) lié depuis l'app
- [x] README réécrit pour refléter la v2 réelle (Supabase, Poussidex, Tamassi, météo, feed, cahier de culture)
- [x] Sync unidirectionnelle du catalogue Kultiva vers Kultivaprix via edge function Supabase et workflow GitHub Actions sur push main
- [x] Gros ménage de lint : 308 substitutions `withOpacity` → `withValues` sur 38 fichiers, plus de 90 % des avertissements résorbés
- [x] Documentation de passation pour Kultivaprix (schéma, RLS, exemples curl/JS) et checklist de test V5 sur device

### 🔥 En cours

- [ ] Validation sur device de la V5 du cahier de culture (10 batchs poussés sur `claude/init-project-docs-hzSyH`, à dérouler avec `docs/v5-test-checklist.md`)
- [ ] Merge de la branche V5 sur `main` pour déclencher la première synchro automatique du catalogue vers Kultivaprix

### 📋 À faire

- [ ] Soumettre l'app sur App Store et Google Play (listing, captures, descriptions, politique de confidentialité)
- [ ] Mettre en place une CI GitHub Actions qui lance `flutter analyze` et `flutter test` à chaque pull request
- [ ] Étendre la couverture de tests, aujourd'hui limitée aux modèles, vers les widgets et un parcours d'intégration
- [ ] Finir les ~40 avertissements de lint restants (Radio/Switch dépréciés, commentaires HTML)
- [ ] Décider du sort de `go_router` : l'activer pour de bon ou le retirer du `pubspec`
- [ ] Déplacer la modération du feed et le comptage de likes côté serveur via des edge functions Supabase
- [ ] Transmettre `docs/kultivaprix-handoff.md` à l'équipe Kultivaprix pour brancher la consommation du catalogue

### 💡 Idées

- [ ] Internationalisation avec extraction des strings et ajout de l'anglais
- [ ] Mode hors ligne complet avec assets météo et tutoriels téléchargeables
- [ ] Intégration de capteurs Bluetooth pour automatiser les mesures hydroponiques (pH, EC, température)
- [ ] Comparatif inter-saisons et entre méthodes (pleine terre vs hydroponie) avec stats partageables
- [ ] Marketplace de semences paysannes au-delà du programme Amazon Associates
- [ ] Groupes privés famille ou voisins avec défis locaux et classements géographiques
