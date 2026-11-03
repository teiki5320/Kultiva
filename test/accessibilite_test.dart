import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Un élément qu'on peut toucher doit se présenter à VoiceOver.
///
/// ⚠️ C'est un **compte**, pas une preuve. Le test vérifie qu'un
/// fichier n'a pas plus de zones tactiles que d'étiquettes : il
/// n'apparie pas les unes aux autres, et il ne dira jamais si
/// l'étiquette est bien écrite. Il attrape la faute franche — un
/// `InkWell` posé sans rien — qui est celle qu'on commet.
///
/// Trouvé le 03/11/2026 par ce compte, sur deux fichiers : la ligne
/// d'une recette, que VoiceOver égrenait en cinq morceaux sans dire
/// qu'elle s'ouvre, et le dépliant « N recettes à manger tout de
/// suite ».
///
/// ⚠️ Ce que ce test ne remplace pas : **personne n'a encore essayé
/// l'app avec VoiceOver réellement activé** (alerte 1). Un compte voit
/// qu'une étiquette existe, pas qu'un écran est agréable à écouter.
void main() {
  /// Les widgets de Material portent déjà leur sémantique : un
  /// `ListTile`, un `TextButton` ou un `IconButton` s'annoncent seuls.
  /// Seules les zones tactiles **nues** demandent une étiquette.
  final tactile = RegExp(r'\b(GestureDetector|InkWell)\(');
  final etiquette = RegExp(r'\bSemantics\(');

  test('toute zone tactile nue a son étiquette VoiceOver', () {
    final manquants = <String>[];
    for (final f in Directory('lib').listSync(recursive: true)) {
      if (f is! File || !f.path.endsWith('.dart')) continue;
      final src = f.readAsStringSync();
      final taps = tactile.allMatches(src).length;
      if (taps == 0) continue;
      final labels = etiquette.allMatches(src).length;
      if (labels < taps) {
        manquants.add('${f.path} : $taps zones tactiles, $labels étiquettes');
      }
    }
    expect(manquants, isEmpty,
        reason: 'Zones tactiles sans étiquette :\n${manquants.join('\n')}');
  });
}
