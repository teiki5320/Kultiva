import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/garden_photo.dart';
import '../models/plantation.dart';
import 'plantation_service.dart';
import 'prefs_service.dart';

/// Rassemble les photos du jardin, éparpillées dans deux magasins.
///
/// Ce service **ne stocke rien**. Il lit `PlantationService` pour les
/// photos de plants et la préférence des défis pour les photos de
/// défis, et en construit une liste datée. Ajouter, supprimer ou
/// déplacer une photo reste l'affaire du propriétaire de la donnée —
/// ici on ne fait que regarder.
///
/// Pourquoi ça existe : jusqu'ici une photo n'était visible que depuis
/// le plant ou le défi auquel elle était accrochée. Personne ne pouvait
/// voir son jardin en photos, ni suivre un plant d'une semaine à
/// l'autre, alors que les fichiers étaient là depuis le début.
class PhotoLibraryService {
  PhotoLibraryService._();

  /// Toutes les photos du jardin, de la plus récente à la plus ancienne.
  static List<GardenPhoto> all() {
    final photos = <GardenPhoto>[
      ...plantPhotos(),
      ...challengePhotos(),
    ];
    photos.sort((a, b) => b.takenAt.compareTo(a.takenAt));
    return photos;
  }

  /// Les photos d'un plant, de la plus ancienne à la plus récente —
  /// l'ordre dans lequel on regarde quelque chose pousser.
  static List<GardenPhoto> forPlantation(String plantationId) {
    final photos = plantPhotos()
        .where((p) => p.plantationId == plantationId)
        .toList()
      ..sort((a, b) => a.takenAt.compareTo(b.takenAt));
    return photos;
  }

  /// Les plants qui ont au moins une photo, le mieux fourni d'abord.
  static List<Plantation> plantsWithPhotos() {
    final plants = PlantationService.instance.all
        .where((p) => p.photoPaths.any(_isLocal))
        .toList();
    plants.sort((a, b) {
      final n = b.photoPaths.length.compareTo(a.photoPaths.length);
      return n != 0 ? n : b.plantedAt.compareTo(a.plantedAt);
    });
    return plants;
  }

  @visibleForTesting
  static List<GardenPhoto> plantPhotos() {
    final out = <GardenPhoto>[];
    for (final p in PlantationService.instance.all) {
      for (final path in p.photoPaths) {
        if (!_isLocal(path)) continue;
        // Faute de date dans le nom (photo d'une très vieille version),
        // on la rattache au jour de la plantation plutôt que de la
        // perdre : elle sera mal placée dans la pellicule, pas absente.
        final prise = takenAtFromPath(path) ?? p.plantedAt;
        out.add(GardenPhoto(
          path: path,
          takenAt: prise,
          source: PhotoSource.plant,
          plantationId: p.id,
          vegetableId: p.vegetableId,
          dayAfterPlanting: _joursEntre(p.plantedAt, prise),
        ));
      }
    }
    return out;
  }

  @visibleForTesting
  static List<GardenPhoto> challengePhotos() {
    final raw = PrefsService.instance.getString('kultiva.challenges.v1');
    if (raw == null || raw.isEmpty) return const <GardenPhoto>[];
    final Map<String, dynamic> map;
    try {
      map = jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      // Préférence illisible : la pellicule montre les plants et se tait
      // sur les défis, plutôt que de refuser de s'ouvrir.
      return const <GardenPhoto>[];
    }
    final out = <GardenPhoto>[];
    map.forEach((challengeId, value) {
      if (value is! String || !_isLocal(value)) return;
      final prise = takenAtFromPath(value);
      if (prise == null) return;
      out.add(GardenPhoto(
        path: value,
        takenAt: prise,
        source: PhotoSource.challenge,
        challengeId: challengeId,
      ));
    });
    return out;
  }

  /// La date de prise de vue, lue dans le nom du fichier.
  ///
  /// `PhotoService` nomme chaque photo `plant_<millisecondes>.jpg` quand
  /// il la copie dans le dossier de l'app. C'est la seule date dont on
  /// dispose : ni `Plantation` ni le magasin des défis n'enregistrent
  /// quand une photo a été prise. La lire dans le nom évite un accès
  /// disque par photo à chaque construction de la liste.
  @visibleForTesting
  static DateTime? takenAtFromPath(String path) {
    final nom = path.split('/').last;
    final m = RegExp(r'^plant_(\d{10,16})\.').firstMatch(nom);
    if (m == null) return null;
    final ms = int.tryParse(m.group(1)!);
    if (ms == null) return null;
    final date = DateTime.fromMillisecondsSinceEpoch(ms);
    // Une valeur aberrante (nom bricolé, horloge déréglée) vaut mieux
    // ignorée que placée en 1970 ou en 2184 dans la pellicule.
    if (date.year < 2020 || date.year > DateTime.now().year + 1) return null;
    return date;
  }

  /// Le nombre de jours **calendaires** entre deux instants.
  ///
  /// `difference().inDays` compte des tranches de 24 h : un plant mis en
  /// terre à 10 h et photographié douze jours plus tard à 9 h donnait
  /// « J+11 ». Un jardinier compte les matins, pas les heures.
  static int _joursEntre(DateTime debut, DateTime fin) {
    final d = DateTime(debut.year, debut.month, debut.day);
    final f = DateTime(fin.year, fin.month, fin.day);
    return f.difference(d).inDays;
  }

  /// Les photos distantes datent du temps des comptes, retiré le
  /// 30/10/2026. L'app n'a plus de couche réseau pour les afficher.
  static bool _isLocal(String path) =>
      path.isNotEmpty && !path.startsWith('http');
}
