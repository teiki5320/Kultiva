import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/badges.dart';
import 'package:kultiva/screens/home/defis/badges_grid.dart';
import 'package:kultiva/utils/text_scale.dart';

/// La description d'un badge ne doit pas être coupée en plein milieu
/// d'une ligne.
///
/// ⚠️ Le défaut, vu à l'écran le 03/11/2026 en prenant la capture
/// « Défis & badges » pour les boutiques : « Planter ton premier »
/// suivi de la moitié haute des lettres de « légume ».
///
/// **Ce n'est pas l'ellipse qui manquait, c'est qu'elle ne partait
/// pas.** Le `Text` portait `maxLines: 4` dans un `Expanded` qui
/// n'offrait la place que d'une ligne : le paragraphe se croyait dans
/// les clous, donc aucune ellipse, et c'est la boîte qui tranchait.
/// `flutter analyze` ne voit rien, et aucun test de débordement non
/// plus — un `RenderParagraph` plus haut que sa boîte ne déclenche pas
/// la bande jaune, il est simplement rogné.
void main() {
  Future<List<int>> maxLinesDesDescriptions(
    WidgetTester tester, {
    required Size taille,
    double echelleTexte = 1.0,
  }) async {
    tester.view.physicalSize = taille;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(textScaler: TextScaler.linear(echelleTexte)),
        child: Scaffold(
          body: BadgesGrid(unlocked: <String>{allBadges.first.id}),
        ),
      ),
    ));
    await tester.pump();
    // Les descriptions sont les seuls textes longs de la tuile : un
    // nom de badge tient en 24 caractères (vérifié plus bas). Ne pas
    // filtrer sur `maxLines != 1` — c'est exactement la valeur que le
    // défaut produisait, et l'exclure rendrait le test aveugle à lui.
    return <int>[
      for (final t in tester.widgetList<Text>(find.byType(Text)))
        if (t.maxLines != null && (t.data ?? '').length > 24) t.maxLines!,
    ];
  }

  testWidgets('sur un iPhone, deux lignes au moins par description',
      (tester) async {
    final lignes =
        await maxLinesDesDescriptions(tester, taille: const Size(390, 844));
    expect(lignes, isNotEmpty, reason: 'aucune tuile rendue : test inutile.');
    expect(lignes.every((n) => n >= 2), isTrue,
        reason: 'Une description n\'a qu\'une ligne : $lignes');
  });

  testWidgets('sur un iPhone SE, la tuile tient encore deux lignes',
      (tester) async {
    final lignes =
        await maxLinesDesDescriptions(tester, taille: const Size(375, 667));
    expect(lignes.every((n) => n >= 2), isTrue, reason: '$lignes');
  });

  testWidgets('à 1,3 de police, il reste au moins une ligne entière',
      (tester) async {
    // L'app plafonne l'agrandissement à 1,3 (voir main.dart). La
    // hauteur de tuile suit la police via `scaledHeight`, donc le
    // compte ne doit pas s'effondrer.
    final lignes = await maxLinesDesDescriptions(tester,
        taille: const Size(390, 844), echelleTexte: 1.3);
    expect(lignes.every((n) => n >= 1), isTrue, reason: '$lignes');
  });

  test('aucun nom de badge ne dépasse 24 caractères', () {
    // Le filtre ci-dessus s'appuie dessus pour distinguer un nom d'une
    // description. Si un nom s'allonge, le test ci-dessus mesurerait
    // le mauvais texte sans rien dire.
    final longs = allBadges
        .where((b) => b.name.length > 24)
        .map((b) => '${b.id} (${b.name.length})')
        .toList();
    expect(longs, isEmpty, reason: 'Noms trop longs : $longs');
  });

  group('lignesQuiTiennent', () {
    testWidgets('compte des lignes entières, jamais une moitié',
        (tester) async {
      late BuildContext ctx;
      await tester.pumpWidget(MaterialApp(home: Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      })));
      // 10 pt × 1,3 d'interligne = 13 points par ligne.
      expect(lignesQuiTiennent(ctx, 13, 10), 1);
      expect(lignesQuiTiennent(ctx, 25, 10), 1, reason: 'une ligne et demie');
      expect(lignesQuiTiennent(ctx, 26, 10), 2);
      expect(lignesQuiTiennent(ctx, 1000, 10), 4, reason: 'plafonné par max');
      expect(lignesQuiTiennent(ctx, 0, 10), 1,
          reason: 'jamais zéro : une boîte vide vaut mieux qu\'un plantage');
    });

    testWidgets('suit le réglage de police de l\'utilisateur',
        (tester) async {
      late BuildContext ctx;
      await tester.pumpWidget(MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(1.3)),
          child: Builder(builder: (c) {
            ctx = c;
            return const SizedBox();
          }),
        ),
      ));
      // 13 pt × 1,3 = 16,9 points par ligne : 26 n'en contient plus
      // qu'une. Sans l'échelle, le calcul en annoncerait deux et la
      // seconde serait coupée — le défaut d'origine, en pire.
      expect(lignesQuiTiennent(ctx, 26, 10), 1);
    });
  });
}
