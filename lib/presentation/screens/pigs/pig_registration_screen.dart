import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/repositories/pig_repository.dart';
import '../../widgets/app_ui.dart';

class PigRegistrationScreen extends StatefulWidget {
  const PigRegistrationScreen({super.key});

  @override
  State<PigRegistrationScreen> createState() => _PigRegistrationScreenState();
}

class _PigRegistrationScreenState extends State<PigRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _farmerIdController = TextEditingController();
  final _penIdController = TextEditingController();
  final _breedController = TextEditingController();
  final _weightController = TextEditingController();
  final _uuid = const Uuid();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _farmerIdController.dispose();
    _penIdController.dispose();
    _breedController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_isSubmitting || !_formKey.currentState!.validate()) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => _isSubmitting = true);

    try {
      await context.read<PigRepository>().registerPig(
        _uuid.v4(),
        _farmerIdController.text,
        _penIdController.text,
        _breedController.text,
        double.parse(_weightController.text.trim()),
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Pig saved and queued for synchronization.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      Navigator.of(context).pop();
    } on ArgumentError catch (error) {
      if (mounted) {
        _showMessage(error.message?.toString() ?? 'Invalid pig data.');
      }
    } catch (_) {
      if (mounted) {
        _showMessage('Unable to save the pig. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  String? _validateRequiredId(String? value, String label) {
    final normalized = value?.trim() ?? '';
    if (normalized.isEmpty) {
      return 'Enter the $label.';
    }
    if (normalized.length > 120) {
      return '$label must not exceed 120 characters.';
    }
    return null;
  }

  String? _validateBreed(String? value) {
    final breed = value?.trim() ?? '';
    if (breed.isEmpty) {
      return 'Enter the pig breed.';
    }
    if (breed.length > 120) {
      return 'Breed must not exceed 120 characters.';
    }
    return null;
  }

  String? _validateWeight(String? value) {
    final weight = double.tryParse(value?.trim() ?? '');
    if (weight == null || !weight.isFinite) {
      return 'Enter a valid weight.';
    }
    if (weight <= 0) {
      return 'Weight must be greater than zero.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: const AppHeader(title: 'DA Magdalena', subtitle: 'Pig Registration'),
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
                      'Pig registration',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Link the pig to its farmer and pen. The record remains '
                      'available offline until synchronization succeeds.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _farmerIdController,
                      enabled: !_isSubmitting,
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          _validateRequiredId(value, 'farmer ID'),
                      decoration: const InputDecoration(
                        labelText: 'Farmer ID',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _penIdController,
                      enabled: !_isSubmitting,
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          _validateRequiredId(value, 'pen ID'),
                      decoration: const InputDecoration(
                        labelText: 'Pen ID',
                        prefixIcon: Icon(Icons.home_work_outlined),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _breedController,
                      enabled: !_isSubmitting,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      validator: _validateBreed,
                      decoration: const InputDecoration(
                        labelText: 'Breed',
                        prefixIcon: Icon(Icons.pets_outlined),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _weightController,
                      enabled: !_isSubmitting,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submit(),
                      validator: _validateWeight,
                      decoration: const InputDecoration(
                        labelText: 'Weight (kg)',
                        prefixIcon: Icon(Icons.monitor_weight_outlined),
                        suffixText: 'kg',
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
                          _isSubmitting ? 'Saving...' : 'Register Pig',
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
