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
  String get tabRecettes => 'Recetas';

  @override
  String get commonAll => 'Todo';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get commonBack => 'Volver';

  @override
  String get commonNext => 'Siguiente';

  @override
  String get commonDone => 'Hecho';

  @override
  String get commonSearch => 'Buscar';

  @override
  String get photosTitle => 'Fotos';

  @override
  String get photosFilm => 'Carrete';

  @override
  String get photosEvolution => 'Evolución';

  @override
  String get photosTake => 'Hacer una foto';

  @override
  String get photosNoMemories => 'El huerto aún no tiene recuerdos';

  @override
  String photosCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fotos del huerto',
      one: '1 foto del huerto',
    );
    return '$_temp0';
  }

  @override
  String get photosEmptyTitle => 'Todavía no hay ninguna foto';

  @override
  String get photosEmptyBody =>
      'Fotografía una planta hoy y la misma dentro de una semana: al verlas juntas te das cuenta de que crece.';

  @override
  String get photosEmptyPlantsTitle => 'Ninguna planta fotografiada';

  @override
  String get photosEmptyPlantsBody =>
      'En cuanto una planta tiene dos fotos, Kultiva las pone juntas y cuenta los días entre ambas.';

  @override
  String get photosWhichPlant => '¿Qué planta estás fotografiando?';

  @override
  String get photosPlantFirst =>
      'Planta algo primero: una foto se engancha a una planta.';

  @override
  String get photosDeleteTitle => '¿Eliminar esta foto?';

  @override
  String get photosDeleteBody =>
      'Se borrará del dispositivo. Kultiva no guarda ninguna copia en otro sitio, así que es definitivo.';

  @override
  String get photosGone => 'Esta foto ya no está en el dispositivo.';

  @override
  String photosAgeDay(int days) {
    return 'D+$days';
  }

  @override
  String get recipesTitle => 'Recetas';

  @override
  String recipesSubtitle(int recipes, int crops) {
    return '$recipes recetas para $crops cosechas';
  }

  @override
  String get recipesSearchHint => 'Una hortaliza, o un plato…';

  @override
  String get recipesInYourGarden => 'En tu huerto';

  @override
  String get recipesNoStepsYet =>
      'El paso a paso animado de esta receta aún no está escrito — llegará.';

  @override
  String get recipesIngredients => 'Lo que necesitas';

  @override
  String recipesStep(int current, int total) {
    return 'Paso $current de $total';
  }

  @override
  String get recipesBonAppetit => '¡Buen provecho!';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'El del teléfono';

  @override
  String get settingsLanguagePartial =>
      'El español tiene por ahora la interfaz y los nombres de las hortalizas; las recetas, las guías y los consejos siguen en francés y llegarán. El francés es el idioma de origen, y el inglés está completo.';
}
