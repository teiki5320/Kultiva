import 'package:kultiva/l10n/app_localizations.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/badges.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/screens/home/defis/badges_grid.dart';
import 'package:kultiva/theme/app_theme.dart';
import 'package:kultiva/widgets/petal_animation.dart';
import 'package:kultiva/widgets/readable_width.dart';
import 'package:kultiva/widgets/season_header.dart';
import 'package:kultiva/widgets/vegetable_card.dart';

/// L'iPad tourne depuis le 30/10/2026 : l'app n'est plus verrouillée en
/// portrait sur tablette. Or son interface n'a jamais été dessinée pour
/// le paysage.
///
/// Première couche : qu'aux dimensions d'un iPad, en portrait comme en
/// paysage, et jusqu'au plafond de police de 1,3, les écrans se
/// construisent sans déborder. Flutter lève sur un débordement, que
/// `takeException` récupère.
///
/// Deuxième couche, ajoutée le 03/11/2026 après un vrai passage sur un
/// iPad Pro 13" : que le contenu soit **borné**. Le premier jeu de
/// tests ne disait rien d'une grille de deux colonnes étalée sur
/// 1 032 points — elle ne débordait pas, elle était seulement vide au
/// milieu. Les cartes du tableau de bord mesuraient 510 points de
/// large pour 138 de haut, et une phrase traversait l'écran d'un bord
/// à l'autre.
///
/// ⚠️ Cela ne remplace toujours pas un coup d'œil sur l'appareil : un
/// test voit une largeur, pas une mise en page agréable.
void main() {
  final tomate = vegetablesBase.firstWhere((v) => v.id == 'tomate');

  // iPad Pro 11" en points.
  const portrait = Size(834, 1194);
  const paysage = Size(1194, 834);

  Future<void> monte(
    WidgetTester tester,
    Widget child, {
    required Size taille,
    double police = 1.0,
  }) async {
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = taille;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: L.localizationsDelegates,
      supportedLocales: L.supportedLocales,
      theme: AppTheme.light,
      home: MediaQuery(
        data: MediaQueryData(
          size: taille,
          textScaler: TextScaler.linear(police),
        ),
        child: Scaffold(body: child),
      ),
    ));
    await tester.pump();
  }

  _bornes();

  group('iPad', () {
    for (final cas in <(String, Size)>[
      ('portrait', portrait),
      ('paysage', paysage),
    ]) {
      final (nom, taille) = cas;

      testWidgets('le bandeau de saison tient en $nom', (tester) async {
        await monte(
          tester,
          const SeasonHeader(season: Season.spring, month: 4),
          taille: taille,
        );
        expect(tester.takeException(), isNull);
      });

      testWidgets('la grille des badges tient en $nom', (tester) async {
        await monte(
          tester,
          BadgesGrid(unlocked: <String>{allBadges.first.id}),
          taille: taille,
        );
        expect(tester.takeException(), isNull);
      });

      testWidgets('une carte de légume tient en $nom, police à 1,3',
          (tester) async {
        await monte(
          tester,
          Center(
            child:
                SizedBox(width: 200, child: VegetableCard(vegetable: tomate)),
          ),
          taille: taille,
          police: 1.3,
        );
        expect(tester.takeException(), isNull);
      });
    }
  });
}

/// Le contenu est borné sur les grands écrans.
///
/// ⚠️ `ReadableWidth` existait depuis le 30/10/2026 et n'était branché
/// que sur **un** écran sur trente-trois. Un widget écrit et non
/// branché, c'est un bug, pas une avance (règle 10). Ces tests
/// vérifient qu'il l'est, et le resterait si un onglet s'ajoutait.
void _bornes() {
  group('largeur bornée sur iPad', () {
    testWidgets('ReadableWidth borne à sa largeur sur un écran large',
        (tester) async {
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = const Size(1032, 1376);
      addTearDown(tester.view.reset);
      await tester.pumpWidget(const MaterialApp(
        home: ReadableWidth(child: SizedBox.expand(key: Key('contenu'))),
      ));
      expect(tester.getSize(find.byKey(const Key('contenu'))).width, 720);
    });

    testWidgets('ReadableWidth ne fait rien sur un téléphone',
        (tester) async {
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = const Size(390, 844);
      addTearDown(tester.view.reset);
      await tester.pumpWidget(const MaterialApp(
        home: ReadableWidth(child: SizedBox.expand(key: Key('contenu'))),
      ));
      expect(tester.getSize(find.byKey(const Key('contenu'))).width, 390);
    });

    test('les feuilles modales sont bornées dans les deux thèmes', () {
      for (final theme in <ThemeData>[AppTheme.light, AppTheme.dark]) {
        final c = theme.bottomSheetTheme.constraints;
        expect(c, isNotNull,
            reason: 'sans contrainte, le dossier d\'un plant traverse '
                'les 1 032 points d\'un iPad');
        expect(c!.maxWidth, lessThanOrEqualTo(720));
      }
    });

    test('chaque onglet est borné, sauf l\'Étal et son damier', () {
      final src = File('lib/screens/root_tabs.dart').readAsStringSync();
      final bloc = src.substring(
          src.indexOf('final pages = <Widget>['), src.indexOf('];'));
      // Un écran par ligne qui se termine par `Screen()`.
      final ecrans = RegExp(r'const (?:ReadableWidth\([^)]*child: )?(\w+)\(\)')
          .allMatches(bloc)
          .map((m) => m.group(1)!)
          .toList();
      expect(ecrans.length, 5, reason: 'cinq onglets');
      for (final e in ecrans) {
        if (e == 'VegetablesScreen') {
          // Exception documentée : la grille de l'Étal se répartit
          // toute seule et profite de la largeur.
          expect(bloc, contains('const VegetablesScreen()'));
          continue;
        }
        expect(bloc, contains('child: $e()'),
            reason: '$e doit passer par ReadableWidth');
      }
    });
  });
}
