import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/badges.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/models/plantation.dart';
import 'package:kultiva/models/vegetable_medal.dart';
import 'package:kultiva/screens/home/poussidex/poussidex_badges.dart';
import 'package:kultiva/screens/home/poussidex/poussidex_card.dart';
import 'package:kultiva/theme/app_theme.dart';
import 'package:kultiva/utils/text_scale.dart';
import 'package:kultiva/widgets/vegetable_card.dart';

/// Premiers tests d'interface du projet.
///
/// Le fichier ne contenait qu'un `MaterialApp` vide avec le mot
/// « Kultiva » : il montait un Scaffold de test, et pas une seule ligne
/// de l'app. C'est cette absence qui a laissé passer quatre
/// fonctionnalités écrites puis jamais reliées à l'interface.
///
/// On teste ici ce qui se voit et s'entend : qu'une carte affiche la
/// bonne donnée, et que ce qu'elle dit au lecteur d'écran correspond à
/// ce qu'elle montre à l'œil.
Widget _host(Widget child) => MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(body: Center(child: SizedBox(width: 200, child: child))),
    );

/// Libellés d'accessibilité présents dans l'arbre rendu.
List<String> _semanticLabels(WidgetTester tester) => tester
    .widgetList<Semantics>(find.byType(Semantics))
    .map((s) => s.properties.label)
    .whereType<String>()
    .where((l) => l.isNotEmpty)
    .toList();

void main() {
  final tomate = vegetablesBase.firstWhere((v) => v.id == 'tomate');

  group('VegetableCard', () {
    testWidgets('affiche le nom du légume', (tester) async {
      await tester.pumpWidget(_host(VegetableCard(vegetable: tomate)));
      expect(find.text(tomate.name), findsOneWidget);
    });

    testWidgets('annonce le légume et sa famille au lecteur d\'écran',
        (tester) async {
      await tester.pumpWidget(_host(VegetableCard(vegetable: tomate)));
      expect(
        _semanticLabels(tester).any(
          (l) => l.contains(tomate.name) && l.contains(tomate.category.label),
        ),
        isTrue,
      );
    });

    testWidgets('le cœur dit s\'il ajoute ou retire des favoris',
        (tester) async {
      await tester.pumpWidget(_host(VegetableCard(
        vegetable: tomate,
        isFavorite: false,
        onFavoriteToggle: () {},
      )));
      expect(
        _semanticLabels(tester).any((l) => l.startsWith('Ajouter')),
        isTrue,
      );

      await tester.pumpWidget(_host(VegetableCard(
        vegetable: tomate,
        isFavorite: true,
        onFavoriteToggle: () {},
      )));
      expect(
        _semanticLabels(tester).any((l) => l.startsWith('Retirer')),
        isTrue,
      );
    });
  });

  group('PlantationCard', () {
    Plantation plant({int waterings = 0, int harvests = 0}) => Plantation(
          id: 'p1',
          vegetableId: 'tomate',
          plantedAt: DateTime.now().subtract(const Duration(days: 10)),
          wateredAt: List<DateTime>.generate(
            waterings,
            (i) => DateTime.now().subtract(Duration(days: i + 1)),
          ),
          harvestCount: harvests,
        );

    testWidgets('affiche le nombre d\'arrosages du plant', (tester) async {
      // C'est le compteur qui prouve que l'arrosage saisi dans « Mes
      // jardins » arrive bien jusqu'au Poussidex.
      await tester.pumpWidget(_host(PlantationCard(
        plantation: plant(waterings: 3),
        vegetable: tomate,
        tier: MedalTier.none,
      )));
      expect(find.textContaining('3'), findsWidgets);
    });

    testWidgets('se monte sans erreur pour un plant tout neuf',
        (tester) async {
      await tester.pumpWidget(_host(PlantationCard(
        plantation: plant(),
        vegetable: tomate,
        tier: MedalTier.none,
      )));
      expect(tester.takeException(), isNull);
      expect(find.text(tomate.name), findsOneWidget);
    });
  });

  group('Taille de texte agrandie', () {
    // Beaucoup de boîtes de l'app ont une hauteur fixe. Quand
    // l'utilisateur agrandit la police dans les réglages de son
    // téléphone — ce que fait toute personne qui voit mal — le contenu
    // déborde et Flutter affiche la bande jaune et noire.
    Widget scaled(Widget child, double factor) => MediaQuery(
          data: MediaQueryData(textScaler: TextScaler.linear(factor)),
          child: _host(child),
        );

    testWidgets('scaledHeight suit le réglage du téléphone', (tester) async {
      late double normal;
      late double grand;
      await tester.pumpWidget(scaled(
        Builder(builder: (c) {
          normal = scaledHeight(c, 48);
          return const SizedBox.shrink();
        }),
        1.0,
      ));
      await tester.pumpWidget(scaled(
        Builder(builder: (c) {
          grand = scaledHeight(c, 48);
          return const SizedBox.shrink();
        }),
        1.3,
      ));
      expect(normal, 48);
      expect(grand, greaterThan(normal));
    });

    testWidgets('une carte de légume ne déborde pas à 1,3', (tester) async {
      await tester.pumpWidget(scaled(VegetableCard(vegetable: tomate), 1.3));
      expect(tester.takeException(), isNull);
    });
  });

  group('Badges', () {
    testWidgets('un badge verrouillé le dit au lecteur d\'écran',
        (tester) async {
      // L'information n'était portée que par la couleur grisée, qu'un
      // lecteur d'écran ne voit pas.
      await tester.pumpWidget(_host(
        const PoussidexBadgesGrid(unlocked: <String>{}),
      ));
      await tester.pump();
      expect(
        _semanticLabels(tester).any((l) => l.contains('verrouillé')),
        isTrue,
      );
    });

    testWidgets('un badge débloqué le dit aussi', (tester) async {
      final premier = allBadges.first;
      await tester.pumpWidget(_host(
        PoussidexBadgesGrid(unlocked: <String>{premier.id}),
      ));
      await tester.pump();
      expect(
        _semanticLabels(tester)
            .any((l) => l.contains(premier.name) && l.contains('débloqué')),
        isTrue,
      );
    });
  });
}
