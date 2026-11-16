# Kultiva : zéro installation, ce que ça autorise

> Texte déplacé tel quel depuis `CLAUDE.md` le 16 novembre 2026, pour alléger les consignes lues à chaque session. Rien n'a été réécrit.

## 🧹 Zéro installation : ce que ça autorise (02/11/2026)

**Décision de Jean** : « personne n'a encore téléchargé Kultiva ».
Aucune donnée ancienne n'existe donc sur aucun téléphone, et tout ce
qui ne servait qu'à la compatibilité est parti.

**Ce qui a été supprimé, et pourquoi c'était mort par construction :**

- `services/plantation_migration.dart` (81 lignes) — convertissait une
  « ancienne grille 2D » vers la collection de plants. Ce format n'a
  jamais quitté un poste de développement ;
- `CultureService.linkLegacyEntries()` — rattachait les cultures
  écrites avant le 30/10/2026. ⚠️ Son filet de sécurité vivant,
  `_plantationIdFor()`, **reste** : il recrée le dossier d'un plant
  supprimé sous une culture encore active, ce qui peut arriver
  aujourd'hui ;
- `Plantation.merge()` — n'avait plus qu'un appelant, la migration.
  Elle datait de la synchronisation cloud, retirée le 30/10 ;
- les préférences `kultiva.gardenGrid` et
  `kultiva.gridMigratedToPoussidex`, et dans `clearUserScopedData` les
  clés `kultiva.creature.*`, `tamassi.stats.*` et `kultiva.auth.*` :
  du ménage pour une poussière qui n'existe nulle part ;
- les routes `kultiva://poussidex` et `kultiva://photos`, conservées
  « pour les anciens liens » — il n'y a pas d'ancien lien ;
- `PhotoService.pick()`, zéro appelant ;
- `dayLabel()` et `monthLabel()` de `months.dart`, zéro appelant
  (`journal_view` et `weather_screen` ont chacun leur `_dayLabel`) ;
- deux entrées de lexique, « poussidex » et « streak ».

**Renommé, sans toucher aux identifiants** : `PoussidexBadge` devient
`GardenBadge`, et `onboarding_poussidex.png` devient
`onboarding_journal.png`. ⚠️ **Les 50 identifiants de badge n'ont pas
bougé** : ce sont les noms des fichiers d'images et les clés
persistées. Renommer une classe est sans risque ; renommer un
identifiant ne l'est pas.

**Un commentaire qui mentait** : `clearUserScopedData()` se disait
« plus appelée par l'app » alors que « Effacer mon jardin » l'appelle.

**Bilan** : −22 tests (leur code est parti avec eux), 1 070 tests
verts, `analyze` propre.

⚠️ **Ce que cette décision ne couvre pas.** Elle vaut **jusqu'à la
première publication**. Le jour où une version est sur une boutique,
toute clé de préférence et tout format persisté deviennent un contrat :
un champ renommé, c'est un jardin perdu. Le bon moment pour ce ménage,
c'était maintenant.

⚠️ **`supabase/migrations/` reste**, volontairement : c'est l'historique
du schéma, et CLAUDE.md le conserve comme point de départ si un backend
revenait (Cloudflare, pas Supabase). Il ne coûte rien et ne s'exécute
jamais.
