import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/repositories/auth_repository.dart';
import '../../../data/sync/sync_coordinator.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_isLoading || !_formKey.currentState!.validate()) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => _isLoading = true);

    try {
      await context.read<AuthRepository>().login(
        _emailController.text,
        _passwordController.text,
      );
      if (mounted) context.read<SyncCoordinator>().notifyAuthenticated();

      if (!mounted) {
        return;
      }

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    } on AuthException catch (error) {
      if (!mounted) {
        return;
      }

      _showError(error.message);
    } catch (_) {
      if (!mounted) {
        return;
      }

      _showError('Unable to sign in. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) {
      return 'Enter your email address.';
    }

    final emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailPattern.hasMatch(email)) {
      return 'Enter a valid email address.';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your password.';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    child: Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(48),
                      ),
                      child: Icon(
                        Icons.agriculture_outlined,
                        size: 44,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'AgriStat Magdalena',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Magdalena, Laguna',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Card(
                    elevation: 0,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: AutofillGroup(
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Field Worker Login',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 24),
                              TextFormField(
                                controller: _emailController,
                                enabled: !_isLoading,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                autofillHints: const [AutofillHints.username],
                                autocorrect: false,
                                validator: _validateEmail,
                                onFieldSubmitted: (_) {
                                  _passwordFocusNode.requestFocus();
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Username or Email',
                                  hintText: 'e.g. jdelacruz',
                                  prefixIcon: Icon(Icons.email_outlined),
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _passwordController,
                                focusNode: _passwordFocusNode,
                                enabled: !_isLoading,
                                obscureText: _obscurePassword,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                autofillHints: const [AutofillHints.password],
                                enableSuggestions: false,
                                autocorrect: false,
                                validator: _validatePassword,
                                onFieldSubmitted: (_) => _login(),
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  suffixIcon: IconButton(
                                    onPressed: _isLoading
                                        ? null
                                        : () {
                                            setState(
                                              () => _obscurePassword =
                                                  !_obscurePassword,
                                            );
                                          },
                                    tooltip: _obscurePassword
                                        ? 'Show password'
                                        : 'Hide password',
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                height: 52,
                                child: FilledButton(
                                  onPressed: _isLoading ? null : _login,
                                  child: _isLoading
                                      ? const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox.square(
                                              dimension: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2.5,
                                              ),
                                            ),
                                            SizedBox(width: 12),
                                            Text('Signing in...'),
                                          ],
                                        )
                                      : const Text('SIGN IN'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Department of Agriculture • Field Operations',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
