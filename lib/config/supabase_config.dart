/// Configuration Supabase pour Kultiva.
///
/// L'URL et la clé anon sont des valeurs PUBLIQUES — elles sont
/// incluses dans chaque requête HTTP que l'app mobile fait. La
/// sécurité de tes données est gérée par les Row Level Security (RLS)
/// policies dans Supabase, pas par le secret de ces valeurs.
///
/// La vraie clé à ne JAMAIS exposer est `service_role` / `secret` —
/// celle-là ne doit vivre que côté serveur (fonctions Edge, scripts
/// admin, etc.).
class SupabaseConfig {
  SupabaseConfig._();

  static const String url = 'https://vkiwkeknfzwdvufcqbrp.supabase.co';
  static const String anonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZraXdrZWtuZnp3ZHZ1ZmNxYnJwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzYzNDQ0NDIsImV4cCI6MjA5MTkyMDQ0Mn0.TlR7djhq7N76fVsKbxpbxTQfz0hlqItVIP0J5zZUPOc';
}

/// Configuration Google OAuth pour Sign in with Google.
///
/// Prérequis — dans Google Cloud Console (console.cloud.google.com) :
///   1. Créer (ou sélectionner) un projet.
///   2. APIs & Services → OAuth consent screen → configurer l'app.
///   3. Credentials → Create Credentials → OAuth client ID :
///        a. Application type = iOS → bundle ID = ton bundle
///           (ex: com.example.kultiva). Copie le REVERSED_CLIENT_ID
///           dans ios/Runner/Info.plist.
///        b. Application type = Web → copie le Client ID ici dans
///           [webClientId]. C'est ce même Client ID + Secret que tu
///           colles dans Supabase Dashboard → Authentication →
///           Providers → Google.
///   4. Pour Android (plus tard) : créer un client OAuth Android
///      avec le SHA-1 de ta clé de signature.
class GoogleOAuthConfig {
  GoogleOAuthConfig._();

  /// Client ID de type "Web" — utilisé par google_sign_in pour
  /// demander un idToken que Supabase peut valider.
  static const String? webClientId =
      '56977548622-l52olnkn81icjbo6aqk6b5trssjpbqiu.apps.googleusercontent.com';

  /// Client ID de type "iOS" — nécessaire pour que le SDK Google
  /// natif puisse ouvrir la feuille de connexion sur iPhone.
  /// Dérivé du REVERSED_CLIENT_ID dans Info.plist.
  static const String? iosClientId =
      '56977548622-fokr6eq79msehbmphcler1pldmokg8fv.apps.googleusercontent.com';
}
