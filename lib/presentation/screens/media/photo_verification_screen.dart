import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:drift/drift.dart' show OrderingTerm;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/sync/offline_record_type.dart';
import '../../../core/sync/offline_sync_status.dart';
import '../../../data/local/database/app_database.dart';
import '../../../domain/repositories/offline_record_repository.dart';

class PhotoVerificationScreen extends StatefulWidget {
  const PhotoVerificationScreen({super.key});

  @override
  State<PhotoVerificationScreen> createState() => _PhotoVerificationScreenState();
}

class _PhotoVerificationScreenState extends State<PhotoVerificationScreen> {
  static const _categories = <_MediaCategory>[
    _MediaCategory('Pig', OfflineRecordType.pig, Icons.pets_outlined),
    _MediaCategory('Piglet', OfflineRecordType.piglet, Icons.cruelty_free_outlined),
    _MediaCategory('Pen', OfflineRecordType.pigPenInspection, Icons.home_work_outlined),
    _MediaCategory('Waste', OfflineRecordType.wasteInspection, Icons.delete_outline),
    _MediaCategory('Wastewater', OfflineRecordType.wastewaterInspection, Icons.water_drop_outlined),
    _MediaCategory('Dispersal', OfflineRecordType.dispersalMonitoring, Icons.volunteer_activism_outlined),
    _MediaCategory('Returned', OfflineRecordType.returnPigletVerification, Icons.assignment_return_outlined),
    _MediaCategory('Field', OfflineRecordType.inspection, Icons.fact_check_outlined),
    _MediaCategory('Document', OfflineRecordType.fieldVerification, Icons.description_outlined),
  ];
  static const _maximumFileBytes = 20 * 1024 * 1024;

  final _recordIdController = TextEditingController();
  final _picker = ImagePicker();
  _MediaCategory _category = _categories.first;
  final List<File> _files = [];
  bool _isPicking = false;
  bool _isSaving = false;

  @override
  void dispose() {
    _recordIdController.dispose();
    super.dispose();
  }

  Future<void> _capture() async {
    if (_isPicking || _isSaving) return;
    setState(() => _isPicking = true);
    try {
      final image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1920,
      );
      if (image == null) return;
      await _addFile(File(image.path));
    } catch (_) {
      _message('Unable to capture a photo. Check camera permission and try again.');
    } finally {
      if (mounted) setState(() => _isPicking = false);
    }
  }

  Future<void> _selectImages() async {
    if (_isPicking || _isSaving) return;
    setState(() => _isPicking = true);
    try {
      final images = await _picker.pickMultiImage(imageQuality: 85, maxWidth: 1920);
      for (final image in images) {
        await _addFile(File(image.path));
      }
    } catch (_) {
      _message('Unable to select images.');
    } finally {
      if (mounted) setState(() => _isPicking = false);
    }
  }

  Future<void> _selectDocuments() async {
    if (_isPicking || _isSaving) return;
    setState(() => _isPicking = true);
    try {
      final selected = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['jpg', 'jpeg', 'png', 'webp', 'pdf', 'doc', 'docx'],
      );
      for (final file in selected) {
        if (file.path != null) await _addFile(File(file.path!));
      }
    } catch (_) {
      _message('Unable to select files.');
    } finally {
      if (mounted) setState(() => _isPicking = false);
    }
  }

  Future<void> _addFile(File source) async {
    if (!await source.exists()) return;
    if (await source.length() > _maximumFileBytes) {
      _message('${p.basename(source.path)} exceeds the 20 MB limit.');
      return;
    }
    if (mounted) setState(() => _files.add(source));
  }

  Future<void> _save() async {
    final recordId = _recordIdController.text.trim();
    if (_isSaving) return;
    if (recordId.isEmpty) {
      _message('Enter the field record UUID before saving evidence.');
      return;
    }
    if (_files.isEmpty) {
      _message('Capture or select at least one photo or document.');
      return;
    }
    setState(() => _isSaving = true);
    final persisted = <String>[];
    try {
      final directory = Directory(
        p.join((await getApplicationDocumentsDirectory()).path, 'field_evidence', recordId),
      );
      await directory.create(recursive: true);
      for (final source in _files) {
        final destination = p.join(
          directory.path,
          '${DateTime.now().microsecondsSinceEpoch}_${p.basename(source.path)}',
        );
        await source.copy(destination);
        persisted.add(destination);
      }
      if (!mounted) return;
      await context.read<OfflineRecordRepository>().queueAttachments(
        recordId: recordId,
        recordType: _category.recordType,
        filePaths: persisted,
      );
      if (!mounted) return;
      _message('${persisted.length} file(s) saved locally and marked Pending upload.');
      setState(() => _files.clear());
    } catch (_) {
      _message('Unable to save evidence locally. Your selected files were not queued.');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _message(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text), behavior: SnackBarBehavior.floating));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('DA Magdalena', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
          Text('Photo Verification', style: TextStyle(fontSize: 12)),
        ]),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
          children: [
            Text('Photo Category', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return ChoiceChip(
                    label: Text(category.label),
                    selected: _category == category,
                    onSelected: _isSaving ? null : (_) => setState(() => _category = category),
                    selectedColor: const Color(0xFF154212),
                    labelStyle: TextStyle(color: _category == category ? Colors.white : colors.onSurfaceVariant, fontWeight: FontWeight.w700),
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _recordIdController,
              enabled: !_isSaving,
              decoration: InputDecoration(
                labelText: '${_category.label} record UUID',
                helperText: 'Evidence stays linked to this existing field record.',
                prefixIcon: const Icon(Icons.link_outlined),
              ),
            ),
            const SizedBox(height: 20),
            _EvidencePreview(
              files: _files,
              category: _category,
              onRemove: _isSaving ? null : (index) => setState(() => _files.removeAt(index)),
            ),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(child: OutlinedButton.icon(onPressed: _isPicking || _isSaving ? null : _capture, icon: const Icon(Icons.camera_alt_outlined), label: const Text('Camera'))),
              const SizedBox(width: 8),
              Expanded(child: OutlinedButton.icon(onPressed: _isPicking || _isSaving ? null : _selectImages, icon: const Icon(Icons.photo_library_outlined), label: const Text('Gallery'))),
            ]),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _isPicking || _isSaving ? null : _selectDocuments,
              icon: const Icon(Icons.attach_file_outlined),
              label: const Text('Select image or supporting document'),
            ),
            const SizedBox(height: 20),
            _MediaQueueSummary(category: _category),
            const SizedBox(height: 20),
            SizedBox(
              height: 56,
              child: FilledButton.icon(
                onPressed: _isSaving ? null : _save,
                icon: _isSaving ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2.3)) : const Icon(Icons.save_outlined),
                label: Text(_isSaving ? 'Saving locally...' : 'Save evidence offline'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EvidencePreview extends StatelessWidget {
  const _EvidencePreview({required this.files, required this.category, required this.onRemove});
  final List<File> files;
  final _MediaCategory category;
  final ValueChanged<int>? onRemove;

  bool _isImage(File file) => const ['.jpg', '.jpeg', '.png', '.webp'].contains(p.extension(file.path).toLowerCase());

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    if (files.isEmpty) {
      return Container(
        height: 260,
        decoration: BoxDecoration(color: colors.surfaceContainerLow, borderRadius: BorderRadius.circular(16), border: Border.all(color: colors.outlineVariant)),
        child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(category.icon, size: 48, color: colors.primary), const SizedBox(height: 10), const Text('No evidence selected yet.')])));
    }
    final file = files.first;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 360,
        color: Colors.black,
        child: Stack(fit: StackFit.expand, children: [
          if (_isImage(file)) Image.file(file, fit: BoxFit.cover) else Center(child: Column(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.picture_as_pdf_outlined, color: Colors.white, size: 64), const SizedBox(height: 8), Text(p.basename(file.path), style: const TextStyle(color: Colors.white))])),
          const DecoratedBox(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.center, colors: [Color(0xB3000000), Colors.transparent]))),
          Positioned(top: 12, right: 12, child: Chip(avatar: const Icon(Icons.cloud_upload_outlined, size: 16), label: const Text('Pending upload'), backgroundColor: colors.primaryContainer)),
          Positioned(left: 14, right: 14, bottom: 12, child: Row(children: [const Icon(Icons.link_outlined, color: Colors.white, size: 17), const SizedBox(width: 6), Expanded(child: Text('${files.length} file(s) · ${category.label} evidence', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)))])),
          if (onRemove != null) Positioned(top: 8, left: 8, child: IconButton.filledTonal(onPressed: () => onRemove!(0), icon: const Icon(Icons.close), tooltip: 'Remove preview')),
        ]),
      ),
    );
  }
}

class _MediaQueueSummary extends StatelessWidget {
  const _MediaQueueSummary({required this.category});
  final _MediaCategory category;

  @override
  Widget build(BuildContext context) {
    final database = context.read<AppDatabase>();
    return StreamBuilder<List<OfflinePhoto>>(
      stream: (database.select(database.offlinePhotos)..where((table) => table.recordType.equals(category.recordType))..orderBy([(table) => OrderingTerm.desc(table.createdAt)])..limit(5)).watch(),
      builder: (context, snapshot) {
        final photos = snapshot.data ?? const <OfflinePhoto>[];
        return Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Recent ${category.label} evidence', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              if (photos.isEmpty) const Text('No queued evidence for this category.'),
              ...photos.map((photo) => ListTile(contentPadding: EdgeInsets.zero, leading: _statusIcon(photo), title: Text(p.basename(photo.filePath), maxLines: 1, overflow: TextOverflow.ellipsis), subtitle: Text('Record ${photo.recordId}'), trailing: _statusLabel(photo))),
            ]),
          ),
        );
      },
    );
  }

  Widget _statusIcon(OfflinePhoto photo) => Icon(switch (photo.syncStatus) {
    OfflineSyncStatus.pending => Icons.schedule_outlined,
    OfflineSyncStatus.syncing => Icons.upload_outlined,
    OfflineSyncStatus.synced => Icons.cloud_done_outlined,
    OfflineSyncStatus.failed => Icons.error_outline,
    _ => Icons.warning_amber_outlined,
  });

  Widget _statusLabel(OfflinePhoto photo) {
    final label = photo.syncStatus == OfflineSyncStatus.synced
        ? switch (photo.verificationStatus) {'verified' => 'Verified', 'rejected' => 'Rejected', _ => 'Verification required'}
        : switch (photo.syncStatus) {OfflineSyncStatus.pending => 'Pending', OfflineSyncStatus.syncing => 'Uploading', OfflineSyncStatus.failed => 'Failed', _ => 'Pending'};
    return Text(label, textAlign: TextAlign.end, style: const TextStyle(fontSize: 12));
  }
}

class _MediaCategory {
  const _MediaCategory(this.label, this.recordType, this.icon);
  final String label;
  final String recordType;
  final IconData icon;
}
