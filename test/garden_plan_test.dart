import 'package:flutter_test/flutter_test.dart';

import 'package:kultiva/models/garden_plan.dart';

void main() {
  group('GardenPlan', () {
    test('crée une grille vide avec dimensions correctes', () {
      final plan = GardenPlan(
        id: 'p1',
        name: 'Jardin test',
        cols: 4,
        rows: 4,
        createdAt: DateTime(2026, 4, 27),
        updatedAt: DateTime(2026, 4, 27),
      );
      expect(plan.cols, 4);
      expect(plan.rows, 4);
      expect(plan.cells, isEmpty);
      expect(plan.widthCm, 120);
      expect(plan.heightCm, 120);
      expect(plan.areaSqMeters, closeTo(1.44, 0.01));
    });

    test('withCell ajoute, modifie et supprime des cases', () {
      var plan = GardenPlan(
        id: 'p1',
        name: 'Jardin',
        cols: 4,
        rows: 4,
        createdAt: DateTime(2026, 4, 27),
        updatedAt: DateTime(2026, 4, 27),
      );

      // Ajout
      final cell = PlannedCell(
        col: 1,
        row: 2,
        vegetableId: 'tomate',
        count: 1,
        plantedAt: DateTime(2026, 4, 27),
      );
      plan = plan.withCell(1, 2, cell);
      expect(plan.cells.length, 1);
      expect(plan.cellAt(1, 2)?.vegetableId, 'tomate');

      // Suppression
      plan = plan.withCell(1, 2, null);
      expect(plan.cells, isEmpty);
    });

    test('sérialisation JSON aller-retour', () {
      final original = GardenPlan(
        id: 'p1',
        name: 'Jardin 1',
        location: 'Nantes',
        cols: 3,
        rows: 3,
        unit: GardenUnit.cm,
        createdAt: DateTime(2026, 4, 27, 10, 0),
        updatedAt: DateTime(2026, 4, 27, 12, 30),
      ).withCell(
        0,
        0,
        PlannedCell(
          col: 0,
          row: 0,
          vegetableId: 'carotte',
          count: 9,
          plantedAt: DateTime(2026, 4, 27),
        ),
      );

      final json = original.toJsonString();
      final restored = GardenPlan.fromJsonString(json);

      expect(restored.id, original.id);
      expect(restored.name, original.name);
      expect(restored.location, original.location);
      expect(restored.cols, original.cols);
      expect(restored.rows, original.rows);
      expect(restored.cellAt(0, 0)?.vegetableId, 'carotte');
      expect(restored.cellAt(0, 0)?.count, 9);
    });

    test("PlannedCell.copyWith permet de changer le nombre", () {
      final cell = PlannedCell(
        col: 0,
        row: 0,
        vegetableId: 'radis',
        count: 16,
        plantedAt: DateTime(2026, 4, 27),
      );
      final updated = cell.copyWith(count: 8);
      expect(updated.count, 8);
      expect(updated.vegetableId, 'radis');
      expect(updated.col, 0);
    });
  });
}
