import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/services/plant_vision_service.dart';

/// Le contrat de [PlantVisionService] : **ne jamais lever**.
///
/// Il n'y a pas de modèle ML Kit dans un `flutter_test` — le canal natif
/// n'existe pas. C'est exactement la situation à vérifier : la fiche
/// conseil doit s'afficher entière quand la lecture de photo est
/// impossible, et retomber sur l'estimation par date.
void main() {
  test('un chemin inexistant ne lève pas et ne voit rien', () async {
    final h = await PlantVisionService.instance
        .read('/chemin/qui/nexiste/pas/photo.jpg');
    expect(h.plantSeen, isFalse);
    expect(h.compatible, isEmpty);
  });

  test('un chemin vide ne lève pas non plus', () async {
    final h = await PlantVisionService.instance.read('');
    expect(h.plantSeen, isFalse);
  });
}
