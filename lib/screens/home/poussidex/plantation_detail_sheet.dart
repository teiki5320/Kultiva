import 'package:flutter/material.dart';

import '../../../models/plantation.dart';
import '../../../models/vegetable.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/category_colors.dart';
import '../../../utils/months.dart';
import '../../../widgets/plantation_photo.dart';
import '../../../widgets/share_card.dart';
import 'poussidex_card.dart' show expectedHarvestDays;

/// Bottom sheet détaillant une plantation du Poussidex :
/// grande carte + stats + timeline + photos + note + actions (arroser,
/// récolter, terminer, retirer) + partage.
class PlantationDetailSheet extends StatefulWidget {
  final Plantation plantation;
  final Vegetable vegetable;
  final VoidCallback onWater;
  final VoidCallback onHarvest;
  final VoidCallback onTerminate;
  final VoidCallback onRemove;
  final ValueChanged<String?> onNoteChanged;
  final ValueChanged<bool> onAddPhoto; // bool = fromCamera
  final ValueChanged<String> onRemovePhoto;

  const PlantationDetailSheet({
    super.key,
    required this.plantation,
    required this.vegetable,
    required this.onWater,
    required this.onHarvest,
    required this.onTerminate,
    required this.onRemove,
    required this.onNoteChanged,
    required this.onAddPhoto,
    required this.onRemovePhoto,
  });

  @override
  State<PlantationDetailSheet> createState() => _PlantationDetailSheetState();
}

class _PlantationDetailSheetState extends State<PlantationDetailSheet> {
  String _fmtDate(DateTime d) => '${d.day} ${monthNamesLong[d.month - 1]}';

  @override
  Widget build(BuildContext context) {
    final p = widget.plantation;
    final v = widget.vegetable;
    final cc = v.category.familyColor;
    final days = p.daysSincePlanted;
    final expected = expectedHarvestDays(v, p.plantedAt);
    final remaining = (expected - days).clamp(0, expected);
    final progress = (days / expected).clamp(0.0, 1.0);
    final thirsty =
        p.isActive && p.daysSinceWatered >= v.effectiveWateringDays;

    final events = <_TimelineEvent>[];
    events.add(_TimelineEvent(
        date: p.plantedAt, emoji: '🌱', label: 'Planté'));
    for (final w in p.wateredAt) {
      events.add(_TimelineEvent(date: w, emoji: '💧', label: 'Arrosé'));
    }
    if (p.harvestedAt != null) {
      events.add(_TimelineEvent(
          date: p.harvestedAt!, emoji: '🏁', label: 'Culture terminée'));
    }
    events.sort((a, b) => b.date.compareTo(a.date));

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (ctx, scrollCtrl) {
        return SingleChildScrollView(
          controller: scrollCtrl,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: cc, width: 3),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: cc.withValues(alpha: 0.25),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 18),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: cc.withValues(alpha: 0.18),
                          border: Border.all(
                              color: cc.withValues(alpha: 0.5), width: 2),
                        ),
                        alignment: Alignment.center,
                        child: Text(v.emoji,
                            style: const TextStyle(fontSize: 52)),
                      ),
                      const SizedBox(height: 12),
                      Text(v.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 22)),
                      Text(v.category.label,
                          style: TextStyle(
                              color: KultivaColors.textSecondary,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    p.isActive
                        ? 'Jour ${days + 1} / $expected'
                        : 'Culture terminée',
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 14),
                  ),
                  if (p.isActive)
                    Text(
                      remaining == 0
                          ? '✨ Prêt à récolter'
                          : '⏳ $remaining j restants',
                      style: TextStyle(
                        color: KultivaColors.textSecondary,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: p.isActive ? progress : 1.0,
                  minHeight: 8,
                  backgroundColor: cc.withValues(alpha: 0.12),
                  valueColor: AlwaysStoppedAnimation<Color>(cc),
                ),
              ),
              const SizedBox(height: 20),
              _InfoRow(
                icon: '💧',
                label: p.lastWatered == null
                    ? 'Jamais arrosé'
                    : 'Dernier arrosage : ${_fmtDate(p.lastWatered!)} (${p.daysSinceWatered}j)',
                alert: thirsty,
              ),
              _InfoRow(
                icon: '🧺',
                label:
                    '${p.harvestCount} récolte${p.harvestCount > 1 ? "s" : ""} enregistrée${p.harvestCount > 1 ? "s" : ""}',
              ),
              _InfoRow(
                icon: '📅',
                label: 'Planté le ${_fmtDate(p.plantedAt)}',
              ),
              if (v.watering != null)
                _InfoRow(icon: '🌊', label: v.watering!),
              const SizedBox(height: 18),
              _PhotoGallery(
                photos: p.photoPaths,
                onAdd: () => _showPhotoSourceSheet(context),
                onRemove: widget.onRemovePhoto,
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => _openShareDialog(context, cc),
                  icon: const Icon(Icons.share, size: 16),
                  label: const Text('Partager cette carte'),
                  style: TextButton.styleFrom(
                    foregroundColor: KultivaColors.primaryGreen,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _NoteEditor(
                initial: p.note,
                onChanged: widget.onNoteChanged,
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: p.isActive ? widget.onWater : null,
                      icon: const Text('💧',
                          style: TextStyle(fontSize: 18)),
                      label: const Text('Arroser'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4FC3F7),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: p.isActive ? widget.onHarvest : null,
                      icon: const Text('🧺',
                          style: TextStyle(fontSize: 18)),
                      label: const Text('Récolter'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: KultivaColors.terracotta,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: <Widget>[
                  if (p.isActive)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: widget.onTerminate,
                        icon: const Text('🏁',
                            style: TextStyle(fontSize: 14)),
                        label: const Text('Terminer'),
                      ),
                    ),
                  if (p.isActive) const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _confirmRemove(context),
                      icon: const Icon(Icons.delete_outline,
                          size: 18, color: Colors.red),
                      label: const Text('Retirer',
                          style: TextStyle(color: Colors.red)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                '📜 Historique',
                style: TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 15),
              ),
              const SizedBox(height: 8),
              for (final e in events)
                _TimelineTile(event: e, formatter: _fmtDate),
            ],
          ),
        );
      },
    );
  }

  void _confirmRemove(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Retirer ce plant ?'),
        content: Text(
            'Cette action supprime définitivement ${widget.vegetable.name} de ton Poussidex. Tes arrosages et récoltes liés seront perdus.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.onRemove();
            },
            child: const Text('Retirer',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _openShareDialog(BuildContext context, Color familyColor) {
    showDialog<void>(
      context: context,
      builder: (_) => SharePreviewDialog(
        plantation: widget.plantation,
        vegetable: widget.vegetable,
        familyColor: familyColor,
      ),
    );
  }

  void _showPhotoSourceSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: const Text('📸', style: TextStyle(fontSize: 22)),
                title: const Text('Prendre une photo',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                onTap: () {
                  Navigator.pop(ctx);
                  widget.onAddPhoto(true);
                },
              ),
              ListTile(
                leading: const Text('🖼️', style: TextStyle(fontSize: 22)),
                title: const Text('Choisir depuis la galerie',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                onTap: () {
                  Navigator.pop(ctx);
                  widget.onAddPhoto(false);
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}

class _TimelineEvent {
  final DateTime date;
  final String emoji;
  final String label;
  const _TimelineEvent({
    required this.date,
    required this.emoji,
    required this.label,
  });
}

class _TimelineTile extends StatelessWidget {
  final _TimelineEvent event;
  final String Function(DateTime) formatter;
  const _TimelineTile({required this.event, required this.formatter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Text(event.emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(event.label,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600)),
          ),
          Text(
            formatter(event.date),
            style: TextStyle(
              color: KultivaColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String icon;
  final String label;
  final bool alert;
  const _InfoRow({required this.icon, required this.label, this.alert = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Text(icon, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: alert ? KultivaColors.terracotta : null,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhotoGallery extends StatelessWidget {
  final List<String> photos;
  final VoidCallback onAdd;
  final ValueChanged<String> onRemove;
  const _PhotoGallery({
    required this.photos,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Text('📷', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Text(
              'Photos${photos.isEmpty ? "" : " (${photos.length})"}',
              style: const TextStyle(
                  fontWeight: FontWeight.w800, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 96,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              for (final path in photos)
                _PhotoThumb(
                  path: path,
                  onRemove: () => onRemove(path),
                ),
              GestureDetector(
                onTap: onAdd,
                child: Container(
                  width: 96,
                  height: 96,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.add_a_photo_outlined,
                          color: KultivaColors.primaryGreen, size: 28),
                      const SizedBox(height: 4),
                      Text(
                        photos.isEmpty ? 'Ajouter' : '+',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: KultivaColors.primaryGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PhotoThumb extends StatelessWidget {
  final String path;
  final VoidCallback onRemove;
  const _PhotoThumb({required this.path, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      margin: const EdgeInsets.only(right: 8),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: PlantationPhoto(
              pathOrUrl: path,
              width: 96,
              height: 96,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey.shade200,
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image_outlined,
                    color: Colors.grey),
              ),
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () {
                showDialog<void>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Retirer la photo ?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Annuler'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onRemove();
                        },
                        child: const Text('Retirer',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close,
                    size: 14, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NoteEditor extends StatefulWidget {
  final String? initial;
  final ValueChanged<String?> onChanged;
  const _NoteEditor({required this.initial, required this.onChanged});

  @override
  State<_NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<_NoteEditor> {
  late TextEditingController _ctrl;
  bool _editing = false;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.initial ?? '');
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _save() {
    final text = _ctrl.text.trim();
    widget.onChanged(text.isEmpty ? null : text);
    setState(() => _editing = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_editing) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            controller: _ctrl,
            autofocus: true,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Ajoute une note sur ce plant…',
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  _ctrl.text = widget.initial ?? '';
                  setState(() => _editing = false);
                },
                child: const Text('Annuler'),
              ),
              const SizedBox(width: 6),
              ElevatedButton(
                onPressed: _save,
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ],
      );
    }
    final text = widget.initial;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => setState(() => _editing = true),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: <Widget>[
            const Text('📝', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text == null || text.isEmpty
                    ? 'Ajouter une note…'
                    : text,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: text == null || text.isEmpty
                      ? KultivaColors.textSecondary
                      : null,
                ),
              ),
            ),
            Icon(Icons.edit_outlined,
                size: 16, color: KultivaColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
