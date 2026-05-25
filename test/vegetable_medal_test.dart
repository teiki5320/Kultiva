import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/models/plantation.dart';
import 'package:kultiva/models/vegetable_medal.dart';

/// Helper pour créer une Plantation rapidement dans les tests.
Plantation _plant({
  required String vegId,
  DateTime? plantedAt,
  int harvests = 0,
  bool active = true,
}) {
  return Plantation(
    id: '${vegId}_${DateTime.now().microsecondsSinceEpoch}',
    vegetableId: vegId,
    plantedAt: plantedAt ?? DateTime.now(),
    harvestedAt: active ? null : DateTime.now(),
    harvestCount: harvests,
  );
}

void main() {
  group('MedalTier enum — valeurs et ordre', () {
    test('contient exactement 5 paliers', () {
      expect(MedalTier.values.length, 5);
    });

    test('les paliers sont dans l\'ordre attendu', () {
      expect(MedalTier.values, <MedalTier>[
        MedalTier.none,
        MedalTier.bronze,
        MedalTier.silver,
        MedalTier.gold,
        MedalTier.shiny,
      ]);
    });

    test('rank est strictement croissant de none à shiny', () {
      for (int i = 0; i < MedalTier.values.length - 1; i++) {
        expect(
          MedalTier.values[i].rank,
          lessThan(MedalTier.values[i + 1].rank),
          reason:
              '${MedalTier.values[i].name}.rank devrait être < '
              '${MedalTier.values[i + 1].name}.rank',
        );
      }
    });

    test('none a un rank de 0', () {
      expect(MedalTier.none.rank, 0);
    });

    test('shiny a le rank le plus élevé (4)', () {
      expect(MedalTier.shiny.rank, 4);
    });
  });

  group('MedalTier — emoji, label, color', () {
    test('none renvoie un emoji et label vides', () {
      expect(MedalTier.none.emoji, isEmpty);
      expect(MedalTier.none.label, isEmpty);
    });

    test('bronze a un emoji et label non vides', () {
      expect(MedalTier.bronze.emoji, '🥉');
      expect(MedalTier.bronze.label, 'Bronze');
    });

    test('silver a un emoji et label non vides', () {
      expect(MedalTier.silver.emoji, '🥈');
      expect(MedalTier.silver.label, 'Argent');
    });

    test('gold a un emoji et label non vides', () {
      expect(MedalTier.gold.emoji, '🥇');
      expect(MedalTier.gold.label, 'Or');
    });

    test('shiny a un emoji et label non vides', () {
      expect(MedalTier.shiny.emoji, '✨');
      expect(MedalTier.shiny.label, 'Shiny');
    });

    test('chaque palier actif (non-none) a un emoji unique', () {
      final activeTiers = MedalTier.values
          .where((t) => t != MedalTier.none)
          .toList();
      final emojis = activeTiers.map((t) => t.emoji).toSet();
      expect(emojis.length, activeTiers.length);
    });

    test('chaque palier actif a une couleur distincte', () {
      final activeTiers = MedalTier.values
          .where((t) => t != MedalTier.none)
          .toList();
      final colors = activeTiers.map((t) => t.color.value).toSet();
      expect(colors.length, activeTiers.length);
    });

    test('none a aussi une couleur (gris par défaut)', () {
      expect(MedalTier.none.color, isNotNull);
    });
  });

  group('computeMedalTier — seuils de palier', () {
    test('0 plantations = none', () {
      expect(computeMedalTier('tomate', <Plantation>[]), MedalTier.none);
    });

    test('1 plantation sans récolte = bronze', () {
      final plantations = [_plant(vegId: 'tomate', harvests: 0)];
      expect(computeMedalTier('tomate', plantations), MedalTier.bronze);
    });

    test('1 récolte = silver', () {
      final plantations = [_plant(vegId: 'tomate', harvests: 1)];
      expect(computeMedalTier('tomate', plantations), MedalTier.silver);
    });

    test('2 récoltes = silver (pas encore gold)', () {
      final plantations = [_plant(vegId: 'tomate', harvests: 2)];
      expect(computeMedalTier('tomate', plantations), MedalTier.silver);
    });

    test('3 récoltes cumulées = gold', () {
      final plantations = [_plant(vegId: 'tomate', harvests: 3)];
      expect(computeMedalTier('tomate', plantations), MedalTier.gold);
    });

    test('4 récoltes cumulées = gold (pas encore shiny)', () {
      final plantations = [_plant(vegId: 'tomate', harvests: 4)];
      expect(computeMedalTier('tomate', plantations), MedalTier.gold);
    });

    test('5 récoltes cumulées = shiny', () {
      final plantations = [_plant(vegId: 'tomate', harvests: 5)];
      expect(computeMedalTier('tomate', plantations), MedalTier.shiny);
    });

    test('récoltes réparties sur plusieurs plantations s\'additionnent', () {
      final plantations = [
        _plant(vegId: 'tomate', harvests: 2),
        _plant(vegId: 'tomate', harvests: 3),
      ];
      // 2 + 3 = 5 → shiny
      expect(computeMedalTier('tomate', plantations), MedalTier.shiny);
    });

    test('plantations dans 2 saisons = gold sans récolte', () {
      final plantations = [
        _plant(
          vegId: 'carotte',
          plantedAt: DateTime(2024, 1, 15), // hiver
          active: false,
        ),
        _plant(
          vegId: 'carotte',
          plantedAt: DateTime(2024, 7, 15), // été
          active: false,
        ),
      ];
      expect(computeMedalTier('carotte', plantations), MedalTier.gold);
    });

    test('plant actif >= 180 jours = shiny', () {
      final plantations = [
        _plant(
          vegId: 'tomate',
          plantedAt: DateTime.now().subtract(const Duration(days: 181)),
          active: true,
        ),
      ];
      expect(computeMedalTier('tomate', plantations), MedalTier.shiny);
    });

    test('plant terminé >= 180 jours ne donne PAS shiny par survie', () {
      final plantations = [
        _plant(
          vegId: 'tomate',
          plantedAt: DateTime.now().subtract(const Duration(days: 200)),
          active: false,
        ),
      ];
      // Terminé, donc pas isActive → la règle survie ne s'applique pas.
      // 0 récolte, 1 saison → bronze.
      expect(computeMedalTier('tomate', plantations), MedalTier.bronze);
    });

    test('les plantations d\'autres espèces sont ignorées', () {
      final plantations = [
        _plant(vegId: 'courgette', harvests: 10),
        _plant(vegId: 'carotte', harvests: 8),
      ];
      expect(computeMedalTier('tomate', plantations), MedalTier.none);
    });
  });

  group('computeAllMedals — map globale', () {
    test('retourne une entrée par espèce présente', () {
      final medals = computeAllMedals([
        _plant(vegId: 'tomate'),
        _plant(vegId: 'carotte', harvests: 1),
        _plant(vegId: 'tomate', harvests: 2),
      ]);
      expect(medals.length, 2);
      expect(medals.containsKey('tomate'), isTrue);
      expect(medals.containsKey('carotte'), isTrue);
    });

    test('espèce absente n\'apparaît pas dans la map', () {
      final medals = computeAllMedals([
        _plant(vegId: 'tomate'),
      ]);
      expect(medals.containsKey('courgette'), isFalse);
    });

    test('liste vide retourne une map vide', () {
      final medals = computeAllMedals(<Plantation>[]);
      expect(medals, isEmpty);
    });

    test('calcule le bon tier pour chaque espèce indépendamment', () {
      final medals = computeAllMedals([
        _plant(vegId: 'tomate', harvests: 5), // shiny
        _plant(vegId: 'carotte', harvests: 0), // bronze
        _plant(vegId: 'radis', harvests: 1), // silver
      ]);
      expect(medals['tomate'], MedalTier.shiny);
      expect(medals['carotte'], MedalTier.bronze);
      expect(medals['radis'], MedalTier.silver);
    });
  });
}
