/// Niveau d'urgence de la suggestion d'arrosage.
enum WateringUrgency { skip, ok, dueSoon, overdue, heatwave }

/// Une recommandation d'arrosage produite à partir de la météo + de
/// l'historique d'arrosage de la culture.
class WateringAdvice {
  final WateringUrgency urgency;
  final String emoji;
  final String message;

  const WateringAdvice({
    required this.urgency,
    required this.emoji,
    required this.message,
  });
}
