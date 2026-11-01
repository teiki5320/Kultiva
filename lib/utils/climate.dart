import '../models/region_data.dart';

/// Seuil de température (°C) au-delà duquel on parle de « canicule ».
///
/// 30 °C est déjà exceptionnel en France mais banal sous les tropiques :
/// on n'y alerte qu'à partir de 40 °C, sinon l'alerte sonnerait
/// quasiment tous les jours de saison sèche et perdrait tout son sens.
///
/// La question est climatique, pas culturelle : depuis l'ouverture
/// mondiale, elle vaut pour toutes les bases tropicales et pas
/// seulement pour l'Afrique de l'Ouest.
double heatwaveThresholdFor(Region region) =>
    region.isTropicalBase ? 40.0 : 30.0;
