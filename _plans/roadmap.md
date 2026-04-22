# 🗺️ Kultiva — Roadmap

> Dernière mise à jour : **2026-04-22**
> Statut global : **actif, pré-publication** — CI iOS branchée, signing Android
> configuré, landing marketing prête, conformité Amazon Associates en place.

## 🎯 Vision

**Le potager kawaii dans ta poche** — rendre le jardinage accessible, ludique et
adapté à la région pour les jardiniers amateurs francophones (France
métropolitaine et Afrique de l'Ouest).

## 📊 Statut actuel

Le projet est dans une phase de **polish pré-store**. Les 20 derniers commits
se concentrent sur la stabilité (permissions caméra / géoloc iOS, fallback
Paris, upgrade `flutter_local_notifications` avec core library desugaring), la
signing Android, la CI Xcode Cloud, la conformité Amazon Associates et
l'onboarding animé. Aucune issue GitHub n'est ouverte, aucune PR n'est en
attente. La branche active est `claude/init-project-docs-hzSyH`, dédiée à la
mise en place de la documentation Claude Code.

## 🏁 Jalons

### ✅ Passés (déduits de l'historique Git)

- **v1 — Calendrier + catalogue** : semer / récolter / mon jardin / paramètres
  (base du projet selon le `README.md`).
- **v2 — Poussidex** : collection chronologique des plants, migration depuis
  l'ancien système de grille.
- **Tamassi** : créature virtuelle + système d'XP, starter (Poussia / Soleia /
  Spira), visiteurs (table `user_xp` publique en lecture).
- **Synchronisation Supabase** : auth email/password + OAuth Google + OAuth
  Apple, sync plantations / préférences / badges / XP, bucket photos.
- **Météo et alertes d'arrosage** : Open-Meteo + geolocator + geocoding,
  fallback Paris, notifications locales.
- **Feed communautaire** : défis photo, likes avec trigger Postgres.
- **Gamification** : badges (50 images), défis, médailles bronze/argent/or.
- **Signing release Android** : `key.properties`, core library desugaring.
- **CI iOS** : Xcode Cloud via `ios/ci_scripts/ci_post_clone.sh`.
- **Conformité Amazon Associates** : mention « Lien partenaire » visible.
- **Landing marketing** : site HTML statique (`landing/index.html`).

### 🎯 Proposés (à valider par le mainteneur)

- **Publication App Store + Google Play** (v1.0.0 publique).
- **Tests de widgets et d'intégration** (couverture actuelle : modèles
  uniquement).
- **CI GitHub Actions** (`flutter analyze` + `flutter test` sur chaque PR).
- **Edge functions Supabase** pour modération du feed (likes, posts, photos).
- **Internationalisation** (au minimum anglais) — actuellement fr-FR uniquement.
- **Nouvelles régions** (Antilles, Québec, Maghreb) au-delà de
  France + Afrique de l'Ouest.
- **Migration `go_router`** — soit activer le package, soit le retirer.

## ✅ Tâches

### 🔥 En cours (WIP)

- **Branche `claude/init-project-docs-hzSyH`** — initialisation du `CLAUDE.md`
  et du fichier `_plans/roadmap.md` (cette tâche).

[À COMPLÉTER : aucun autre WIP détecté — pas d'issue assignée, pas de TODO /
FIXME dans le code, pas de branche expérimentale.]

### 📋 À faire — Prioritaire

Aucune issue GitHub ouverte ; la liste ci-dessous est déduite des incohérences
du repo et à valider par le mainteneur :

- **Réécrire le `README.md`** — le fichier actuel décrit une v1 obsolète
  (auth démo locale, 4 fonctionnalités) et ne reflète plus le produit.
- **Écrire une suite de tests de widgets / intégration** — la couverture
  actuelle est limitée aux modèles (`vegetable`, `plantation`, `badges`,
  `medals`).
- **Préparer la publication** App Store + Google Play (listing, captures,
  descriptions, politique de confidentialité, pages légales).
- **Activer une CI GitHub Actions** (`flutter analyze` + `flutter test`).

### 📌 Backlog

[À COMPLÉTER : aucune source GitHub — tirets issus d'observations du code.]

- Retirer ou activer la dépendance `go_router` (12.x, non utilisée).
- Évaluer la migration des majeures figées (`flutter_local_notifications`
  17 → 21, `geolocator` 11 → 14, `go_router` 12 → 17).
- Extraire la logique de likes / compteurs / modération du feed vers des
  **edge functions Supabase**.
- Ajouter un **dashboard admin** (côté Supabase) pour modérer les posts
  signalés.
- **Internationalisation** : extraire les strings dans des fichiers ARB,
  ajouter en_US.
- **Élargir le catalogue régional** : plus de légumes West Africa, nouvelles
  régions.
- **Export / import de données** : backup JSON local, import depuis une autre
  app.

### ✔️ Terminé récemment

(10 derniers commits significatifs extraits de `git log --oneline -20` —
`main`)

1. `19b1b07` — Add Xcode Cloud post-clone script for Flutter setup.
2. `3576784` — Fix dashboard animation not centered in WebView.
3. `c60dc9a` — Replace dashboard tuto with animated kawaii showcase.
4. `d0e1e3c` — Move app-onboarding tutos into a new 'Prise en main' category.
5. `0975835` — Fix camera not opening on iOS after permission grant.
6. `5e91900` — Retry geoloc on Paris fallback + add weather refresh button.
7. `c3e94af` — Wire 38 kawaii accessory images with emoji fallback.
8. `d0bae61` — Android: enable core library desugaring for
   `flutter_local_notifications` 17+.
9. `907e730` — Bump `flutter_local_notifications` 16.3.3 → 17.2.3.
10. `93d83ee` — Android: wire release signing config from `key.properties`.

## 🐛 Bugs connus

- **Aucune issue ouverte** sur GitHub.
- **Aucun marqueur `TODO` / `FIXME` / `XXX` / `HACK`** trouvé dans `lib/` ni
  `supabase/`.
- À surveiller : fallback Paris quand la géoloc est refusée (comportement
  voulu mais à documenter côté UX).

## 💡 Idées / Explorations

[À COMPLÉTER : aucune branche expérimentale, aucun commentaire marqué
« exploration » dans le code. Suggestions ci-dessous à valider.]

- **Modes saisonniers avancés** : rotations suggérées automatiquement par
  saison + historique des cultures passées.
- **Marketplace graines** : partenariats au-delà d'Amazon (fournisseurs
  éthiques, semences paysannes).
- **Mode social étendu** : groupes privés (famille / voisins), défis
  communautaires locaux.
- **Intégrations domotiques** : bacs connectés, capteurs d'humidité.
- **Mode hors ligne complet** : téléchargement des assets météo / tutos pour
  usage sans connexion.

## 📈 Métriques

| Indicateur                     | Valeur                                 |
| ------------------------------ | -------------------------------------- |
| Commits totaux                 | **238**                                |
| Contributeurs                  | Claude (192) · teiki5320 (27) · Jean Perraudeau (19) |
| Issues GitHub ouvertes         | **0**                                  |
| PRs ouvertes                   | **0**                                  |
| Branches actives               | `main`, `claude/init-project-docs-hzSyH` |
| Fichiers Dart (`lib/`)         | **68**                                 |
| Lignes de code Dart (`lib/`)   | **~24 685**                            |
| Fichiers de tests              | **5** (631 LoC)                        |
| Migrations Supabase            | **4** (`001` → `004`)                  |
| Tables Postgres                | **7**                                  |
| Buckets Storage                | **1** (`plant-photos`)                 |
| Edge functions                 | **0**                                  |
| Assets (images + sons + tutos) | **~160 fichiers**                      |
| Langues UI                     | **fr-FR**                              |
| Régions supportées             | **2** (France, Afrique de l'Ouest)     |
