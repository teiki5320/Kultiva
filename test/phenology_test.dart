import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/models/culture_entry.dart';
import 'package:kultiva/models/vegetable.dart';
import 'package:kultiva/utils/phenology.dart';

void main() {
  // Légumes synthétiques pour tester sans dépendre du catalogue.
  const tomato = Vegetable(
    id: 'tomate',
    name: 'Tomate',
    emoji: '🍅',
    category: VegetableCategory.fruits,
    germinationDays: '6 à 10 jours',
  );

  const lettuce = Vegetable(
    id: 'salade',
    name: 'Salade',
    emoji: '🥬',
    category: VegetableCategory.leaves,
    germinationDays: '7 à 14 jours',
  );

  const carrot = Vegetable(
    id: 'carotte',
    name: 'Carotte',
    emoji: '🥕',
    category: VegetableCategory.roots,
    germinationDays: '10 à 20 jours',
  );

  const accessory = Vegetable(
    id: 'acc_seau',
    name: 'Seau',
    emoji: '🪣',
    category: VegetableCategory.accessories,
  );

  group('deducedPhase', () {
    test('semis pour un plant juste planté', () {
      expect(deducedPhase(tomato, 0), GrowthPhase.seedling);
      expect(deducedPhase(lettuce, 5), GrowthPhase.seedling);
    });

    test('semis tant qu\'on est dans germMax + 7 jours', () {
      // Tomate : germMax = 10, donc 17j = limite supérieure.
      expect(deducedPhase(tomato, 16), GrowthPhase.seedling);
      expect(deducedPhase(tomato, 17), isNot(GrowthPhase.seedling));
    });

    test('croissance végétative pour un plant moyennement avancé', () {
      // Tomate : harvestStart fruits = 65, -14 = 51.
      // À 30 jours on est en végétative.
      expect(deducedPhase(tomato, 30), GrowthPhase.vegetative);
    });

    test('floraison pour un fruit proche de la récolte', () {
      // Tomate : harvestStart fruits = 65, on est en floraison entre
      // 51 et 65.
      expect(deducedPhase(tomato, 60), GrowthPhase.flowering);
    });

    test('fructification après la récolte attendue', () {
      // Tomate : harvestStart fruits = 65, on est en fructification dès 65.
      expect(deducedPhase(tomato, 70), GrowthPhase.fruiting);
      expect(deducedPhase(tomato, 90), GrowthPhase.fruiting);
    });

    test('feuilles / aromates / racines : pas de floraison ni fructification',
        () {
      // Salade harvestStart leaves = 35.
      expect(deducedPhase(lettuce, 30), GrowthPhase.vegetative);
      expect(deducedPhase(lettuce, 40), GrowthPhase.vegetative);

      // Carotte harvestStart roots = 65.
      expect(deducedPhase(carrot, 30), GrowthPhase.vegetative);
      expect(deducedPhase(carrot, 80), GrowthPhase.vegetative);
    });

    test('accessoires renvoient toujours seedling (no-op)', () {
      expect(deducedPhase(accessory, 0), GrowthPhase.seedling);
      expect(deducedPhase(accessory, 1000), GrowthPhase.seedling);
    });
  });

  group('expectedStage', () {
    test('null pour les accessoires', () {
      expect(expectedStage(accessory, 0), isNull);
    });

    test('Germination tant qu\'on est sous germMax', () {
      final hint = expectedStage(tomato, 5);
      expect(hint, isNotNull);
      expect(hint!.label, contains('Germination'));
    });

    test('Plantule juste après la germination', () {
      // Tomate germMax = 10, plantule jusqu\'à 20.
      final hint = expectedStage(tomato, 12);
      expect(hint, isNotNull);
      expect(hint!.label, 'Plantule');
    });

    test('Récolte attendue après harvestStart', () {
      // Tomate harvestStart = 65.
      final hint = expectedStage(tomato, 70);
      expect(hint, isNotNull);
      expect(hint!.label, 'Récolte attendue');
    });

    test('Cycle terminé après harvestEnd (= harvestStart + 60)', () {
      final hint = expectedStage(tomato, 200);
      expect(hint, isNotNull);
      expect(hint!.label, 'Cycle terminé');
    });
  });
}
