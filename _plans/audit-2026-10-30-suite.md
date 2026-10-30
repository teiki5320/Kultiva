# Kultiva — correctifs appliqués, audit à jour et pistes

> 30 octobre 2026. Suite de `_plans/audit-2026-10-30.md`.
> Vérifié par outils : `flutter analyze` propre, **205/205 tests verts**
> (187 → 205), CI verte, projet Supabase confirmé `INACTIVE` par appel API.
> Commits `dc77c81` et `28669d6`.

---

# Partie 1 — Ce qui a été corrigé

## Le plus grave : une perte de photos silencieuse

Trouvé en instrumentant les blocs `catch` muets, pas en le cherchant.

`PhotoService.purgeOrphans()` tourne à chaque démarrage et supprime tout
fichier de `plant_photos/` absent de l'inventaire des photos encore
référencées. Cet inventaire se construisait avec `Plantation.decodeAll`,
qui **renvoie une liste vide dès que le JSON est illisible** :

```dart
} catch (_) {
  return <Plantation>[];   // ← « illisible » devient « vide »
}
```

Conséquence : des préférences corrompues — une seule plantation malformée
suffit, `fromJson` lève et tout le lot tombe — donnaient un inventaire
vide, et la purge effaçait **toutes les photos du jardin** au démarrage
suivant. Irrécupérables pour un utilisateur sans compte, puisque les
photos locales sont alors le seul exemplaire. Et l'utilisateur voyait en
même temps un Poussidex vide, sans jamais comprendre pourquoi.

`referencedLocalPaths()` décode maintenant elle-même, strictement, et
renvoie `null` quand elle ne peut pas conclure. La purge s'abstient alors
de toute suppression. **« Rien à garder » et « je ne sais pas quoi
garder » ne se confondent plus.** Sept tests verrouillent le
comportement (`test/photo_service_keepset_test.dart`).

La tolérance de `Plantation.decodeAll` n'a pas été touchée : elle est la
bonne pour l'affichage. C'était son usage pour décider d'une suppression
qui était faux.

## Les autres correctifs

| | Sujet | Ce qui a changé |
|---|---|---|
| 1 | Message d'erreur de connexion | `_friendlyError` ne filtrait que le mot « network », or `gotrue` emballe les pannes réseau dans un `AuthRetryableFetchException` dont le message brut est `ClientException with SocketException: Failed host lookup: '<projet>.supabase.co'`. Ce texte s'affichait tel quel — anglais, technique, révélant l'adresse du backend — à chaque testeur TestFlight, le projet étant en pause. Remplacé par « Serveur injoignable — vérifie ta connexion et réessaie. » |
| 2 | Ordre de Sentry | `SentryFlutter.init` était appelé **après** tout le bootstrap : Supabase, préférences, notifications et fuseau horaire tournaient hors zone surveillée, donc un plantage au démarrage ne remontait jamais. L'init passe en premier, le bootstrap devient son `appRunner`. |
| 3 | Démarrage résilient | Les étapes non critiques (notifications, musique) passent par un garde qui signale l'échec à Sentry et **laisse l'app démarrer** au lieu de rester sur un écran vide. |
| 4 | ITMS-90683 | `NSLocationAlwaysAndWhenInUseUsageDescription` ajoutée à `Info.plist`. L'avertissement qu'Apple renvoyait à chaque envoi disparaît au prochain build. |
| 5 | Alertes muettes | Les trois routines d'alerte (arrosage, canicule, premières pluies) signalent désormais leurs échecs. Elles portent des fonctionnalités annoncées sur la fiche et pouvaient être mortes sur un parc entier d'appareils sans que personne ne le sache. |
| 6 | Version affichée | « Kultiva v1.0 » était écrit en dur et devenait faux au premier bump. Vient de `AppInfo` (`lib/config/app_info.dart`). |
| 7 | Grille iPad | Les 4 tuiles de statistiques du Poussidex étaient figées à 2 colonnes : deux cartes démesurées par ligne sur 13 pouces. Elles passent sur une ligne au-delà de 600 points, au même seuil que le catalogue. |
| 8 | Texte agrandi | La taille de texte système est plafonnée à 1,3. **Mesure de sauvegarde, pas mise en conformité** — voir plus bas. |
| 9 | Snapshot du catalogue | Régénéré (97 → 169 entrées), et la CI échoue maintenant s'il dérive à nouveau. |
| 10 | Décomptes des fiches | `catalog-sync.md` et `kultivaprix-handoff.md` annonçaient 98 entrées et faisaient vérifier à Kultivaprix `count(*) = 98` — qui aurait signalé une sync cassée alors qu'il y en a 169. |
| 11 | Tests | +18 (187 → 205). `weather_data_test` couvre `consecutiveDryDays` et `rainNext3Days`, entièrement découverts alors qu'ils déclenchent les alertes et reposent sur une convention d'index fragile. |

## Une erreur de ma part, corrigée en route

J'ai commencé par sortir `kultiva-catalog.json` du dépôt, en le prenant
pour un artefact généré inutile. C'était faux :
`docs/kultivaprix-handoff.md` en fait explicitement le **snapshot de
secours** que Kultivaprix télécharge quand Supabase est indisponible —
c'est-à-dire maintenant. Le dé-suivre aurait cassé une intégration
documentée, en 404 sur `raw.githubusercontent.com`. Il est donc régénéré,
gardé sous suivi, et protégé par un garde-fou de CI.

## Ce que je n'ai volontairement PAS touché

Ce ne sont pas des oublis. Chacun demande une décision qui t'appartient,
ou un risque que je ne peux pas évaluer sans backend ni appareil.

1. **Le champ `amazonUrl`.** Il est mort (169 entrées à `null`), mais
   `docs/INFRA.md` le documente comme **le chemin de retour** de
   l'affiliation : « créer un identifiant dans le nouveau compte, puis
   renseigner `amazonUrl` ». Le supprimer détruirait ce chemin.

2. **Les tables mortes `challenge_posts` / `post_likes`.** Révoquer leurs
   policies de lecture publique réduirait la surface, mais les migrations
   de ce projet s'appliquent à la main depuis le dashboard, et le projet
   est en pause. Ajouter un fichier `017_*.sql` non appliqué ferait
   mentir le dossier `migrations/`. Le SQL est prêt, il attend le
   rallumage :

   ```sql
   -- 017_revoke_dead_feed_read.sql — à créer au moment de l'appliquer
   drop policy if exists "posts_select_visible" on public.challenge_posts;
   drop policy if exists "likes_select_all"     on public.post_likes;
   -- Les tables et les données restent intactes : seule la lecture
   -- publique disparaît. Réversible en recréant les policies (voir
   -- migrations 002 et 010) le jour où le feed revient.
   ```

3. **Les températures nulles d'Open-Meteo.** Dans
   `weather_service.dart`, les précipitations tolèrent `null`
   (`(e as num?)?.toDouble() ?? 0.0`) mais pas `temperature_2m_max` /
   `_min` : une seule valeur nulle fait échouer tout le parsing et
   supprime la météo. Le correctif demande de décider **ce que l'app
   affiche pour un jour à température inconnue** — 0 °C serait faux et
   fausserait la détection de canicule. C'est un choix produit.

4. **Le plafond de taille de texte.** Plafonner à 1,3 évite les écrans
   cassés aujourd'hui, mais ignore la préférence au-delà. Le vrai
   correctif est de rendre extensibles les **83 hauteurs fixes**, écran
   par écran, en regardant le résultat. Il faut un appareil.

5. **Les montées de dépendances.** `timezone` ne peut pas passer de 0.9 à
   0.11 seule : `flutter_local_notifications 17.2.4` la contraint — d'où
   l'épinglage, qui est correct. Et je n'ai **pas** monté
   `supabase_flutter` (2.12 → 2.18, pourtant compatible) : changer le
   client d'authentification alors que le backend est injoignable, donc
   intestable, à quelques jours d'une soumission, c'est exactement le
   mauvais moment.

6. **`orElse: () => vegetablesBase.first`.** Quatre endroits du planificateur
   affichent **une tomate** quand l'identifiant du légume est introuvable,
   au lieu de ne rien afficher. Ça ne plante pas, mais ça ment. Décider
   quoi montrer à la place est un choix d'interface.

---

# Partie 2 — Audit à jour

## État réel

Le code est sain. `flutter analyze` ne renvoie rien, **205 tests
passent**, la CI est verte, zéro `TODO` dans 36 300 lignes, aucune
dépendance déclarée inutilisée.

**La fiche App Store ne mentait pas.** J'ai repris la description ligne
par ligne : calendrier régional, export PDF, 130 fiches *avec rendement
estimé renseigné pour les 130*, carrés en glisser-déposer, rotation,
Tamassi et ses visiteurs, météo 7 jours, canicule par légume, Poussidex,
médailles, 50 défis, 50 badges, 33 tutos, lexique, maladies,
compagnonnage, hors ligne. **Tout existe.** Les réglages sont complets
(confidentialité, suppression de compte, mode sombre, pays,
notifications) et le réglage de debug est bien masqué par `kDebugMode`.

## Ce qui reste bloquant, et qui ne dépend pas du code

1. **Supabase en pause** (`INACTIVE`, vérifié le 30 octobre). Sans lui :
   pas de connexion, pas de synchronisation, et surtout **pas de
   suppression de compte** — que le testeur Apple va essayer.
2. **Clés Google « Se connecter »** à recréer (supprimées le 9 octobre).
3. **Captures d'écran** : 8 en iPhone 6,9″, 8 en iPad 13″.
4. **Compte de démonstration**, **téléphone de revue**, **déclaration
   DSA** (à retrancher depuis le retrait de l'affiliation).
5. **Revue visuelle de l'iPad 13″** — la seule chose de cet audit que je
   n'ai pas pu juger. Il me faut l'accès simulateur.

## Dette restante, par ordre d'urgence décroissante

| Sujet | État |
|---|---|
| 10 services sur 16 sans test | `auth`, `cloud_sync`, `notification`, `photo` (partiel), `pdf`, `culture`, `garden_plan`, `geolocation`, `audio`, `review` |
| `widget_test.dart` | Monte un `Scaffold` vide : teste Flutter, pas Kultiva. Aucun test de widget réel |
| 83 hauteurs fixes | Plafond posé ; correctif de fond à faire |
| Accessibilité | 27 usages de `Semantics` sur 102 fichiers. Aucune passe VoiceOver |
| 11 dépendances en retard d'une majeure | `share_plus` 7→13, `flutter_local_notifications` 17→22, `sentry_flutter` 8→10… Rien d'urgent, mais la marche grandit |
| `vegetables_base.dart` | 4 056 lignes de données en Dart. Lisible, mais le jour où le catalogue devient éditable hors code, il faudra le sortir |

---

# Partie 3 — Idées d'amélioration

Classées par rapport valeur/effort. Toutes s'appuient sur du code qui
existe déjà.

## 1. Le trou de l'hiver — le plus urgent des sujets produit

C'est le vrai risque de rétention, et il n'est traité nulle part.
Kultiva dit quoi semer. En France, de novembre à février, la réponse est
« presque rien ». L'app devient silencieuse quatre mois par an, juste
après le pic de téléchargement de l'automne. Les utilisateurs
désinstallent en hiver et ne reviennent pas au printemps.

**Les chantiers d'hiver.** Une liste saisonnière de tâches qui ne sont
pas des semis : pailler, tailler les fruitiers, nettoyer et huiler les
outils, lancer le compost, commander les graines, forcer des endives,
semer sous abri. Tu as déjà tout : `notification_service` pour les
rappels, les 33 tutos pour le contenu, `challenges.dart` pour la
mécanique. C'est du contenu, pas de l'architecture.

**L'hiver comme saison de planification.** `garden_planner_screen` existe
et `rotation_advisor` sait avertir. Retourne la morte-saison : « dessine
ton potager de l'an prochain » devient *l'*activité de janvier, avec les
avertissements de rotation calculés sur ce que tu as réellement cultivé.
En Afrique de l'Ouest, le même mécanisme s'applique à la saison sèche.

## 2. Un potager qui apprend de tes récoltes

Aujourd'hui l'app donne des conseils génériques par région, et ne saura
jamais si ça a marché chez toi. Or `culture_entry` enregistre déjà les
dates, les arrosages et les récoltes.

Ajoute **une seule question** à la clôture d'une culture : « ça a donné ?
— bien / moyen / raté », plus une cause en un tap (monté en graines,
limaces, trop d'eau, pas assez de soleil). La saison suivante :

> « L'an dernier tes radis ont filé en juin. Chez toi, essaie
> début mars. »

C'est le seul avantage qu'aucun concurrent ne peut copier : il est dans
**l'historique de l'utilisateur**. Deux saisons et l'app connaît son
terrain mieux que n'importe quel calendrier régional. Aucun backend
nécessaire, tout est local.

## 3. Transformer le catalogue en aide à la décision

169 fiches, c'est une encyclopédie. Un débutant ne sait pas quoi en
faire. Il ne veut pas chercher « tomate », il veut savoir **quoi planter
ce week-end**.

Un assistant en trois questions — *combien de place ? / combien de temps
par semaine ? / plutôt salade ou plutôt confiture ?* — qui sort cinq
propositions avec la date limite de semis. Les données existent :
calendrier régional, `densityPerSqFt`, `effectiveWateringDays`,
catégories. Et un parcours « mon premier potager en 5 plantes » qui ne
propose que de l'increvable : radis, laitue, courgette, basilic, haricot.

## 4. Faire du Poussidex une vraie collection

Le cadre « Pokédex du potager » est excellent et sous-exploité. 50 badges
et 50 défis, c'est une liste de courses, pas une collection.

- **Des familles à compléter** : les solanacées, les cucurbitacées, les
  aromatiques — avec une récompense visuelle à la complétion.
- **Des entrées saisonnières** : une tomate récoltée en octobre n'est pas
  la même prise qu'en juillet.
- **La carte de fin de saison** : `share_card` et
  `challenge_story_card` existent déjà. « Ma saison 2027 : 14 plants,
  3,2 kg de tomates, 47 arrosages, Tamassi niveau 12. » C'est ça qu'on
  partage, pas une photo de défi.

## 5. Un diagnostic guidé, sans intelligence artificielle

En 2026, une app de jardinage où l'on doit auto-diagnostiquer en lisant
un guide des maladies fait daté. Mais tu n'as pas besoin d'un modèle de
vision : `diseases.dart` contient déjà les symptômes.

Un arbre de questions — *quelle partie ? quelle couleur ? dessus ou
dessous de la feuille ? par temps humide ?* — qui converge en quatre taps
vers deux ou trois candidats, hors ligne, sans serveur, sans coût. C'est
80 % de la valeur perçue d'un « scanner de plantes » pour 2 % du travail.

## 6. Le balcon comme mode de plein droit

« Mes jardins » pense en carrés de pleine terre. Or le gros du marché
urbain cultive en pots sur un balcon : pas de rotation, des contraintes
de volume et d'exposition radicalement différentes, un arrosage bien plus
fréquent. Aujourd'hui ces utilisateurs détournent l'outil. Un mode
« pots et jardinières », avec des conseils d'arrosage calés sur le volume
du pot, élargit l'audience sans toucher au cœur.

## 7. Finitions qui comptent plus qu'elles n'en ont l'air

- **Une passe VoiceOver** et le correctif de fond des hauteurs fixes :
  c'est une app classée 4+ qui vise aussi des jardiniers âgés.
- **Les quatre `orElse: () => vegetablesBase.first`** qui affichent une
  tomate à la place du bon légume.
- **Les températures nulles** d'Open-Meteo qui peuvent supprimer la
  météo.

---

# Partie 4 — Idées pour transformer l'app

Les quatre premières sont des évolutions. Celles-ci changent ce que
Kultiva **est**.

## A. Le jardin partagé — famille, couple, classe

**C'est le levier le plus fort, et il contourne précisément le piège qui
a tué le feed.**

Le feed communautaire a été coupé parce qu'un contenu public exige
signalement **et** blocage (guideline 1.2), une modération que tu ne peux
pas tenir seul, et fait passer la classification de 4+ à 13+.

Un **jardin partagé fermé** — deux à cinq personnes qui s'invitent
nominativement — n'a aucun de ces problèmes : pas de contenu public, pas
de découverte d'inconnus, pas de modération à l'échelle. Et ça règle d'un
coup le point le plus faible du produit : **il n'y a aujourd'hui aucune
raison de parler de Kultiva à quelqu'un.**

Un couple qui suit le même potager, un parent et son enfant qui se
passent les défis photo, deux voisins qui partagent un carré : chacun
amène un utilisateur. Techniquement, les tables `plantations` et
`preferences` sont déjà par utilisateur avec RLS ; il faut une notion de
jardin partagé et une invitation. Ce n'est pas rien, mais c'est net.

## B. Le mode classe — et c'est peut-être là qu'est l'argent

Regarde ce que tu as, vu par une enseignante de primaire : **33 tutoriels
illustrés, 50 défis photo, une créature kawaii, classé 4+, entièrement
hors ligne, en français**. C'est exactement l'outil que cherchent les
écoles pour un jardin pédagogique — un dispositif qui figure dans les
programmes, financé par des budgets d'école, et où le hors-ligne est un
avantage parce que le wifi n'arrive pas jusqu'au potager.

Un mode classe — l'enseignante crée un jardin, distribue des défis, les
élèves photographient, le Tamassi de la classe grandit collectivement —
transforme une app de loisir en outil éducatif. Et c'est un modèle
économique honnête : une licence annuelle par classe, sans publicité ni
achat intégré dans une app pour enfants.

## C. Afrique de l'Ouest : un produit, pas une variante

Tu as construit là quelque chose que presque personne ne sert : des
calendriers par sous-zone climatique (sahel, soudanien, guinéen), les
noms locaux, un mode maraîchage en FCFA, des conseils d'achat au marché,
les maladies tropicales.

Mais les deux publics ne veulent pas la même chose. En France, Kultiva
est un **loisir** : on cultive pour le plaisir et la fierté de la
première tomate. En Afrique de l'Ouest, le maraîchage est souvent un
**revenu** : combien ai-je semé, combien ai-je vendu, à quel prix, quelle
marge.

Suivre les rendements et les revenus en FCFA, avec les prix du marché,
serait d'une valeur immédiate pour un maraîcher — et ça n'a rien à voir
avec un Pokédex kawaii. Deux chemins : assumer deux produits distincts
sur le même socle, ou choisir un seul marché pour la v1 et traiter
l'autre plus tard. Aujourd'hui l'app fait les deux à moitié.

## D. Tamassi comme interface, pas comme récompense

Tamassi est aujourd'hui un compteur d'XP déguisé en créature : il réagit
à ce que tu fais, mais ne te dit rien. Fais-en **la voix de l'app**.
C'est lui qui annonce la canicule, remarque que tu n'as pas arrosé depuis
six jours, demande ce qu'est devenue la courgette de mai, se réjouit
d'une récolte.

Une app de jardinage de plus est une utilité, qu'on ouvre quand on en a
besoin. Une créature dont on s'occupe est une relation, qu'on ouvre tous
les jours. Tu as déjà payé le coût de l'animation, des trois variantes et
des émotions. Tu n'en récoltes qu'une partie.

Attention au dosage : la frontière entre attachant et pénible est mince,
et sur une app pour enfants elle compte double.

---

# La question qui précède toutes les autres

Ces idées ne se classent pas pareil selon la réponse, et c'est à toi
seul de la donner : **est-ce que Kultiva est un produit que tu veux faire
vivre, ou une app que tu veux publier ?**

Si c'est **publier et passer à autre chose** : ne fais rien de la
partie 4. Rallume Supabase, prends les captures, soumets. L'app est
prête, et rien de ce qui précède ne bloque la publication.

Si c'est **faire vivre un produit** : alors le trou de l'hiver (§1) et
l'absence de toute raison d'en parler (§A) sont les deux seules choses
qui comptent vraiment. Tout le reste est du polish. Une app saisonnière
sans boucle hivernale et sans partage ne garde pas ses utilisateurs,
quelle que soit la qualité de son catalogue — et le catalogue est bon.

Mon avis, puisque tu le demandes : **publie d'abord, tel quel.** Tu as
une app complète, propre et honnête, bloquée par un clic sur Supabase et
une poignée de captures. Les idées de la partie 4 méritent d'être
décidées avec de vrais utilisateurs et de vrais chiffres de rétention,
pas avant. Et si tu ne dois en retenir qu'une pour la v1.1, prends les
chantiers d'hiver : c'est du contenu, c'est sans risque technique, et ça
arrive précisément au moment où tes premiers utilisateurs s'apprêtent à
te quitter.
