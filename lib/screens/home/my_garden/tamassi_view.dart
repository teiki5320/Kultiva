import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../models/tamassi_visitor.dart';
import '../../../models/weather_data.dart';
import '../../../services/audio_service.dart';
import '../../../services/cloud_sync_service.dart';
import '../../../services/prefs_service.dart';
import '../../../services/tamassi_stats.dart';
import '../../../services/weather_service.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/plant_creature.dart';
import '../../../widgets/tamassi_story_card.dart';
import '../my_garden_screen.dart';
import 'kawaii_background.dart';
import 'tamassi_widgets.dart';

export 'tamassi_widgets.dart' show TamassiEffect;

/// Vue Tamassi — la créature du joueur avec animations.
/// Si aucun starter n'est choisi, affiche l'écran de sélection.
class TamassiView extends StatefulWidget {
  const TamassiView({super.key});

  @override
  State<TamassiView> createState() => TamassiViewState();
}

class TamassiViewState extends State<TamassiView>
    with TickerProviderStateMixin {
  static const _kStarter = 'kultiva.creature.starter';
  static const _kName = 'kultiva.creature.name';
  static const _kStreak = 'kultiva.creature.streak';
  static const _kLastSeen = 'kultiva.creature.lastSeen';

  double _level = 5;
  late final AnimationController _effectCtrl;
  late final AnimationController _crossingCtrl;
  late final AnimationController _evolveCtrl;
  late final AnimationController _celebrateCtrl;
  late final AnimationController _ambientCtrl;
  TamassiEffect? _effect;

  CreatureStarter? _starter;
  String _creatureName = '';
  int _streak = 0;

  // XP réel (différent de _level qui vient du slider debug).
  // Gagné via Arroser (+5), Engrais (+10), Défi complété (+20).
  int _xp = 0;
  static const _kXp = 'kultiva.creature.xp';
  static const _kLastWater = 'kultiva.creature.lastWater';
  static const _kLastFertilize = 'kultiva.creature.lastFertilize';
  static const _kLastCaress = 'kultiva.creature.lastCaress';

  String _prevStage = '';
  bool _showEvolve = false;
  bool _celebrating = false;

  bool _showGreeting = false;
  Timer? _greetingTimer;
  Timer? _crossingTimer;
  CrossingAnimal? _currentCrossing;
  bool _crossingLTR = true;
  WeatherData? _weatherCache;

  // Visites d'amis : un autre Tamassi traverse l'écran en bas.
  Timer? _visitTimer;
  late final AnimationController _visitCtrl;
  TamassiVisitor? _currentVisitor;
  bool _visitorLTR = true;

  @override
  void initState() {
    super.initState();
    _effectCtrl = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    );
    _crossingCtrl = AnimationController(
      duration: const Duration(milliseconds: 6000),
      vsync: this,
    );
    _evolveCtrl = AnimationController(
      duration: const Duration(milliseconds: 4500),
      vsync: this,
    );
    _celebrateCtrl = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );
    _ambientCtrl = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
    _visitCtrl = AnimationController(
      duration: const Duration(milliseconds: 9000),
      vsync: this,
    );
    _loadCreature();
    _loadXp();
    _prevStage = _stageName;
    _updateStreak();
    _showGreetingBubble();
    _scheduleCrossing();
    _loadWeatherCache();
    _scheduleVisit();
    TamassiStats.recordLogin();
    TamassiStats.recordTab('tamassi');
    tamassiResetNotifier.addListener(_onResetRequested);
  }

  void _scheduleVisit() {
    // Première visite après 30-90s, puis toutes les 2-5 min.
    final firstDelay = Duration(seconds: 30 + Random().nextInt(60));
    _visitTimer = Timer(firstDelay, () async {
      if (!mounted) return;
      final visitors = await CloudSyncService.instance.fetchTamassiVisitors(
        count: 1,
      );
      if (!mounted) return;
      if (visitors.isNotEmpty) {
        setState(() {
          _currentVisitor = visitors.first;
          _visitorLTR = !_visitorLTR;
        });
        _visitCtrl.forward(from: 0).whenComplete(() {
          if (mounted) setState(() => _currentVisitor = null);
        });
      }
      // Replanifie pour toutes les 2-5 min.
      _visitTimer = Timer(
        Duration(seconds: 120 + Random().nextInt(180)),
        _scheduleVisitLoop,
      );
    });
  }

  void _scheduleVisitLoop() async {
    if (!mounted) return;
    final visitors =
        await CloudSyncService.instance.fetchTamassiVisitors(count: 1);
    if (!mounted) return;
    if (visitors.isNotEmpty) {
      setState(() {
        _currentVisitor = visitors.first;
        _visitorLTR = !_visitorLTR;
      });
      TamassiStats.incrementInt('visits');
      _visitCtrl.forward(from: 0).whenComplete(() {
        if (mounted) setState(() => _currentVisitor = null);
      });
    }
    _visitTimer = Timer(
      Duration(seconds: 120 + Random().nextInt(180)),
      _scheduleVisitLoop,
    );
  }

  Future<void> _loadWeatherCache() async {
    final w = await WeatherService.getWeather();
    if (!mounted) return;
    setState(() => _weatherCache = w);
    if (w != null) {
      unawaited(TamassiStats.recordWeather(w.currentWeatherCode));
    }
  }

  void _loadXp() {
    final stored = PrefsService.instance.getString(_kXp);
    final xp = stored == null ? 1 : int.tryParse(stored) ?? 1;
    _xp = xp.clamp(1, 100);
    _level = _xp.toDouble();
  }

  bool _canAct(String dayKeyPref) {
    final todayKey = _todayKey();
    return PrefsService.instance.getString(dayKeyPref) != todayKey;
  }

  String _todayKey() {
    final d = DateTime.now();
    return '${d.year}-${d.month}-${d.day}';
  }

  Future<void> _gainXp(int amount, String reason) async {
    final oldLevel = _xp;
    final newLevel = (_xp + amount).clamp(1, 100);
    if (newLevel == oldLevel) return;
    setState(() {
      _xp = newLevel;
      _level = _xp.toDouble();
    });
    await PrefsService.instance.setString(_kXp, _xp.toString());
    // Cloud sync (fire-and-forget).
    unawaited(CloudSyncService.instance.uploadXp(
      xp: _xp,
      starter: _starter?.name,
      creatureName: _creatureName,
    ));
    _checkLevelUp();
    // Toast "+X XP" en haut de l'écran.
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('+$amount XP · $reason'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          backgroundColor: KultivaColors.primaryGreen,
        ),
      );
    }
  }

  void _onResetRequested() {
    if (!mounted) return;
    PrefsService.instance.setString(_kXp, '1');
    PrefsService.instance.setString(_kLastWater, '');
    PrefsService.instance.setString(_kLastFertilize, '');
    PrefsService.instance.setString(_kLastCaress, '');
    setState(() {
      _starter = null;
      _creatureName = '';
      _xp = 1;
      _level = 1;
    });
  }

  /// Déclenché par le parent quand un défi est complété.
  void triggerCelebration() {
    HapticFeedback.heavyImpact();
    AudioService.instance.play(Sfx.celebrate);
    setState(() => _celebrating = true);
    _celebrateCtrl.forward(from: 0).whenComplete(() {
      if (mounted) setState(() => _celebrating = false);
    });
  }

  void _checkLevelUp() {
    final newStage = _stageName;
    if (newStage != _prevStage) {
      _prevStage = newStage;
      HapticFeedback.mediumImpact();
      AudioService.instance.play(Sfx.levelUp);
      setState(() => _showEvolve = true);
      _evolveCtrl.forward(from: 0).whenComplete(() {
        if (mounted) setState(() => _showEvolve = false);
      });
    }
  }

  void _updateStreak() {
    final prefs = PrefsService.instance;
    final lastSeenRaw = prefs.getString(_kLastSeen);
    final storedStreak = int.tryParse(prefs.getString(_kStreak) ?? '') ?? 0;
    final today = DateTime.now();
    final todayKey = '${today.year}-${today.month}-${today.day}';
    int next = storedStreak;
    if (lastSeenRaw == null) {
      next = 1;
    } else if (lastSeenRaw == todayKey) {
      // Déjà vu aujourd'hui : pas de changement.
      next = storedStreak > 0 ? storedStreak : 1;
    } else {
      final last = DateTime.tryParse(lastSeenRaw);
      if (last == null) {
        next = 1;
      } else {
        final diff = today.difference(last).inDays;
        next = diff == 1 ? storedStreak + 1 : 1;
      }
    }
    prefs.setString(_kLastSeen, todayKey);
    prefs.setString(_kStreak, next.toString());
    _streak = next;
  }

  bool get _isNight {
    final h = effectiveHour();
    return h >= 21 || h < 6;
  }

  void _showGreetingBubble() {
    if (_starter == null) return;
    setState(() => _showGreeting = true);
    _greetingTimer = Timer(const Duration(seconds: 4), () {
      if (mounted) setState(() => _showGreeting = false);
    });
  }

  String _greetingText() {
    final hour = effectiveHour();
    if (hour < 6) return 'Chut… 💤';
    if (hour < 12) return 'Bonjour ! ☀️';
    if (hour < 18) return 'Coucou ! 🌸';
    if (hour < 22) return 'Bonsoir ! 🌙';
    return 'Bonne nuit ! 💤';
  }

  void _scheduleCrossing() {
    _crossingTimer = Timer(
      Duration(seconds: 25 + Random().nextInt(35)),
      () {
        if (!mounted) return;
        final pool = _animalPoolForHour(effectiveHour());
        final animal = pool[Random().nextInt(pool.length)];
        setState(() {
          _currentCrossing = animal;
          _crossingLTR = !_crossingLTR;
        });
        // Track: pour débloquer "see_bee" / "see_butterfly".
        if (animal.emoji == '🐝') {
          TamassiStats.addToSet('animals', 'bee');
        } else if (animal.emoji == '🦋') {
          TamassiStats.addToSet('animals', 'butterfly');
        }
        _crossingCtrl.duration =
            Duration(milliseconds: animal.durationMs);
        _crossingCtrl.forward(from: 0).whenComplete(() {
          if (mounted) setState(() => _currentCrossing = null);
        });
        _scheduleCrossing();
      },
    );
  }

  List<CrossingAnimal> _animalPoolForHour(int hour) {
    final pool = <CrossingAnimal>[];
    if (hour >= 6 && hour < 12) {
      pool.addAll(const <CrossingAnimal>[
        CrossingAnimal(
            emoji: '🐦', style: CrossingStyle.flyHigh, durationMs: 5000),
        CrossingAnimal(
            emoji: '🐝', style: CrossingStyle.zigzag, durationMs: 6000),
      ]);
    } else if (hour >= 12 && hour < 18) {
      pool.addAll(const <CrossingAnimal>[
        CrossingAnimal(
            emoji: '🦋', style: CrossingStyle.zigzag, durationMs: 6000),
        CrossingAnimal(
            emoji: '🐞', style: CrossingStyle.groundSlow, durationMs: 8000),
        CrossingAnimal(
            emoji: '🐛', style: CrossingStyle.groundSlow, durationMs: 9000),
      ]);
    } else if (hour >= 18 && hour < 21) {
      pool.addAll(const <CrossingAnimal>[
        CrossingAnimal(
            emoji: '🦔', style: CrossingStyle.groundSlow, durationMs: 8000),
        CrossingAnimal(
            emoji: '🐸', style: CrossingStyle.hop, durationMs: 5000),
        CrossingAnimal(
            emoji: '🐿️', style: CrossingStyle.groundSlow, durationMs: 4000),
      ]);
    } else {
      // Nuit : chouette + chauve-souris (lucioles permanentes).
      pool.addAll(const <CrossingAnimal>[
        CrossingAnimal(
            emoji: '🦉', style: CrossingStyle.flyHigh, durationMs: 5500),
        CrossingAnimal(
            emoji: '🦇', style: CrossingStyle.zigzag, durationMs: 5000),
      ]);
    }
    // Bonus météo : renforce la cohérence avec le fond.
    final code = _weatherCache?.currentWeatherCode;
    if (code != null) {
      if (code >= 51 && code <= 67 || code >= 80 && code <= 82) {
        // Pluie : grenouille + escargot.
        pool.addAll(const <CrossingAnimal>[
          CrossingAnimal(
              emoji: '🐸', style: CrossingStyle.hop, durationMs: 5000),
          CrossingAnimal(
              emoji: '🐌',
              style: CrossingStyle.groundSlow,
              durationMs: 11000),
        ]);
      } else if (code >= 71 && code <= 77) {
        // Neige : pingouin qui glisse.
        pool.add(const CrossingAnimal(
            emoji: '🐧', style: CrossingStyle.groundSlow, durationMs: 6500));
      } else if (code == 0 || code == 1) {
        // Grand soleil : abeille supplémentaire.
        pool.add(const CrossingAnimal(
            emoji: '🐝', style: CrossingStyle.zigzag, durationMs: 6000));
      }
    }
    return pool;
  }

  void _loadCreature() {
    final raw = PrefsService.instance.getString(_kStarter);
    if (raw != null) {
      _starter = CreatureStarter.values.firstWhere(
        (s) => s.name == raw,
        orElse: () => CreatureStarter.poussia,
      );
      _creatureName = PrefsService.instance.getString(_kName) ?? '';
    }
  }

  Future<void> _selectStarter(CreatureStarter starter) async {
    AudioService.instance.play(Sfx.creatureTap);
    final name = await _askName(context, starter);
    if (name == null || name.trim().isEmpty) return;
    AudioService.instance.play(Sfx.success);
    await PrefsService.instance.setString(_kStarter, starter.name);
    await PrefsService.instance.setString(_kName, name.trim());
    if (!mounted) return;
    setState(() {
      _starter = starter;
      _creatureName = name.trim();
    });
    _showGreetingBubble();
  }

  Future<String?> _askName(
      BuildContext context, CreatureStarter starter) async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Nomme ta ${starter.name[0].toUpperCase()}${starter.name.substring(1)} !',
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          maxLength: 20,
          decoration: const InputDecoration(
            hintText: 'Ex: Poupoune, Sunny, Twisty…',
          ),
          onSubmitted: (v) {
            if (v.trim().isNotEmpty) Navigator.pop(ctx, v.trim());
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              final v = controller.text.trim();
              if (v.isNotEmpty) Navigator.pop(ctx, v);
            },
            child: const Text('Valider'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _greetingTimer?.cancel();
    _crossingTimer?.cancel();
    _visitTimer?.cancel();
    _visitCtrl.dispose();
    _effectCtrl.dispose();
    _crossingCtrl.dispose();
    _evolveCtrl.dispose();
    _celebrateCtrl.dispose();
    _ambientCtrl.dispose();
    tamassiResetNotifier.removeListener(_onResetRequested);
    super.dispose();
  }

  /// Déclenche l'effet visuel (gouttes/étincelles) et gagne de l'XP
  /// si l'action n'a pas encore été faite aujourd'hui.
  void triggerEffect(TamassiEffect effect) {
    HapticFeedback.mediumImpact();
    setState(() => _effect = effect);
    _effectCtrl.forward(from: 0).whenComplete(() {
      if (mounted) setState(() => _effect = null);
    });
    final todayKey = _todayKey();
    if (effect == TamassiEffect.water) {
      if (_canAct(_kLastWater)) {
        PrefsService.instance.setString(_kLastWater, todayKey);
        TamassiStats.incrementInt('water');
        _gainXp(1, '💧 Arrosage quotidien');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('💧 Déjà arrosé aujourd\'hui — reviens demain !'),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } else {
      if (_canAct(_kLastFertilize)) {
        PrefsService.instance.setString(_kLastFertilize, todayKey);
        TamassiStats.incrementInt('fertilize');
        _gainXp(2, '🌿 Engrais quotidien');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🌿 Déjà fertilisé aujourd\'hui — reviens demain !'),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  /// Appelée quand un défi photo est complété (+3 XP + tracking).
  void awardChallengeXp(String challengeId) {
    TamassiStats.addToSet('completed_challenges', challengeId);
    _gainXp(3, '📸 Défi complété !');
  }

  /// Tap sur la créature — petit bonjour quotidien (+3 XP).
  void _onPet() {
    if (_canAct(_kLastCaress)) {
      PrefsService.instance.setString(_kLastCaress, _todayKey());
      TamassiStats.incrementInt('pet');
      _gainXp(3, '👋 Bonjour quotidien');
    }
    // Pas de snackbar "déjà fait" — sinon on spammerait à chaque tap.
  }

  String get _stageName {
    final lv = _level.round();
    if (lv < 5) return 'Graine I';
    if (lv < 10) return 'Graine II';
    if (lv < 15) return 'Graine III';
    if (lv < 20) return 'Germe';
    if (lv < 30) return 'Pousse';
    if (lv < 40) return 'Bourgeon';
    if (lv < 50) return 'Fleur';
    if (lv < 60) return 'Plante';
    if (lv < 75) return 'Arbrisseau';
    if (lv < 100) return 'Arbre';
    return 'Arbre légendaire';
  }

  @override
  Widget build(BuildContext context) {
    // Pas de starter choisi → écran de sélection.
    if (_starter == null) {
      return _buildStarterSelection();
    }
    return _buildCreatureView();
  }

  Widget _buildStarterSelection() {
    return Stack(
      children: <Widget>[
        const Positioned.fill(child: KawaiiBackground()),
        SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              const Text(
                'Choisis ton compagnon',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Il t\'accompagnera dans tes aventures !',
                style: TextStyle(
                  fontSize: 13,
                  color: KultivaColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: AspectRatio(
                      aspectRatio: 3 / 2,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/creatures/3.png',
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => const Center(
                                child: Text('🌱🌻🌿',
                                    style: TextStyle(fontSize: 64)),
                              ),
                            ),
                          ),
                          // Zones cliquables : 3 tiers de l'image.
                          Positioned.fill(
                            child: Row(
                              children: <Widget>[
                                // Gauche : Soleia.
                                Expanded(
                                  child: StarterTapZone(
                                    onTap: () => _selectStarter(
                                        CreatureStarter.soleia),
                                  ),
                                ),
                                // Centre : Spira.
                                Expanded(
                                  child: StarterTapZone(
                                    onTap: () => _selectStarter(
                                        CreatureStarter.spira),
                                  ),
                                ),
                                // Droite : Poussia.
                                Expanded(
                                  child: StarterTapZone(
                                    onTap: () => _selectStarter(
                                        CreatureStarter.poussia),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 32),
                child: Text(
                  '👆 Tape sur ton compagnon',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCreatureView() {
    final lv = _level.round();
    final screenWidth = MediaQuery.of(context).size.width;
    final creatureSize = min(screenWidth * 0.9, 420.0);
    return Stack(
      children: <Widget>[
        const Positioned.fill(child: KawaiiBackground()),
        // Bouton "Partager Story" en haut à gauche.
        Positioned(
          top: 8,
          left: 8,
          child: SafeArea(
            child: Material(
              color: KultivaColors.primaryGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {
                  AudioService.instance.play(Sfx.tap);
                  showTamassiStoryShare(
                    context,
                    starter: _starter!,
                    creatureName: _creatureName,
                    level: lv,
                    stageName: _stageName,
                  );
                },
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.share, color: Colors.white, size: 14),
                      SizedBox(width: 4),
                      Text(
                        'Partager',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        // Bouton debug "+10 XP" en haut à droite (test d'évolution).
        Positioned(
          top: 8,
          right: 8,
          child: SafeArea(
            child: Material(
              color: Colors.black.withValues(alpha: 0.55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () => _gainXp(10, '🧪 Debug'),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text(
                    '+10 XP',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Visite d'ami : un autre Tamassi traverse l'écran en bas.
        if (_currentVisitor != null)
          AnimatedBuilder(
            animation: _visitCtrl,
            builder: (context, _) {
              final v = _currentVisitor!;
              final p = _visitCtrl.value;
              final w = MediaQuery.of(context).size.width;
              final h = MediaQuery.of(context).size.height;
              final x = _visitorLTR
                  ? -120 + p * (w + 240)
                  : w + 120 - p * (w + 240);
              final y = h * 0.62 + 6.0 * sin(p * pi * 4);
              return Positioned(
                left: x,
                top: y,
                child: VisitorBubble(visitor: v),
              );
            },
          ),
        // Animal qui traverse l'écran (selon l'heure).
        if (_currentCrossing != null)
          AnimatedBuilder(
            animation: _crossingCtrl,
            builder: (context, _) {
              final anim = _currentCrossing!;
              final p = _crossingCtrl.value;
              final w = MediaQuery.of(context).size.width;
              final h = MediaQuery.of(context).size.height;
              final x = _crossingLTR
                  ? -80 + p * (w + 160)
                  : w + 80 - p * (w + 160);
              late final double y;
              late final double rotateZ;
              late final double rotateY;
              switch (anim.style) {
                case CrossingStyle.flyHigh:
                  // Vol haut, ligne quasi droite avec léger bob.
                  y = 100.0 + 18.0 * sin(p * pi * 4);
                  rotateZ = _crossingLTR ? -0.08 : 0.08;
                  rotateY = sin(p * pi * 8) * 0.3;
                  break;
                case CrossingStyle.zigzag:
                  // Vol moyen en arc + battement.
                  y = 140.0 +
                      80.0 * (1 - (p - 0.5).abs() * 2) +
                      18.0 * sin(p * pi * 6);
                  rotateZ = _crossingLTR ? -0.1 : 0.1;
                  rotateY = sin(p * pi * 12) * 0.4;
                  break;
                case CrossingStyle.groundSlow:
                  // Déplacement au sol, légère ondulation.
                  y = h * 0.78 + 4.0 * sin(p * pi * 10);
                  rotateZ = 0;
                  rotateY = _crossingLTR ? 0 : pi; // miroir
                  break;
                case CrossingStyle.hop:
                  // Série de bonds paraboliques.
                  final hopPhase = (p * 4) % 1.0;
                  final hopHeight = 40.0 * (1 - (hopPhase * 2 - 1) * (hopPhase * 2 - 1));
                  y = h * 0.75 - hopHeight;
                  rotateZ = 0;
                  rotateY = _crossingLTR ? 0 : pi;
                  break;
              }
              return Positioned(
                left: x,
                top: y,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateZ(rotateZ)
                    ..rotateY(rotateY),
                  child: Text(
                    anim.emoji,
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              );
            },
          ),
        Column(
          children: <Widget>[
            // En-tête : nom de la créature (petit, centré, en haut).
            const SizedBox(height: 8),
            Text(
              _creatureName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
                color: KultivaColors.textSecondary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Niveau $lv',
              style: const TextStyle(
                fontSize: 11,
                color: KultivaColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (_streak >= 2) ...<Widget>[
              const SizedBox(height: 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Colors.orange.shade300, width: 1),
                ),
                child: Text(
                  '🔥 $_streak jours',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                    color: Colors.orange.shade800,
                  ),
                ),
              ),
            ],
            const Spacer(flex: 12),
            SizedBox(
              width: creatureSize,
              height: creatureSize,
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Positioned.fill(
                    child: PlantCreature(
                      level: lv,
                      size: creatureSize,
                      starter: _starter!,
                      onTap: _onPet,
                    ),
                  ),
                  // Lucioles qui tournoient autour de la créature la nuit.
                  if (_isNight)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: AnimatedBuilder(
                          animation: _ambientCtrl,
                          builder: (_, __) => CustomPaint(
                            painter: FireflyOrbitPainter(
                              progress: _ambientCtrl.value,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (_effect != null)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: AnimatedBuilder(
                          animation: _effectCtrl,
                          builder: (_, __) => CustomPaint(
                            painter: EffectPainter(
                              effect: _effect!,
                              progress: _effectCtrl.value,
                            ),
                          ),
                        ),
                      ),
                    ),
                  // Bulle de greeting (Bonjour/Coucou/Bonsoir...).
                  if (_showGreeting)
                    Positioned(
                      top: -8,
                      left: creatureSize * 0.55,
                      child: SpeechBubble(text: _greetingText()),
                    ),
                  // Évolution : grande animation cinématique (4.5s).
                  if (_showEvolve)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: AnimatedBuilder(
                          animation: _evolveCtrl,
                          builder: (_, __) {
                            final p = _evolveCtrl.value;
                            // Phase 1 : flash blanc (0-0.15)
                            // Phase 2 : rayons magiques qui tournent (0.05-0.85)
                            // Phase 3 : bandeau ÉVOLUTION qui grandit (0.2-0.9)
                            // Phase 4 : fade out tout (0.85-1.0)
                            final flashOpacity = p < 0.15
                                ? (p / 0.15) * 0.9
                                : p < 0.35
                                    ? 0.9 - ((p - 0.15) / 0.2) * 0.6
                                    : p > 0.85
                                        ? (1 - p) / 0.15 * 0.3
                                        : 0.3;
                            final raysProgress = (p - 0.05).clamp(0.0, 0.85);
                            final raysOpacity = p < 0.85
                                ? (raysProgress * 2).clamp(0.0, 1.0) *
                                    (p > 0.7 ? (0.85 - p) / 0.15 : 1.0)
                                : 0.0;
                            final bannerP = ((p - 0.2) / 0.65).clamp(0.0, 1.0);
                            final bannerOpacity = p < 0.9
                                ? bannerP.clamp(0.0, 1.0) *
                                    (p > 0.8 ? (0.9 - p) / 0.1 : 1.0)
                                : 0.0;
                            final bannerScale = 0.3 +
                                bannerP * 1.0 +
                                sin(bannerP * pi) * 0.05;
                            return Stack(
                              children: <Widget>[
                                // Flash blanc.
                                Positioned.fill(
                                  child: Container(
                                    color: Colors.white
                                        .withValues(alpha: flashOpacity),
                                  ),
                                ),
                                // Rayons lumineux rotatifs.
                                if (raysOpacity > 0)
                                  Positioned.fill(
                                    child: CustomPaint(
                                      painter: EvolutionRaysPainter(
                                        progress: raysProgress,
                                        opacity: raysOpacity,
                                      ),
                                    ),
                                  ),
                                // Particules qui explosent.
                                if (p > 0.1 && p < 0.95)
                                  Positioned.fill(
                                    child: CustomPaint(
                                      painter: ConfettiPainter(
                                        progress: ((p - 0.1) / 0.85)
                                            .clamp(0.0, 1.0),
                                      ),
                                    ),
                                  ),
                                // Bandeau "ÉVOLUTION !".
                                Center(
                                  child: Transform.scale(
                                    scale: bannerScale,
                                    child: Opacity(
                                      opacity: bannerOpacity,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 26, vertical: 14),
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: <Color>[
                                              Color(0xFFFFE066),
                                              Color(0xFFFFB04C),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: const Color(0xFFFFB04C)
                                                  .withValues(alpha: 0.7),
                                              blurRadius: 24,
                                              spreadRadius: 4,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const Text(
                                              '✨ ÉVOLUTION ✨',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 26,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              _stageName,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 16,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  // "Bravo !" sur célébration (défi complété).
                  if (_celebrating)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: AnimatedBuilder(
                          animation: _celebrateCtrl,
                          builder: (_, __) {
                            final p = _celebrateCtrl.value;
                            return CustomPaint(
                              painter: ConfettiPainter(progress: p),
                              child: Center(
                                child: Transform.scale(
                                  scale: 0.6 + (1 - (p - 0.5).abs() * 2) * 0.5,
                                  child: Opacity(
                                    opacity: (1 - p).clamp(0.0, 1.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 22, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        boxShadow: const <BoxShadow>[
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 8,
                                          ),
                                        ],
                                      ),
                                      child: const Text(
                                        '🎉 Bravo ! 🎉',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Spacer(flex: 2),
            // Barre d'XP : progression vers la prochaine évolution.
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 4),
              child: XpBar(level: lv),
            ),
            // Slider debug (à retirer quand le système XP sera branché).
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Row(
                children: <Widget>[
                  const Text('1',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  Expanded(
                    child: Slider(
                      value: _level,
                      min: 1,
                      max: 100,
                      divisions: 99,
                      label: '$lv',
                      activeColor: KultivaColors.primaryGreen,
                      onChanged: (v) {
                        setState(() {
                          _level = v;
                          _xp = v.round();
                        });
                        PrefsService.instance
                            .setString(_kXp, _xp.toString());
                        _checkLevelUp();
                      },
                    ),
                  ),
                  const Text('100',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Zone cliquable transparente sur l'image de sélection du starter.
/// Affiche un petit scale + glow au tap (press).
class StarterTapZone extends StatefulWidget {
  final VoidCallback onTap;
  const StarterTapZone({super.key, required this.onTap});

  @override
  State<StarterTapZone> createState() => _StarterTapZoneState();
}

class _StarterTapZoneState extends State<StarterTapZone> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: _pressed ? Colors.white.withValues(alpha: 0.25) : Colors.transparent,
        ),
      ),
    );
  }
}

/// Bouton d'action Arroser / Engrais sous les onglets Tamassi.
class TamassiActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const TamassiActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(22),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withValues(alpha: 0.35),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

