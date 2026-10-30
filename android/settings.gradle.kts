pluginManagement {
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.11.1" apply false
    // Le pin en 2.1.x existait pour sentry_flutter 8.x, dont le plugin
    // Android imposait encore le langage 1.6, supprimé par Kotlin 2.2.
    // Sentry est passé en 9.30 et n'impose plus rien : le pin est levé.
    // Flutter 3.47 exige par ailleurs Kotlin ≥ 2.2.20 — sous ce seuil,
    // `flutter build apk` refuse de démarrer.
    id("org.jetbrains.kotlin.android") version "2.2.20" apply false
}

include(":app")
