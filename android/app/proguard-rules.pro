# Règles R8 pour le build release Android.
#
# ⚠️ Sans ce fichier, **l'app plante au lancement en release**, et
# seulement en release. Mesuré le 03/11/2026 sur un émulateur
# Android 36, APK release arm64 :
#
#   FATAL EXCEPTION: main
#   Unable to start receiver
#     com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver
#   Caused by: java.lang.RuntimeException: Missing type parameter.
#     at com.dexterous.flutterlocalnotifications
#          .FlutterLocalNotificationsPlugin.loadScheduledNotifications
#
# La cause : le plugin relit ses notifications programmées avec Gson,
# qui a besoin du type générique de la liste. R8 efface l'attribut
# `Signature` du bytecode, donc `TypeToken` ne trouve plus rien et
# lève « Missing type parameter ». En debug R8 ne tourne pas : le
# défaut est invisible pendant tout le développement.
#
# ⚠️ Il se déclenche au **deuxième** lancement, pas au premier : il
# faut que `scheduled_notifications.xml` existe déjà pour qu'il y ait
# quelque chose à relire. Une installation neuve lancée une seule fois
# ne le montre pas.
-keepattributes Signature
-keepattributes *Annotation*
-keep class com.dexterous.** { *; }

# ⚠️ `-keepattributes Signature` **ne suffit pas**, mesuré : avec la
# seule ligne ci-dessus, R8 en « full mode » (le défaut depuis AGP 8)
# efface quand même la signature des sous-classes **anonymes** de
# `TypeToken`, et c'est exactement ce que le plugin utilise. Ce sont
# les règles officielles de Gson, qu'une version récente livre dans
# son AAR mais que celle embarquée ici n'apporte pas.
-keep class com.google.gson.reflect.TypeToken { *; }
-keep class * extends com.google.gson.reflect.TypeToken
-keep,allowobfuscation,allowshrinking class com.google.gson.reflect.TypeToken
-keep,allowobfuscation,allowshrinking class * extends com.google.gson.reflect.TypeToken
