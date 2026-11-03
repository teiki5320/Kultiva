import 'package:kultiva/l10n/app_localizations.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/badges.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/screens/home/accueil/accueil_cartes.dart';
import 'package:kultiva/screens/home/defis/badges_grid.dart';
import 'package:kultiva/theme/app_theme.dart';
import 'package:kultiva/widgets/petal_animation.dart';
import 'package:kultiva/widgets/grille_adaptative.dart';
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
  _cartesTableauDeBord();

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

    // Les trois onglets qui sont des **grilles** prennent toute la
    // largeur, et c'est voulu : elles comptent leurs colonnes d'après
    // la place. Les deux autres sont des colonnes de texte et gardent
    // leur mesure. Ce test existe pour qu'un sixième onglet ne
    // s'ajoute pas sans qu'on ait tranché dans quel camp il tombe.
    const grilles = <String>{
      'SowScreen',
      'VegetablesScreen',
      'TutosScreen',
    };

    test('chaque onglet est rangé : grille pleine largeur, ou texte borné',
        () {
      final src = File('lib/screens/root_tabs.dart').readAsStringSync();
      final bloc = src.substring(
          src.indexOf('final pages = <Widget>['), src.indexOf('];'));
      final ecrans = RegExp(r'const (?:ReadableWidth\([^)]*child: )?(\w+)\(\)')
          .allMatches(bloc)
          .map((m) => m.group(1)!)
          .toList();
      expect(ecrans.length, 5, reason: 'cinq onglets');
      for (final e in ecrans) {
        if (grilles.contains(e)) {
          expect(bloc, contains('const $e()'),
              reason: '$e est une grille : elle prend la largeur');
        } else {
          expect(bloc, contains('child: $e()'),
              reason: '$e est du texte : il passe par ReadableWidth');
        }
      }
    });

    test('le tableau de bord demande deux colonnes, pas trois', () {
      // ⚠️ Ce test lit le **réglage réel** de `sow_screen.dart`. Celui
      // d'à côté construit sa propre grille : il vérifie
      // `GrilleAdaptative`, pas le tableau de bord. Il s'appelait
      // pourtant « la grille du tableau de bord passe à trois
      // colonnes » et il est resté vert le jour où elle est passée à
      // deux. Un test qui ne lit pas la valeur qu'il nomme ne la
      // protège pas.
      final src = File('lib/screens/home/sow_screen.dart').readAsStringSync();
      expect(src, contains('colonnesMax: 2'),
          reason: 'six tuiles sur trois colonnes laissent 500 points de '
              'blanc sous la dernière, sur un iPad 13″.');
    });

    testWidgets('GrilleAdaptative compte ses colonnes d\'après la place',
        (tester) async {
      // 160 de cible, 12 d'espacement : sur un téléphone deux
      // colonnes, sur un iPad trois si le plafond l'autorise.
      Future<int> colonnes(double largeur) async {
        tester.view.devicePixelRatio = 1.0;
        tester.view.physicalSize = Size(largeur, 1200);
        addTearDown(tester.view.reset);
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: GrilleAdaptative(
              largeurCible: 160,
              colonnesMax: 3,
              enfants: <Widget>[
                for (var i = 0; i < 6; i++)
                  SizedBox(key: ValueKey<int>(i), height: 100),
              ],
            ),
          ),
        ));
        final l = tester.getSize(find.byKey(const ValueKey<int>(0))).width;
        return ((largeur + 12) / (l + 12)).round();
      }

      expect(await colonnes(343), 2);
      expect(await colonnes(1000), 3);
    });

    // Un écran **poussé** s'ouvre par-dessus l'onglet, donc il perd le
    // `ReadableWidth` que `root_tabs.dart` posait autour de lui. Sans
    // le sien, sa ligne s'étire sur les 1 032 points d'un iPad : le
    // journal du jardin y affichait l'heure à treize centimètres de
    // son libellé, trouvé le 03/11/2026 en prenant les captures.
    test('tout écran poussé borne sa largeur, ou dit pourquoi non', () {
      // Les grilles et les documents pleine largeur : une vignette de
      // plus par ligne, c'est une vignette de plus qu'on voit.
      const pleineLargeur = <String>{
        'garden_planner_screen.dart', // la grille du potager carré
        'defis_badges_screen.dart', // deux grilles de 50 tuiles
        'tuto_fiche_screen.dart', // une WebView, qui se borne elle-même
        'recipe_player_screen.dart', // idem
      };
      // Les onglets sont bornés **de l'extérieur**, dans
      // `root_tabs.dart`, et le test juste au-dessus le vérifie. Les
      // chercher ici une seconde fois ne dirait que des faux positifs.
      const onglets = <String>{
        'recettes_screen.dart',
        'mes_jardins_screen.dart',
      };
      final nus = <String>[];
      for (final f in Directory('lib/screens').listSync(recursive: true)) {
        if (f is! File || !f.path.endsWith('.dart')) continue;
        final nom = f.path.split('/').last;
        if (pleineLargeur.contains(nom) || onglets.contains(nom)) continue;
        final src = f.readAsStringSync();
        if (!src.contains('Scaffold(')) continue;
        if (src.contains('ReadableWidth')) continue;
        nus.add(f.path);
      }
      expect(nus, isEmpty,
          reason: 'Écrans sans largeur bornée :\n${nus.join('\n')}\n'
              'Soit ils passent par ReadableWidth, soit ils entrent dans '
              '`pleineLargeur` avec la raison.');
    });

    testWidgets('une grille ne fait jamais plus de colonnes que de tuiles',
        (tester) async {
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = const Size(1032, 1200);
      addTearDown(tester.view.reset);
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: GrilleAdaptative(
            largeurCible: 100,
            enfants: <Widget>[
              SizedBox(key: Key('seule'), height: 50),
            ],
          ),
        ),
      ));
      // Une tuile seule occupe toute la ligne, et pas un dixième.
      expect(tester.getSize(find.byKey(const Key('seule'))).width, 1032);
    });
  });
}

/// Les cartes du tableau de bord grandissent sur iPad, et **seulement**
/// sur iPad.
///
/// ⚠️ Le défaut, vu le 03/11/2026 en comparant deux captures : agrandir
/// la boîte sans agrandir son contenu ne donne pas une carte d'iPad,
/// ça donne une carte de téléphone étirée — 493 × 300 d'aplat de
/// couleur avec une icône de 44 points dans un coin.
///
/// ⚠️ Et le premier seuil d'échelle, posé à 173, faisait grossir
/// l'icône de 14 % sur un iPhone 18 Pro Max pendant que le commentaire
/// jurait que le téléphone ne bougeait pas. **Une promesse de
/// non-régression se teste**, sinon c'est un vœu.
void _cartesTableauDeBord() {
  group('la carte du tableau de bord suit sa largeur', () {
    /// Largeur d'une carte à deux colonnes pour un écran donné :
    /// l'écran, moins 16 de marge de chaque côté, moins 12 de
    /// gouttière, divisé par deux.
    double carteA(double ecran) => (ecran - 32 - 12) / 2;

    test('aucun téléphone n\'agrandit quoi que ce soit', () {
      // iPhone SE, 14, 16 Pro, 18 Pro Max : le plus large des quatre
      // donne une carte de 198 points, sous le seuil de 220.
      for (final ecran in <double>[375, 390, 402, 440]) {
        expect(KawaiiCard.echellePour(carteA(ecran)), 1.0,
            reason: 'un écran de $ecran points a bougé');
        expect(KawaiiCard.hauteurPour(carteA(ecran)), 138.0,
            reason: 'la hauteur a bougé sur un écran de $ecran points');
      }
    });

    test('un iPad 13″ agrandit le contenu et la carte', () {
      final largeur = carteA(1032);
      expect(largeur, closeTo(494, 1));
      expect(KawaiiCard.echellePour(largeur), 1.8,
          reason: 'le facteur doit être plafonné, pas proportionnel');
      expect(KawaiiCard.hauteurPour(largeur), 260.0,
          reason: 'la hauteur doit être plafonnée à 260');
    });

    test('la hauteur reste bornée des deux côtés', () {
      expect(KawaiiCard.hauteurPour(10), 138.0);
      expect(KawaiiCard.hauteurPour(10000), 260.0);
      expect(KawaiiCard.echellePour(10), 1.0);
      expect(KawaiiCard.echellePour(10000), 1.8);
    });

    test('entre les deux, la hauteur suit vraiment la largeur', () {
      // Sans ça, les bornes passeraient même si la fonction rendait
      // une constante.
      expect(KawaiiCard.hauteurPour(300), closeTo(186, 0.5));
      expect(KawaiiCard.echellePour(330), closeTo(1.5, 0.01));
    });

    test('aucun téléphone ne passe la carte en ligne', () {
      for (final ecran in <double>[375, 390, 402, 440]) {
        expect(KawaiiCard.enLignePour(carteA(ecran)), isFalse,
            reason: 'un écran de $ecran points a changé de disposition');
      }
      expect(KawaiiCard.enLignePour(carteA(1032)), isTrue);
    });

    /// ⚠️ Les deux tests ci-dessous regardent **où les choses sont
    /// dessinées**, pas ce qu'une fonction renvoie. C'est le défaut
    /// qu'ils attrapent : une carte dont l'icône reste au-dessus du
    /// titre garde 86 points de vide au milieu sur un iPad, et aucune
    /// borne ni aucun calcul ne le dit.
    testWidgets('une carte large pose son icône à gauche du titre',
        (tester) async {
      await _monteCarte(tester, 494);
      final icone = tester.getCenter(find.text('🌱'));
      final titre = tester.getCenter(find.text('Semer'));
      expect(icone.dx, lessThan(titre.dx),
          reason: 'l\'icône doit précéder le titre, pas le surmonter');
      expect((icone.dy - titre.dy).abs(), lessThan(24),
          reason: 'les deux doivent être sur la même ligne');
    });

    testWidgets('une carte de téléphone garde son icône au-dessus',
        (tester) async {
      await _monteCarte(tester, 165);
      final icone = tester.getCenter(find.text('🌱'));
      final titre = tester.getCenter(find.text('Semer'));
      expect(icone.dy, lessThan(titre.dy));
      expect((icone.dx - titre.dx).abs(), lessThan(40),
          reason: 'les deux restent alignés sur le bord gauche');
    });
  });
}

/// Monte une seule carte à la largeur voulue, sans le reste de l'écran.
Future<void> _monteCarte(WidgetTester tester, double largeur) async {
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = Size(largeur + 40, 400);
  addTearDown(tester.view.reset);
  await tester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: Center(
        child: SizedBox(
          width: largeur,
          child: KawaiiCard(
            emoji: '🌱',
            label: 'Semer',
            subtitle: '22 légumes',
            gradientColors: const <Color>[Colors.white, Colors.white],
            bubbleColor: Colors.green,
            onTap: () {},
          ),
        ),
      ),
    ),
  ));
}
