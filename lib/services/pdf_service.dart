import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../data/companions.dart';
import '../data/regions/france.dart';
import '../data/regions/west_africa.dart';
import '../data/vegetables_base.dart';
import '../models/culture_entry.dart';
import '../models/region_data.dart';
import '../models/vegetable.dart';

/// Génère et affiche un PDF de la fiche complète d'un légume.
class PdfService {
  PdfService._();

  static Future<void> printVegetableSheet(Vegetable vegetable, Region region) async {
    final doc = pw.Document();
    final regionData = _findRegionData(vegetable.id, region);

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context ctx) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: <pw.Widget>[
              // Titre
              pw.Row(
                children: [
                  pw.Text(
                    '${vegetable.emoji}  ${vegetable.name}',
                    style: pw.TextStyle(
                      fontSize: 28,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Spacer(),
                  pw.Text(
                    vegetable.category.label,
                    style: pw.TextStyle(fontSize: 14, color: PdfColors.grey600),
                  ),
                ],
              ),
              pw.SizedBox(height: 8),
              if (vegetable.description != null)
                pw.Text(
                  vegetable.description!,
                  style: const pw.TextStyle(fontSize: 12),
                ),
              pw.SizedBox(height: 4),
              if (vegetable.note != null)
                pw.Text(
                  vegetable.note!,
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontStyle: pw.FontStyle.italic,
                    color: PdfColors.grey700,
                  ),
                ),
              pw.SizedBox(height: 16),
              pw.Divider(),
              pw.SizedBox(height: 8),

              // Calendrier
              if (regionData != null) ...[
                pw.Text(
                  'Calendrier — ${region.label}',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                _buildMonthBar('Semis', regionData.sowingMonths, PdfColors.green),
                pw.SizedBox(height: 4),
                _buildMonthBar('Récolte', regionData.harvestMonths, PdfColors.orange),
                if (regionData.regionalNote != null) ...[
                  pw.SizedBox(height: 6),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.amber50,
                      borderRadius: pw.BorderRadius.circular(4),
                    ),
                    child: pw.Text(
                      '${region.emoji} ${regionData.regionalNote}',
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                  ),
                ],
                pw.SizedBox(height: 16),
                pw.Divider(),
                pw.SizedBox(height: 8),
              ],

              // Techniques
              pw.Text(
                'Techniques de culture',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              _buildInfoTable(<List<String?>>[
                ['Technique', vegetable.sowingTechnique],
                ['Profondeur', vegetable.sowingDepth],
                ['Température germination', vegetable.germinationTemp],
                ['Levée', vegetable.germinationDays],
                ['Exposition', vegetable.exposure],
                ['Espacement', vegetable.spacing],
                ['Arrosage', vegetable.watering],
                ['Sol', vegetable.soil],
                ['Rendement', vegetable.yieldEstimate],
              ]),

              // Compagnonnage
              if (companionMap.containsKey(vegetable.id) ||
                  incompatibleMap.containsKey(vegetable.id)) ...[
                pw.SizedBox(height: 16),
                pw.Divider(),
                pw.SizedBox(height: 8),
                pw.Text(
                  'Compagnonnage',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                if (companionMap.containsKey(vegetable.id))
                  _buildCompanionRow(
                    'Bons voisins',
                    companionMap[vegetable.id]!,
                    PdfColors.green700,
                  ),
                if (incompatibleMap.containsKey(vegetable.id)) ...[
                  pw.SizedBox(height: 4),
                  _buildCompanionRow(
                    'À éviter',
                    incompatibleMap[vegetable.id]!,
                    PdfColors.red700,
                  ),
                ],
              ],

              pw.Spacer(),
              pw.Divider(color: PdfColors.grey300),
              pw.SizedBox(height: 4),
              pw.Text(
                'Fiche générée par Kultiva',
                style: pw.TextStyle(fontSize: 9, color: PdfColors.grey500),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (_) => doc.save(),
      name: 'Kultiva — ${vegetable.name}',
    );
  }

  /// Génère un PDF de récap saison à partir des cultures pleine terre
  /// de l'utilisateur sur l'année [year]. Imprime tout : nombre de
  /// cultures, jours moyens, top légumes, total arrosages.
  static Future<void> printSeasonRecap({
    required int year,
    required List<CultureEntry> cultures,
  }) async {
    final doc = pw.Document();
    final soilCultures = cultures
        .where((c) =>
            c.method == CultivationMethod.soil &&
            c.startedAt.year == year)
        .toList();
    final totalCultures = soilCultures.length;
    final waterings = soilCultures.fold<int>(
      0,
      (sum, c) => sum + c.wateredAt.length,
    );
    final categories = <VegetableCategory, int>{};
    final byVeg = <String, int>{};
    var totalDuration = 0;
    var endedCount = 0;
    for (final c in soilCultures) {
      try {
        final v = vegetablesBase.firstWhere((veg) => veg.id == c.vegetableId);
        categories[v.category] = (categories[v.category] ?? 0) + 1;
      } catch (_) {}
      byVeg[c.vegetableId] = (byVeg[c.vegetableId] ?? 0) + 1;
      if (c.endedAt != null) {
        totalDuration += c.endedAt!.difference(c.startedAt).inDays;
        endedCount++;
      }
    }
    final avgDuration =
        endedCount == 0 ? 0 : (totalDuration / endedCount).round();
    final topVeg = (byVeg.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value)))
        .take(5)
        .toList();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context ctx) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: <pw.Widget>[
              pw.Text(
                'Récap saison $year',
                style: pw.TextStyle(
                  fontSize: 28,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                'Cahier de culture pleine terre',
                style: pw.TextStyle(
                  fontSize: 13,
                  color: PdfColors.grey700,
                ),
              ),
              pw.SizedBox(height: 22),
              pw.Row(
                children: <pw.Widget>[
                  _Stat(label: 'Cultures', value: '$totalCultures'),
                  _Stat(label: 'Arrosages', value: '$waterings'),
                  _Stat(
                    label: 'Durée moy.',
                    value: avgDuration == 0 ? '—' : '$avgDuration j',
                  ),
                ],
              ),
              pw.SizedBox(height: 24),
              pw.Text(
                'Top 5 légumes',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              if (topVeg.isEmpty)
                pw.Text(
                  'Aucune culture cette saison.',
                  style: const pw.TextStyle(color: PdfColors.grey700),
                ),
              for (final entry in topVeg)
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 3),
                  child: pw.Row(
                    children: <pw.Widget>[
                      pw.Container(
                        width: 18,
                        child: pw.Text('•'),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          _vegName(entry.key),
                          style: const pw.TextStyle(fontSize: 13),
                        ),
                      ),
                      pw.Text(
                        '${entry.value} ×',
                        style: pw.TextStyle(
                          fontSize: 13,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              pw.SizedBox(height: 22),
              pw.Text(
                'Répartition par famille',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              for (final entry in (categories.entries.toList()
                ..sort((a, b) => b.value.compareTo(a.value))))
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 2),
                  child: pw.Text(
                    '${entry.key.label} : ${entry.value} culture${entry.value > 1 ? 's' : ''}',
                    style: const pw.TextStyle(fontSize: 12),
                  ),
                ),
              pw.SizedBox(height: 22),
              pw.Text(
                'Détail des cultures',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              for (final c in soilCultures)
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 3),
                  child: pw.Text(
                    '${_fmtShort(c.startedAt)} → '
                    '${c.endedAt == null ? "en cours" : _fmtShort(c.endedAt!)}'
                    '   ${_vegName(c.vegetableId)}'
                    '   (${c.wateredAt.length} arrosages)',
                    style: const pw.TextStyle(fontSize: 11),
                  ),
                ),
              pw.SizedBox(height: 32),
              pw.Text(
                'Récap généré par Kultiva',
                style: pw.TextStyle(
                  fontSize: 9,
                  color: PdfColors.grey500,
                ),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (_) => doc.save(),
      name: 'Kultiva — Récap $year',
    );
  }

  static String _vegName(String id) {
    try {
      final v = vegetablesBase.firstWhere((veg) => veg.id == id);
      return v.name;
    } catch (_) {
      return id;
    }
  }

  static String _fmtShort(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}';

  static RegionData? _findRegionData(String vegetableId, Region region) {
    final list = region == Region.france ? franceData : westAfricaData;
    try {
      return list.firstWhere((rd) => rd.vegetableId == vegetableId);
    } catch (_) {
      return null;
    }
  }

  static const List<String> _shortMonths = [
    'J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D',
  ];

  static pw.Widget _buildMonthBar(
      String label, List<int> months, PdfColor color) {
    return pw.Row(
      children: [
        pw.SizedBox(
          width: 60,
          child: pw.Text(label, style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
        ),
        ...List.generate(12, (i) {
          final m = i + 1;
          final active = months.contains(m);
          return pw.Container(
            width: 32,
            height: 20,
            margin: const pw.EdgeInsets.symmetric(horizontal: 1),
            alignment: pw.Alignment.center,
            decoration: pw.BoxDecoration(
              color: active ? color : PdfColors.grey200,
              borderRadius: pw.BorderRadius.circular(3),
            ),
            child: pw.Text(
              _shortMonths[i],
              style: pw.TextStyle(
                fontSize: 8,
                color: active ? PdfColors.white : PdfColors.grey600,
                fontWeight: active ? pw.FontWeight.bold : pw.FontWeight.normal,
              ),
            ),
          );
        }),
      ],
    );
  }

  static pw.Widget _buildInfoTable(List<List<String?>> rows) {
    final filled = rows.where((r) => r[1] != null && r[1]!.isNotEmpty).toList();
    return pw.Table(
      columnWidths: {
        0: const pw.FixedColumnWidth(160),
        1: const pw.FlexColumnWidth(),
      },
      children: filled.map((r) {
        return pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 2),
              child: pw.Text(r[0]!,
                  style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColors.grey700)),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 2),
              child: pw.Text(r[1]!, style: const pw.TextStyle(fontSize: 10)),
            ),
          ],
        );
      }).toList(),
    );
  }

  static pw.Widget _buildCompanionRow(
      String label, List<String> ids, PdfColor color) {
    final names = ids.map((id) {
      try {
        return vegetablesBase.firstWhere((v) => v.id == id).name;
      } catch (_) {
        return id;
      }
    }).join(', ');
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('$label : ',
            style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: color)),
        pw.Expanded(
          child: pw.Text(names, style: const pw.TextStyle(fontSize: 10)),
        ),
      ],
    );
  }
}

/// Petit bloc statistique pour le récap saison (interne au service).
class _Stat extends pw.StatelessWidget {
  final String label;
  final String value;
  _Stat({required this.label, required this.value});

  @override
  pw.Widget build(pw.Context context) {
    return pw.Expanded(
      child: pw.Container(
        padding: const pw.EdgeInsets.all(10),
        margin: const pw.EdgeInsets.only(right: 8),
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.grey400),
          borderRadius: pw.BorderRadius.circular(8),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            pw.Text(
              label,
              style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              value,
              style: pw.TextStyle(
                fontSize: 22,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
