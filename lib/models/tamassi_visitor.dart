/// Données minimales d'un Tamassi d'un autre utilisateur, suffisantes
/// pour l'afficher dans l'écran de visite.
class TamassiVisitor {
  final int xp;
  final String starter; // 'poussia' / 'soleia' / 'spira'
  final String name;
  const TamassiVisitor({
    required this.xp,
    required this.starter,
    required this.name,
  });
}
