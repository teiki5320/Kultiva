import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/vegetables_base.dart';
import 'package:kultiva/models/culture_entry.dart';
import 'package:kultiva/models/plantation.dart';
import 'package:kultiva/services/culture_service.dart';
import 'package:kultiva/services/plantation_service.dart';
import 'package:kultiva/services/prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Une sauvegarde illisible ne doit jamais être remplacée par ce qu'on
/// croit avoir en mémoire.
///
/// `decodeAll` renvoyait une liste vide aussi bien pour « aucun plant »
/// que pour « sauvegarde corrompue ». La première mutation réécrivait
/// alors une liste d'un seul élément : toute la collection disparaissait,
/// sans compte ni sauvegarde pour la récupérer. C'est la même famille de
/// bug que la purge des photos orphelines.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final prefs = PrefsService.instance;
  final plants = PlantationService.instance;
  final cultures = CultureService.instance;

  group('décodeurs', () {
    test('une sauvegarde illisible se distingue d\'une sauvegarde vide', () {
      expect(Plantation.decodeAllOrNull(null), isEmpty);
      expect(Plantation.decodeAllOrNull(''), isEmpty);
      expect(Plantation.decodeAllOrNull('pas-du-json'), isNull);
      expect(Plantation.decodeAllOrNull('{"foo":1}'), isNull);

      expect(CultureEntry.decodeAllOrNull(null), isEmpty);
      expect(CultureEntry.decodeAllOrNull('pas-du-json'), isNull);
    });

    test('decodeAll garde son comportement tolérant', () {
      expect(Plantation.decodeAll('pas-du-json'), isEmpty);
      expect(CultureEntry.decodeAll('pas-du-json'), isEmpty);
    });
  });

  group('collection', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues(<String, Object>{
        'kultiva.plantations.v1': 'sauvegarde-cassee',
      });
      await prefs.load();
      plants.load();
    });

    test('ajouter un plant ne réécrit pas une sauvegarde illisible',
        () async {
      await plants.add('tomate');
      // Le magasin est laissé intact : l'utilisateur garde une chance de
      // récupérer ses données, et on ne les remplace pas par ce seul
      // plant.
      expect(prefs.plantationsJson, 'sauvegarde-cassee');
    });

    test('arroser et récolter ne réécrivent rien non plus', () async {
      await plants.water('nimporte');
      await plants.harvest('nimporte');
      expect(prefs.plantationsJson, 'sauvegarde-cassee');
    });
  });

  group('cahier de culture', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues(<String, Object>{
        'kultiva.cultures.v1': 'sauvegarde-cassee',
      });
      await prefs.load();
      plants.load();
    });

    test('démarrer une culture ne réécrit pas un cahier illisible',
        () async {
      await cultures.add(
        vegetableId: 'tomate',
        startedAt: DateTime(2026, 5, 1),
      );
      expect(prefs.culturesJson, 'sauvegarde-cassee');
    });

    test('le rattachement des anciennes entrées s\'abstient', () async {
      await cultures.linkLegacyEntries();
      expect(prefs.culturesJson, 'sauvegarde-cassee');
    });
  });

  group('légume introuvable', () {
    test('un identifiant inconnu ne renvoie pas le premier du catalogue', () {
      // Quatre écrans du potager carré affichaient une TOMATE à la place
      // du légume manquant.
      final v = vegetableById('cette-espece-nexiste-pas');
      expect(v.id, '_inconnu');
      expect(v.name, 'Légume inconnu');
      expect(v.id, isNot(vegetablesBase.first.id));
    });

    test('un identifiant connu est bien résolu', () {
      expect(vegetableById('tomate').id, 'tomate');
    });
  });
}
