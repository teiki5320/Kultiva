# Kultiva : Sentry ne parle qu'en release

> Texte déplacé tel quel depuis `CLAUDE.md` le 16 novembre 2026, pour alléger les consignes lues à chaque session. Rien n'a été réécrit.

## 🔭 Sentry ne parle qu'en release (02/11/2026)

**Ce qui s'est passé** : un débordement de 6 px vu sur un simulateur
pendant le développement a déclenché une alerte « New issue, level
fatal » dans la boîte mail de Jean, avec `environment: debug`.

**Pourquoi c'est un défaut de réglage et pas un incident** : une erreur
de mise en page qu'on est en train de corriger se voit déjà à l'écran,
en rayures jaunes. Elle est bruyante par nature en debug — chaque
contrainte trop serrée pendant un remaniement en produit une. Noyer les
vraies alertes sous les siennes, c'est apprendre à ne plus les lire.

**Le filtre `beforeSend` a été remplacé le 03/11/2026 par une garde
plus haut**, dans `main()` : en debug, Sentry n'est **pas initialisé du
tout**, et `_bootstrapAndRun()` est appelé directement.

```dart
if (!kReleaseMode) {
  await _bootstrapAndRun();
  return;
}
```

**Pourquoi** : le filtre rejetait déjà tout en debug, donc le SDK natif
n'y faisait que coûter — et il coûtait cher. Mesuré sur un **iPad Pro
13″ en simulateur** : plus de **deux minutes** de splash, processus
vivant à 0 % de CPU. Un `sample` du processus a montré le fil principal
bloqué dans `objc_copyClassList` → `realizeAllClasses` → **CloudKit**,
c'est-à-dire le balayage de classes que fait Sentry pour instrumenter
les contrôleurs de vue. Sans Sentry, le même build dessine en **20 s**.

⚠️ **Et ce n'est pas un défaut de l'app livrée.** Le même commit
compilé en **release** dessine le tableau de bord en **moins de 4 s**
sur le même iPad, Sentry compris. Le blocage est propre au debug
(JIT + simulateur). Ne pas le citer comme un bug utilisateur.

⚠️ **Conséquence à connaître** : un plantage survenu pendant un
`flutter run` ne remonte plus à Sentry — et il n'y a plus de zone
surveillée du tout en debug. C'est voulu : il est déjà dans la console,
avec sa pile d'appels. Pour tester Sentry lui-même, il faut un build
release.
