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
