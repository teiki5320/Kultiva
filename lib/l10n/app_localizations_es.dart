// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class LEs extends L {
  LEs([String locale = 'es']) : super(locale);

  @override
  String get tabHome => 'Inicio';

  @override
  String get tabCahier => 'Diario';

  @override
  String get tabEtal => 'Catálogo';

  @override
  String get tabTutos => 'Guías';

  @override
  String get tabRecettes => 'Conservas';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguagePartial =>
      'Los tres idiomas están completos: interfaz, catálogo, recetas, guías y consejos. El francés sigue siendo el idioma de origen: lo que aún no está traducido vuelve a él.';
}
