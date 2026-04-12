import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../data/companions.dart';
import '../data/regions/france.dart';
import '../data/regions/west_africa.dart';
import '../data/vegetables_base.dart';
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
