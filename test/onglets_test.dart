import 'package:flutter/material.dart';
import 'package:kultiva/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/screens/root_tabs.dart';

/// L'ordre des onglets a changé le 30/10/2026 : le cahier de culture
/// passe en deuxième, devant l'Étal, et le Poussidex quitte la barre.
/// Recettes s'ajoute le 01/11/2026 en bout de barre. Photo y est
/// arrivé le même jour puis a été retiré — « trop compliqué », et le
/// module ne faisait que doubler les photos du cahier.
///
/// Tutos passe **en dernier** le 01/11/2026, à la demande de Jean :
/// Recettes prend l'index 3 et Tutos le 4. Ce test est ce qui garantit
/// que les deep-links des tutos ont suivi.
///
/// Ces positions ne sont pas qu'une affaire de goût : les tutos HTML
/// embarqués naviguent par `kultiva://` en posant un index dans
/// `RootTabs.tabIndex`. Un décalage d'un cran et « Étal » ouvre le
/// cahier, sans que rien n'échoue.
void main() {
  testWidgets('la barre affiche les cinq onglets dans l\'ordre attendu',
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
      <String>['Home', 'Cahier', 'Étal', 'Recettes', 'Tutos'],
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
      <String>['Home', 'Journal', 'Catalog', 'Recipes', 'Guides'],
    );
  });
}
