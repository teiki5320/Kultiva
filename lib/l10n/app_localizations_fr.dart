// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class LFr extends L {
  LFr([String locale = 'fr']) : super(locale);

  @override
  String get tabHome => 'Home';

  @override
  String get tabCahier => 'Cahier';

  @override
  String get tabEtal => 'Étal';

  @override
  String get tabTutos => 'Tutos';

  @override
  String get tabRecettes => 'Conservation';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsLanguagePartial =>
      'Les trois langues sont complètes : interface, catalogue, recettes, tutos et conseils. Le français reste la langue source — ce qui n\'est pas encore traduit y retombe.';
}
