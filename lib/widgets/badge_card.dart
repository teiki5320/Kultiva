import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/badges.dart';
import '../models/vegetable_medal.dart';
import '../theme/app_theme.dart';

/// Ouvre un overlay plein écran qui affiche une grande carte "Pokemon"
/// pour un badge donné. La carte tourne légèrement en idle sur l'axe Y,
/// et on peut la faire pivoter manuellement en la draguant.
///
/// [unlocked] détermine si la carte est affichée en pleine couleur ou
/// en silhouette verrouillée.
Future<void> showBadgeCard(
  BuildContext context, {
  required PoussidexBadge badge,
  required bool unlocked,
}) {
  return showGeneralDialog<void>(
    context: context,
    barrierColor: Colors.black.withOpacity(0.75),
    barrierDismissible: true,
    barrierLabel: 'Fermer',
    transitionDuration: const Duration(milliseconds: 240),
    pageBuilder: (_, __, ___) => _BadgeCardOverlay(
      badge: badge,
      unlocked: unlocked,
    ),
    transitionBuilder: (context, anim, _, child) {
      final scale = Tween<double>(begin: 0.7, end: 1.0)
          .chain(CurveTween(curve: Curves.easeOutBack))
          .animate(anim);
      return FadeTransition(
        opacity: anim,
        child: ScaleTransition(scale: scale, child: child),
      );
    },
  );
}

class _BadgeCardOverlay extends StatefulWidget {
  final PoussidexBadge badge;
  final bool unlocked;

  const _BadgeCardOverlay({
    required this.badge,
    required this.unlocked,
  });

  @override
  State<_BadgeCardOverlay> createState() => _BadgeCardOverlayState();
}

class _BadgeCardOverlayState extends State<_BadgeCardOverlay>
    with TickerProviderStateMixin {
  late final AnimationController _idleCtrl;
  late final AnimationController _flipCtrl;

  /// Rotation Y contrôlée par le drag utilisateur (en radians).
  double _dragRotationY = 0;

  /// Rotation X contrôlée par le drag vertical (en radians).
  double _dragRotationX = 0;

  /// true pendant un drag : pause le balancement idle.
  bool _dragging = false;

  /// true si la carte montre sa face arrière.
  bool _showingBack = false;

  @override
  void initState() {
    super.initState();
    _idleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: false);
    _flipCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _idleCtrl.dispose();
    _flipCtrl.dispose();
    super.dispose();
  }

  void _toggleFlip() {
    setState(() => _showingBack = !_showingBack);
    if (_showingBack) {
      _flipCtrl.forward();
    } else {
      _flipCtrl.reverse();
    }
  }

  void _onDragStart(_) {
    setState(() => _dragging = true);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      // 0.008 rad par pixel = ~0.5° par pixel → une gesture normale
      // (quelques centaines de pixels) permet un demi-tour.
      _dragRotationY += details.delta.dx * 0.008;
      _dragRotationX -= details.delta.dy * 0.005;
      // Cap X rotation pour éviter de retourner la carte verticalement.
      _dragRotationX = _dragRotationX.clamp(-0.6, 0.6);
    });
  }

  void _onDragEnd(_) {
    setState(() => _dragging = false);
    // On ne reset pas la rotation : la carte reste là où l'utilisateur
    // l'a laissée, et le balancement idle reprend à partir de cette
    // position.
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Tap sur le fond → ferme.
      onTap: () => Navigator.of(context).pop(),
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge(<Listenable>[_idleCtrl, _flipCtrl]),
          builder: (context, _) {
            // Balancement idle : sinusoïde ±0.25 rad (~14°) sur Y.
            final idleY = _dragging
                ? 0.0
                : math.sin(_idleCtrl.value * 2 * math.pi) * 0.25;
            // Angle du retournement : 0 → π sur _flipCtrl.
            final flipY = _flipCtrl.value * math.pi;
            final totalY = _dragRotationY + idleY + flipY;
            final totalX = _dragRotationX;

            final matrix = Matrix4.identity()
              ..setEntry(3, 2, 0.0015) // perspective
              ..rotateX(totalX)
              ..rotateY(totalY);

            // On détermine quelle face montrer en fonction de l'angle Y
            // effectif (modulo 2π). Si on est dans [π/2, 3π/2] → face
            // arrière. Sinon → face avant.
            final normalizedY =
                (totalY % (2 * math.pi) + 2 * math.pi) % (2 * math.pi);
            final showBack =
                normalizedY > math.pi / 2 && normalizedY < 3 * math.pi / 2;

            // Contenu à afficher. Le dos est pré-inversé en miroir (Y)
            // pour compenser la rotation — sans ça, les textes du dos
            // apparaîtraient à l'envers.
            final Widget content = showBack
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(math.pi),
                    child: _BadgeCardBack(
                      unlocked: widget.unlocked,
                      tier: widget.badge.tier,
                    ),
                  )
                : _BadgeCardVisual(
                    badge: widget.badge,
                    unlocked: widget.unlocked,
                    rotationX: totalX,
                    rotationY: totalY,
                  );

            return GestureDetector(
              // Tap sur la carte = retournement (au lieu de rien).
              onTap: _toggleFlip,
              onPanStart: _onDragStart,
              onPanUpdate: _onDragUpdate,
              onPanEnd: _onDragEnd,
              child: Transform(
                alignment: Alignment.center,
                transform: matrix,
                child: content,
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Visuel de la carte (face avant). Format ~pokemon (280×400).
class _BadgeCardVisual extends StatelessWidget {
  final PoussidexBadge badge;
  final bool unlocked;

  /// Rotation courante (en radians) — utilisée pour animer l'effet
  /// holographique qui suit le tilt de la carte.
  final double rotationX;
  final double rotationY;

  const _BadgeCardVisual({
    required this.badge,
    required this.unlocked,
    this.rotationX = 0,
    this.rotationY = 0,
  });

  @override
  Widget build(BuildContext context) {
    final tierColors = _TierColors.forBadge(badge.tier, unlocked);
    final Color frameColor = tierColors.frame;

    return Container(
      width: 280,
      height: 400,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: tierColors.frameGradient,
        ),
        border: Border.all(color: frameColor, width: 4),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
          if (unlocked)
            BoxShadow(
              color: tierColors.glow,
              blurRadius: 30,
              spreadRadius: 2,
            ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: frameColor.withOpacity(0.35)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        child: Column(
          children: <Widget>[
            // Bandeau du nom.
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: frameColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: frameColor.withOpacity(0.5)),
              ),
              child: Text(
                badge.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: tierColors.text,
                  letterSpacing: 0.4,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Illustration centrale : image custom si dispo dans
            // assets/images/badges/<id>.png, sinon gros emoji + sparkles.
            // Superposée d'un effet holographique qui réagit à la
            // rotation de la carte (sur les badges débloqués uniquement).
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: tierColors.innerGradient,
                    ),
                    border: Border.all(
                        color: frameColor.withOpacity(0.4), width: 1.5),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      // 1. Illustration (image ou fallback emoji).
                      Opacity(
                        opacity: unlocked ? 1.0 : 0.35,
                        child: Image.asset(
                          'assets/images/badges/${badge.id}.png',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _EmojiFallback(
                            emoji: badge.emoji,
                            unlocked: unlocked,
                          ),
                        ),
                      ),
                      // 2. Effet holo (badges débloqués uniquement).
                      if (unlocked)
                        IgnorePointer(
                          child: _HolographicOverlay(
                            rotationX: rotationX,
                            rotationY: rotationY,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            // Description.
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: frameColor.withOpacity(0.25)),
              ),
              child: Text(
                badge.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11.5,
                  height: 1.35,
                  fontWeight: FontWeight.w600,
                  color: unlocked
                      ? KultivaColors.textPrimary
                      : Colors.grey.shade500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Bas de carte : ID + "KULTIVA".
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '#${badge.id.toUpperCase()}',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade500,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  'KULTIVA',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: frameColor,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Fallback quand l'image `assets/images/badges/<id>.png` n'existe pas
/// encore : gros emoji centré + sparkles décoratifs.
class _EmojiFallback extends StatelessWidget {
  final String emoji;
  final bool unlocked;

  const _EmojiFallback({
    required this.emoji,
    required this.unlocked,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        if (unlocked)
          Positioned(
            top: 12,
            left: 14,
            child: Text(
              '✨',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
        if (unlocked)
          Positioned(
            bottom: 18,
            right: 18,
            child: Text(
              '⭐',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
        Text(emoji, style: const TextStyle(fontSize: 96)),
      ],
    );
  }
}

/// Superposition holographique qui réagit à la rotation de la carte.
///
/// Deux couches :
///  1. Un gradient arc-en-ciel pastel (reflet prismatique) dont
///     l'orientation suit la rotation → on voit différentes teintes
///     selon l'angle de vue.
///  2. Une bande de lumière diagonale (reflet brillant) qui traverse
///     la carte selon [rotationY] → sensation d'un vrai reflet sur
///     une surface brillante.
class _HolographicOverlay extends StatelessWidget {
  final double rotationX;
  final double rotationY;

  const _HolographicOverlay({
    required this.rotationX,
    required this.rotationY,
  });

  static const List<Color> _rainbowColors = <Color>[
    Color(0xFFFFC7E0), // rose
    Color(0xFFC9E6FF), // bleu ciel
    Color(0xFFD8C7FF), // lavande
    Color(0xFFFFF3B0), // jaune doux
    Color(0xFFC7F5E0), // mint
    Color(0xFFFFC7E0), // bouclage rose
  ];

  @override
  Widget build(BuildContext context) {
    // Position normalisée du spot brillant, dérivée de rotationY.
    // rotationY = 0 → centre ; rotationY > 0 → droite ; rotationY < 0
    // → gauche. On clamp pour qu'à fort tilt le reflet sorte du cadre
    // plutôt que de s'étirer.
    final rawPos = 0.5 + rotationY * 0.6;
    final shinePos = rawPos.clamp(-0.2, 1.2);
    final left = (shinePos - 0.18).clamp(0.0, 1.0);
    final mid = shinePos.clamp(0.0, 1.0);
    final right = (shinePos + 0.18).clamp(0.0, 1.0);

    // Intensité du reflet : maximum au tilt maximal, faible au repos.
    final tiltMagnitude =
        (rotationY.abs() + rotationX.abs()).clamp(0.0, 1.0);
    final shineOpacity = 0.15 + tiltMagnitude * 0.4;

    // Angle du gradient arc-en-ciel : rotate selon rotationY pour donner
    // l'illusion que les teintes changent avec l'inclinaison.
    final angleRad = rotationY * 1.5;
    final dx = math.cos(angleRad);
    final dy = math.sin(angleRad);

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // Couche 1 : teinte arc-en-ciel (blendMode plus = additive).
        Opacity(
          opacity: 0.25,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-dx, -dy),
                end: Alignment(dx, dy),
                colors: _rainbowColors,
              ),
            ),
          ),
        ),
        // Couche 2 : bande de lumière qui traverse la carte.
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: <double>[
                left,
                mid,
                right,
              ],
              colors: <Color>[
                Colors.white.withOpacity(0),
                Colors.white.withOpacity(shineOpacity),
                Colors.white.withOpacity(0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Face arrière de la carte : design "Poussidex Collection" sans
/// dépendre d'un badge spécifique. Même format 280×400 que la face
/// avant pour un retournement fluide.
class _BadgeCardBack extends StatelessWidget {
  final bool unlocked;
  final MedalTier tier;

  const _BadgeCardBack({
    required this.unlocked,
    required this.tier,
  });

  @override
  Widget build(BuildContext context) {
    final tierColors = _TierColors.forBadge(tier, unlocked);
    final Color frameColor = tierColors.frame;

    return Container(
      width: 280,
      height: 400,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: tierColors.frameGradient,
        ),
        border: Border.all(color: frameColor, width: 4),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
          if (unlocked)
            BoxShadow(
              color: tierColors.glow,
              blurRadius: 30,
              spreadRadius: 2,
            ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: tierColors.innerGradient,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: frameColor.withOpacity(0.5), width: 2),
        ),
        child: Stack(
          children: <Widget>[
            // Motif de fond : hexagones + sparkles en mosaïque douce.
            Positioned.fill(
              child: Opacity(
                opacity: 0.25,
                child: CustomPaint(
                  painter: _BackPatternPainter(color: frameColor),
                ),
              ),
            ),
            // Contenu central : gros emoji + lettrage stylisé.
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  const Spacer(),
                  // Grand logo (emoji central).
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.9),
                      border: Border.all(color: frameColor, width: 3),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: frameColor.withOpacity(0.4),
                          blurRadius: 16,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '🪴',
                      style: TextStyle(fontSize: 72),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'POUSSIDEX',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                      letterSpacing: 4,
                      color: tierColors.text,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'COLLECTION',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                      letterSpacing: 5,
                      color: frameColor,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'KULTIVA',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                      letterSpacing: 3,
                      color: frameColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Motif de fond décoratif pour le dos de carte : petits symboles
/// jardinage (feuilles, sparkles) dispersés en diagonale.
class _BackPatternPainter extends CustomPainter {
  final Color color;
  _BackPatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const symbols = <String>['🌱', '✨', '🍃', '⭐'];
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    final step = 48.0;
    int i = 0;
    for (double y = -step; y < size.height + step; y += step) {
      for (double x = -step; x < size.width + step; x += step) {
        final offsetX = (i.isEven) ? 0.0 : step / 2;
        final symbol = symbols[i % symbols.length];
        textPainter.text = TextSpan(
          text: symbol,
          style: TextStyle(
            fontSize: 16,
            color: color.withOpacity(0.8),
          ),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(x + offsetX, y));
        i++;
      }
    }
  }

  @override
  bool shouldRepaint(_BackPatternPainter old) => old.color != color;
}

/// Palette de couleurs pour une carte badge selon son [MedalTier].
/// Chaque palier a sa propre teinte de cadre, son gradient, et sa
/// couleur de texte assombrie qui garde le contraste.
class _TierColors {
  final Color frame;
  final Color glow;
  final Color text;
  final List<Color> frameGradient;
  final List<Color> innerGradient;

  const _TierColors({
    required this.frame,
    required this.glow,
    required this.text,
    required this.frameGradient,
    required this.innerGradient,
  });

  static _TierColors forBadge(MedalTier tier, bool unlocked) {
    final base = () {
      switch (tier) {
        case MedalTier.bronze:
          return _bronze;
        case MedalTier.silver:
          return _silver;
        case MedalTier.gold:
          return _gold;
        case MedalTier.shiny:
          return _shiny;
        case MedalTier.none:
          return _locked;
      }
    }();
    // Les badges verrouillés gardent la teinte de leur tier mais en
    // version désaturée : l'utilisateur voit à quoi ressemble un
    // shiny/gold sans avoir besoin de le débloquer.
    if (!unlocked) return base._faded();
    return base;
  }

  _TierColors _faded() {
    Color dim(Color c) =>
        Color.lerp(c, Colors.grey.shade400, 0.55) ?? c;
    return _TierColors(
      frame: dim(frame),
      glow: glow.withOpacity(0),
      text: Colors.grey.shade700,
      frameGradient: frameGradient.map(dim).toList(),
      innerGradient: innerGradient.map(dim).toList(),
    );
  }

  static const _bronze = _TierColors(
    frame: Color(0xFFCD7F32),
    glow: Color(0x73B5722B), // 0.45 alpha
    text: Color(0xFF5A3817),
    frameGradient: <Color>[
      Color(0xFFF2D3A7),
      Color(0xFFCD7F32),
      Color(0xFF8E4F10),
    ],
    innerGradient: <Color>[
      Color(0xFFFDEAD3),
      Color(0xFFE8BE85),
    ],
  );

  static const _silver = _TierColors(
    frame: Color(0xFF9AA4B0),
    glow: Color(0x7399A4B1),
    text: Color(0xFF2F3A45),
    frameGradient: <Color>[
      Color(0xFFEFF3F8),
      Color(0xFFB8C1CC),
      Color(0xFF6E7986),
    ],
    innerGradient: <Color>[
      Color(0xFFF7F9FC),
      Color(0xFFCED5DE),
    ],
  );

  static const _gold = _TierColors(
    frame: Color(0xFFFFB74D),
    glow: Color(0x73FFB800),
    text: Color(0xFF5A3E00),
    frameGradient: <Color>[
      Color(0xFFFFF3B0),
      Color(0xFFFFD54A),
      Color(0xFFE8B923),
    ],
    innerGradient: <Color>[
      Color(0xFFFFF9E6),
      Color(0xFFFFE5A8),
    ],
  );

  static const _shiny = _TierColors(
    frame: Color(0xFFFF5CA8),
    glow: Color(0x80FF5CA8), // 0.5 alpha — plus vif
    text: Color(0xFF6B1F4B),
    frameGradient: <Color>[
      Color(0xFFFFB3C1), // rose
      Color(0xFFB5DEFF), // cyan
      Color(0xFFCFB5FF), // lavande
      Color(0xFFFFF0A0), // jaune doux
      Color(0xFFC7F5E0), // mint
    ],
    innerGradient: <Color>[
      Color(0xFFFFF2FA),
      Color(0xFFFFE0EE),
    ],
  );

  static final _locked = _TierColors(
    frame: Colors.grey.shade500,
    glow: Colors.grey.shade500.withOpacity(0.3),
    text: Colors.grey.shade700,
    frameGradient: <Color>[
      Colors.grey.shade300,
      Colors.grey.shade400,
    ],
    innerGradient: <Color>[
      Colors.grey.shade100,
      Colors.grey.shade200,
    ],
  );
}

/// Affiche une animation "pack opening" quand un nouveau badge est
/// débloqué : la carte tombe du ciel en tournant sur elle-même, se
/// stabilise au centre en face avant, et des particules de sparkles
/// explosent autour. L'utilisateur peut tap pour fermer.
Future<void> showBadgeUnlockedAnimation(
  BuildContext context, {
  required PoussidexBadge badge,
}) {
  return showGeneralDialog<void>(
    context: context,
    barrierColor: Colors.black.withOpacity(0.85),
    barrierDismissible: false,
    barrierLabel: 'Nouveau badge',
    transitionDuration: const Duration(milliseconds: 1),
    pageBuilder: (_, __, ___) => _BadgeUnlockedOverlay(badge: badge),
  );
}

class _BadgeUnlockedOverlay extends StatefulWidget {
  final PoussidexBadge badge;
  const _BadgeUnlockedOverlay({required this.badge});

  @override
  State<_BadgeUnlockedOverlay> createState() => _BadgeUnlockedOverlayState();
}

class _BadgeUnlockedOverlayState extends State<_BadgeUnlockedOverlay>
    with TickerProviderStateMixin {
  late final AnimationController _ctrl;
  // Contrôleur séparé pour le balancement idle une fois la carte posée.
  late final AnimationController _idleCtrl;
  bool _showParticles = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );
    _idleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _ctrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _showParticles = true);
        _idleCtrl.repeat();
      }
    });
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _idleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      behavior: HitTestBehavior.opaque,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Burst de particules radiales une fois la carte posée.
          if (_showParticles)
            Positioned.fill(
              child: IgnorePointer(
                child: _ParticleBurst(tier: widget.badge.tier),
              ),
            ),
          // Carte centrale animée.
          AnimatedBuilder(
            animation: Listenable.merge(<Listenable>[_ctrl, _idleCtrl]),
            builder: (context, _) {
              final t = _ctrl.value;
              // Phase 1 (0 → 0.5) : chute depuis le ciel + spin rapide.
              // Phase 2 (0.5 → 0.9) : atterrissage avec bounce (ease out).
              // Phase 3 (0.9 → 1.0) : stabilisation douce.
              final fallCurve = Curves.easeIn.transform(
                (t / 0.5).clamp(0.0, 1.0),
              );
              final bounceCurve = Curves.elasticOut.transform(
                ((t - 0.5) / 0.5).clamp(0.0, 1.0),
              );

              // Translation verticale : du haut de l'écran vers le centre.
              final dy = (1 - fallCurve) * -400;
              // Rotation totale : 4 tours complets durant la chute.
              final spinY = (1 - fallCurve) * 4 * 2 * math.pi;
              // Scale : petite quand elle tombe, grossit en atterrissant.
              final scale = 0.3 + bounceCurve * 0.7;
              // Balancement idle une fois posée.
              final idleY = _showParticles
                  ? math.sin(_idleCtrl.value * 2 * math.pi) * 0.2
                  : 0.0;

              final matrix = Matrix4.identity()
                ..setEntry(3, 2, 0.0015)
                ..translate(0.0, dy, 0.0)
                ..scale(scale)
                ..rotateY(spinY + idleY);

              return Transform(
                alignment: Alignment.center,
                transform: matrix,
                child: _BadgeCardVisual(
                  badge: widget.badge,
                  unlocked: true,
                  rotationY: spinY + idleY,
                ),
              );
            },
          ),
          // Banderole "NOUVEAU BADGE !" en haut quand posée.
          if (_showParticles)
            Positioned(
              top: MediaQuery.of(context).size.height * 0.12,
              child: IgnorePointer(
                child: Column(
                  children: <Widget>[
                    Text(
                      '✨ NOUVEAU BADGE ✨',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 3,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            color: Colors.black.withOpacity(0.7),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.badge.name,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            color: Colors.black.withOpacity(0.6),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          // Indication "Tap pour continuer" en bas une fois posée.
          if (_showParticles)
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.08,
              child: IgnorePointer(
                child: Text(
                  'Tape n\'importe où pour continuer',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.7),
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Burst de 24 particules (emojis) qui rayonnent depuis le centre,
/// avec des couleurs et emojis qui varient selon le [tier] du badge.
class _ParticleBurst extends StatefulWidget {
  final MedalTier tier;
  const _ParticleBurst({required this.tier});

  @override
  State<_ParticleBurst> createState() => _ParticleBurstState();
}

class _ParticleBurstState extends State<_ParticleBurst>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  List<String> get _emojis {
    switch (widget.tier) {
      case MedalTier.bronze:
        return <String>['✨', '🌱', '⭐'];
      case MedalTier.silver:
        return <String>['✨', '⭐', '💫'];
      case MedalTier.gold:
        return <String>['✨', '🏆', '⭐', '💫'];
      case MedalTier.shiny:
        return <String>['✨', '🌈', '⭐', '💫', '💖', '🌟'];
      case MedalTier.none:
        return <String>['✨'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final emojis = _emojis;
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        final t = _ctrl.value;
        final size = MediaQuery.of(context).size;
        final cx = size.width / 2;
        final cy = size.height / 2;
        return Stack(
          children: List<Widget>.generate(24, (i) {
            final angle = (i / 24) * 2 * math.pi;
            final distance = t * 220;
            final x = cx + math.cos(angle) * distance;
            final y = cy + math.sin(angle) * distance;
            final fontSize = 24.0 * (1 - t * 0.5);
            final opacity = (1 - t).clamp(0.0, 1.0);
            return Positioned(
              left: x - fontSize / 2,
              top: y - fontSize / 2,
              child: Opacity(
                opacity: opacity,
                child: Text(
                  emojis[i % emojis.length],
                  style: TextStyle(fontSize: fontSize),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
