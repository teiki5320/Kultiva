import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/regions/france.dart';
import 'package:kultiva/data/regions/regional_calendar.dart';
import 'package:kultiva/data/regions/temperate_zones.dart';
import 'package:kultiva/data/regions/zone_shift.dart';
import 'package:kultiva/models/region_data.dart';
import 'package:kultiva/models/country.dart';

/// Les calendriers méditerranéen, continental et subtropical écrits à
/// la main.
///
/// Ils corrigent la dérivation là où elle se trompe. Trois choses à
/// garder vraies :
///
/// 1. **ils parlent de cultures qui existent** — une clé inventée
///    serait un calendrier que personne ne verrait jamais ;
/// 2. **ils disent autre chose que la dérivation** — une surcharge
///    identique au décalage est du bruit, et une occasion de plus de
///    diverger ;
/// 3. **ils ne contredisent pas le climat** — pas de semis en pleine
///    terre en janvier en Pologne, pas de salade en plein août à
///    Séville.
void main() {
  final idsFrance = <String>{
    for (final r in franceData) r.vegetableId,
  };

  /// Les mois où le sol est gelé en climat continental. Semer dehors
  /// ou récolter à ces dates n'a pas de sens.
  const gel = <int>{12, 1, 2};

  /// Les mois où rien de tendre ne pousse en climat méditerranéen :
  /// une laitue y monte en graine avant de pommer.
  const canicule = <int>{7, 8};

  group('les trois calendriers écrits', () {
    final tous = <String, Map<String, ZoneCalendar>>{
      'méditerranéen': mediterraneanCalendar,
      'continental': continentalCalendar,
      'subtropical': subtropicalCalendar,
    };

    test('ne parlent que de cultures du catalogue', () {
      tous.forEach((nom, cal) {
        for (final id in cal.keys) {
          expect(idsFrance.contains(id), isTrue,
              reason: 'Le calendrier $nom décrit « $id », qui n\'est '
                  'pas dans le calendrier français. Faute de frappe ?');
        }
      });
    });

    test('ont des mois valides et non vides', () {
      tous.forEach((nom, cal) {
        cal.forEach((id, c) {
          expect(c.sowing, isNotEmpty, reason: '$nom · $id : pas de semis.');
          expect(c.harvest, isNotEmpty,
              reason: '$nom · $id : pas de récolte.');
          for (final m in <int>[...c.sowing, ...c.harvest]) {
            expect(m, inInclusiveRange(1, 12),
                reason: '$nom · $id : mois $m hors de 1..12.');
          }
          expect(c.sowing.toSet().length, c.sowing.length,
              reason: '$nom · $id : un mois de semis en double.');
          expect(c.harvest.toSet().length, c.harvest.length,
              reason: '$nom · $id : un mois de récolte en double.');
        });
      });
    });

    test('portent tous une note qui explique l\'écart', () {
      // Un jardinier français installé en Espagne qui voit « semer la
      // laitue en octobre » croit à une erreur. La note est ce qui
      // transforme la surprise en conseil.
      tous.forEach((nom, cal) {
        cal.forEach((id, c) {
          expect(c.note.length, greaterThan(40),
              reason: '$nom · $id : note trop courte pour expliquer.');
        });
      });
    });

    test('disent autre chose que la dérivation', () {
      // Une surcharge identique au simple décalage ne sert à rien et
      // crée un deuxième endroit où se tromper.
      //
      // ⚠️ Les trois zones ne se dérivent pas pareil : un décalage
      // d'un mois pour les deux premières, un **élargissement** des
      // deux côtés pour la subtropicale. Comparer à la mauvaise
      // formule laisserait passer une surcharge inutile.
      List<int> deriveSemis(ClimateZone z, List<int> base) =>
          z == ClimateZone.subtropical
              ? (<int>{...base, ...shiftMonths(base, -1)}.toList()..sort())
              : shiftMonths(base, z == ClimateZone.mediterranean ? -1 : 1);
      List<int> deriveRecolte(ClimateZone z, List<int> base) =>
          z == ClimateZone.subtropical
              ? (<int>{...base, ...shiftMonths(base, 1)}.toList()..sort())
              : shiftMonths(base, z == ClimateZone.mediterranean ? -1 : 1);

      for (final entree in <MapEntry<ClimateZone, Map<String, ZoneCalendar>>>[
        const MapEntry(ClimateZone.mediterranean, mediterraneanCalendar),
        const MapEntry(ClimateZone.continental, continentalCalendar),
        const MapEntry(ClimateZone.subtropical, subtropicalCalendar),
      ]) {
        for (final r in franceData) {
          final c = entree.value[r.vegetableId];
          if (c == null) continue;
          final attenduSemis = deriveSemis(entree.key, r.sowingMonths);
          final attenduRecolte = deriveRecolte(entree.key, r.harvestMonths);
          final identique =
              (c.sowing.toList()..sort()).join(',') == attenduSemis.join(',') &&
                  (c.harvest.toList()..sort()).join(',') ==
                      attenduRecolte.join(',');
          expect(identique, isFalse,
              reason: '${entree.key.name} · ${r.vegetableId} : la '
                  'surcharge dit exactement ce que la dérivation '
                  'dirait. Retire-la, ou corrige-la.');
        }
      }
    });
  });

  group('le climat méditerranéen', () {
    test('ne sème pas de salade en plein été', () {
      // La correction qui justifie tout le fichier : un décalage d'un
      // mois laissait semer la laitue en juillet, où elle monte en
      // graine avant de pommer.
      for (final id in <String>['laitue', 'epinard', 'mache', 'roquette']) {
        final c = mediterraneanCalendar[id];
        expect(c, isNotNull, reason: '$id devrait être corrigé.');
        for (final m in c!.sowing) {
          expect(canicule.contains(m), isFalse,
              reason: '$id : semis en mois $m, en pleine canicule.');
        }
      }
    });

    test('sème les légumineuses à l\'automne', () {
      for (final id in <String>['feve', 'petit_pois', 'pois_mange_tout']) {
        final c = mediterraneanCalendar[id]!;
        expect(c.sowing.any((m) => m >= 10 || m <= 1), isTrue,
            reason: '$id : rien de semé entre octobre et janvier.');
      }
    });

    test('allonge la saison des légumes de chaleur', () {
      final tomate = mediterraneanCalendar['tomate']!;
      final fr = franceData.firstWhere((r) => r.vegetableId == 'tomate');
      expect(tomate.harvest.length, greaterThan(fr.harvestMonths.length),
          reason: 'La tomate produit plus longtemps qu\'en France.');
      expect(tomate.sowing.first, lessThanOrEqualTo(2),
          reason: 'Elle démarre dès janvier ou février.');
    });
  });

  group('le climat subtropical humide', () {
    /// Juin à août : chaud **et** humide. Une salade y monte en graine
    /// ou pourrit du collet.
    const eteLourd = <int>{6, 7, 8};

    test('ne sème pas de salade dans l\'été lourd', () {
      for (final id in <String>[
        'laitue',
        'epinard',
        'mache',
        'roquette',
        'cresson',
      ]) {
        final c = subtropicalCalendar[id];
        expect(c, isNotNull, reason: '$id devrait être corrigé.');
        for (final m in c!.sowing) {
          expect(eteLourd.contains(m), isFalse,
              reason: '$id : semis en mois $m, dans l\'été lourd.');
        }
      }
    });

    test('sème deux fois ce qui encadre le creux humide', () {
      // La signature de cette zone, et ce qui la distingue du
      // méditerranéen : une récolte de printemps **et** une
      // d'automne, de part et d'autre de juillet-août.
      for (final id in <String>[
        'tomate',
        'courgette',
        'concombre',
        'mais',
        'pomme_de_terre',
      ]) {
        final c = subtropicalCalendar[id]!;
        expect(c.sowing.any((m) => m <= 5), isTrue,
            reason: '$id : aucun semis de printemps.');
        expect(c.sowing.any((m) => m >= 6), isTrue,
            reason: '$id : aucun semis de fin d\'été.');
      }
    });

    test('laisse les légumes de chaleur traverser l\'été', () {
      for (final id in <String>[
        'gombo',
        'patate_douce',
        'niebe',
        'pasteque',
        'aubergine',
      ]) {
        final c = subtropicalCalendar[id]!;
        expect(c.harvest.any(eteLourd.contains), isTrue,
            reason: '$id : rien récolté entre juin et août, alors que '
                'c\'est sa saison.');
      }
    });

    test('sème les légumineuses d\'hiver à l\'automne', () {
      for (final id in <String>['feve', 'petit_pois', 'pois_mange_tout']) {
        final c = subtropicalCalendar[id]!;
        expect(c.sowing.every((m) => m >= 9 || m <= 1), isTrue,
            reason: '$id : un semis hors de la fenêtre d\'automne.');
      }
    });

    test('mène la fraise en annuelle d\'automne', () {
      // Un pied laissé en place ne passe pas l'été humide : on plante
      // à l'automne, on récolte l'hiver, on arrache.
      final c = subtropicalCalendar['fraise']!;
      expect(c.sowing.every((m) => m == 9 || m == 10), isTrue,
          reason: 'la fraise se plante à l\'automne, pas ailleurs.');
      expect(c.harvest.any(<int>{12, 1, 2}.contains), isTrue,
          reason: 'aucune récolte en hiver, qui est pourtant sa saison.');
    });

    test('se retourne pour l\'Argentine, qui est au sud', () {
      // Une tomate semée en janvier dans l'hémisphère nord se sème en
      // juillet à Buenos Aires. C'est le cas qui a motivé la
      // vérification des 73 pays le 02/11.
      final base = franceData.firstWhere((r) => r.vegetableId == 'tomate');
      final nord = deriveTemperate(base, ClimateZone.subtropical);
      final sud = deriveTemperate(base, ClimateZone.subtropical,
          hemisphere: Hemisphere.south);
      expect(nord.sowingMonths, <int>[1, 2, 6, 7]);
      expect(sud.sowingMonths, <int>[1, 7, 8, 12]);
      expect(sud.regionalNote, contains('hémisphère sud'));
    });
  });

  group('le climat continental', () {
    test('ne sème rien **dehors** pendant le gel', () {
      continentalCalendar.forEach((id, c) {
        // Deux exceptions, toutes deux voulues et dites par la note :
        //  — l'ail, parce que c'est le froid qui déclenche la
        //    formation des gousses ;
        //  — les semis à l'abri, en godet sur un rebord de fenêtre.
        //    Un poivron se sème bien en février en Pologne, mais
        //    jamais en pleine terre.
        if (id == 'ail') return;
        if (c.note.contains('à l\'abri')) return;
        for (final m in c.sowing) {
          expect(gel.contains(m), isFalse,
              reason: '$id : semis en mois $m, sol gelé — et sa note '
                  'ne dit pas que c\'est un semis à l\'abri.');
        }
      });
    });

    test('dit « à l\'abri » pour tout semis d\'hiver', () {
      // La réciproque du test précédent : si une culture se sème
      // pendant le gel, le jardinier doit lire pourquoi.
      continentalCalendar.forEach((id, c) {
        if (id == 'ail') return;
        if (c.sowing.any(gel.contains)) {
          expect(c.note, contains('abri'),
              reason: '$id se sème en mois gelé sans que sa note '
                  'explique qu\'il faut le démarrer à couvert.');
        }
      });
    });

    test('ne récolte rien sous la neige', () {
      continentalCalendar.forEach((id, c) {
        for (final m in c.harvest) {
          expect(gel.contains(m), isFalse,
              reason: '$id : récolte en mois $m, sol gelé. En France '
                  'cette culture passe l\'hiver en terre ; ici elle '
                  'doit être arrachée avant les gelées.');
        }
      });
    });

    test('arrache le poireau avant l\'hiver', () {
      // En France il se récolte de septembre à mars. Ici, non.
      final c = continentalCalendar['poireau']!;
      expect(c.harvest.every((m) => m >= 8 && m <= 11), isTrue);
      expect(c.note, contains('gèle'));
    });

    test('garde l\'ail en plantation d\'automne', () {
      final c = continentalCalendar['ail']!;
      expect(c.sowing.any((m) => m >= 9 && m <= 11), isTrue,
          reason: 'C\'est le froid qui fait diviser la tête d\'ail.');
    });
  });

  group('le calendrier composé', () {
    test('sert le calendrier écrit quand il existe', () {
      final med = regionalCalendar(Region.france,
          zone: ClimateZone.mediterranean);
      final laitue = med.firstWhere((r) => r.vegetableId == 'laitue');
      expect(laitue.sowingMonths, contains(10),
          reason: 'Le calendrier écrit doit l\'emporter sur le décalage.');
      expect(laitue.regionalNote, isNotNull);
      expect(laitue.regionalNote, contains('automne'));
    });

    test('garde la dérivation pour les cultures non corrigées', () {
      // Le potiron méditerranéen n'a pas de surcharge : il reste
      // dérivé, et sa note doit le dire.
      expect(mediterraneanCalendar.containsKey('sarrasin'), isFalse);
      final med = regionalCalendar(Region.france,
          zone: ClimateZone.mediterranean);
      final sarrasin = med.firstWhere((r) => r.vegetableId == 'sarrasin');
      expect(sarrasin.regionalNote, contains('adapté'));
    });

    test('retourne les calendriers écrits dans l\'hémisphère sud', () {
      final nord = regionalCalendar(Region.france,
          zone: ClimateZone.mediterranean);
      final sud = regionalCalendar(Region.france,
          zone: ClimateZone.mediterranean, hemisphere: Hemisphere.south);
      final ln = nord.firstWhere((r) => r.vegetableId == 'laitue');
      final ls = sud.firstWhere((r) => r.vegetableId == 'laitue');
      expect(ls.sowingMonths, isNot(ln.sowingMonths));
      expect(ls.sowingMonths, shiftMonths(ln.sowingMonths, 6));
      expect(ls.regionalNote, contains('hémisphère sud'));
    });
  });
}
