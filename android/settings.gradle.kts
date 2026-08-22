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
    // Kotlin épinglé en 2.1.x : la 2.2 a supprimé le support du langage 1.6,
    // que le plugin Android de sentry_flutter 8.x impose encore
    // (`languageVersion = "1.6"` dans son build.gradle) → le build release
    // échouait sur `:sentry_flutter:compileReleaseKotlin`.
    // À lever le jour où l'on montera sentry_flutter en 9.x.
    id("org.jetbrains.kotlin.android") version "2.1.20" apply false
}

include(":app")
