import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/sync/offline_record_type.dart';
import '../../../domain/repositories/offline_record_repository.dart';
import '../../widgets/app_ui.dart';

class PigHealthScreen extends StatefulWidget {
  const PigHealthScreen({super.key});

  @override
  State<PigHealthScreen> createState() => _PigHealthScreenState();
}

class _PigHealthScreenState extends State<PigHealthScreen> {
  static const _maximumPhotoBytes = 10 * 1024 * 1024;
  static const _conditions = <String>[
    'Healthy',
    'Needs Attention',
    'Sick',
    'Injured',
  ];

  final _formKey = GlobalKey<FormState>();
  final _pigIdController = TextEditingController();
  final _notesController = TextEditingController();
  final _picker = ImagePicker();
  String _condition = _conditions.first;
  Position? _position;
  XFile? _photo;
  bool _isLocating = false;
  bool _isCapturing = false;
  bool _isSaving = false;

  @override
  void dispose() {
    _pigIdController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _captureLocation() async {
    if (_isLocating || _isSaving) return;
    setState(() => _isLocating = true);
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        if (mounted) _message('Turn on location services and try again.');
        return;
      }
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (mounted) _message('Location permission is required.');
        return;
      }
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 30),
        ),
      );
      if (mounted) setState(() => _position = position);
    } on TimeoutException {
      if (mounted) _message('Location capture timed out. Please try again.');
    } catch (_) {
      if (mounted) _message('Unable to capture the current location.');
    } finally {
      if (mounted) setState(() => _isLocating = false);
    }
  }

  Future<void> _capturePhoto() async {
    if (_isCapturing || _isSaving) return;
    setState(() => _isCapturing = true);
    try {
      final photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1920,
      );
      if (photo == null) return;
      if (await photo.length() > _maximumPhotoBytes) {
        if (mounted) _message('The photo must be smaller than 10 MB.');
        return;
      }
      if (mounted) setState(() => _photo = photo);
    } on PlatformException {
      if (mounted) {
        _message('Camera permission is required to capture evidence.');
      }
    } catch (_) {
      if (mounted) _message('Unable to capture the photo.');
    } finally {
      if (mounted) setState(() => _isCapturing = false);
    }
  }

  Future<void> _save() async {
    if (_isSaving || !_formKey.currentState!.validate()) return;
    final position = _position;
    final photo = _photo;
    if (position == null) {
      _message('Capture the GPS location before saving.');
      return;
    }
    if (photo == null) {
      _message('Capture a pig health photo before saving.');
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => _isSaving = true);
    String? persistedPath;
    try {
      final documents = await getApplicationDocumentsDirectory();
      final directory = Directory(p.join(documents.path, 'pig_health_photos'));
      await directory.create(recursive: true);
      final extension =
          {
            '.jpg',
            '.jpeg',
            '.png',
            '.webp',
          }.contains(p.extension(photo.path).toLowerCase())
          ? p.extension(photo.path).toLowerCase()
          : '.jpg';
      persistedPath = p.join(
        directory.path,
        '${DateTime.now().microsecondsSinceEpoch}$extension',
      );
      await File(photo.path).copy(persistedPath);

      if (!mounted) return;
      await context.read<OfflineRecordRepository>().saveRecord(
        recordType: OfflineRecordType.pigHealth,
        payload: {
          'pig_id': _pigIdController.text.trim(),
          'condition': _condition,
          'notes': _notesController.text.trim(),
        },
        endpoint: '/pig-health',
        method: 'POST',
        latitude: position.latitude,
        longitude: position.longitude,
        photoPaths: [persistedPath],
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pig health record saved offline and queued for sync.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.of(context).pop();
    } catch (_) {
      if (persistedPath != null) {
        final file = File(persistedPath);
        if (await file.exists()) await file.delete();
      }
      if (mounted) _message('Unable to save the pig health record.');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _message(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(text), behavior: SnackBarBehavior.floating),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: const AppHeader(title: 'DA Magdalena', subtitle: 'Health Monitoring'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Record a field health assessment',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _pigIdController,
                      enabled: !_isSaving,
                      decoration: const InputDecoration(
                        labelText: 'Pig ID',
                        prefixIcon: Icon(Icons.pets_outlined),
                      ),
                      validator: (value) => value?.trim().isEmpty ?? true
                          ? 'Enter the pig ID.'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      initialValue: _condition,
                      decoration: const InputDecoration(
                        labelText: 'Condition',
                        prefixIcon: Icon(Icons.monitor_heart_outlined),
                      ),
                      items: _conditions
                          .map(
                            (condition) => DropdownMenuItem(
                              value: condition,
                              child: Text(condition),
                            ),
                          )
                          .toList(),
                      onChanged: _isSaving
                          ? null
                          : (value) {
                              if (value != null) {
                                setState(() => _condition = value);
                              }
                            },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _notesController,
                      enabled: !_isSaving,
                      minLines: 3,
                      maxLines: 6,
                      maxLength: 1000,
                      decoration: const InputDecoration(
                        labelText: 'Assessment Notes',
                        alignLabelWithHint: true,
                      ),
                      validator: (value) => (value?.trim().length ?? 0) < 2
                          ? 'Enter assessment notes.'
                          : null,
                    ),
                    const SizedBox(height: 8),
                    _CaptureCard(
                      icon: Icons.location_on_outlined,
                      title: 'GPS Location',
                      detail: _position == null
                          ? 'No location captured.'
                          : '${_position!.latitude.toStringAsFixed(6)}, '
                                '${_position!.longitude.toStringAsFixed(6)}',
                      buttonLabel: _position == null
                          ? 'Capture Location'
                          : 'Update Location',
                      isBusy: _isLocating,
                      onPressed: _captureLocation,
                    ),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Photo Evidence',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 12),
                            if (_photo != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(_photo!.path),
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              )
                            else
                              const SizedBox(
                                height: 100,
                                child: Center(
                                  child: Text('No photo captured.'),
                                ),
                              ),
                            const SizedBox(height: 12),
                            OutlinedButton.icon(
                              onPressed: _isCapturing || _isSaving
                                  ? null
                                  : _capturePhoto,
                              icon: _isCapturing
                                  ? const SizedBox.square(
                                      dimension: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.3,
                                      ),
                                    )
                                  : const Icon(Icons.camera_alt_outlined),
                              label: Text(
                                _photo == null
                                    ? 'Capture Photo'
                                    : 'Retake Photo',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 52,
                      child: FilledButton.icon(
                        onPressed: _isSaving ? null : _save,
                        icon: _isSaving
                            ? const SizedBox.square(
                                dimension: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.3,
                                ),
                              )
                            : const Icon(Icons.save_outlined),
                        label: Text(_isSaving ? 'Saving...' : 'Save Offline'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CaptureCard extends StatelessWidget {
  const _CaptureCard({
    required this.icon,
    required this.title,
    required this.detail,
    required this.buttonLabel,
    required this.isBusy,
    required this.onPressed,
  });

  final IconData icon;
  final String title;
  final String detail;
  final String buttonLabel;
  final bool isBusy;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 10),
                Text(title, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 12),
            SelectableText(detail),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: isBusy ? null : onPressed,
              icon: isBusy
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2.3),
                    )
                  : const Icon(Icons.my_location),
              label: Text(isBusy ? 'Capturing...' : buttonLabel),
            ),
          ],
        ),
      ),
    );
  }
}
