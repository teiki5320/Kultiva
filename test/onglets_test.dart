import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/screens/root_tabs.dart';

/// L'ordre des onglets a changé le 30/10/2026 : le cahier de culture
/// passe en deuxième, devant l'Étal, et le Poussidex quitte la barre.
///
/// Ces positions ne sont pas qu'une affaire de goût : les tutos HTML
/// embarqués naviguent par `kultiva://` en posant un index dans
/// `RootTabs.tabIndex`. Un décalage d'un cran et « Étal » ouvre le
/// cahier, sans que rien n'échoue.
void main() {
  testWidgets('la barre affiche Home, Cahier, Étal, Tutos dans cet ordre',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: RootTabs()));
    await tester.pump();

    final barre = tester.widget<BottomNavigationBar>(
      find.byType(BottomNavigationBar),
    );
    expect(
      barre.items.map((i) => i.label).toList(),
      <String>['Home', 'Cahier', 'Étal', 'Tutos'],
    );
  });

  testWidgets('le Poussidex n\'est plus un onglet', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: RootTabs()));
    await tester.pump();

    final barre = tester.widget<BottomNavigationBar>(
      find.byType(BottomNavigationBar),
    );
    expect(barre.items.map((i) => i.label), isNot(contains('Poussidex')));
  });
}
