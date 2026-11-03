import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter_test/flutter_test.dart';
import 'package:kultiva/data/vegetables_base.dart';

/// Deux légumes différents ne doivent pas montrer la même image.
///
/// ⚠️ **Le défaut que ça attrape.** `assets_exist_test.dart` vérifie
/// qu'un fichier existe, et qu'un fichier embarqué sert à quelqu'un.
/// Aucun des deux ne regarde **ce que l'image montre**. C'est le même
/// angle mort que les quatre médaillons de badge du 31/10/2026 : le
/// fichier existe, il raconte simplement autre chose.
///
/// Trouvé le 03/11/2026 en garnissant une installation pour les
/// captures des boutiques : le cahier affichait une courgette sous
/// « Haricot vert ».
///
/// **Comment on compare.** Chaque image est réduite à 16×16 et on
/// mesure l'écart moyen par canal de couleur.
/// ⚠️ Une empreinte en **noir et blanc ne marche pas** : ces images
/// sont toutes « un objet centré sur fond crème », donc elles se
/// ressemblent toutes en luminance — une carotte orange et une
/// aubergine violette donnaient la même empreinte. C'est la couleur
/// qui sépare.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  /// En dessous, deux images montrent le même sujet. Mesuré : les
  /// doublons avérés sont entre 4 et 6, et la première paire
  /// légitimement proche (panais et salsifis, deux racines pâles) est
  /// à 7,6.
  const seuil = 7.0;

  /// Les doublons **connus**, avec ce qu'il faudrait faire.
  ///
  /// ⚠️ Ce n'est pas une liste d'exceptions tolérées : c'est une dette
  /// datée. Chaque paire ici est une image à refaire, et la refaire
  /// coûte des crédits OpenArt — à demander à Jean avant de dépenser
  /// (règle permanente).
  ///
  /// **Elle est vide depuis le 03/11/2026** : les trois images fausses
  /// (`haricot` et `concombre` qui montraient une courgette, `navet`
  /// qui montrait un radis) ont été refaites en une planche 2×2,
  /// 37 crédits. Le test existe maintenant pour qu'une quatrième ne
  /// s'ajoute pas sans qu'on le voie.
  const dette = <String, String>{};

  Future<List<int>> vignette(String chemin) async {
    final octets = await File(chemin).readAsBytes();
    final codec = await ui.instantiateImageCodec(
      Uint8List.fromList(octets),
      targetWidth: 16,
      targetHeight: 16,
    );
    final image = (await codec.getNextFrame()).image;
    final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    image.dispose();
    codec.dispose();
    return data!.buffer.asUint8List().toList();
  }

  test('deux légumes ne montrent pas la même image', () async {
    final images = <String, List<int>>{};
    for (final v in vegetablesBase) {
      final a = v.imageAsset;
      // Seules les cultures ont une image à elles ; les accessoires
      // partagent des photos d'outils, où la ressemblance est normale.
      if (a == null || !a.contains('/vegetables/')) continue;
      if (!File(a).existsSync()) continue;
      images[v.id] = await vignette(a);
    }
    expect(images.length, greaterThan(100),
        reason: 'trop peu d\'images lues : le test ne prouverait rien.');

    final ids = images.keys.toList()..sort();
    final trouves = <String>[];
    for (var i = 0; i < ids.length; i++) {
      for (var j = i + 1; j < ids.length; j++) {
        final a = images[ids[i]]!;
        final b = images[ids[j]]!;
        var somme = 0;
        for (var k = 0; k < a.length; k += 4) {
          somme += (a[k] - b[k]).abs() +
              (a[k + 1] - b[k + 1]).abs() +
              (a[k + 2] - b[k + 2]).abs();
        }
        final ecart = somme / (a.length / 4 * 3);
        if (ecart > seuil) continue;
        final cle = '${ids[i]}|${ids[j]}';
        if (dette.containsKey(cle)) continue;
        trouves.add('${ids[i]} et ${ids[j]} : écart '
            '${ecart.toStringAsFixed(2)} — même sujet ?');
      }
    }
    expect(trouves, isEmpty,
        reason: 'Deux légumes partagent une image :\n'
            '${trouves.join('\n')}\n'
            'Si la ressemblance est légitime (deux racines pâles, par '
            'exemple), ajoute la paire à `dette` en disant pourquoi.');
  });

  test('la dette d\'images ne parle que de légumes du catalogue', () {
    // Une paire qui ne correspond plus à rien, c'est une dette qu'on
    // croit avoir et qui n'existe plus — ou une faute de frappe.
    final ids = <String>{for (final v in vegetablesBase) v.id};
    for (final cle in dette.keys) {
      for (final id in cle.split('|')) {
        expect(ids.contains(id), isTrue, reason: '« $id » n\'existe pas.');
      }
      expect(dette[cle]!.length, greaterThan(20),
          reason: '$cle : dis ce qu\'il faut faire, pas seulement '
              'qu\'il y a un doublon.');
    }
  });
}
