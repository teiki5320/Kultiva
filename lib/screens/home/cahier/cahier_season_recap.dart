import 'package:flutter/material.dart';

import '../../../services/culture_service.dart';
import '../../../services/error_reporter.dart';
import '../../../services/pdf_service.dart';
import '../../../theme/app_theme.dart';

/// Bouton d'export du récap de saison en PDF.
///
/// `PdfService.printSeasonRecap` fait 170 lignes et n'était appelée de
/// nulle part : la description App Store promet un calendrier
/// « exportable en PDF pour l'accrocher dans l'abri de jardin », et la
/// checklist de test demandait de vérifier un « CTA Récap saison »
/// qui n'existait pas. Sixième fonctionnalité écrite puis jamais
/// reliée — et celle-là, le test anti-orphelin ne pouvait pas
/// l'attraper : le fichier est bien importé, c'est une seule de ses
/// fonctions qui était morte.
///
/// Ne s'affiche qu'avec au moins une culture démarrée cette année :
/// un récap de saison vide n'apprend rien.
class CahierSeasonRecap extends StatefulWidget {
  const CahierSeasonRecap({super.key});

  @override
  State<CahierSeasonRecap> createState() => _CahierSeasonRecapState();
}

class _CahierSeasonRecapState extends State<CahierSeasonRecap> {
  bool _enCours = false;

  Future<void> _exporter(int annee) async {
    setState(() => _enCours = true);
    try {
      await PdfService.printSeasonRecap(
        year: annee,
        cultures: CultureService.instance.loadAll(),
      );
    } catch (e, st) {
      // Impression refusée, annulée, ou pas d'imprimante : ça ne doit
      // pas faire tomber l'écran.
      await ErrorReporter.report('pdf_season_recap', e, st);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('🧾 Export impossible pour le moment')),
        );
      }
    } finally {
      if (mounted) setState(() => _enCours = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final annee = DateTime.now().year;
    final cettAnnee = CultureService.instance
        .loadAll()
        .where((c) => c.startedAt.year == annee)
        .length;
    if (cettAnnee == 0) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: OutlinedButton.icon(
        onPressed: _enCours ? null : () => _exporter(annee),
        icon: const Text('🧾', style: TextStyle(fontSize: 16)),
        label: Text(
          _enCours ? 'Préparation…' : 'Récap de la saison $annee',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: KultivaColors.primaryGreen,
          side: BorderSide(
            color: KultivaColors.primaryGreen.withValues(alpha: 0.5),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          minimumSize: const Size.fromHeight(0),
        ),
      ),
    );
  }
}
