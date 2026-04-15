import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

import 'prefs_service.dart';

/// Sons disponibles.
enum Sfx {
  tap('sounds/sfx_tap.mp3'),
  plant('sounds/sfx_plant.mp3'),
  favorite('sounds/sfx_favorite.mp3'),
  drop('sounds/sfx_drop.mp3'),
  rain('sounds/sfx_rain.mp3'),
  cart('sounds/sfx_cart.mp3');

  final String asset;
  const Sfx(this.asset);
}

/// Service audio — effets sonores + musique de fond.
class AudioService {
  AudioService._();
  static final AudioService instance = AudioService._();

  // Plusieurs players pour que les sons se superposent sans se couper.
  final List<AudioPlayer> _sfxPool = List.generate(4, (_) => AudioPlayer());
  int _poolIndex = 0;

  // Player dédié à la musique de fond (loop).
  final AudioPlayer _musicPlayer = AudioPlayer();
  bool _musicPlaying = false;

  /// Joue un effet sonore si l'utilisateur a activé les sons.
  Future<void> play(Sfx sfx) async {
    if (!PrefsService.instance.soundEnabled.value) return;
    try {
      final player = _sfxPool[_poolIndex];
      _poolIndex = (_poolIndex + 1) % _sfxPool.length;
      await player.stop();
      await player.setVolume(PrefsService.instance.soundVolume.value);
      await player.play(AssetSource(sfx.asset));
    } catch (e) {
      if (kDebugMode) debugPrint('AudioService.play error: $e');
    }
  }

  /// Démarre la musique de fond (ou la redémarre).
  Future<void> startMusic() async {
    if (_musicPlaying) return;
    if (!PrefsService.instance.musicEnabled.value) return;
    try {
      await _musicPlayer.setReleaseMode(ReleaseMode.loop);
      await _musicPlayer.setVolume(PrefsService.instance.soundVolume.value * 0.5);
      await _musicPlayer.play(AssetSource('sounds/music_loop.mp3'));
      _musicPlaying = true;
    } catch (e) {
      if (kDebugMode) debugPrint('AudioService.startMusic error: $e');
    }
  }

  /// Arrête la musique de fond.
  Future<void> stopMusic() async {
    try {
      await _musicPlayer.stop();
      _musicPlaying = false;
    } catch (_) {}
  }

  /// Met à jour le volume de la musique en direct.
  Future<void> setMusicVolume(double v) async {
    try {
      await _musicPlayer.setVolume(v * 0.5);
    } catch (_) {}
  }
}
