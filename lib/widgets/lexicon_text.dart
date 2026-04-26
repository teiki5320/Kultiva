import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../data/lexicon.dart';
import '../theme/app_theme.dart';

/// Widget qui rend un texte en soulignant automatiquement les termes présents
/// dans `lexicon`. Tap sur un mot souligné ouvre un pop-up avec la définition.
///
/// Utilisation :
/// ```dart
/// LexiconText('Attention au mildiou sur les solanacées.')
/// ```
class LexiconText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const LexiconText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final base = style ?? DefaultTextStyle.of(context).style;

    // On construit un RegExp OR avec tous les termes (plus long en premier
    // pour matcher "bouillie bordelaise" avant "bouillie").
    final terms = <String>[for (final e in lexicon) e.term]
      ..sort((a, b) => b.length.compareTo(a.length));
    if (terms.isEmpty) {
      return Text(text,
          style: base,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow);
    }
    final pattern = RegExp(
      terms.map(RegExp.escape).join('|'),
      caseSensitive: false,
      unicode: true,
    );

    final spans = <InlineSpan>[];
    int cursor = 0;
    for (final m in pattern.allMatches(text)) {
      if (m.start > cursor) {
        spans.add(TextSpan(text: text.substring(cursor, m.start)));
      }
      final matched = text.substring(m.start, m.end);
      spans.add(TextSpan(
        text: matched,
        style: TextStyle(
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.dotted,
          decorationColor: KultivaColors.primaryGreen,
          color: KultivaColors.primaryGreen,
          fontWeight: FontWeight.w700,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () => _showDefinition(context, matched),
      ));
      cursor = m.end;
    }
    if (cursor < text.length) {
      spans.add(TextSpan(text: text.substring(cursor)));
    }

    return Text.rich(
      TextSpan(style: base, children: spans),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  void _showDefinition(BuildContext context, String term) {
    final entry = lookupLexicon(term);
    if (entry == null) return;
    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.45),
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('📖', style: TextStyle(fontSize: 26)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      entry.term[0].toUpperCase() + entry.term.substring(1),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                entry.definition,
                style: const TextStyle(fontSize: 14, height: 1.45),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Compris !'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
