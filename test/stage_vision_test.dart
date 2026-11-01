import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/models/culture_entry.dart';
import 'package:kultiva/models/stage_hypothesis.dart';
import 'package:kultiva/services/stage_vision.dart';

void main() {
  group('StageVision.read — lecture des étiquettes', () {
    test('aucune étiquette : rien vu', () {
      final h = StageVision.read(const <ImageLabel>[]);
      expect(h.plantSeen, isFalse);
      expect(h.compatible, isEmpty);
    });

    test('des étiquettes sans rapport : rien vu', () {
      final h = StageVision.read(const <ImageLabel>[
        ImageLabel('Person', 0.95),
        ImageLabel('Car', 0.88),
      ]);
      expect(h.plantSeen, isFalse);
    });

    test('un fruit : fructification seule', () {
      final h = StageVision.read(const <ImageLabel>[ImageLabel('Fruit', 0.82)]);
      expect(h.compatible, <GrowthPhase>{GrowthPhase.fruiting});
      expect(h.seen, 'un fruit');
      expect(h.confidence, closeTo(0.82, 0.001));
    });

    test('une fleur : floraison seule', () {
      final h =
          StageVision.read(const <ImageLabel>[ImageLabel('Flower', 0.77)]);
      expect(h.compatible, <GrowthPhase>{GrowthPhase.flowering});
      expect(h.seen, 'une fleur');
    });

    test('du feuillage : deux stades, parce que le modèle ne sait pas '
        'distinguer une plantule d\'un plant adulte', () {
      final h = StageVision.read(const <ImageLabel>[ImageLabel('Leaf', 0.91)]);
      expect(h.compatible, <GrowthPhase>{
        GrowthPhase.seedling,
        GrowthPhase.vegetative,
      });
      expect(h.seen, 'du feuillage');
      expect(h.indecis, isFalse);
    });

    test('le signal le plus avancé gagne : un plant qui fructifie porte '
        'encore feuilles et fleurs', () {
      final h = StageVision.read(const <ImageLabel>[
        ImageLabel('Leaf', 0.96),
        ImageLabel('Flower', 0.90),
        ImageLabel('Fruit', 0.65),
      ]);
      expect(h.compatible, <GrowthPhase>{GrowthPhase.fruiting});
    });

    test('la fleur passe devant le feuillage', () {
      final h = StageVision.read(const <ImageLabel>[
        ImageLabel('Plant', 0.98),
        ImageLabel('Petal', 0.71),
      ]);
      expect(h.compatible, <GrowthPhase>{GrowthPhase.flowering});
    });

    test('un contexte de jardin seul : une plante, mais stade illisible', () {
      final h =
          StageVision.read(const <ImageLabel>[ImageLabel('Flowerpot', 0.64)]);
      expect(h.indecis, isTrue);
      expect(h.compatible.length, GrowthPhase.values.length);
    });

    test('sous le seuil, une étiquette de stade ne décide de rien', () {
      final h = StageVision.read(const <ImageLabel>[ImageLabel('Fruit', 0.41)]);
      expect(h.plantSeen, isFalse);
    });

    test('casse et espaces ignorés', () {
      final h =
          StageVision.read(const <ImageLabel>[ImageLabel('  FLOWER ', 0.80)]);
      expect(h.compatible, <GrowthPhase>{GrowthPhase.flowering});
    });

    test('les étiquettes retenues sont celles au-dessus du seuil de '
        'contexte', () {
      final h = StageVision.read(const <ImageLabel>[
        ImageLabel('Fruit', 0.82),
        ImageLabel('Bruit', 0.12),
      ]);
      expect(h.labels.length, 1);
      expect(h.labels.first.label, 'Fruit');
    });
  });

  group('StageVision.reconcile — croisement avec la date', () {
    VisionReading lire(List<ImageLabel> labels, GrowthPhase attendu) {
      return StageVision.reconcile(
        hypothesis: StageVision.read(labels),
        attendu: attendu,
      );
    }

    test('rien vu : la date garde la main, et on le dit', () {
      final r = lire(const <ImageLabel>[ImageLabel('Sky', 0.9)],
          GrowthPhase.vegetative);
      expect(r.verdict, VisionVerdict.pasDePlante);
      expect(r.suggere, isNull);
      expect(r.actionnable, isFalse);
    });

    test('du feuillage sur un semis récent : accord', () {
      final r =
          lire(const <ImageLabel>[ImageLabel('Leaf', 0.9)], GrowthPhase.seedling);
      expect(r.verdict, VisionVerdict.accord);
    });

    test('du feuillage sur un plant en croissance : accord aussi — les '
        'deux stades sont compatibles', () {
      final r = lire(
          const <ImageLabel>[ImageLabel('Leaf', 0.9)], GrowthPhase.vegetative);
      expect(r.verdict, VisionVerdict.accord);
    });

    test('un fruit quand la date dit floraison : suggestion du voisin', () {
      final r =
          lire(const <ImageLabel>[ImageLabel('Fruit', 0.8)], GrowthPhase.flowering);
      expect(r.verdict, VisionVerdict.suggestion);
      expect(r.suggere, GrowthPhase.fruiting);
      expect(r.actionnable, isTrue);
    });

    test('un fruit sur un plant tout juste semé : désaccord, pas '
        'suggestion — c\'est peut-être une photo de légume acheté', () {
      final r =
          lire(const <ImageLabel>[ImageLabel('Fruit', 0.9)], GrowthPhase.seedling);
      expect(r.verdict, VisionVerdict.desaccord);
      expect(r.suggere, GrowthPhase.fruiting);
      expect(r.phrase, contains('autre sujet'));
    });

    test('du feuillage quand la date annonce la fructification : '
        'désaccord', () {
      final r =
          lire(const <ImageLabel>[ImageLabel('Leaf', 0.9)], GrowthPhase.fruiting);
      expect(r.verdict, VisionVerdict.desaccord);
      // Le plus proche des deux stades lus, pas le premier venu.
      expect(r.suggere, GrowthPhase.vegetative);
    });

    test('contexte seul : rien à proposer', () {
      final r =
          lire(const <ImageLabel>[ImageLabel('Garden', 0.7)], GrowthPhase.flowering);
      expect(r.verdict, VisionVerdict.indecis);
      expect(r.actionnable, isFalse);
    });

    test('une phrase est toujours disponible, quel que soit le verdict', () {
      for (final attendu in GrowthPhase.values) {
        for (final labels in <List<ImageLabel>>[
          const <ImageLabel>[],
          const <ImageLabel>[ImageLabel('Fruit', 0.9)],
          const <ImageLabel>[ImageLabel('Flower', 0.9)],
          const <ImageLabel>[ImageLabel('Leaf', 0.9)],
          const <ImageLabel>[ImageLabel('Garden', 0.7)],
        ]) {
          final r = lire(labels, attendu);
          expect(r.phrase.trim(), isNotEmpty);
        }
      }
    });
  });
}
