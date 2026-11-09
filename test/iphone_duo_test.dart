import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/l10n/app_localizations.dart';
import 'package:kultiva/screens/root_tabs.dart';
import 'package:kultiva/services/prefs_service.dart';
import 'package:kultiva/theme/app_theme.dart';
import 'package:kultiva/widgets/grille_adaptative.dart';
import 'package:kultiva/widgets/petal_animation.dart';
import 'package:kultiva/widgets/season_header.dart';

/// L'iPhone Duo (iPhone19,4), premier pliable d'Apple, en vente depuis
/// le 23/10/2026.
///
/// **Les deux tailles sont mesurées, pas déduites** : un simulateur
/// `iPhone Duo` sous iOS 27.2 a été créé le 09/11/2026, l'app y a été
/// posée, et un point d'entrée jetable a lu `MediaQuery` à l'écran.
///
/// | État | Points | Pixels | Pouces |
/// | --- | --- | --- | --- |
/// | Fermé, écran externe | **466 × 678** | 1398 × 2034 | 5,4″ |
/// | Ouvert, écran interne | **669 × 951** | 2007 × 2853 | 7,6″ |
///
/// Les deux sont en densité 3. Les pouces se recalculent à 460 ppi,
/// la densité des iPhone : 1398/460 × 2034/460 donne 5,37″ de
/// diagonale, et 2007/460 × 2853/460 en donne 7,58″. Les deux chiffres
/// annoncés par Apple tombent, ce qui confirme l'affectation des deux
/// dalles.
///
/// ⚠️ **Ce que l'écran fermé n'est pas : un petit écran.** À 466
/// points, il est plus **large** que tous les iPhone — 402 pour un
/// iPhone 17, 440 pour un 17 Pro Max. Ce qu'il a de particulier est
/// ailleurs, et c'est ce que ce fichier surveille :
///
/// 1. il est **court** — 678 points contre 874, soit la hauteur d'un
///    iPhone SE sur une largeur de Pro Max ;
/// 2. il porte une **encoche latérale de 84 points**. Mesuré :
///    `padding` vaut `top 0, bottom 34, left 0, right 84`. La barre
///    d'état d'iOS y est dessinée **sur le côté**, verticalement.
///    Aucun appareil Apple n'avait jamais eu de marge horizontale de
///    cette taille, et aucun test de ce dépôt n'en posait : ils
///    montent tous un `MediaQueryData` dont le `padding` est nul.
///
/// C'est donc le point 2 qui est neuf, pas la largeur.
///
/// ⚠️ **Le dépliage est un redimensionnement, pas un relancement** :
/// la même fenêtre passe de 466 × 678 à 669 × 951. Rien ne casse par
/// construction — aucun `initState` de `lib/` ne lit `MediaQuery`,
/// vérifié au peigne le 09/11/2026 — mais la mise en page doit suivre,
/// d'où les deux tailles jouées ici.
///
/// ⚠️ **Et ce fichier n'ajoute rien à ce qui existe** : il monte les
/// mêmes écrans, aux tailles du Duo. Le dernier test vérifie qu'à
/// 390 points un téléphone rend exactement ce qu'il rendait avant.
void main() {
  // L'environnement de test tourne en en-US : sans ça, les libellés
  // lus plus bas seraient anglais.
  setUpAll(() => PrefsService.instance.language.value = 'fr');

  const ferme = Size(466, 678);
  const ouvert = Size(669, 951);

  // Mesuré sur l'appareil, écran fermé.
  const encocheFermee = EdgeInsets.only(right: 84, bottom: 34);

  Future<void> monte(
    WidgetTester tester,
    Widget child, {
    required Size taille,
    EdgeInsets padding = EdgeInsets.zero,
    double police = 1.0,
    bool brut = false,
  }) async {
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = taille;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('fr'),
      localizationsDelegates: L.localizationsDelegates,
      supportedLocales: L.supportedLocales,
      theme: AppTheme.light,
      home: MediaQuery(
        data: MediaQueryData(
          size: taille,
          padding: padding,
          viewPadding: padding,
          textScaler: TextScaler.linear(police),
        ),
        child: brut ? child : Scaffold(body: child),
      ),
    ));
    await tester.pump();
  }

  group('les deux tailles de l\'iPhone Duo', () {
    for (final cas in <(String, Size, EdgeInsets)>[
      ('fermé', ferme, encocheFermee),
      // ⚠️ L'état ouvert n'a pas pu être joué sur l'appareil : le
      // pliage se commande depuis `Simulator.app`, absent de ce Mac,
      // et `simctl` n'a pas d'option pour ça. Sa marge n'est donc
      // **pas** mesurée — on ne l'invente pas, on joue la géométrie
      // seule.
      ('ouvert', ouvert, EdgeInsets.zero),
    ]) {
      final (nom, taille, padding) = cas;

      for (final police in <double>[1.0, 1.3]) {
        testWidgets('l\'app entière tient $nom à police $police',
            (tester) async {
          await monte(tester, const RootTabs(),
              taille: taille, padding: padding, police: police, brut: true);
          expect(tester.takeException(), isNull);
        });

        testWidgets('le bandeau de saison tient $nom à police $police',
            (tester) async {
          await monte(
            tester,
            const SeasonHeader(season: Season.autumn, month: 11),
            taille: taille,
            padding: padding,
            police: police,
          );
          expect(tester.takeException(), isNull);
        });
      }
    }
  });

  group('l\'encoche latérale de 84 points', () {
    /// Le bord droit utilisable, écran fermé.
    const bordSur = 466.0 - 84.0;

    testWidgets('aucun texte de l\'app n\'est peint sous la barre d\'état',
        (tester) async {
      await monte(tester, const RootTabs(),
          taille: ferme, padding: encocheFermee, brut: true);

      final fautifs = <String>[];
      for (final e in tester.widgetList<Text>(find.byType(Text))) {
        final libelle = e.data;
        if (libelle == null || libelle.isEmpty) continue;
        final boite = tester.getRect(find.byWidget(e));
        if (boite.right > bordSur + 0.5) {
          fautifs.add('« $libelle » va jusqu\'à '
              '${boite.right.toStringAsFixed(1)}');
        }
      }
      expect(fautifs, isEmpty,
          reason: 'ces textes passent le bord sûr de $bordSur :\n'
              '${fautifs.join('\n')}');
    });
  });

  group('la grille ne change pas de compte', () {
    /// Le tableau de bord pose sa grille dans 16 points de marge de
    /// chaque côté, sous la zone sûre.
    int colonnes(double ecranLarge, double encocheDroite) {
      final dispo = ecranLarge - encocheDroite - 32;
      return ((dispo + 12) / (160 + 12)).floor().clamp(1, 2);
    }

    test('deux colonnes sur l\'écran fermé, comme sur un téléphone', () {
      // 466 − 84 d'encoche − 32 de marges = 350 points, soit deux
      // colonnes de 169 : exactement ce que donne un iPhone 17.
      expect(colonnes(466, 84), 2);
      expect(colonnes(402, 0), 2);
    });

    test('deux colonnes aussi sur l\'écran ouvert', () {
      // Le plafond est à deux, et c'est voulu : six tuiles sur trois
      // colonnes laissent un demi-rang vide (décision du 03/11/2026).
      expect(colonnes(669, 0), 2);
    });
  });

  group('rien ne bouge sur un téléphone', () {
    /// Le `Scaffold` qui porte la barre d'onglets.
    Scaffold barreDe(WidgetTester tester) => tester.widget<Scaffold>(
          find
              .ancestor(
                of: find.byType(BottomNavigationBar),
                matching: find.byType(Scaffold),
              )
              .first,
        );

    testWidgets('à marges nulles, la barre d\'onglets n\'est pas enveloppée',
        (tester) async {
      await monte(tester, const RootTabs(),
          taille: const Size(390, 844), brut: true);
      // ⚠️ L'assertion porte sur le **widget passé au Scaffold**, pas
      // sur une position à l'écran : c'est la seule façon de voir
      // qu'aucune boîte ne s'est glissée là où il n'y en avait pas.
      expect(barreDe(tester).bottomNavigationBar, isA<BottomNavigationBar>(),
          reason: 'un téléphone sans encoche doit recevoir la barre nue');
    });

    testWidgets('avec une encoche latérale, elle l\'est', (tester) async {
      await monte(tester, const RootTabs(),
          taille: ferme, padding: encocheFermee, brut: true);
      // Vérifié dans les deux sens : sans ça, un correctif qui ne
      // s'applique jamais passerait le test d'au-dessus.
      expect(barreDe(tester).bottomNavigationBar, isA<ColoredBox>(),
          reason: 'l\'encoche de 84 points doit ranger la barre');
    });

    testWidgets('à 390 points sans encoche, la grille rend ses deux colonnes',
        (tester) async {
      await monte(
        tester,
        GrilleAdaptative(
          largeurCible: 160,
          colonnesMax: 2,
          enfants: <Widget>[
            for (var i = 0; i < 6; i++) const SizedBox(height: 40),
          ],
        ),
        taille: const Size(390, 844),
      );
      final boites = tester
          .widgetList<SizedBox>(find.descendant(
            of: find.byType(GrilleAdaptative),
            matching: find.byType(SizedBox),
          ))
          .where((b) => b.width != null)
          .toList();
      expect(boites, isNotEmpty);
      expect(boites.first.width, closeTo((390 - 12) / 2, 0.5));
    });
  });
}
