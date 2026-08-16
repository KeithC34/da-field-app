import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/repositories/farmer_repository.dart';
import '../../widgets/app_ui.dart';

class FarmerRegistrationScreen extends StatefulWidget {
  const FarmerRegistrationScreen({super.key});

  @override
  State<FarmerRegistrationScreen> createState() =>
      _FarmerRegistrationScreenState();
}

class _FarmerRegistrationScreenState extends State<FarmerRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _uuid = const Uuid();

  Position? _position;
  bool _isLocating = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _contactNumberController.dispose();
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
            'Turn on location services before capturing the farm location.',
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

  Future<void> _submit() async {
    if (_isSubmitting || !_formKey.currentState!.validate()) {
      return;
    }

    final position = _position;
    if (position == null) {
      _showMessage('Capture the farmer location before submitting.');
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => _isSubmitting = true);

    try {
      await context.read<FarmerRepository>().registerFarmer(
        _uuid.v4(),
        _fullNameController.text,
        _contactNumberController.text,
        position.latitude,
        position.longitude,
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Farmer saved and queued for synchronization.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      Navigator.of(context).pop();
    } on ArgumentError catch (error) {
      if (mounted) {
        _showMessage(error.message?.toString() ?? 'Invalid farmer details.');
      }
    } catch (_) {
      if (mounted) {
        _showMessage('Unable to save the farmer. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
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

  String? _validateFullName(String? value) {
    final fullName = value?.trim() ?? '';
    if (fullName.isEmpty) {
      return 'Enter the farmer full name.';
    }
    if (fullName.length < 2 || fullName.length > 120) {
      return 'Full name must contain 2 to 120 characters.';
    }

    return null;
  }

  String? _validateContactNumber(String? value) {
    final contactNumber = value?.trim() ?? '';
    if (contactNumber.isEmpty) {
      return 'Enter the contact number.';
    }
    if (!RegExp(r'^[0-9+\-\s()]{7,30}$').hasMatch(contactNumber)) {
      return 'Enter a valid contact number.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final position = _position;

    return Scaffold(
      appBar: const AppHeader(title: 'DA Magdalena', subtitle: 'Farmer Registration'),
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
                      'Farmer information',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'The record is saved on this device first and will sync '
                      'when a connection is available.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _fullNameController,
                      enabled: !_isSubmitting,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.name],
                      validator: _validateFullName,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _contactNumberController,
                      enabled: !_isSubmitting,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.telephoneNumber],
                      validator: _validateContactNumber,
                      decoration: const InputDecoration(
                        labelText: 'Contact Number',
                        hintText: '09XX XXX XXXX',
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                    ),
                    const SizedBox(height: 24),
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
                                  Icons.location_on_outlined,
                                  color: colorScheme.primary,
                                ),
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
                                value: position.latitude.toStringAsFixed(6),
                              ),
                              const SizedBox(height: 8),
                              _CoordinateRow(
                                label: 'Longitude',
                                value: position.longitude.toStringAsFixed(6),
                              ),
                              const SizedBox(height: 8),
                              _CoordinateRow(
                                label: 'Accuracy',
                                value:
                                    '${position.accuracy.toStringAsFixed(1)} m',
                              ),
                            ],
                            const SizedBox(height: 16),
                            OutlinedButton.icon(
                              onPressed: _isLocating || _isSubmitting
                                  ? null
                                  : _captureLocation,
                              icon: _isLocating
                                  ? const SizedBox.square(
                                      dimension: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.3,
                                      ),
                                    )
                                  : const Icon(Icons.my_location),
                              label: Text(
                                _isLocating
                                    ? 'Capturing location...'
                                    : position == null
                                    ? 'Capture Current Location'
                                    : 'Update Location',
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
                            : const Icon(Icons.save_outlined),
                        label: Text(
                          _isSubmitting ? 'Saving...' : 'Submit Registration',
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

class _CoordinateRow extends StatelessWidget {
  const _CoordinateRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        SelectableText(
          value,
          style: const TextStyle(fontFeatures: [FontFeature.tabularFigures()]),
        ),
      ],
    );
  }
}
