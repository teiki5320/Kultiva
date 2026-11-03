import '../data/companions.dart';
import '../data/content_i18n.dart';
import '../data/diseases.dart';
import '../data/names_en.dart';
import '../data/rotation.dart';
import '../data/ui_i18n.dart';
import '../data/vegetables_base.dart';
import '../models/region_data.dart';
import '../models/vegetable.dart';

/// Le conseil du jour du tableau de bord, composé **sur les cultures
/// d'ici** : compagnonnage, rotation, maladies.
///
/// ⚠️ **Pourquoi ce fichier existe.** Le conseil vivait dans l'état de
/// `SowScreen`, donc aucun test ne pouvait l'atteindre — et il portait
/// le même défaut que le légume du jour : il piochait dans les 130
/// cultures sans regarder le calendrier. Vu à l'écran le 03/11/2026 sur
/// une installation française : « 🍌 Bananier plantain adore pousser à
/// côté de 🟤 Taro ! ». Trouvé une heure après la correction du légume
/// du jour, sur le même écran, parce que la règle était écrite dans une
/// fonction au lieu d'être nommée.
///
/// ⚠️ **Pour le compagnonnage, les deux doivent pousser ici.** Un
/// conseil qui envoie planter une tomate à côté d'un taro ne sert pas
/// davantage que l'inverse.
///
/// Déterministe : le même jour donne le même conseil à tous ceux qui
/// jardinent sous le même calendrier.
String conseilDuJour(DateTime jour, List<RegionData> calendar) {
  final conseils = conseilsPossibles(calendar);
  // Un calendrier inconnu ne doit pas faire planter l'accueil sur une
  // division par zéro.
  if (conseils.isEmpty) return trUi('Prends le temps de regarder ton jardin.');
  final dayOfYear = jour.difference(DateTime(jour.year)).inDays;
  return conseils[dayOfYear % conseils.length];
}

/// Tous les conseils que ce calendrier autorise, dans l'ordre où le
/// tirage les parcourt. Exposé pour que les tests puissent les lire
/// tous plutôt qu'un par jour.
List<String> conseilsPossibles(List<RegionData> calendar) {
  final ici = cultivablesEnPleineTerre(calendar);
  Vegetable? dIci(String id) => ici.contains(id)
      ? vegetablesBase.where((v) => v.id == id).firstOrNull
      : null;

  final conseils = <String>[];

  for (final entry in companionMap.entries) {
    final veg = dIci(entry.key);
    final comp = entry.value.isNotEmpty ? dIci(entry.value.first) : null;
    if (veg != null && comp != null) {
      conseils.add(trUiArgs('{0} {1} adore pousser à côté de {2} {3} !',
          <Object?>[veg.emoji, veg.displayName, comp.emoji, comp.displayName]));
    }
  }

  for (final entry in rotationMap.entries) {
    final veg = dIci(entry.key);
    if (veg != null) {
      conseils.add(trUiArgs(
          '{0} {1} : attendre {2} ans avant de replanter au même endroit.',
          <Object?>[veg.emoji, veg.displayName, entry.value.waitYears]));
    }
  }

  for (final entry in diseaseMap.entries) {
    final veg = dIci(entry.key);
    if (veg != null && entry.value.isNotEmpty) {
      final d = entry.value.first;
      // ⚠️ « attention au {2} » ne se dit en français que pour un nom
      // masculin à initiale consonne. Mesuré sur les 36 maladies
      // citées en France, c'est juste 8 fois : les autres sont
      // féminines (« à la piéride »), commencent par une voyelle
      // (« à l'oïdium ») ou sont au pluriel (« aux pucerons »). Le
      // tiret se passe du genre, et l'anglais comme l'espagnol s'en
      // accommodent aussi bien que de leur préposition.
      conseils.add(trUiArgs('{0} {1} — {2} : {3}.', <Object?>[
        veg.emoji,
        veg.displayName,
        d.displayName,
        d.displayRemedy
      ]));
    }
  }

  return conseils;
}

/// Les cultures qu'un conseil met en avant ce jour-là.
///
/// Les conseils sont des phrases composées : pour vérifier qu'aucune
/// culture étrangère au calendrier n'y apparaît, un test a besoin des
/// identifiants, pas du texte. Les rendre ici évite de relire la phrase
/// à l'envers avec une expression régulière.
Set<String> culturesCiteesParLesConseils(List<RegionData> calendar) {
  final ici = cultivablesEnPleineTerre(calendar);
  final citees = <String>{};
  for (final entry in companionMap.entries) {
    if (!ici.contains(entry.key)) continue;
    if (entry.value.isEmpty || !ici.contains(entry.value.first)) continue;
    citees.add(entry.key);
    citees.add(entry.value.first);
  }
  for (final entry in rotationMap.entries) {
    if (ici.contains(entry.key)) citees.add(entry.key);
  }
  for (final entry in diseaseMap.entries) {
    if (entry.value.isNotEmpty && ici.contains(entry.key)) citees.add(entry.key);
  }
  return citees;
}
