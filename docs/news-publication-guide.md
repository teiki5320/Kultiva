# 📰 Guide — Publier une actualité Kultiva

> Comment ajouter une nouvelle slide dans l'app et le site, en 2 minutes.

## 🎯 En résumé

L'utilisateur final voit les actus **dans l'app Kultiva** (sous forme de
stories Instagram-like, swipables verticalement) et **sur le site
Kultivaprix** (article complet, lien depuis la slide).

Tu es la **seule personne** qui publie. Tu utilises **Supabase Studio**
(interface web admin gratuite, native Supabase) — pas besoin de SDK ou
de code.

## 🛠️ Workflow recommandé (2 min)

### 1. Tu produis ton contenu

- Tu montes ta vidéo / prends tes photos
- Tu choisis **une image** principale au format **vertical 1080×1920**
  (format story Instagram). C'est cette image qui s'affichera plein
  écran dans l'app.
- Tu rédiges l'article complet sur Kultivaprix (CMS dédié, séparé)
- Tu publies sur Instagram

### 2. Tu uploades l'image dans Supabase

1. Va sur [app.supabase.com](https://app.supabase.com) → projet
   **Kultiva** → menu **Storage** dans la sidebar gauche
2. Sélectionne le bucket **`news-images`** (déjà créé)
3. Drag-and-drop ton image (format `.png`, `.jpg` ou `.webp` — préfère
   `.webp` compressé pour réduire la taille)
4. Clique sur l'image → **Get URL** → copie l'URL publique
   (ressemble à `https://vkiwkeknfzwdvufcqbrp.supabase.co/storage/v1/object/public/news-images/ma-photo.webp`)

### 3. Tu crées la slide dans Supabase

1. Toujours sur Supabase Studio, menu **Table Editor** → table
   **`news_items`**
2. Clique **Insert row** (bouton vert en haut à droite)
3. Remplis les champs :

| Champ | Type | Exemple | Obligatoire ? |
|---|---|---|---|
| `title` | court (≤ 80 chars) | `"Les fraises arrivent !"` | ✅ |
| `caption` | court (≤ 280 chars) | `"C'est la saison des fraises gariguette. Direct du potager au panier."` | ✅ |
| `image_url` | URL Supabase Storage | (collée à l'étape 2) | ✅ |
| `article_url` | URL Kultivaprix | `"https://kultivaprix.fr/news/fraises-juin-2026"` | optionnel |
| `video_url` | URL YouTube/Insta | `"https://www.instagram.com/p/Cxxxxxx/"` | optionnel |
| `tags` | array de strings | `["saison", "fruits", "fraise"]` | optionnel |
| `priority` | entier | `0` (défaut) ou `10` pour mettre en haut | optionnel |
| `published_at` | timestamp | laisse vide → maintenant | optionnel |

4. Clique **Save**

### 4. Vérification

Ouvre Kultiva sur ton iPhone → carte « Actualités » sur le dashboard →
ta nouvelle slide apparaît en premier (les actus sont triées par
`priority` puis `published_at` décroissant).

## 📱 Côté Kultivaprix

Le site Kultivaprix lit la même table `news_items`. Le mainteneur de
Kultivaprix doit utiliser la même clé `anonKey` Supabase pour lire la
table en lecture seule (RLS l'autorise pour tous). Voir
`docs/kultivaprix-handoff.md` pour le code JS.

## 🎨 Conseils style

- **Image vertical 9:16** obligatoire (1080×1920) pour le rendu plein
  écran style story
- **Titre** : court et accrocheur, max ~ 6 mots
- **Caption** : 1 à 3 phrases, ton chaleureux et kawaii
- **Tags** : utilise les mêmes mots-clés que tes posts Instagram pour
  cohérence (ex: `saison`, `astuce`, `fruits`, `bio`)

## 🐛 Debug

- **L'image ne s'affiche pas** → vérifie que le bucket `news-images` est
  bien public et que l'URL contient `/object/public/news-images/`
- **L'actu n'apparaît pas dans l'app** → tire vers le bas dans le feed
  (pull-to-refresh) pour forcer le rechargement depuis Supabase
- **Erreur RLS** → la table est en lecture seule pour `anon` ; pour
  insérer, tu dois passer par Supabase Studio (qui utilise
  automatiquement la clé `service_role`)

## 🔮 Évolutions prévues

- **Édition / suppression** depuis l'app : pas prévu, gestion uniquement
  via Supabase Studio
- **Notifications push** quand une nouvelle actu sort : à câbler plus
  tard via `flutter_local_notifications`
- **Partage Instagram automatique** : pas prévu, le workflow reste
  manuel (tu postes sur Insta puis tu crées la slide)

---

📅 Dernière mise à jour : 2026-04-28
