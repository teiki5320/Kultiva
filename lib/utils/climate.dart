import '../models/region_data.dart';

/// Seuil de température (°C) au-delà duquel on parle de « canicule ».
///
/// 30 °C est déjà exceptionnel en France mais banal sous les tropiques :
/// en Afrique de l'Ouest on n'alerte qu'à partir de 40 °C, sinon
/// l'alerte sonnerait quasiment tous les jours de saison sèche et
/// perdrait tout son sens.
double heatwaveThresholdFor(Region region) =>
    region == Region.westAfrica ? 40.0 : 30.0;
