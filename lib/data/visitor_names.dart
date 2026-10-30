import 'dart:math';

import '../models/tamassi_visitor.dart';

/// Visiteurs de Tamassi, générés localement.
///
/// Les visiteurs venaient d'une lecture publique de la table `user_xp`.
/// En pratique la fonctionnalité ne marchait pour **personne** : la
/// requête renvoyait une liste vide sans compte connecté, donc pour la
/// quasi-totalité des utilisateurs — alors que la fiche App Store promet
/// des « visiteurs surprise ».
///
/// Les comptes ayant été retirés de la v1, les visiteurs sont maintenant
/// tirés d'un petit répertoire local : ils apparaissent pour tout le
/// monde, hors ligne, sans compte et sans réseau.
///
/// Les prénoms sont choisis pour les deux marchés de l'app, France et
/// Afrique de l'Ouest, et les noms de créature restent dans le registre
/// kawaii végétal du jeu.
const List<String> _visitorNames = <String>[
  'Pousspouss', 'Bouboule', 'Radichou', 'Mimosa', 'Pistache',
  'Niébé', 'Fonio', 'Gombo', 'Moringa', 'Bissap',
  'Capucine', 'Mirabelle', 'Praline', 'Noisette', 'Verveine',
  'Djakhatou', 'Sorgho', 'Tamarin', 'Baobab', 'Karité',
  'Coquelicot', 'Églantine', 'Myrtille', 'Cresson', 'Topinambour',
  'Soleil', 'Fougère', 'Trèfle', 'Pâquerette', 'Romarin',
];

const List<String> _starters = <String>['poussia', 'soleia', 'spira'];

/// Tire [count] visiteurs distincts, de niveau plausible par rapport à
/// celui du joueur.
///
/// [playerXp] sert à rester crédible : un joueur débutant ne croise pas
/// que des créatures de niveau 40, et un joueur avancé ne croise pas que
/// des nouveau-nés. On tire donc autour de son niveau, avec un plancher
/// à 1.
List<TamassiVisitor> randomVisitors({
  required int playerXp,
  int count = 1,
  Random? random,
}) {
  final rng = random ?? Random();
  final noms = <String>[..._visitorNames]..shuffle(rng);
  final n = count.clamp(0, noms.length);
  return <TamassiVisitor>[
    for (var i = 0; i < n; i++)
      TamassiVisitor(
        // Fenêtre de ±60 % autour du joueur, jamais sous 1.
        xp: max(1, (playerXp * (0.4 + rng.nextDouble() * 1.2)).round()),
        starter: _starters[rng.nextInt(_starters.length)],
        name: noms[i],
      ),
  ];
}
