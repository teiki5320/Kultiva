/// Identité de la version affichée dans l'app.
///
/// La chaîne était écrite en dur dans l'écran des réglages
/// (« Kultiva v1.0 ») et devenait donc fausse au premier bump. Elle est
/// maintenant centralisée ici.
///
/// ⚠️ **À tenir synchronisé avec `version:` dans `pubspec.yaml`** à chaque
/// montée de version. Ce doublon est volontaire : lire la vraie valeur du
/// bundle demanderait `package_info_plus`, donc un plugin natif de plus,
/// un `pod install` et un nouveau build Xcode Cloud — un coût qui ne se
/// justifie pas pour un libellé, à ce stade de la soumission. À
/// reconsidérer après la v1.
class AppInfo {
  const AppInfo._();

  /// Version marketing (`CFBundleShortVersionString` côté iOS,
  /// `versionName` côté Android).
  static const String version = '1.0.0';

  /// Libellé prêt à afficher : « Kultiva 1.0.0 ».
  ///
  /// ⚠️ **Sans numéro de build, et c'est volontaire.** Le `+5` de
  /// `pubspec.yaml` n'est pas ce qui arrive sur l'appareil : Xcode Cloud
  /// numérote lui-même les builds qu'il envoie (TestFlight affichait
  /// 1.0.0 **(77)** le 30/10/2026). Afficher « (5) » donnait donc un
  /// numéro faux, inutilisable dans un rapport de bug — pire que pas de
  /// numéro du tout. Pour afficher le vrai, il faudrait lire le bundle
  /// avec `package_info_plus`.
  static const String label = 'Kultiva $version';
}
