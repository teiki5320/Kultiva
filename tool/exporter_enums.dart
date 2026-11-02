// Sort les libellés qui vivent dans un champ d'enum `const`.
//
// Trois enums portent du texte visible dans un champ `final String`
// rempli par un constructeur `const` : `Country.label`,
// `Country.capitalName` et `Region.label`. Un champ `const` ne peut
// pas appeler de fonction, donc ces trois-là sont traduits par un
// getter — `trUi(label)` — et non par un appel à littérale.
//
// Conséquence : `tool/exporter_interface.py`, qui lit les littérales
// dans le code, ne peut pas les voir. Cet outil les lit **dans
// l'enum**, ce qui est exact par construction.
//
// ⚠️ Il tourne sous `flutter test` et non `dart run` : `country.dart`
// importe `ui_i18n.dart`, qui importe `PrefsService`, qui importe
// Flutter. Même raison que `exporter_contenu.dart`.
//
// Usage :
//   flutter test tool/exporter_enums.dart
//
// Il écrit une clé par ligne dans `build/traduction/cles_enum.txt`,
// que l'exportateur d'interface fusionne avec les littérales.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../lib/models/country.dart';
import '../lib/models/region_data.dart';

void main() {
  test('exporte les libellés d\'enum', () {
    final cles = <String>{
      for (final r in Region.values) r.label,
      for (final c in Country.values) ...<String>[c.label, c.capitalName],
    };
    final liste = cles.toList()..sort();

    Directory('build/traduction').createSync(recursive: true);
    File('build/traduction/cles_enum.txt')
        .writeAsStringSync('${liste.join('\n')}\n');

    stdout.writeln('  ${Region.values.length} régions, '
        '${Country.values.length} pays');
    stdout.writeln('  ${liste.length} clés distinctes '
        '(pays, capitales et régions se recoupent)');
    stdout.writeln('  → build/traduction/cles_enum.txt');
  });
}
