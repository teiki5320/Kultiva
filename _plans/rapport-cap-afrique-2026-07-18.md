# 🌍 Rapport d'implémentation « Cap Afrique de l'Ouest » — 18 juillet 2026

> Branche : `claude/loving-noether-7Vw5y` — 4 commits (`ca5b6d4` fix CI,
> `154c864` et précédents). **148/148 tests, `flutter analyze` 0 erreur.**

## Ce qui a été fait

### 1. Pays & détection
- Modèle `Country` : 🇫🇷 France + 🇸🇳🇨🇮🇲🇱🇧🇫🇧🇯🇹🇬🇳🇪🇬🇳 (8 pays francophones
  d'AO), chacun avec zone climatique (sahélienne/soudanienne/guinéenne),
  drapeau et capitale.
- Onboarding « Où jardines-tu ? » : bouton **Détecter mon pays** (géocodage
  inverse du code ISO, boîte englobante AO en secours) + liste des pays.
  Même sélecteur dans les Réglages. Pays synchronisé dans le cloud.
- Fallback météo = capitale du pays (Dakar, Abidjan, Bamako…) au lieu de
  Paris codé en dur.
- Manifest Android réparé : permissions localisation + POST_NOTIFICATIONS +
  receivers `flutter_local_notifications` (géoloc et notifs étaient mortes).

### 2. Saisons tropicales
- `Season` régionalisé : 🌬️ Harmattan (nov-fév) / ☀️ Saison sèche (mars-mai) /
  🌧️ Hivernage (juin-oct) — appliqué au dashboard, aux 2 calendriers, à la
  météo, au fond kawaii (plus de neige), avec gradients ocre/vert.
- Planner : filtres Saison sèche / Hivernage + picker branché sur le
  calendrier régional (était codé sur la France).
- Médaille or « 2 saisons » : saisons de la région (sèche/pluies en AO).
- Défis : 5 variantes AO à ids constants (Givre→Harmattan, Halloween→Panier
  de gombo, Saison morte→Cœur de saison sèche, 14 juillet→Premières pluies,
  Trèfle→Pousse surprise). Badges de complétion intacts.

### 3. Météo & arrosage
- Seuil canicule par région : 30 °C France / **40 °C AO** (fini l'alerte
  quotidienne à Bamako).
- Nouvelle notification **« Premières pluies »** : ≥7 jours secs + ≥10 mm
  prévus sous 3 jours → signal de semis de l'hivernage (throttle 30 j).

### 4. Contenu
- Calendrier AO : **59 → 130 entrées** (120 cultures existantes couvertes,
  dont 14 « non adaptées » avec alternatives locales, + 10 nouvelles).
- **10 cultures ouest-africaines** : mil, fonio, moringa, aubergine africaine,
  corète, célosie, baselle, citronnelle, papayer, bananier plantain — fiches,
  compagnonnage, rotation, maladies, calendrier.
- Accessoire **ombrière** (filet d'ombrage 30-50 %).
- Maladies tropicales : TYLCV + aleurode (tomate), chenille légionnaire +
  striga (maïs/sorgho), maruca (niébé)…
- Lexique : 12 termes (harmattan, hivernage, zaï, demi-lune, billon…).
- **4 tutos « Climat tropical »** : saison sèche, hivernage, ombrière, igname.
- Liens Amazon + accessoires anti-froid masqués hors France.

### 5. Poids & data
- **Assets : 245 → 33 Mo** (badges 94→9, créatures 35→4, accessoires 27→4,
  légumes 21→3, captures tuto 39→1,3).
- Nunito bundlée (plus de téléchargement de police au 1er lancement),
  tutos HTML 100 % hors-ligne (CDN supprimés, GSAP inliné), Sentry 5 %.

### 6. Corrections critiques au passage
- Test à retardement réparé (CI cassée depuis le 14/07).
- Bug XP : `fetchAndApplyXp` filtré sur `user_id` + jamais de rétrogradation.
- Migration **012** : FK `challenge_posts→profiles` (feed réparé).
- Migration **013** : colonne `country` dans `preferences`.

## ⚠️ Actions requises / vigilance

1. **Appliquer les migrations 012 et 013** dans le dashboard Supabase.
2. **Vérifier visuellement sur device** : images quantisées (badges,
   créatures), typo des tutos (polices système), animation du tuto dashboard.
3. **Générer les images ComfyUI** des 10 nouvelles cultures + ombrière +
   pastille « tuto_climat_tropical.png » (fallback emoji en attendant).
4. Zones climatiques par pays = v1 partagée (un seul calendrier AO) ; affiner
   sahel/côte en v2.
5. Restent de l'audit du 7 juillet (hors périmètre AO) : suppression de
   compte in-app, CFBundleVersion, badges cloud destructifs, merge
   plantations, contrôles debug XP en prod… — voir `_plans/audit-2026-07-07.md`.
