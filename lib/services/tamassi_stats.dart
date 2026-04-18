import 'prefs_service.dart';

/// Toutes les stats utiles pour le système de badges Tamassi.
/// Stockées sous forme de valeurs simples dans SharedPreferences via
/// [PrefsService.getString] / setString, cast en int quand nécessaire.
///
/// Écrire avec les helpers `increment*` / `record*` ci-dessous, lire
/// en construisant un [TamassiStats] via [TamassiStats.load()].
class TamassiStats {
  // Counters cumulés.
  final int waterCount;
  final int fertilizeCount;
  final int petCount;
  final int challengesCompletedCount;
  final int visitsSeen;
  final int morningLogins;
  final int nightLogins;
  final int rainLogins;
  final int snowLogins;
  final int sunnyLogins;

  // Plus grande streak atteinte.
  final int maxStreak;

  // Ensembles (stockés en CSV).
  final Set<String> tabsVisited;
  final Set<String> seasonsLoggedIn; // "spring"/"summer"/"autumn"/"winter"
  final Set<String> animalsSeen;
  final Set<String> completedChallengeIds;

  // Flags ponctuels.
  final bool named; // le Tamassi a un nom

  const TamassiStats({
    required this.waterCount,
    required this.fertilizeCount,
    required this.petCount,
    required this.challengesCompletedCount,
    required this.visitsSeen,
    required this.morningLogins,
    required this.nightLogins,
    required this.rainLogins,
    required this.snowLogins,
    required this.sunnyLogins,
    required this.maxStreak,
    required this.tabsVisited,
    required this.seasonsLoggedIn,
    required this.animalsSeen,
    required this.completedChallengeIds,
    required this.named,
  });

  factory TamassiStats.load() {
    final p = PrefsService.instance;
    int readInt(String key) =>
        int.tryParse(p.getString('tamassi.stats.$key') ?? '') ?? 0;
    Set<String> readSet(String key) {
      final raw = p.getString('tamassi.stats.$key') ?? '';
      return raw.split(',').where((s) => s.isNotEmpty).toSet();
    }

    final name = p.getString('kultiva.creature.name') ?? '';
    return TamassiStats(
      waterCount: readInt('water'),
      fertilizeCount: readInt('fertilize'),
      petCount: readInt('pet'),
      challengesCompletedCount: readSet('completed_challenges').length,
      visitsSeen: readInt('visits'),
      morningLogins: readInt('morning'),
      nightLogins: readInt('night'),
      rainLogins: readInt('rain'),
      snowLogins: readInt('snow'),
      sunnyLogins: readInt('sunny'),
      maxStreak:
          int.tryParse(p.getString('kultiva.creature.streak') ?? '') ?? 0,
      tabsVisited: readSet('tabs'),
      seasonsLoggedIn: readSet('seasons'),
      animalsSeen: readSet('animals'),
      completedChallengeIds: readSet('completed_challenges'),
      named: name.trim().isNotEmpty,
    );
  }

  // ══════════════════════════════════════════════════════════════════
  // Helpers d'écriture (statiques pour éviter de tout reconstruire).
  // ══════════════════════════════════════════════════════════════════

  static Future<void> incrementInt(String key, {int by = 1}) async {
    final p = PrefsService.instance;
    final cur = int.tryParse(p.getString('tamassi.stats.$key') ?? '') ?? 0;
    await p.setString('tamassi.stats.$key', (cur + by).toString());
  }

  static Future<void> addToSet(String key, String value) async {
    if (value.isEmpty) return;
    final p = PrefsService.instance;
    final raw = p.getString('tamassi.stats.$key') ?? '';
    final set = raw.split(',').where((s) => s.isNotEmpty).toSet();
    set.add(value);
    await p.setString('tamassi.stats.$key', set.join(','));
  }

  /// À appeler quand l'utilisateur arrive sur un onglet du Poussidex.
  static Future<void> recordTab(String tab) => addToSet('tabs', tab);

  /// À appeler à l'ouverture de l'onglet Poussidex — enregistre la plage
  /// horaire (matin / nuit) et la saison courante.
  static Future<void> recordLogin() async {
    final now = DateTime.now();
    // Tranches horaires.
    if (now.hour >= 6 && now.hour < 9) {
      await incrementInt('morning');
    } else if (now.hour >= 22 || now.hour < 2) {
      await incrementInt('night');
    }
    // Saison.
    final season = switch (now.month) {
      3 || 4 || 5 => 'spring',
      6 || 7 || 8 => 'summer',
      9 || 10 || 11 => 'autumn',
      _ => 'winter',
    };
    await addToSet('seasons', season);
  }

  /// Enregistre le code météo courant sous la bonne catégorie.
  static Future<void> recordWeather(int code) async {
    if (code == 0 || code == 1) {
      await incrementInt('sunny');
    } else if ((code >= 51 && code <= 67) || (code >= 80 && code <= 82)) {
      await incrementInt('rain');
    } else if (code >= 71 && code <= 77) {
      await incrementInt('snow');
    }
  }
}
