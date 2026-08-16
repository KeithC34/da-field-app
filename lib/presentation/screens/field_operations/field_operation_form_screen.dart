import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/repositories/field_operations_repository.dart';
import '../../../data/local/database/app_database.dart';
import '../../widgets/app_ui.dart';

class OperationField {
  const OperationField({required this.key, required this.label, this.options = const [], this.multiline = false, this.number = false, this.date = false});
  final String key;
  final String label;
  final List<String> options;
  final bool multiline;
  final bool number;
  final bool date;
}

/// Reusable, durable form surface for new field operations. It deliberately
/// delegates persistence to [FieldOperationsRepository] so UI does not own
/// synchronization behavior.
class FieldOperationFormScreen extends StatefulWidget {
  const FieldOperationFormScreen({super.key, required this.title, required this.subtitle, required this.recordType, required this.fields, this.requireDispersalLink = false});
  final String title;
  final String subtitle;
  final String recordType;
  final List<OperationField> fields;
  final bool requireDispersalLink;
  @override
  State<FieldOperationFormScreen> createState() => _FieldOperationFormScreenState();
}

class _FieldOperationFormScreenState extends State<FieldOperationFormScreen> {
  final _form = GlobalKey<FormState>();
  final _picker = ImagePicker();
  final _uuid = const Uuid();
  late final Map<String, TextEditingController> _controllers;
  final List<XFile> _photos = [];
  Position? _position;
  bool _locating = false;
  bool _capturing = false;
  bool _saving = false;

  @override
  void initState() { super.initState(); _controllers = {for (final field in widget.fields) field.key: TextEditingController()}; }
  @override
  void dispose() { for (final controller in _controllers.values) { controller.dispose(); } super.dispose(); }

  Future<void> _location() async {
    if (_locating || _saving) return;
    setState(() => _locating = true);
    try {
      if (!await Geolocator.isLocationServiceEnabled()) { _notice('Turn on location services, then try again.'); return; }
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) { _notice('Location permission is permanently denied.', action: SnackBarAction(label: 'SETTINGS', onPressed: Geolocator.openAppSettings)); return; }
      if (permission == LocationPermission.denied) { _notice('Location permission is required to save an offline field record.'); return; }
      final value = await Geolocator.getCurrentPosition(locationSettings: const LocationSettings(accuracy: LocationAccuracy.high, timeLimit: Duration(seconds: 30)));
      if (mounted) setState(() => _position = value);
    } on TimeoutException { _notice('Location capture timed out. Move to an open area and retry.'); }
    catch (_) { _notice('Unable to capture the current location.'); }
    finally { if (mounted) setState(() => _locating = false); }
  }

  Future<void> _photo() async {
    if (_capturing || _saving) return;
    setState(() => _capturing = true);
    try {
      final photo = await _picker.pickImage(source: ImageSource.camera, imageQuality: 85, maxWidth: 1920);
      if (photo != null && mounted) setState(() => _photos.add(photo));
    } on PlatformException { _notice('Unable to open the camera. Check camera permission and retry.'); }
    catch (_) { _notice('Unable to capture a photo.'); }
    finally { if (mounted) setState(() => _capturing = false); }
  }

  Future<void> _save() async {
    if (_saving || !_form.currentState!.validate()) return;
    final position = _position;
    if (position == null) { _notice('Capture the current GPS location before saving.'); return; }
    setState(() => _saving = true);
    final id = _uuid.v4();
    try {
      final paths = <String>[];
      if (_photos.isNotEmpty) {
        final directory = Directory(p.join((await getApplicationDocumentsDirectory()).path, 'field_operation_media', id));
        await directory.create(recursive: true);
        for (final photo in _photos) {
          final extension = p.extension(photo.path).isEmpty ? '.jpg' : p.extension(photo.path);
          paths.add((await File(photo.path).copy(p.join(directory.path, '${_uuid.v4()}$extension'))).path);
        }
      }
      final payload = <String, dynamic>{
        for (final entry in _controllers.entries) entry.key: entry.value.text.trim(),
        'location': {'latitude': position.latitude, 'longitude': position.longitude},
        if (widget.requireDispersalLink) 'dispersal_id': _controllers['dispersal_id']?.text.trim(),
      };
      if (!mounted) return;
      await context.read<FieldOperationsRepository>().saveOperation(recordType: widget.recordType, payload: payload, latitude: position.latitude, longitude: position.longitude, photoPaths: paths, id: id);
      if (!mounted) return;
      _notice('Saved offline. This record will sync when internet becomes available.');
      Navigator.of(context).pop();
    } on ArgumentError catch (error) { _notice(error.message?.toString() ?? 'Check the operation details.'); }
    catch (_) { _notice('Unable to save this offline record.'); }
    finally { if (mounted) setState(() => _saving = false); }
  }

  void _notice(String text, {SnackBarAction? action}) => ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(text), action: action));

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppHeader(title: 'DA Magdalena', subtitle: widget.title),
    body: SafeArea(child: Form(key: _form, child: ListView(padding: const EdgeInsets.fromLTRB(16, 18, 16, 32), children: [
      SectionHeader(title: widget.title, subtitle: widget.subtitle), const SizedBox(height: 18),
      SectionCard(child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        for (final field in widget.fields) ...[_field(field), const SizedBox(height: 14)],
      ])),
      const SizedBox(height: 16), _locationCard(), const SizedBox(height: 16), _photoCard(), const SizedBox(height: 16),
      const OfflineBanner(), const SizedBox(height: 12), FilledButton.icon(onPressed: _saving ? null : _save, icon: _saving ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.save_outlined), label: Text(_saving ? 'SAVING...' : 'SAVE OFFLINE')),
    ]))),
  );

  Widget _field(OperationField field) {
    final controller = _controllers[field.key]!;
    if ({'farmer_id', 'mother_sow_id', 'pen_id'}.contains(field.key)) {
      return _referenceField(field, controller);
    }
    if (field.options.isNotEmpty) {
      return DropdownButtonFormField<String>(
      initialValue: controller.text.isEmpty ? null : controller.text,
      items: field.options.map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
      decoration: InputDecoration(labelText: field.label),
      onChanged: _saving ? null : (value) => controller.text = value ?? '',
      validator: (value) => value == null || value.isEmpty ? 'Select ${field.label.toLowerCase()}.' : null,
      );
    }
    if (field.date) {
      return TextFormField(controller: controller, readOnly: true, decoration: InputDecoration(labelText: field.label, suffixIcon: const Icon(Icons.calendar_today_outlined)), validator: (value) => value == null || value.isEmpty ? 'Select ${field.label.toLowerCase()}.' : null, onTap: _saving ? null : () async { final date = await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime.now().add(const Duration(days: 3650)), initialDate: DateTime.now()); if (date != null) { setState(() => controller.text = date.toIso8601String().substring(0, 10)); } });
    }
    return TextFormField(controller: controller, enabled: !_saving, minLines: field.multiline ? 3 : 1, maxLines: field.multiline ? 5 : 1, keyboardType: field.number ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.text, decoration: InputDecoration(labelText: field.label, alignLabelWithHint: field.multiline), validator: (value) { final normalized = value?.trim() ?? ''; if (normalized.isEmpty) return 'Enter ${field.label.toLowerCase()}.'; if (field.number && double.tryParse(normalized) == null) return 'Enter a valid number.'; return null; });
  }

  Widget _referenceField(OperationField field, TextEditingController controller) {
    final database = context.read<AppDatabase>();
    return FutureBuilder<List<_ReferenceValue>>(
      future: _references(database, field.key),
      builder: (context, snapshot) {
        final values = snapshot.data ?? const <_ReferenceValue>[];
        if (values.isEmpty) {
          return TextFormField(
            controller: controller,
            enabled: !_saving,
            decoration: InputDecoration(
              labelText: field.label,
              helperText: 'No local choices yet; enter the linked record ID.',
            ),
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Enter ${field.label.toLowerCase()}.'
                : null,
          );
        }
        return DropdownButtonFormField<String>(
          initialValue: controller.text.isEmpty ? null : controller.text,
          isExpanded: true,
          decoration: InputDecoration(labelText: field.label),
          items: values
              .map((value) => DropdownMenuItem(
                    value: value.id,
                    child: Text(value.label, overflow: TextOverflow.ellipsis),
                  ))
              .toList(),
          onChanged: _saving ? null : (value) => controller.text = value ?? '',
          validator: (value) => value == null || value.isEmpty
              ? 'Select ${field.label.toLowerCase()}.'
              : null,
        );
      },
    );
  }

  Future<List<_ReferenceValue>> _references(
    AppDatabase database,
    String fieldKey,
  ) async {
    if (fieldKey == 'farmer_id') {
      final farmers = await database.select(database.farmers).get();
      return farmers
          .map((farmer) => _ReferenceValue(farmer.id, '${farmer.fullName} (${farmer.id})'))
          .toList();
    }
    final pigs = await database.select(database.pigs).get();
    if (fieldKey == 'mother_sow_id') {
      return pigs
          .map((pig) => _ReferenceValue(pig.id, '${pig.breed} (${pig.id})'))
          .toList();
    }
    return pigs
        .map((pig) => pig.penId.trim())
        .where((penId) => penId.isNotEmpty)
        .toSet()
        .map((penId) => _ReferenceValue(penId, penId))
        .toList();
  }

  Widget _locationCard() => SectionCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [const Icon(Icons.my_location_outlined), const SizedBox(width: 8), Text('GPS Location', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700))]), const SizedBox(height: 10), Text(_position == null ? 'Required for an offline, traceable field record.' : '${_position!.latitude.toStringAsFixed(6)}, ${_position!.longitude.toStringAsFixed(6)} · ±${_position!.accuracy.toStringAsFixed(0)} m'), const SizedBox(height: 12), OutlinedButton.icon(onPressed: _locating || _saving ? null : _location, icon: _locating ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.gps_fixed), label: Text(_locating ? 'CAPTURING...' : _position == null ? 'CAPTURE LOCATION' : 'UPDATE LOCATION'))]));

  Widget _photoCard() => SectionCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [const Icon(Icons.photo_camera_outlined), const SizedBox(width: 8), Text('Photo Documentation', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700))]), const SizedBox(height: 12), if (_photos.isNotEmpty) SizedBox(height: 96, child: ListView.separated(scrollDirection: Axis.horizontal, itemCount: _photos.length, separatorBuilder: (_, _) => const SizedBox(width: 8), itemBuilder: (context, index) => Stack(children: [ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(File(_photos[index].path), width: 96, height: 96, fit: BoxFit.cover)), Positioned(top: 0, right: 0, child: IconButton.filledTonal(onPressed: _saving ? null : () => setState(() => _photos.removeAt(index)), icon: const Icon(Icons.close, size: 16))) ]))), if (_photos.isNotEmpty) const SizedBox(height: 12), OutlinedButton.icon(onPressed: _capturing || _saving ? null : _photo, icon: _capturing ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.camera_alt_outlined), label: Text(_capturing ? 'OPENING CAMERA...' : 'CAPTURE PHOTO'))]));
}

class _ReferenceValue {
  const _ReferenceValue(this.id, this.label);
  final String id;
  final String label;
}
