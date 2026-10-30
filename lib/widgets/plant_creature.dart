import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../services/audio_service.dart';
import 'creature_painter.dart';
import 'creature_starter.dart';

export 'creature_starter.dart';

/// La créature-plante du Poussidex. Rendue 100% en CustomPainter —
/// son apparence évolue avec le niveau.
class PlantCreature extends StatefulWidget {
  final int level;
  final CreatureStarter starter;
  final double size;
  final VoidCallback? onTap;

  const PlantCreature({
    super.key,
    required this.level,
    this.starter = CreatureStarter.poussia,
    this.size = 220,
    this.onTap,
  });

  @override
  State<PlantCreature> createState() => _PlantCreatureState();
}

class _PlantCreatureState extends State<PlantCreature>
    with TickerProviderStateMixin {
  late final AnimationController _breathCtrl;
  late final AnimationController _blinkCtrl;
  late final AnimationController _swayCtrl;
  late final AnimationController _tapCtrl;
  late final AnimationController _danceCtrl;
  late final AnimationController _sneezeCtrl;
  late final AnimationController _sleepCtrl; // pour fade in/out du "Zzz"

  Timer? _blinkTimer;
  Timer? _danceTimer;
  Timer? _sneezeTimer;
  Timer? _sleepTimer;
  StreamSubscription<AccelerometerEvent>? _accelSub;

  final math.Random _rng = math.Random();

  // Inclinaison du téléphone (−1..1 sur x, filtrée).
  double _tiltX = 0;
  // Dernière magnitude pour détecter le "shake".
  double _lastAccelMagnitude = 9.8;
  bool _shaking = false;
  DateTime? _lastShake;
  late final AnimationController _shakeCtrl;

  // Variante d'emoji affiché au tap.
  String _tapEmoji = '❤️';
  bool _showTapEmoji = false;

  bool _sleeping = false;
  bool _sneezing = false;

  // Position normalisée du dernier drag pour les yeux qui suivent.
  // (-1..1 en x et y, relatif au centre de la créature.)
  Offset _eyeLook = Offset.zero;

  @override
  void initState() {
    super.initState();
    _breathCtrl = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..repeat(reverse: true);
    _blinkCtrl = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _swayCtrl = AnimationController(
      duration: const Duration(milliseconds: 3200),
      vsync: this,
    )..repeat(reverse: true);
    _tapCtrl = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _danceCtrl = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _sneezeCtrl = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _sleepCtrl = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _shakeCtrl = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _scheduleBlink();
    _scheduleDance();
    _scheduleSneeze();
    _armSleepTimer();
    _startAccelListener();
  }

  void _startAccelListener() {
    _accelSub = accelerometerEventStream(
      samplingPeriod: const Duration(milliseconds: 100),
    ).listen((event) {
      if (!mounted) return;
      // Inclinaison : x négatif = penche à gauche.
      final filtered = _tiltX * 0.8 + (event.x / 9.8) * 0.2;
      _tiltX = filtered.clamp(-1.0, 1.0);
      // Shake : magnitude globale d'accélération.
      final mag =
          math.sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
      final delta = (mag - _lastAccelMagnitude).abs();
      _lastAccelMagnitude = mag;
      if (delta > 18 && !_shaking) {
        final now = DateTime.now();
        if (_lastShake == null ||
            now.difference(_lastShake!).inMilliseconds > 2000) {
          _lastShake = now;
          _triggerShake();
        }
      }
      setState(() {});
    });
  }

  void _triggerShake() {
    HapticFeedback.mediumImpact();
    AudioService.instance.play(Sfx.shake);
    setState(() => _shaking = true);
    _shakeCtrl.forward(from: 0).whenComplete(() {
      if (mounted) setState(() => _shaking = false);
    });
    _wake();
  }

  void _scheduleBlink() {
    _blinkTimer = Timer(
      Duration(milliseconds: 2500 + _rng.nextInt(3000)),
      () {
        if (!mounted) return;
        if (!_sleeping) {
          _blinkCtrl.forward().then((_) {
            if (mounted) _blinkCtrl.reverse();
          });
        }
        _scheduleBlink();
      },
    );
  }

  void _scheduleDance() {
    _danceTimer = Timer(
      Duration(seconds: 20 + _rng.nextInt(15)),
      () {
        if (!mounted) return;
        if (!_sleeping) _danceCtrl.forward(from: 0);
        _scheduleDance();
      },
    );
  }

  void _scheduleSneeze() {
    // Éternuement rare : toutes les 45-90s, 30% de chance.
    _sneezeTimer = Timer(
      Duration(seconds: 45 + _rng.nextInt(45)),
      () {
        if (!mounted) return;
        if (!_sleeping && _rng.nextDouble() < 0.30) {
          _triggerSneeze();
        }
        _scheduleSneeze();
      },
    );
  }

  void _triggerSneeze() {
    HapticFeedback.lightImpact();
    AudioService.instance.play(Sfx.sneeze);
    setState(() => _sneezing = true);
    _sneezeCtrl.forward(from: 0).whenComplete(() {
      if (mounted) setState(() => _sneezing = false);
    });
  }

  void _armSleepTimer() {
    _sleepTimer?.cancel();
    _sleepTimer = Timer(const Duration(seconds: 30), () {
      if (!mounted) return;
      setState(() => _sleeping = true);
      _sleepCtrl.forward();
    });
  }

  void _wake() {
    if (_sleeping) {
      setState(() => _sleeping = false);
      _sleepCtrl.reverse();
    }
    _armSleepTimer();
  }

  @override
  void dispose() {
    _blinkTimer?.cancel();
    _danceTimer?.cancel();
    _sneezeTimer?.cancel();
    _sleepTimer?.cancel();
    _accelSub?.cancel();
    _breathCtrl.dispose();
    _blinkCtrl.dispose();
    _swayCtrl.dispose();
    _tapCtrl.dispose();
    _danceCtrl.dispose();
    _sneezeCtrl.dispose();
    _sleepCtrl.dispose();
    _shakeCtrl.dispose();
    super.dispose();
  }

  static const _tapEmojis = <String>['❤️', '🎵', '✨', '⭐', '💕', '🌟'];

  void _onTap() {
    _wake();
    HapticFeedback.lightImpact();
    AudioService.instance.play(Sfx.creatureTap);
    widget.onTap?.call();
    setState(() {
      _tapEmoji = _tapEmojis[_rng.nextInt(_tapEmojis.length)];
      _showTapEmoji = true;
    });
    _tapCtrl.forward(from: 0).then((_) {
      if (mounted) setState(() => _showTapEmoji = false);
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _wake();
    // Position locale (0..widget.size) → normalisée autour du centre.
    final cx = widget.size / 2;
    final cy = widget.size / 2;
    final dx = ((details.localPosition.dx - cx) / cx).clamp(-1.0, 1.0);
    final dy = ((details.localPosition.dy - cy) / cy).clamp(-1.0, 1.0);
    setState(() => _eyeLook = Offset(dx, dy));
  }

  void _onPanEnd(_) {
    // Les yeux reviennent lentement au centre.
    setState(() => _eyeLook = Offset.zero);
  }

  /// Mapping niveau → chemin d'asset PNG (null si pas d'illustration
  /// disponible, on retombe alors sur le CustomPainter).
  String? _assetPathForLevel() {
    final lv = widget.level;
    final String folder;
    final String prefix;
    switch (widget.starter) {
      case CreatureStarter.poussia:
        folder = 'Poussia';
        prefix = 'P';
        break;
      case CreatureStarter.soleia:
        folder = 'Soleia';
        prefix = 'S';
        break;
      case CreatureStarter.spira:
        folder = 'Spira';
        prefix = 'SP';
        break;
    }
    final base = 'assets/images/creatures/$folder';
    final int n;
    if (lv >= 100) {
      n = 11;
    } else if (lv >= 75) {
      n = 10;
    } else if (lv >= 60) {
      n = 9;
    } else if (lv >= 50) {
      n = 8;
    } else if (lv >= 40) {
      n = 7;
    } else if (lv >= 30) {
      n = 6;
    } else if (lv >= 20) {
      n = 5;
    } else if (lv >= 15) {
      n = 4;
    } else if (lv >= 10) {
      n = 3;
    } else if (lv >= 5) {
      n = 2;
    } else {
      n = 1;
    }
    return '$base/$prefix$n.png';
  }

  /// Retourne soit une Image.asset (si illustration dispo) soit le
  /// CustomPainter de fallback.
  Widget _buildCreatureVisual() {
    final assetPath = _assetPathForLevel();
    if (assetPath != null) {
      // Les 4 premiers stades (graines + germe) sont dessinés plus gros
      // par l'IA → on les réduit pour matcher les autres stades.
      final scale = widget.level < 20 ? 0.85 : 1.0;
      Widget image = SizedBox.square(
        dimension: widget.size,
        child: Image.asset(
          assetPath,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => CustomPaint(
            size: Size.square(widget.size),
            painter: CreaturePainter(
              level: widget.level,
              starter: widget.starter,
              blink: _blinkCtrl.value,
            ),
          ),
        ),
      );
      if (scale != 1.0) {
        image = Transform.scale(scale: scale, child: image);
      }
      return image;
    }
    return CustomPaint(
      size: Size.square(widget.size),
      painter: CreaturePainter(
        level: widget.level,
        starter: widget.starter,
        blink: _blinkCtrl.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Tamassi ${widget.starter.name}, niveau ${widget.level}',
      child: GestureDetector(
        onTap: _onTap,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        behavior: HitTestBehavior.opaque,
        child: SizedBox.square(
          dimension: widget.size,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: <Widget>[
              AnimatedBuilder(
                animation: Listenable.merge(<Listenable>[
                  _breathCtrl,
                  _blinkCtrl,
                  _swayCtrl,
                  _tapCtrl,
                  _danceCtrl,
                  _sneezeCtrl,
                  _shakeCtrl,
                ]),
                builder: (context, _) {
                  final t = _breathCtrl.value;
                  final breathScale = _sleeping
                      ? 1.0 + 0.015 * math.sin(t * math.pi)
                      : 1.0 + 0.03 * math.sin(t * math.pi);
                  final sway =
                      0.03 * math.sin(_swayCtrl.value * math.pi * 2 - math.pi);
                  final tap = _tapCtrl.value;
                  final squash = tap < 0.3
                      ? 1.0 - 0.12 * (tap / 0.3)
                      : 1.0 - 0.12 * (1.0 - (tap - 0.3) / 0.7);
                  final stretch = tap < 0.3
                      ? 1.0 + 0.08 * (tap / 0.3)
                      : 1.0 + 0.08 * (1.0 - (tap - 0.3) / 0.7);
                  final dance = _danceCtrl.value > 0
                      ? math.sin(_danceCtrl.value * math.pi * 4) * 0.12
                      : 0.0;
                  final sneeze = _sneezeCtrl.value;
                  final sneezeScale = sneeze < 0.3
                      ? 1.0 - 0.10 * (sneeze / 0.3)
                      : 1.0 + 0.10 * math.sin((sneeze - 0.3) / 0.7 * math.pi);
                  final lookDx = _eyeLook.dx * widget.size * 0.04;
                  final lookDy = _eyeLook.dy * widget.size * 0.02;
                  // Inclinaison du téléphone : rotation douce.
                  final tilt = -_tiltX * 0.18;
                  // Shake : spin 360° quand secoué.
                  final shakeSpin = _shakeCtrl.value > 0
                      ? _shakeCtrl.value * math.pi * 2
                      : 0.0;
                  return Transform.translate(
                    offset: Offset(lookDx, lookDy),
                    child: Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()
                        ..rotateZ(sway + dance + tilt + shakeSpin)
                        ..scaleByDouble(
                          squash * breathScale * sneezeScale,
                          stretch * breathScale * sneezeScale,
                          squash * breathScale * sneezeScale,
                          1.0,
                        ),
                      child: _buildCreatureVisual(),
                    ),
                  );
                },
              ),
              // Emoji flottant au tap.
              if (_showTapEmoji)
                AnimatedBuilder(
                  animation: _tapCtrl,
                  builder: (context, child) {
                    final p = _tapCtrl.value;
                    return Positioned(
                      top: widget.size * 0.05 - p * widget.size * 0.15,
                      child: Opacity(
                        opacity: (1.0 - p).clamp(0.0, 1.0),
                        child: Transform.scale(
                          scale: 0.5 + p * 0.8,
                          child: Text(_tapEmoji,
                              style: const TextStyle(fontSize: 30)),
                        ),
                      ),
                    );
                  },
                ),
              // "Zzz" quand dort.
              AnimatedBuilder(
                animation: _sleepCtrl,
                builder: (_, __) {
                  if (_sleepCtrl.value == 0) return const SizedBox.shrink();
                  return Positioned(
                    top: -8,
                    right: widget.size * 0.10,
                    child: Opacity(
                      opacity: _sleepCtrl.value,
                      child: const Text(
                        '💤',
                        style: TextStyle(fontSize: 32),
                      ),
                    ),
                  );
                },
              ),
              // Bulle "Atchoum!" + goutte lors de l'éternuement.
              if (_sneezing)
                AnimatedBuilder(
                  animation: _sneezeCtrl,
                  builder: (_, __) {
                    final p = _sneezeCtrl.value;
                    final opacity = p < 0.1
                        ? p / 0.1
                        : (1 - (p - 0.5) / 0.5).clamp(0.0, 1.0);
                    return Positioned(
                      top: widget.size * 0.05,
                      right: -widget.size * 0.05,
                      child: Opacity(
                        opacity: opacity,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Text(
                            'Atchoum !',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
