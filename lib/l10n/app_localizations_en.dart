// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class LEn extends L {
  LEn([String locale = 'en']) : super(locale);

  @override
  String get tabHome => 'Home';

  @override
  String get tabCahier => 'Journal';

  @override
  String get tabEtal => 'Catalog';

  @override
  String get tabTutos => 'Guides';

  @override
  String get tabRecettes => 'Preserving';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguagePartial =>
      'All three languages are complete: interface, catalog, recipes, guides and tips. French stays the source language — anything not yet translated falls back to it.';
}
