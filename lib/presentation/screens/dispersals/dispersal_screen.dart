import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/repositories/dispersal_repository.dart';
import '../../widgets/app_ui.dart';

class DispersalScreen extends StatefulWidget {
  const DispersalScreen({super.key});

  @override
  State<DispersalScreen> createState() => _DispersalScreenState();
}

class _DispersalScreenState extends State<DispersalScreen> {
  static const _conditions = ['Healthy', 'Underweight', 'Sick', 'Recovering'];

  final _formKey = GlobalKey<FormState>();
  final _farmerIdController = TextEditingController();
  final _pigIdController = TextEditingController();
  final _remarksController = TextEditingController();
  final _uuid = const Uuid();

  String _condition = _conditions.first;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _farmerIdController.dispose();
    _pigIdController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_isSubmitting || !_formKey.currentState!.validate()) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => _isSubmitting = true);

    try {
      await context.read<DispersalRepository>().submitDispersal(
        _uuid.v4(),
        _farmerIdController.text,
        _pigIdController.text,
        _condition,
        _remarksController.text,
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Dispersal update saved and queued for synchronization.',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      Navigator.of(context).pop();
    } on ArgumentError catch (error) {
      if (mounted) {
        _showMessage(error.message?.toString() ?? 'Invalid dispersal data.');
      }
    } catch (_) {
      if (mounted) {
        _showMessage('Unable to save the dispersal update. Please try again.');
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

  String? _validateRemarks(String? value) {
    final remarks = value?.trim() ?? '';
    if (remarks.isEmpty) {
      return 'Enter monitoring remarks.';
    }
    if (remarks.length > 1000) {
      return 'Remarks must not exceed 1,000 characters.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: const AppHeader(title: 'DA Magdalena', subtitle: 'Dispersal Monitoring'),
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
                      'Dispersal follow-up',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Record the current condition of a distributed pig and '
                      'notes from the field visit.',
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
                      controller: _pigIdController,
                      enabled: !_isSubmitting,
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          _validateRequiredId(value, 'pig ID'),
                      decoration: const InputDecoration(
                        labelText: 'Pig ID',
                        prefixIcon: Icon(Icons.pets_outlined),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      initialValue: _condition,
                      decoration: const InputDecoration(
                        labelText: 'Condition',
                        prefixIcon: Icon(Icons.health_and_safety_outlined),
                      ),
                      items: _conditions
                          .map(
                            (condition) => DropdownMenuItem(
                              value: condition,
                              child: Text(condition),
                            ),
                          )
                          .toList(growable: false),
                      onChanged: _isSubmitting
                          ? null
                          : (value) {
                              if (value != null) {
                                setState(() => _condition = value);
                              }
                            },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _remarksController,
                      enabled: !_isSubmitting,
                      textCapitalization: TextCapitalization.sentences,
                      minLines: 4,
                      maxLines: 6,
                      textInputAction: TextInputAction.newline,
                      validator: _validateRemarks,
                      decoration: const InputDecoration(
                        labelText: 'Remarks',
                        alignLabelWithHint: true,
                        prefixIcon: Icon(Icons.notes_outlined),
                        hintText: 'Enter observations and follow-up actions',
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
                          _isSubmitting ? 'Saving...' : 'Save Monitoring',
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
