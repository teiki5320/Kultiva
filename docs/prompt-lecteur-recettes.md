# Prompt — refaire le lecteur de recettes de Kultiva

> À coller dans une conversation Claude Design.
> Écrit le 1er novembre 2026, après que Jean a jugé le lecteur actuel
> « pas beau du tout ». Il l'est : fonctionnel, pas dessiné.
>
> ⚠️ Le précédent chantier du même genre (`prompt-tuto-dashboard.md`)
> est revenu avec GSAP chargé depuis cdnjs et Nunito depuis Google
> Fonts. Il a fallu tout réinliner. Les contraintes ci-dessous ne sont
> pas des préférences.

---

Je veux refaire **un seul fichier HTML** : le lecteur qui déroule une
recette pas à pas dans mon application de jardinage. Il est affiché
dans une WebView en plein écran sur téléphone.

## Ce que c'est

Une app Flutter de potager, style **pastel kawaii japonais** : lignes
arrondies, ombres douces, couleurs tendres, emojis parcimonieux mais
bienvenus. Ton chaleureux et enfantin, jamais corporate.

Palette claire : fond `#F5FAF8`, vert primaire `#4A9B5A`, vert clair
`#A8D5A2`, terracotta `#E8A87C`, texte `#2A4A3A`.
Palette sombre : fond `#0F1F18`, vert `#5ABD6A`, carte `#1A2E22`.

Le lecteur sert à **conserver une récolte** : mettre en bocal, congeler,
sécher, faire une confiture. On le lit debout dans sa cuisine, souvent
les mains sales, parfois en tenant le téléphone d'une main.

## Les contraintes, toutes bloquantes

1. **Un seul fichier.** Il sert les 376 recettes. Aucun fichier
   compagnon : ni CSS, ni JS, ni image externe.
2. **Zéro appel réseau.** Pas de CDN, pas de Google Fonts, pas
   d'`https://` nulle part. Une recette se lit dans une cave ou un
   jardin sans réseau. Police = pile système
   (`-apple-system, "SF Pro Rounded", system-ui, sans-serif`).
   Si tu veux une animation, écris-la en CSS ou inline le JavaScript.
3. **Le contenu arrive en JSON**, injecté par Dart à la place du
   marqueur `__RECIPE__`, qui ne doit apparaître **qu'une seule fois**
   dans tout le fichier — commentaires compris. Écrire le marqueur
   deux fois a déjà cassé le lecteur pendant une journée entière.
4. **Clair et sombre.** Le JSON porte `theme: "light" | "dark"`.
5. **Largeur téléphone**, de 360 à 430 px. Aucun défilement
   horizontal, jamais.
6. **Pas d'image de plat.** Il n'en existe aucune et il n'y en aura
   pas. Les emojis sont le seul visuel disponible.

## La forme exacte du JSON

```json
{
  "name": "Coulis de tomates en bocaux",
  "emoji": "🫙",
  "subtitle": "120 min · 8 pers. · 1 an au placard",
  "theme": "light",
  "ingredients": ["5 kg de tomates bien mûres", "2 oignons"],
  "steps": [
    { "emoji": "🍅", "text": "Lave les tomates…" },
    { "emoji": "⏱", "text": "Laisse cuire…", "minutes": 45 }
  ]
}
```

- `ingredients` : 3 à 6 lignes, parfois vide.
- `steps` : **4 à 9 étapes**. Le texte fait une à trois phrases, et
  contient parfois `**du gras**` à rendre.
- `minutes` est **optionnel** : seules les étapes d'attente en ont.

## Ce qu'il doit faire

- Une **première page** avec le titre, le sous-titre et la liste des
  ingrédients.
- Puis **une page par étape** : son emoji, « étape 3 sur 9 », son
  texte.
- Une étape qui porte `minutes` affiche un **minuteur** avec une jauge
  qui se remplit.
- Navigation : un bouton « Suivant » (« Terminé » à la dernière), un
  retour, des pastilles de progression, et le **balayage au doigt**.

## Ce qui ne va pas aujourd'hui, à mon avis

Le texte de l'étape flotte au milieu d'un grand vide. L'emoji dans un
rond vert plat fait pauvre. Les ingrédients sont des rectangles blancs
empilés sans rythme. Rien ne dit qu'on conserve une récolte plutôt
qu'on suit une recette de cuisine ordinaire. Et il n'y a aucun moment
de satisfaction à la dernière étape.

Mais je peux me tromper sur le diagnostic : **propose ta lecture avant
de dessiner.**

## Ce qui compte le plus

Quelqu'un debout, mains occupées, qui doit comprendre l'étape en cours
**en une seconde** depuis un plan de travail. La lisibilité à distance
prime sur tout le reste — y compris sur la densité d'information.

Montre-moi deux directions différentes avant d'en développer une.
