import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';

import 'sync_processor.dart';

/// Starts synchronization on app resume, reconnection, login, and a periodic
/// retry while an authenticated field-worker session is active.
class SyncCoordinator with WidgetsBindingObserver {
  SyncCoordinator(
    this._processor,
    this._connectivity, {
    required this.hasAuthenticatedSession,
  });

  final SyncProcessor _processor;
  final Connectivity _connectivity;
  final bool Function() hasAuthenticatedSession;
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  Timer? _retryTimer;
  bool _started = false;

  void start() {
    if (_started) return;
    _started = true;
    WidgetsBinding.instance.addObserver(this);
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      if (_isOnline(results)) _synchronize('connectivity');
    });
    _retryTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => _synchronize('retry_timer'),
    );
    _synchronize('app_start');
  }

  void notifyAuthenticated() => _synchronize('login', force: true);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _synchronize('app_resume');
  }

  void _synchronize(String trigger, {bool force = false}) {
    if (!hasAuthenticatedSession()) return;
    unawaited(_processor.processQueue(trigger: trigger, force: force));
  }

  bool _isOnline(List<ConnectivityResult> results) =>
      results.any((result) => result != ConnectivityResult.none);

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _subscription?.cancel();
    _retryTimer?.cancel();
  }
}
