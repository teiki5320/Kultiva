# 🌍 Audit « Cap Afrique de l'Ouest » — 18 juillet 2026

> Objectif produit acté : **France et Afrique de l'Ouest au même niveau**, avec au
> démarrage une **détection automatique du pays** et un **choix parmi les pays
> francophones d'Afrique de l'Ouest**. Audit réalisé par 4 agents spécialisés
> (saisons UI, météo/arrosage, contenu, plomberie région/monétisation) sur tout le code.

## 🧭 Verdict

Le socle **données** est étonnamment bon : calendrier AO pour 59 cultures avec
notes régionales fines, compagnonnage/rotation/maladies couvrant déjà gombo,
igname, manioc, niébé, taro, sorgho, bissap… Mais **tout le reste de
l'expérience est câblé France** : la détection de région retourne toujours la
France (codée en dur), la météo retombe sur Paris, l'UI affiche des flocons de
neige en décembre, le seuil « canicule » de 30 °C sonnerait tous les jours à
Bamako, 0 tuto tropical sur 29, et les liens Amazon (amazon.fr, tag
`kultiva-21`) sont économiquement morts en AO.

**Chiffres clés de l'écart :**

| Dimension | État |
| --- | --- |
| Détection auto de région | `geolocation_service.dart:48` retourne `Region.france` **en dur** |
| Fallback météo | Paris (48.85, 2.35) **en dur** (`weather_service.dart:14`) |
| Calendrier AO | **59/120** cultures couvertes |
| Tutos tropicaux | **0/29** |
| Lexique tropical | **0 terme** (harmattan, hivernage, zaï… absents) |
| Seuil canicule | **30 °C** → alerte quasi permanente en AO |
| Planner potager | Saisons + picker codés sur `franceData` |
| UI saisons | « Hiver » + ❄️ flocons déc-fév partout (`petal_animation.dart`) |
| Badges | « Neige » et « 4 saisons » **inatteignables** en AO |
| Liens d'achat | 100 % amazon.fr — pas de livraison AO |
| Poids | **245 Mo d'assets** (badges 91 Mo !) + polices/CDN téléchargés au runtime |

## 🏗️ Architecture cible : pays francophones + zones climatiques

### Modèle proposé

1. **Nouveau modèle `Country`** : 🇫🇷 France + 8 pays francophones d'AO :
   🇸🇳 Sénégal, 🇨🇮 Côte d'Ivoire, 🇲🇱 Mali, 🇧🇫 Burkina Faso, 🇧🇯 Bénin,
   🇹🇬 Togo, 🇳🇪 Niger, 🇬🇳 Guinée. (Extensible : Mauritanie, etc.)
2. Chaque pays AO est **mappé vers une zone climatique** qui porte le
   calendrier — on maintient 3 jeux de données au lieu de 8 :
   - **Sahélienne** (pluies juin-sept, courtes) : Sénégal, Mali, Niger
   - **Soudanienne** (pluies mai-oct) : Burkina Faso
   - **Guinéenne côtière** (2 saisons des pluies) : Côte d'Ivoire, Bénin, Togo, Guinée
   - v1 pragmatique : 1 zone par pays, affinable ensuite par latitude
     (nord CI ≠ Abidjan). `Region.westAfrica` actuel = zone de repli.
3. **`Region` reste le pivot rétro-compatible** : la région est dérivée du pays.
   Rien ne casse pour les utilisateurs France existants.
4. **Détection au démarrage** : la géoloc + `geocoding` (déjà dans l'app)
   donnent `placemark.isoCountryCode` → pays proposé automatiquement à
   l'onboarding (« Tu jardines au Sénégal 🇸🇳 ? »), avec liste des pays en
   secours si géoloc refusée. Bounding box lat/long en plan B sans réseau.
   ⚠️ Dépend du fix du **manifest Android** (aucune permission localisation
   déclarée aujourd'hui — la géoloc est morte sur Android).
5. **Fallback météo par pays** : Dakar, Abidjan, Bamako, Ouagadougou, Cotonou,
   Lomé, Niamey, Conakry — Paris seulement pour la France.
6. **Sync cloud** : ajouter le pays aux préférences synchronisées.

## 🔨 Les chantiers

### Chantier 0 — Préalables techniques

- ✅ **Fait (poussé sur la branche)** : le test à retardement qui cassait la CI
  depuis le 14 juillet est corrigé (`ca5b6d4`).
- **Manifest Android** : ajouter `ACCESS_FINE_LOCATION`/`COARSE`,
  `POST_NOTIFICATIONS`, receivers `flutter_local_notifications` — sans ça, ni
  la détection de pays ni les alertes ne fonctionnent sur Android.
- Rappel audit du 7 juillet : le bug critique de sync XP (`cloud_sync_service.dart:300`)
  et la FK manquante du feed touchent aussi (surtout) les futurs utilisateurs AO.

### Chantier 1 — Pays & détection (la fondation)

1. Modèle `Country` + mapping pays → zone climatique + drapeaux.
2. Onboarding : écran « Où jardines-tu ? » — détection auto + choix manuel
   parmi les 9 pays.
3. Réimplémenter `_regionFromCoordinates` (aujourd'hui : `return Region.france;`)
   via code pays ISO, bounding box AO en secours.
4. Fallback météo = capitale du pays.
5. Sélecteur de pays dans Réglages (remplace le sélecteur de région).
6. Sync cloud du pays choisi.

### Chantier 2 — Saisons tropicales dans l'UI

Tout dérive de l'enum `Season` de `petal_animation.dart` (source unique — bonne
nouvelle). Le rendre région-dépendant :

- **Saisons AO** : 🌬️ Harmattan / saison sèche fraîche (nov-fév),
  ☀️ Saison sèche chaude (mars-mai), 🌧️ Hivernage / saison des pluies
  (juin-oct) — bornes par zone climatique.
- Particules : poussière dorée d'harmattan, soleil, gouttes de pluie —
  **plus de flocons à Dakar**. Gradients ocre/vert au lieu du bleu glacé.
- `kawaii_background` : supprimer la neige du fallback déc-fév hors France.
- Médaille gold « 2 saisons » et badge « 4 saisons » → « saison sèche +
  hivernage » en AO ; badge « Neige » → badge « Harmattan » ou « Premières pluies ».
- Planner : filtre saison par région (sèche/pluies) + picker branché sur les
  données de la région (fix du codage en dur `franceData`).
- `harvestTimeBySeason` (clés spring/summer/autumn/winter dans les 120 fiches) :
  chantier de fond — à migrer vers des clés par région (moyen terme).

### Chantier 3 — Météo & arrosage tropicaux

- **Seuil canicule par région** : 30 °C en France, ≥ 40-42 °C (ou anomalie vs
  normale saisonnière) en AO — sinon spam permanent.
- Demander à Open-Meteo l'**humidité relative et l'ET0** (gratuits) :
  en hivernage 35 °C + 90 % HR ≠ besoin d'arroser ; en harmattan l'air
  ultra-sec accélère l'évaporation → conseils justes dans les deux sens.
- **Alerte « premières pluies »** 🌧️ : LA notification à forte valeur en AO —
  « Les premières pluies arrivent à Bamako, c'est le moment de semer le niébé ! »
  (le calendrier AO est déjà structuré autour de ça).
- Étiquette harmattan (heuristique vent + sécheresse), brouillard WMO 45/48.
- `WateringService` doit tenir compte de l'arrosage manuel enregistré
  (aujourd'hui il ignore `lastWatering`).

### Chantier 4 — Contenu Afrique de l'Ouest

- **Compléter les 61 calendriers AO manquants** (ou marquer explicitement
  « culture non adaptée au climat tropical » — c'est une info utile aussi).
- **Nouvelles cultures locales** (~10) : mil, fonio, moringa, aubergine
  africaine (djakhatou), corète potagère (crincrin), célosie, baselle,
  citronnelle, papayer, bananier plantain. Images ComfyUI avec la formule
  existante, partagées avec Kultivaprix.
- **Maladies tropicales majeures** : virose TYLCV de la tomate (+ aleurode),
  chenille légionnaire d'automne sur maïs, nématodes maraîchers, striga
  (mil/sorgho), maruca du niébé.
- **5-6 tutos AO** : jardiner en saison sèche (économiser l'eau : paillage,
  zaï, demi-lunes), préparer l'hivernage, fabriquer une ombrière, cultiver
  l'igname (buttes/billons), le maraîchage en sacs, gérer l'harmattan.
- **Lexique** : harmattan, hivernage, maraîchage, jardin de case, billon,
  zaï, demi-lunes, ombrière, butte d'igname…
- **Défis AO** : « Premières pluies », « Récolte de gombo », « Jardin de
  case », « Sous l'ombrière »… en remplacement de givre/« saison morte »/14 juillet
  (défis affichés selon le pays).
- **Accessoires** : ajouter ombrière/filet d'ombrage 30-50 % (le grand absent),
  arrosage économe ; masquer voile d'hivernage, châssis, cloche hors France.
- Prose des fiches européennes (« semer après les gelées », « sous abri
  chauffé ») : utiliser `regionalNote` (déjà dans le modèle) pour la variante AO.

### Chantier 5 — Distribution, poids & monétisation

Crucial pour un marché où la data mobile coûte cher et où l'Android d'entrée
de gamme domine :

- **245 Mo d'assets → viser < 60 Mo** : badges 91 Mo (!), créatures 34 Mo,
  accessoires 26 Mo, screenshots tutos 38 Mo (jusqu'à 9 Mo par PNG). Compression
  WebP/redimensionnement massif.
- **Zéro réseau au runtime** : bundler Nunito en asset (google_fonts télécharge
  depuis gstatic au 1er lancement), retirer les CDN des tutos HTML
  (fonts.googleapis + gsap sur cdnjs → cassés/coûteux sur connexion faible).
- **Liens Amazon** : masqués pour les pays AO (v1), puis à remplacer par un
  équivalent local (programme d'affiliation Jumia à étudier, ou conseils
  « où acheter au marché »). Amazon reste actif pour la France.
- Sentry : baisser `tracesSampleRate` (data) — serveur UE, à mentionner dans
  la privacy policy.

### Chantier 6 — Non-régression France

- La France garde exactement son expérience actuelle (saisons européennes,
  calendrier, Amazon, tutos) — tout le régional est ajouté **par-dessus** le
  pivot `Region`, pas en remplacement.
- Tests par région : chaque logique régionalisée (saisons, seuils, calendriers,
  badges) testée pour France ET pour une zone AO.

## ⚡ Ordre recommandé

**Quick wins (1re salve)** — fort impact, faible effort :
1. Manifest Android (permissions + receivers) — débloque tout
2. Détection du pays (`isoCountryCode`) + écran pays à l'onboarding
3. Fallback météo par capitale
4. Seuil canicule par région
5. Masquer les liens Amazon + accessoires hivernage hors France
6. Badge « Neige » → « Harmattan », défis givre/hiver filtrés par pays

**2e salve** : saisons tropicales UI (enum `Season` régionalisé + particules +
gradients), planner branché région, 61 calendriers AO complétés, alerte
premières pluies.

**3e salve** : nouvelles cultures + tutos + maladies + lexique + défis AO,
refactor `harvestTimeBySeason`, régime data (assets, polices, CDN), zones
climatiques affinées par latitude.

---

_Audit réalisé sur la branche `claude/loving-noether-7Vw5y`. Rapports sources :
audit général du 7 juillet (`_plans/audit-2026-07-07.md`, 113 erreurs) +
4 explorations ciblées AO du 18 juillet._
