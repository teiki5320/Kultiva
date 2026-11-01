import 'package:flutter/material.dart';
import 'package:kultiva/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/screens/root_tabs.dart';

/// L'ordre des onglets a changé le 30/10/2026 : le cahier de culture
/// passe en deuxième, devant l'Étal, et le Poussidex quitte la barre.
/// Photo puis Recettes s'ajoutent le 01/11/2026 — en bout de barre,
/// pour ne décaler aucun des index déjà pointés par les tutos.
///
/// Ces positions ne sont pas qu'une affaire de goût : les tutos HTML
/// embarqués naviguent par `kultiva://` en posant un index dans
/// `RootTabs.tabIndex`. Un décalage d'un cran et « Étal » ouvre le
/// cahier, sans que rien n'échoue.
void main() {
  testWidgets('la barre affiche les six onglets dans l\'ordre attendu',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      locale: Locale('fr'),
      localizationsDelegates: L.localizationsDelegates,
      supportedLocales: L.supportedLocales,
      home: RootTabs(),
    ));
    await tester.pump();

    final barre = tester.widget<BottomNavigationBar>(
      find.byType(BottomNavigationBar),
    );
    expect(
      barre.items.map((i) => i.label).toList(),
      <String>['Home', 'Cahier', 'Étal', 'Tutos', 'Photo', 'Recettes'],
    );
  });

  testWidgets('le Poussidex n\'est plus un onglet', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      locale: Locale('fr'),
      localizationsDelegates: L.localizationsDelegates,
      supportedLocales: L.supportedLocales,
      home: RootTabs(),
    ));
    await tester.pump();

    final barre = tester.widget<BottomNavigationBar>(
      find.byType(BottomNavigationBar),
    );
    expect(barre.items.map((i) => i.label), isNot(contains('Poussidex')));
  });

  testWidgets('la barre se traduit quand la langue change', (tester) async {
    // Ajouté le 01/11/2026 avec l'anglais. Le test précédent passait
    // en réalité *en anglais* sans que personne le voie : un test de
    // libellés doit dire dans quelle langue il lit.
    await tester.pumpWidget(const MaterialApp(
      locale: Locale('en'),
      localizationsDelegates: L.localizationsDelegates,
      supportedLocales: L.supportedLocales,
      home: RootTabs(),
    ));
    await tester.pump();

    final barre = tester.widget<BottomNavigationBar>(
      find.byType(BottomNavigationBar),
    );
    expect(
      barre.items.map((i) => i.label).toList(),
      <String>['Home', 'Journal', 'Catalog', 'Guides', 'Photos', 'Recipes'],
    );
  });
}
