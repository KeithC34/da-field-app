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

import '../../../domain/repositories/inspection_repository.dart';
import '../../widgets/app_ui.dart';

class InspectionScreen extends StatefulWidget {
  const InspectionScreen({super.key});

  @override
  State<InspectionScreen> createState() => _InspectionScreenState();
}

class _InspectionScreenState extends State<InspectionScreen> {
  static const _maximumPhotoBytes = 10 * 1024 * 1024;

  final _formKey = GlobalKey<FormState>();
  final _penIdController = TextEditingController();
  final _wastewaterPhController = TextEditingController();
  final _coliformLevelController = TextEditingController();
  final _imagePicker = ImagePicker();
  final _uuid = const Uuid();

  bool _wasteManagementCompliant = false;
  Position? _position;
  XFile? _capturedPhoto;
  bool _isLocating = false;
  bool _isCapturingPhoto = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _penIdController.dispose();
    _wastewaterPhController.dispose();
    _coliformLevelController.dispose();
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
            'Turn on location services before capturing the pen location.',
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

      if (await photo.length() > _maximumPhotoBytes) {
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
        _showMessage(
          cameraAccessDenied
              ? 'Camera permission was denied. Enable it in the app settings.'
              : 'Unable to open the camera. Please try again.',
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
      _showMessage('Capture the inspection location before submitting.');
      return;
    }

    final capturedPhoto = _capturedPhoto;
    if (capturedPhoto == null) {
      _showMessage('Capture an inspection photo before submitting.');
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => _isSubmitting = true);

    String? persistedPhotoPath;
    var inspectionSaved = false;

    try {
      final inspectionId = _uuid.v4();
      persistedPhotoPath = await _persistPhoto(
        inspectionId,
        capturedPhoto.path,
      );

      if (!mounted) {
        await _deleteIfPresent(persistedPhotoPath);
        return;
      }

      await context.read<InspectionRepository>().submitInspection(
        inspectionId,
        _penIdController.text,
        _wasteManagementCompliant,
        double.parse(_wastewaterPhController.text.trim()),
        double.parse(_coliformLevelController.text.trim()),
        position.latitude,
        position.longitude,
        persistedPhotoPath,
      );
      inspectionSaved = true;

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Inspection saved and queued for synchronization.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      Navigator.of(context).pop();
    } on ArgumentError catch (error) {
      if (!inspectionSaved) {
        await _deleteIfPresent(persistedPhotoPath);
      }
      if (mounted) {
        _showMessage(error.message?.toString() ?? 'Invalid inspection data.');
      }
    } catch (_) {
      if (!inspectionSaved) {
        await _deleteIfPresent(persistedPhotoPath);
      }
      if (mounted) {
        _showMessage('Unable to save the inspection. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  Future<String> _persistPhoto(String inspectionId, String sourcePath) async {
    final sourceFile = File(sourcePath);
    if (!await sourceFile.exists()) {
      throw const FileSystemException('The captured photo is unavailable.');
    }

    final documentsDirectory = await getApplicationDocumentsDirectory();
    final photoDirectory = Directory(
      p.join(documentsDirectory.path, 'inspection_photos'),
    );
    await photoDirectory.create(recursive: true);

    final sourceExtension = p.extension(sourcePath).toLowerCase();
    final extension =
        {'.jpg', '.jpeg', '.png', '.webp'}.contains(sourceExtension)
        ? sourceExtension
        : '.jpg';
    final destination = File(
      p.join(photoDirectory.path, '$inspectionId$extension'),
    );

    return (await sourceFile.copy(destination.path)).path;
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

  String? _validatePenId(String? value) {
    final penId = value?.trim() ?? '';
    if (penId.isEmpty) {
      return 'Enter the pen ID.';
    }
    if (penId.length > 120) {
      return 'Pen ID must not exceed 120 characters.';
    }

    return null;
  }

  String? _validateWastewaterPh(String? value) {
    final ph = double.tryParse(value?.trim() ?? '');
    if (ph == null) {
      return 'Enter a valid wastewater pH.';
    }
    if (ph < 0 || ph > 14) {
      return 'Wastewater pH must be between 0 and 14.';
    }

    return null;
  }

  String? _validateColiformLevel(String? value) {
    final level = double.tryParse(value?.trim() ?? '');
    if (level == null) {
      return 'Enter a valid coliform level.';
    }
    if (level < 0) {
      return 'Coliform level must be zero or greater.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final capturedPhoto = _capturedPhoto;

    return Scaffold(
      appBar: const AppHeader(title: 'DA Magdalena', subtitle: 'Pig Pen Inspection'),
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
                      'Environmental compliance inspection',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Capture pen conditions, water-quality readings, GPS, '
                      'and photo evidence while working offline.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _penIdController,
                      enabled: !_isSubmitting,
                      textInputAction: TextInputAction.next,
                      validator: _validatePenId,
                      decoration: const InputDecoration(
                        labelText: 'Pen ID',
                        prefixIcon: Icon(Icons.home_work_outlined),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 0,
                      color: colorScheme.surfaceContainerLow,
                      child: SwitchListTile(
                        value: _wasteManagementCompliant,
                        onChanged: _isSubmitting
                            ? null
                            : (value) {
                                setState(
                                  () => _wasteManagementCompliant = value,
                                );
                              },
                        title: const Text('Waste management compliant'),
                        subtitle: const Text(
                          'Enable when storage, handling, and disposal meet '
                          'the required practices.',
                        ),
                        secondary: const Icon(Icons.recycling_outlined),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _wastewaterPhController,
                      enabled: !_isSubmitting,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      textInputAction: TextInputAction.next,
                      validator: _validateWastewaterPh,
                      decoration: const InputDecoration(
                        labelText: 'Wastewater pH',
                        hintText: '0.0–14.0',
                        prefixIcon: Icon(Icons.science_outlined),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _coliformLevelController,
                      enabled: !_isSubmitting,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      textInputAction: TextInputAction.done,
                      validator: _validateColiformLevel,
                      decoration: const InputDecoration(
                        labelText: 'Coliform Level',
                        hintText: 'Enter laboratory or field-test reading',
                        prefixIcon: Icon(Icons.biotech_outlined),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _InspectionGpsCard(
                      position: _position,
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
                                  'Inspection Photo',
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
                            : const Icon(Icons.fact_check_outlined),
                        label: Text(
                          _isSubmitting ? 'Saving...' : 'Submit Inspection',
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

class _InspectionGpsCard extends StatelessWidget {
  const _InspectionGpsCard({
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
              _InspectionCoordinateRow(
                label: 'Latitude',
                value: position!.latitude.toStringAsFixed(6),
              ),
              const SizedBox(height: 8),
              _InspectionCoordinateRow(
                label: 'Longitude',
                value: position!.longitude.toStringAsFixed(6),
              ),
              const SizedBox(height: 8),
              _InspectionCoordinateRow(
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

class _InspectionCoordinateRow extends StatelessWidget {
  const _InspectionCoordinateRow({required this.label, required this.value});

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
