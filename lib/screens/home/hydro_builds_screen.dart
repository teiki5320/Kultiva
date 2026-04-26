import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/vegetables_base.dart';
import '../../services/auth_service.dart';
import '../../services/cloud_sync_service.dart';
import '../../services/hydro_build_service.dart';
import '../../theme/app_theme.dart';

/// Écran "Builds de la communauté" : la liste des installations
/// hydroponiques partagées par les autres utilisateurs.
class HydroBuildsScreen extends StatefulWidget {
  const HydroBuildsScreen({super.key});

  @override
  State<HydroBuildsScreen> createState() => _HydroBuildsScreenState();
}

class _HydroBuildsScreenState extends State<HydroBuildsScreen> {
  Future<List<HydroBuild>>? _future;
  HydroSystemType? _filter;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _future = HydroBuildService.instance.fetchAll(filterSystem: _filter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🌐  Builds hydro de la communauté'),
        actions: <Widget>[
          if (AuthService.instance.isSignedIn)
            IconButton(
              tooltip: 'Partager mon installation',
              icon: const Icon(Icons.add),
              onPressed: () async {
                final ok = await Navigator.of(context).push<bool>(
                  MaterialPageRoute<bool>(
                    builder: (_) => const ShareBuildScreen(),
                  ),
                );
                if (ok == true) _refresh();
              },
            ),
        ],
      ),
      body: Column(
        children: <Widget>[
          _FilterBar(
            current: _filter,
            onChanged: (v) {
              _filter = v;
              _refresh();
            },
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => _refresh(),
              child: FutureBuilder<List<HydroBuild>>(
                future: _future,
                builder: (ctx, snap) {
                  if (snap.connectionState != ConnectionState.done) {
                    return const Center(
                        child: CircularProgressIndicator());
                  }
                  final list = snap.data ?? <HydroBuild>[];
                  if (list.isEmpty) {
                    return const _EmptyBuilds();
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
                    itemCount: list.length,
                    itemBuilder: (ctx, i) =>
                        _BuildCard(entry: list[i], onChanged: _refresh),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: AuthService.instance.isSignedIn
          ? FloatingActionButton.extended(
              onPressed: () async {
                final ok = await Navigator.of(context).push<bool>(
                  MaterialPageRoute<bool>(
                    builder: (_) => const ShareBuildScreen(),
                  ),
                );
                if (ok == true) _refresh();
              },
              icon: const Icon(Icons.add),
              label: const Text('Partager mon build'),
              backgroundColor: const Color(0xFF4A9BBF),
              foregroundColor: Colors.white,
            )
          : null,
    );
  }
}

class _FilterBar extends StatelessWidget {
  final HydroSystemType? current;
  final ValueChanged<HydroSystemType?> onChanged;
  const _FilterBar({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _FilterChip(
            label: 'Tous',
            selected: current == null,
            onTap: () => onChanged(null),
          ),
          for (final s in HydroSystemType.values)
            _FilterChip(
              label: '${s.emoji}  ${s.label.split(' ').first}',
              selected: current == s,
              onTap: () => onChanged(s),
            ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 6, bottom: 6),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
      ),
    );
  }
}

class _EmptyBuilds extends StatelessWidget {
  const _EmptyBuilds();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(32),
      children: <Widget>[
        const SizedBox(height: 60),
        const Center(
          child: Text('🛠️', style: TextStyle(fontSize: 48)),
        ),
        const SizedBox(height: 12),
        Text(
          'Aucun build pour ce filtre. Sois le premier à partager ton '
          'installation pour inspirer la communauté !',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: KultivaColors.textSecondary,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class _BuildCard extends StatelessWidget {
  final HydroBuild entry;
  final VoidCallback onChanged;
  const _BuildCard({required this.entry, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: KultivaColors.winterA.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF4A9BBF).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                entry.systemType.emoji,
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      entry.systemType.label,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Par ${entry.userName}',
                      style: TextStyle(
                        fontSize: 11,
                        color: KultivaColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (entry.photoUrl != null) ...<Widget>[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                entry.photoUrl!,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const SizedBox(height: 180),
              ),
            ),
          ],
          if (entry.caption != null && entry.caption!.isNotEmpty) ...<Widget>[
            const SizedBox(height: 10),
            Text(entry.caption!, style: const TextStyle(fontSize: 13)),
          ],
          if (entry.equipment.isNotEmpty) ...<Widget>[
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: entry.equipment
                  .map(
                    (e) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A9BBF).withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        e,
                        style: const TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w700),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  entry.likedByMe ? Icons.favorite : Icons.favorite_border,
                  color: entry.likedByMe ? Colors.pinkAccent : null,
                ),
                onPressed: () async {
                  await HydroBuildService.instance.toggleLike(
                    entry.id,
                    currentlyLiked: entry.likedByMe,
                  );
                  onChanged();
                },
              ),
              Text('${entry.likesCount}'),
              const Spacer(),
              Text(
                _ago(entry.createdAt),
                style: TextStyle(
                  fontSize: 11,
                  color: KultivaColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static String _ago(DateTime dt) {
    final d = DateTime.now().difference(dt);
    if (d.inDays >= 1) return 'il y a ${d.inDays}j';
    if (d.inHours >= 1) return 'il y a ${d.inHours}h';
    if (d.inMinutes >= 1) return 'il y a ${d.inMinutes}min';
    return "à l'instant";
  }
}

/// Formulaire de partage d'un nouveau build.
class ShareBuildScreen extends StatefulWidget {
  const ShareBuildScreen({super.key});

  @override
  State<ShareBuildScreen> createState() => _ShareBuildScreenState();
}

class _ShareBuildScreenState extends State<ShareBuildScreen> {
  HydroSystemType _system = HydroSystemType.dwc;
  final TextEditingController _captionCtrl = TextEditingController();
  final TextEditingController _equipCtrl = TextEditingController();
  final List<String> _equipment = <String>[];
  String? _vegetableId;
  File? _photo;
  bool _publishing = false;

  @override
  void dispose() {
    _captionCtrl.dispose();
    _equipCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final x = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (x == null) return;
    setState(() => _photo = File(x.path));
  }

  void _addEquipment() {
    final t = _equipCtrl.text.trim();
    if (t.isEmpty) return;
    setState(() {
      _equipment.add(t);
      _equipCtrl.clear();
    });
  }

  Future<void> _publish() async {
    if (_publishing) return;
    setState(() => _publishing = true);
    try {
      String? photoUrl;
      if (_photo != null) {
        photoUrl = await CloudSyncService.instance.uploadPhoto(
          localPath: _photo!.path,
          plantationId: 'builds',
        );
      }
      await HydroBuildService.instance.publish(
        systemType: _system,
        equipment: _equipment,
        photoUrl: photoUrl,
        caption: _captionCtrl.text.trim().isEmpty
            ? null
            : _captionCtrl.text.trim(),
        vegetableId: _vegetableId,
      );
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec de la publication : $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _publishing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Partager mon build hydro')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          const Text(
            'Type de système',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: HydroSystemType.values
                .map(
                  (s) => ChoiceChip(
                    label: Text('${s.emoji}  ${s.label}'),
                    selected: _system == s,
                    onSelected: (_) => setState(() => _system = s),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 18),
          const Text(
            'Légume cultivé (optionnel)',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String?>(
            value: _vegetableId,
            isExpanded: true,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            items: <DropdownMenuItem<String?>>[
              const DropdownMenuItem<String?>(
                value: null,
                child: Text('—'),
              ),
              ...vegetablesBase
                  .where((v) => !v.id.startsWith('acc_'))
                  .map(
                    (v) => DropdownMenuItem<String?>(
                      value: v.id,
                      child: Text('${v.emoji}  ${v.name}'),
                    ),
                  ),
            ],
            onChanged: (v) => setState(() => _vegetableId = v),
          ),
          const SizedBox(height: 18),
          const Text(
            'Équipement utilisé',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          Text(
            'Ajoute un élément à la fois (ex. "Pompe air 4W", "LED 100W full spectrum"…).',
            style: TextStyle(
              fontSize: 12,
              color: KultivaColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _equipCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  onSubmitted: (_) => _addEquipment(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: _addEquipment,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: _equipment
                .map(
                  (e) => Chip(
                    label: Text(e),
                    onDeleted: () =>
                        setState(() => _equipment.remove(e)),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 18),
          const Text(
            'Photo (optionnelle)',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          if (_photo != null) ...<Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(_photo!,
                  height: 180, width: double.infinity, fit: BoxFit.cover),
            ),
            const SizedBox(height: 8),
          ],
          OutlinedButton.icon(
            onPressed: _pickPhoto,
            icon: const Icon(Icons.image_outlined),
            label: Text(_photo == null ? 'Choisir une photo' : 'Changer'),
          ),
          const SizedBox(height: 18),
          const Text(
            'Description (optionnelle)',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _captionCtrl,
            maxLines: 4,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText:
                  'Quelques mots sur ton install, ce qui marche bien, '
                  'ce que tu améliorerais…',
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _publishing ? null : _publish,
            child: Text(_publishing ? 'Publication...' : 'Publier'),
          ),
        ],
      ),
    );
  }
}
