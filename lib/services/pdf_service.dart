import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../data/companions.dart';
import '../data/names_en.dart';
import '../data/regions/regional_calendar.dart';
import '../data/ui_i18n.dart';
import '../utils/months.dart';
import '../data/vegetables_base.dart';
import '../models/culture_entry.dart';
import '../models/country.dart';
import '../models/region_data.dart';
import 'culture_service.dart';
import 'prefs_service.dart';
import '../models/vegetable.dart';

/// Génère et affiche un PDF de la fiche complète d'un légume.
class PdfService {
  PdfService._();

  static Future<void> printVegetableSheet(
      Vegetable vegetable, Region region) async {
    final doc = pw.Document();
    final regionData = _findRegionData(vegetable.id, region);
    // L'en-tête disait « Calendrier — France » à un jardinier
    // allemand : `Region.label` vaut « France » pour la base tempérée.
    final pays = PrefsService.instance.country.value;

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
                    '${vegetable.emoji}  ${vegetable.displayName}',
                    style: const pw.TextStyle(
                      fontSize: 28,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Spacer(),
                  pw.Text(
                    vegetable.category.label,
                    style: const pw.TextStyle(
                        fontSize: 14, color: PdfColors.grey600),
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
                  style: const pw.TextStyle(
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
                  trUiArgs('Calendrier — {0}',
                      <Object?>[placeLabelFor(region, pays)]),
                  style: const pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                _buildMonthBar(
                    trUi('Semis'), regionData.sowingMonths, PdfColors.green),
                pw.SizedBox(height: 4),
                _buildMonthBar(trUi('Récolte'), regionData.harvestMonths,
                    PdfColors.orange),
                if (regionData.regionalNote != null) ...[
                  pw.SizedBox(height: 6),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.amber50,
                      borderRadius: pw.BorderRadius.circular(4),
                    ),
                    child: pw.Text(
                      '${placeEmojiFor(region, pays)} ${regionData.regionalNote}',
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
                trUi('Techniques de culture'),
                style: const pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              _buildInfoTable(<List<String?>>[
                [trUi('Technique'), vegetable.sowingTechnique],
                [trUi('Profondeur'), vegetable.sowingDepth],
                [trUi('Température germination'), vegetable.germinationTemp],
                [trUi('Levée'), vegetable.germinationDays],
                [trUi('Exposition'), vegetable.exposure],
                [trUi('Espacement'), vegetable.spacing],
                [trUi('Arrosage'), vegetable.watering],
                [trUi('Sol'), vegetable.soil],
                [trUi('Rendement'), vegetable.yieldEstimate],
              ]),

              // Compagnonnage
              if (companionMap.containsKey(vegetable.id) ||
                  incompatibleMap.containsKey(vegetable.id)) ...[
                pw.SizedBox(height: 16),
                pw.Divider(),
                pw.SizedBox(height: 8),
                pw.Text(
                  trUi('Compagnonnage'),
                  style: const pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                if (companionMap.containsKey(vegetable.id))
                  _buildCompanionRow(
                    trUi('Bons voisins'),
                    companionMap[vegetable.id]!,
                    PdfColors.green700,
                  ),
                if (incompatibleMap.containsKey(vegetable.id)) ...[
                  pw.SizedBox(height: 4),
                  _buildCompanionRow(
                    trUi('À éviter'),
                    incompatibleMap[vegetable.id]!,
                    PdfColors.red700,
                  ),
                ],
              ],

              pw.Spacer(),
              pw.Divider(color: PdfColors.grey300),
              pw.SizedBox(height: 4),
              pw.Text(
                trUi('Fiche générée par Kultiva'),
                style:
                    const pw.TextStyle(fontSize: 9, color: PdfColors.grey500),
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
    final soilCultures =
        cultures.where((c) => c.startedAt.year == year).toList();
    final totalCultures = soilCultures.length;
    // Les arrosages sont lus via le service : ils vivent dans le
    // dossier du plant depuis le rattachement du 30/10/2026, et
    // `c.wateredAt` ne porte plus que les anciennes sauvegardes.
    final wateringCounts = <String, int>{
      for (final c in soilCultures)
        c.id: CultureService.instance.wateringsFor(c).length,
    };
    final waterings = wateringCounts.values.fold<int>(0, (sum, n) => sum + n);
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
                trUiArgs('Récap saison {0}', <Object?>[year]),
                style: const pw.TextStyle(
                  fontSize: 28,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                trUi('Cahier de culture pleine terre'),
                style: const pw.TextStyle(
                  fontSize: 13,
                  color: PdfColors.grey700,
                ),
              ),
              pw.SizedBox(height: 22),
              pw.Row(
                children: <pw.Widget>[
                  _Stat(label: trUi('Cultures'), value: '$totalCultures'),
                  _Stat(label: trUi('Arrosages'), value: '$waterings'),
                  _Stat(
                    label: trUi('Durée moy.'),
                    value: avgDuration == 0
                        ? '—'
                        : trUiArgs('{0} j', <Object?>[avgDuration]),
                  ),
                ],
              ),
              pw.SizedBox(height: 24),
              pw.Text(
                trUi('Top 5 légumes'),
                style: const pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              if (topVeg.isEmpty)
                pw.Text(
                  trUi('Aucune culture cette saison.'),
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
                        style: const pw.TextStyle(
                          fontSize: 13,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              pw.SizedBox(height: 22),
              pw.Text(
                trUi('Répartition par famille'),
                style: const pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              for (final entry
                  in (categories.entries.toList()
                    ..sort((a, b) => b.value.compareTo(a.value))))
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 2),
                  child: pw.Text(
                    entry.value > 1
                        ? trUiArgs('{0} : {1} cultures',
                            <Object?>[entry.key.label, entry.value])
                        : trUiArgs('{0} : {1} culture',
                            <Object?>[entry.key.label, entry.value]),
                    style: const pw.TextStyle(fontSize: 12),
                  ),
                ),
              pw.SizedBox(height: 22),
              pw.Text(
                trUi('Détail des cultures'),
                style: const pw.TextStyle(
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
                    '${c.endedAt == null ? trUi("en cours") : _fmtShort(c.endedAt!)}'
                    '   ${_vegName(c.vegetableId)}'
                    '   ${trUiArgs("({0} arrosages)", <Object?>[
                      wateringCounts[c.id] ?? 0
                    ])}',
                    style: const pw.TextStyle(fontSize: 11),
                  ),
                ),
              pw.SizedBox(height: 32),
              pw.Text(
                trUi('Récap généré par Kultiva'),
                style: const pw.TextStyle(
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
      name: trUiArgs('Kultiva — Récap {0}', <Object?>[year]),
    );
  }

  static String _vegName(String id) {
    try {
      final v = vegetablesBase.firstWhere((veg) => veg.id == id);
      return v.displayName;
    } catch (_) {
      return id;
    }
  }

  static String _fmtShort(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}';

  static RegionData? _findRegionData(String vegetableId, Region region) {
    final list =
        regionalCalendar(region, zone: PrefsService.instance.effectiveZone);
    try {
      return list.firstWhere((rd) => rd.vegetableId == vegetableId);
    } catch (_) {
      return null;
    }
  }

  /// Les douze initiales de la barre de mois.
  ///
  /// Dérivées de la table des mois abrégés plutôt qu'écrites à la
  /// main : en espagnol, janvier est « enero », donc la première
  /// colonne porte un **E** et non un J. Écrites en dur, elles
  /// auraient menti dans une langue sur trois.
  static List<String> get _shortMonths =>
      monthNamesShort.map((m) => m[0].toUpperCase()).toList(growable: false);

  static pw.Widget _buildMonthBar(
      String label, List<int> months, PdfColor color) {
    return pw.Row(
      children: [
        pw.SizedBox(
          width: 60,
          child: pw.Text(label,
              style: const pw.TextStyle(
                  fontSize: 10, fontWeight: pw.FontWeight.bold)),
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
                  style: const pw.TextStyle(
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.grey700)),
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
        return vegetablesBase.firstWhere((v) => v.id == id).displayName;
      } catch (_) {
        return id;
      }
    }).join(', ');
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('$label : ',
            style: pw.TextStyle(
                fontSize: 10, fontWeight: pw.FontWeight.bold, color: color)),
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
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              value,
              style: const pw.TextStyle(
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
