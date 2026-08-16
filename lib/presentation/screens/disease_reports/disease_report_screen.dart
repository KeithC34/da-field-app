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

import '../../../domain/repositories/disease_report_repository.dart';
import '../../widgets/app_ui.dart';

class DiseaseReportScreen extends StatefulWidget {
  const DiseaseReportScreen({super.key});

  @override
  State<DiseaseReportScreen> createState() => _DiseaseReportScreenState();
}

class _DiseaseReportScreenState extends State<DiseaseReportScreen> {
  static const _maximumPhotoBytes = 10 * 1024 * 1024;

  final _formKey = GlobalKey<FormState>();
  final _pigIdController = TextEditingController();
  final _symptomsController = TextEditingController();
  final _imagePicker = ImagePicker();
  final _uuid = const Uuid();

  Position? _position;
  XFile? _capturedPhoto;
  bool _isLocating = false;
  bool _isCapturingPhoto = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _pigIdController.dispose();
    _symptomsController.dispose();
    super.dispose();
  }

  Future<void> _captureLocation() async {
    if (_isLocating || _isSubmitting) {
      return;
    }

    setState(() => _isLocating = true);

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          _showMessage(
            'Turn on location services before capturing the report location.',
            action: SnackBarAction(
              label: 'Settings',
              onPressed: () => Geolocator.openLocationSettings(),
            ),
          );
        }
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        if (mounted) {
          _showMessage('Location permission was denied.');
        }
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          _showMessage(
            'Location permission is permanently denied. Enable it in the '
            'app settings.',
            action: SnackBarAction(
              label: 'Settings',
              onPressed: () => Geolocator.openAppSettings(),
            ),
          );
        }
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 30),
        ),
      );

      if (mounted) {
        setState(() => _position = position);
      }
    } on TimeoutException {
      if (mounted) {
        _showMessage(
          'Location capture timed out. Move to an open area and try again.',
        );
      }
    } catch (_) {
      if (mounted) {
        _showMessage('Unable to capture the current location.');
      }
    } finally {
      if (mounted) {
        setState(() => _isLocating = false);
      }
    }
  }

  Future<void> _capturePhoto() async {
    if (_isCapturingPhoto || _isSubmitting) {
      return;
    }

    setState(() => _isCapturingPhoto = true);

    try {
      final photo = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1920,
      );

      if (photo == null) {
        return;
      }

      final photoSize = await photo.length();
      if (photoSize > _maximumPhotoBytes) {
        if (mounted) {
          _showMessage('The photo must be smaller than 10 MB.');
        }
        return;
      }

      if (mounted) {
        setState(() => _capturedPhoto = photo);
      }
    } on PlatformException catch (error) {
      if (mounted) {
        final cameraAccessDenied = {
          'camera_access_denied',
          'camera_access_denied_without_prompt',
          'camera_access_restricted',
        }.contains(error.code);
        final message = cameraAccessDenied
            ? 'Camera permission was denied. Enable it in the app settings.'
            : 'Unable to open the camera. Please try again.';
        _showMessage(
          message,
          action: cameraAccessDenied
              ? SnackBarAction(
                  label: 'Settings',
                  onPressed: () => Geolocator.openAppSettings(),
                )
              : null,
        );
      }
    } catch (_) {
      if (mounted) {
        _showMessage('Unable to capture the photo. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() => _isCapturingPhoto = false);
      }
    }
  }

  Future<void> _submit() async {
    if (_isSubmitting || !_formKey.currentState!.validate()) {
      return;
    }

    final position = _position;
    if (position == null) {
      _showMessage('Capture the report location before submitting.');
      return;
    }

    final capturedPhoto = _capturedPhoto;
    if (capturedPhoto == null) {
      _showMessage('Capture a disease report photo before submitting.');
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => _isSubmitting = true);

    String? persistedPhotoPath;
    var reportSaved = false;

    try {
      final reportId = _uuid.v4();
      persistedPhotoPath = await _persistPhoto(reportId, capturedPhoto.path);

      if (!mounted) {
        await _deleteIfPresent(persistedPhotoPath);
        return;
      }

      await context.read<DiseaseReportRepository>().reportDisease(
        reportId,
        _pigIdController.text,
        _symptomsController.text,
        position.latitude,
        position.longitude,
        persistedPhotoPath,
      );
      reportSaved = true;

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Disease report saved and queued for synchronization.',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      Navigator.of(context).pop();
    } on ArgumentError catch (error) {
      if (!reportSaved) {
        await _deleteIfPresent(persistedPhotoPath);
      }
      if (mounted) {
        _showMessage(error.message?.toString() ?? 'Invalid report details.');
      }
    } catch (_) {
      if (!reportSaved) {
        await _deleteIfPresent(persistedPhotoPath);
      }
      if (mounted) {
        _showMessage('Unable to save the disease report. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  Future<String> _persistPhoto(String reportId, String sourcePath) async {
    final sourceFile = File(sourcePath);
    if (!await sourceFile.exists()) {
      throw const FileSystemException('The captured photo is unavailable.');
    }

    final documentsDirectory = await getApplicationDocumentsDirectory();
    final photoDirectory = Directory(
      p.join(documentsDirectory.path, 'disease_report_photos'),
    );
    await photoDirectory.create(recursive: true);

    final sourceExtension = p.extension(sourcePath).toLowerCase();
    final extension =
        {'.jpg', '.jpeg', '.png', '.webp'}.contains(sourceExtension)
        ? sourceExtension
        : '.jpg';
    final destination = File(
      p.join(photoDirectory.path, '$reportId$extension'),
    );
    final copiedFile = await sourceFile.copy(destination.path);

    return copiedFile.path;
  }

  Future<void> _deleteIfPresent(String? filePath) async {
    if (filePath == null) {
      return;
    }

    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
    } on FileSystemException {
      // Cleanup must not hide the original save error from the field worker.
    }
  }

  void _showMessage(String message, {SnackBarAction? action}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          action: action,
        ),
      );
  }

  String? _validatePigId(String? value) {
    final pigId = value?.trim() ?? '';
    if (pigId.isEmpty) {
      return 'Enter the pig ID.';
    }
    if (pigId.length > 120) {
      return 'Pig ID must not exceed 120 characters.';
    }

    return null;
  }

  String? _validateSymptoms(String? value) {
    final symptoms = value?.trim() ?? '';
    if (symptoms.isEmpty) {
      return 'Describe the observed symptoms.';
    }
    if (symptoms.length < 2 || symptoms.length > 2000) {
      return 'Symptoms must contain 2 to 2000 characters.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final position = _position;
    final capturedPhoto = _capturedPhoto;

    return Scaffold(
      appBar: const AppHeader(title: 'DA Magdalena', subtitle: 'Disease Reporting'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Document a suspected illness',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'The report and photo are stored safely on this device '
                      'until an authenticated connection is available.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _pigIdController,
                      enabled: !_isSubmitting,
                      textInputAction: TextInputAction.next,
                      validator: _validatePigId,
                      decoration: const InputDecoration(
                        labelText: 'Pig ID',
                        prefixIcon: Icon(Icons.pets_outlined),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _symptomsController,
                      enabled: !_isSubmitting,
                      minLines: 3,
                      maxLines: 6,
                      maxLength: 2000,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.multiline,
                      validator: _validateSymptoms,
                      decoration: const InputDecoration(
                        labelText: 'Symptoms',
                        hintText:
                            'Describe visible signs and changes in behavior',
                        alignLabelWithHint: true,
                        prefixIcon: Icon(Icons.medical_information_outlined),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _GpsCard(
                      position: position,
                      isBusy: _isLocating,
                      isEnabled: !_isSubmitting,
                      onCapture: _captureLocation,
                    ),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 0,
                      color: colorScheme.surfaceContainerLow,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.photo_camera_outlined,
                                  color: colorScheme.primary,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Photo Documentation',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            if (capturedPhoto == null)
                              Container(
                                height: 180,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: colorScheme.outlineVariant,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  'No photo captured yet.',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              )
                            else
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.file(
                                  File(capturedPhoto.path),
                                  height: 220,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) => const SizedBox(
                                    height: 180,
                                    child: Center(
                                      child: Text(
                                        'Unable to preview the photo.',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 16),
                            OutlinedButton.icon(
                              onPressed: _isCapturingPhoto || _isSubmitting
                                  ? null
                                  : _capturePhoto,
                              icon: _isCapturingPhoto
                                  ? const SizedBox.square(
                                      dimension: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.3,
                                      ),
                                    )
                                  : const Icon(Icons.camera_alt_outlined),
                              label: Text(
                                _isCapturingPhoto
                                    ? 'Opening camera...'
                                    : capturedPhoto == null
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
                        onPressed: _isSubmitting ? null : _submit,
                        icon: _isSubmitting
                            ? const SizedBox.square(
                                dimension: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.3,
                                ),
                              )
                            : const Icon(Icons.send_outlined),
                        label: Text(
                          _isSubmitting ? 'Saving...' : 'Submit Disease Report',
                        ),
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

class _GpsCard extends StatelessWidget {
  const _GpsCard({
    required this.position,
    required this.isBusy,
    required this.isEnabled,
    required this.onCapture,
  });

  final Position? position;
  final bool isBusy;
  final bool isEnabled;
  final VoidCallback onCapture;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.location_on_outlined, color: colorScheme.primary),
                const SizedBox(width: 10),
                Text(
                  'GPS Location',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (position == null)
              Text(
                'No location captured yet.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              )
            else ...[
              _CoordinateRow(
                label: 'Latitude',
                value: position!.latitude.toStringAsFixed(6),
              ),
              const SizedBox(height: 8),
              _CoordinateRow(
                label: 'Longitude',
                value: position!.longitude.toStringAsFixed(6),
              ),
              const SizedBox(height: 8),
              _CoordinateRow(
                label: 'Accuracy',
                value: '${position!.accuracy.toStringAsFixed(1)} m',
              ),
            ],
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: isBusy || !isEnabled ? null : onCapture,
              icon: isBusy
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2.3),
                    )
                  : const Icon(Icons.my_location),
              label: Text(
                isBusy
                    ? 'Capturing location...'
                    : position == null
                    ? 'Capture Current Location'
                    : 'Update Location',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoordinateRow extends StatelessWidget {
  const _CoordinateRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        SelectableText(value),
      ],
    );
  }
}
