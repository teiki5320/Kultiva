import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/badges.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/models/vegetable.dart';

/// Vérifie que chaque image annoncée par le catalogue existe vraiment.
///
/// Un `imageAsset` qui pointe vers un fichier absent ne fait pas échouer
/// la compilation : l'app affiche simplement l'emoji de secours, et on
/// ne s'en aperçoit qu'en parcourant les 130 fiches à la main. C'est
/// précisément le risque de la bascule des PNG vers les WebP kawaii.
void main() {
  _orphelins();

  group('images du catalogue', () {
    test('chaque imageAsset de légume pointe vers un fichier présent', () {
      final manquants = <String>[];
      for (final v in vegetablesBase) {
        final path = v.imageAsset;
        if (path == null) continue;
        if (!File(path).existsSync()) manquants.add('${v.id} → $path');
      }
      expect(manquants, isEmpty,
          reason: 'Images déclarées mais absentes :\n${manquants.join('\n')}');
    });

    test('toutes les cultures ont une image', () {
      // Les accessoires peuvent s'en passer (emoji), pas les cultures :
      // ce sont elles qu'on voit dans le calendrier et le Poussidex.
      final sans = vegetablesBase
          .where((v) => v.category != VegetableCategory.accessories)
          .where((v) => v.imageAsset == null)
          .map((v) => v.id)
          .toList();
      expect(sans, isEmpty, reason: 'Cultures sans image : $sans');
    });
  });

  group('images des badges', () {
    test('chaque badge a son médaillon', () {
      final manquants = <String>[];
      for (final b in allBadges) {
        final path = 'assets/images/badges/${b.id}.webp';
        if (!File(path).existsSync()) manquants.add(b.id);
      }
      expect(manquants, isEmpty, reason: 'Badges sans image : $manquants');
    });
  });
}

/// L'inverse : une image embarquée que **personne n'affiche**.
///
/// ⚠️ Ajouté le 03/11/2026 après en avoir trouvé 3,2 Mo d'un coup. Les
/// quatre fonds d'écran par moment de la journée
/// (`backgrounds/morning.png`…) servaient à la créature supprimée le
/// 31/10 ; `potager.png`, `potager_bg.png` et `onboarding_5.png`
/// n'étaient plus cités nulle part. Tout cela partait quand même dans
/// chaque téléchargement, et `assets_exist_test` ne regardait que dans
/// l'autre sens : il vérifiait qu'un chemin déclaré existe, jamais
/// qu'un fichier présent sert.
///
/// ⚠️ Les dossiers adressés **par identifiant** sont exclus : le
/// catalogue construit `assets/images/badges/<id>.webp` à la volée, et
/// chercher le nom de fichier dans le code n'y trouverait rien.
void _orphelins() {
  // Les dossiers adressés par identifiant : le catalogue construit
  // `assets/images/badges/<id>.webp` à la volée, chercher le nom de
  // fichier dans le code n'y trouverait rien.
  const parIdentifiant = <String>[
    'assets/images/badges/',
    'assets/images/vegetables/',
    'assets/images/accessories/',
    'assets/images/vegetables_kawaii/',
    'assets/google_fonts/',
    'assets/sounds/',
    'assets/tutos/',
  ];

  test('aucune image embarquée sans personne pour l\'afficher', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();

    // ⚠️ On ne regarde que ce que `pubspec.yaml` déclare. Les dossiers
    // `*_png_v1` traînent sur le disque depuis la bascule vers le WebP,
    // ne sont pas suivis par git et ne partent dans aucun build : les
    // signaler serait du bruit.
    final declares = <String>[
      for (final l in pubspec.split('\n'))
        if (l.trimLeft().startsWith('- assets/')) l.trim().substring(2),
    ];

    final sources = StringBuffer(pubspec);
    for (final dir in <String>['lib', 'assets', 'test']) {
      for (final f in Directory(dir).listSync(recursive: true)) {
        if (f is! File) continue;
        if (f.path.endsWith('.dart') || f.path.endsWith('.html')) {
          sources.write(f.readAsStringSync());
        }
      }
    }
    final tout = sources.toString();

    final orphelins = <String>[];
    for (final decl in declares) {
      if (parIdentifiant.any((d) => decl.startsWith(d))) continue;
      final fichiers = decl.endsWith('/')
          ? Directory(decl)
              .listSync()
              .whereType<File>()
              .map((f) => f.path)
              .toList()
          : <String>[decl];
      for (final chemin in fichiers) {
        final nom = chemin.split('/').last;
        if (nom.startsWith('.') || nom.endsWith('.md')) continue;
        // Un nom cité dans la seule ligne du pubspec qui le déclare ne
        // compte pas : c'est la déclaration, pas un affichage.
        final ailleurs = tout.replaceAll('- $chemin', '');
        if (!ailleurs.contains(nom)) {
          orphelins.add('$chemin (${File(chemin).lengthSync() ~/ 1024} Ko)');
        }
      }
    }
    expect(orphelins, isEmpty,
        reason: 'Images embarquées que rien n\'affiche :\n'
            '${orphelins.join('\n')}');
  });
}
