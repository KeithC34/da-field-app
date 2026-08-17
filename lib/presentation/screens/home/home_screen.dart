import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart' show OrderingTerm;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/notifications/notification_alert_service.dart';
import '../../../core/security/secure_session_storage.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/local/database/app_database.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/notification_repository.dart';
import '../../widgets/app_ui.dart';
import '../auth/login_screen.dart';
import '../disease_reports/disease_report_screen.dart';
import '../dispersals/dispersal_screen.dart';
import '../farmers/farmer_registration_screen.dart';
import '../gis/gis_field_map_screen.dart';
import '../inspections/inspection_screen.dart';
import '../media/photo_verification_screen.dart';
import '../notifications/notification_screen.dart';
import '../pig_health/pig_health_screen.dart';
import '../piglets/piglet_registration_screen.dart';
import '../pigs/pig_registration_screen.dart';
import '../returns/return_piglet_verification_screen.dart';
import '../sync/sync_status_screen.dart';
import '../waste/waste_management_inspection_screen.dart';
import '../wastewater/wastewater_inspection_screen.dart';
import 'home_dashboard_status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final Connectivity _connectivity = Connectivity();

  bool _isLoggingOut = false;
  bool _checkingConnectivity = true;
  bool _refreshingNotifications = false;
  bool _redirectingToLogin = false;
  bool _soundEnabled = true;
  bool? _backendReachable;
  int _tab = 0;
  List<ConnectivityResult> _connectivityResults = const <ConnectivityResult>[];
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  Timer? _notificationTimer;

  List<_DashboardAction> get _actions => [
    _DashboardAction(
      'Register Farmer',
      'Farmer and GPS details',
      Icons.person_add_alt_1_outlined,
      AppTheme.primary,
      () => _open(const FarmerRegistrationScreen()),
    ),
    _DashboardAction(
      'Register Pig',
      'Livestock and pen record',
      Icons.pets_outlined,
      AppTheme.primary,
      () => _open(const PigRegistrationScreen()),
    ),
    _DashboardAction(
      'Health Check',
      'Health, GPS, and evidence',
      Icons.vaccines_outlined,
      const Color(0xFF536B42),
      () => _open(const PigHealthScreen()),
    ),
    _DashboardAction(
      'Report Disease',
      'Suspected illness report',
      Icons.health_and_safety_outlined,
      const Color(0xFF9B263B),
      () => _open(const DiseaseReportScreen()),
    ),
    _DashboardAction(
      'Pen Inspection',
      'Pen and waste conditions',
      Icons.fact_check_outlined,
      const Color(0xFF536B42),
      () => _open(const InspectionScreen()),
    ),
    _DashboardAction(
      'Dispersal',
      'Pig follow-up record',
      Icons.volunteer_activism_outlined,
      const Color(0xFF536B42),
      () => _open(const DispersalScreen()),
    ),
    _DashboardAction(
      'Photo Verification',
      'Photos and documents',
      Icons.verified_user_outlined,
      const Color(0xFF536B42),
      () => _open(const PhotoVerificationScreen()),
    ),
    _DashboardAction(
      'Synchronization',
      'Review queue and retry',
      Icons.sync_outlined,
      const Color(0xFF536B42),
      () => _open(const SyncStatusScreen()),
    ),
    _DashboardAction(
      'Register Piglet',
      'Link sow, farmer, and pen',
      Icons.cruelty_free_outlined,
      AppTheme.primary,
      () => _open(const PigletRegistrationScreen()),
    ),
    _DashboardAction(
      'Waste Inspection',
      'Waste compliance and evidence',
      Icons.delete_outline,
      const Color(0xFF536B42),
      () => _open(const WasteManagementInspectionScreen()),
    ),
    _DashboardAction(
      'Wastewater Inspection',
      'Discharge and GPS evidence',
      Icons.water_drop_outlined,
      const Color(0xFF536B42),
      () => _open(const WastewaterInspectionScreen()),
    ),
    _DashboardAction(
      'Return Verification',
      'Verify distributed piglet returns',
      Icons.assignment_return_outlined,
      const Color(0xFF536B42),
      () => _open(const ReturnPigletVerificationScreen()),
    ),
  ];

  bool get _hasNetwork =>
      _connectivityResults.any((result) => result != ConnectivityResult.none);

  bool get _hasAuthenticatedSession =>
      context.read<SecureSessionStorage>().hasAccessToken;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadNotificationPreferences();
    unawaited(_refreshConnectivity());
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _handleConnectivityChange,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_refreshNotifications(playAlert: false));
    });
    _notificationTimer = Timer.periodic(
      const Duration(seconds: 45),
      (_) => unawaited(_refreshNotifications()),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _connectivitySubscription?.cancel();
    _notificationTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(_refreshConnectivity());
      unawaited(_refreshNotifications());
    }
  }

  Future<void> _loadNotificationPreferences() async {
    final service = context.read<NotificationAlertService>();
    if (!mounted) return;
    setState(() => _soundEnabled = service.isSoundEnabled);
  }

  Future<void> _refreshConnectivity() async {
    final results = await _connectivity.checkConnectivity();
    if (!mounted) return;
    setState(() {
      _connectivityResults = results;
      _checkingConnectivity = false;
    });
  }

  void _handleConnectivityChange(List<ConnectivityResult> results) {
    final wasOnline = _hasNetwork;
    if (!mounted) return;
    setState(() {
      _connectivityResults = results;
      _checkingConnectivity = false;
    });
    if (!wasOnline && _hasNetwork) {
      unawaited(_refreshNotifications());
    }
  }

  Future<void> _refreshNotifications({
    bool playAlert = true,
    bool showFailure = false,
  }) async {
    if (!_hasAuthenticatedSession) {
      await _redirectToLoginOnExpiredSession();
      return;
    }
    if (_refreshingNotifications) return;
    setState(() => _refreshingNotifications = true);
    try {
      final result = await context.read<NotificationRepository>().refresh();
      if (!mounted) return;
      setState(() => _backendReachable = true);
      if (playAlert && result.newAlerts.isNotEmpty) {
        await context.read<NotificationAlertService>().notifyFreshNotifications(
          result.newAlerts,
        );
      }
    } catch (error) {
      if (_isUnauthorizedError(error)) {
        await _redirectToLoginOnExpiredSession();
        return;
      }
      if (!mounted) return;
      setState(() => _backendReachable = false);
      if (showFailure) {
        _message(
          'Unable to refresh notifications right now. Saved records remain available offline.',
        );
      }
    } finally {
      if (mounted) setState(() => _refreshingNotifications = false);
    }
  }

  Future<void> _toggleNotificationSound(bool value) async {
    final service = context.read<NotificationAlertService>();
    await service.setSoundEnabled(value);
    if (value) {
      final permissionGranted = await service.ensurePermission();
      if (!permissionGranted && mounted) {
        _message(
          'Android notification permission is off, so alerts may only play while the app is open.',
        );
      }
    }
    if (!mounted) return;
    setState(() => _soundEnabled = value);
  }

  Future<void> _logout() async {
    if (_isLoggingOut) return;
    setState(() => _isLoggingOut = true);
    try {
      await context.read<AuthRepository>().logout();
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    } on AuthException catch (error) {
      _message(error.message);
    } finally {
      if (mounted) setState(() => _isLoggingOut = false);
    }
  }

  Future<void> _redirectToLoginOnExpiredSession() async {
    if (_redirectingToLogin || !mounted) {
      return;
    }
    _redirectingToLogin = true;
    await context.read<SecureSessionStorage>().clearAccessToken();
    if (!mounted) {
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (_) => const LoginScreen(
          noticeMessage: 'Your session expired. Please sign in again to continue syncing and viewing notifications.',
        ),
      ),
      (route) => false,
    );
  }

  Future<void> _open(Widget screen) =>
      Navigator.of(context)
          .push(MaterialPageRoute<void>(builder: (_) => screen));

  Future<void> _openNotifications() async {
    await _open(const NotificationScreen());
    await _refreshNotifications(playAlert: false);
  }

  void _message(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    const titles = <String>[
      'Home',
      'Assigned Tasks',
      'Offline Records',
      'GIS Field Map',
      'Profile',
    ];
    final database = context.read<AppDatabase>();
    return Scaffold(
      appBar: AppHeader(
        title: 'DA Magdalena',
        subtitle: titles[_tab],
        actions: [
          StreamBuilder<int>(
            stream: context.read<NotificationRepository>().watchUnreadCount(),
            builder: (context, snapshot) => NotificationBellButton(
              unreadCount: snapshot.data ?? 0,
              onPressed: _openNotifications,
            ),
          ),
          if (_tab == 4)
            IconButton(
              onPressed: _isLoggingOut ? null : _logout,
              tooltip: 'Log out',
              icon: _isLoggingOut
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.logout_outlined),
            ),
        ],
      ),
      body: IndexedStack(
        index: _tab,
        children: [
          _dashboard(database),
          _taskList(),
          _records(),
          _mapState(),
          _profile(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (value) => setState(() => _tab = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.checklist_outlined),
            selectedIcon: Icon(Icons.checklist),
            label: 'Tasks',
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_open_outlined),
            selectedIcon: Icon(Icons.folder_open),
            label: 'Records',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: 'Map',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _dashboard(AppDatabase database) => StreamBuilder<List<SyncQueueData>>(
    stream: database.select(database.syncQueue).watch(),
    builder: (context, queueSnapshot) {
      final items = queueSnapshot.data ?? const <SyncQueueData>[];
      final pendingCount = items
          .where((item) => item.syncStatus == 'pending')
          .length;
      final syncingCount = items
          .where((item) => item.syncStatus == 'syncing')
          .length;
      final failedCount = items
          .where((item) => item.syncStatus == 'failed')
          .length;
      final conflictCount = items
          .where((item) => item.syncStatus == 'conflict')
          .length;
      return StreamBuilder<List<SyncLog>>(
        stream:
            (database.select(database.syncLogs)
                  ..orderBy([(table) => OrderingTerm.desc(table.startedAt)])
                  ..limit(1))
                .watch(),
        builder: (context, logSnapshot) {
          final lastLog = (logSnapshot.data ?? const <SyncLog>[]).isEmpty
              ? null
              : logSnapshot.data!.first;
          final status = HomeDashboardStatus.resolve(
            checkingConnectivity: _checkingConnectivity,
            hasNetwork: _hasNetwork,
            isSyncing: _refreshingNotifications,
            pendingCount: pendingCount,
            syncingCount: syncingCount,
            failedCount: failedCount,
            conflictCount: conflictCount,
            backendReachable: _knownBackendReachability(lastLog),
            lastSyncStatus: lastLog?.status,
          );
          final theme = Theme.of(context);
          return RefreshIndicator(
            onRefresh: () => _refreshNotifications(showFailure: true),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
              children: [
                Text(
                  'Good day, Field Worker',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Magdalena, Laguna',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 18),
                _SyncOverviewCard(
                  status: status,
                  onOpenSyncStatus: () => _open(const SyncStatusScreen()),
                ),
                if (status.state == HomeDashboardState.offline) ...[
                  const SizedBox(height: 12),
                  OfflineBanner(
                    message: status.pendingCount > 0
                        ? 'Offline mode is active. ${status.pendingCount} saved item(s) will sync automatically later.'
                        : 'Offline mode is active. You can keep recording field work safely on this device.',
                  ),
                ],
                const SizedBox(height: 28),
                SectionHeader(
                  title: 'Quick Actions',
                  subtitle: 'Jump into the most common field workflows.',
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.04,
                  ),
                  itemBuilder: (context, index) =>
                      _ActionCard(action: _actions[index]),
                ),
                const SizedBox(height: 28),
                SectionHeader(
                  title: 'Field Operations',
                  subtitle: 'Everything else you may need during the day.',
                  trailing: TextButton(
                    onPressed: () => setState(() => _tab = 1),
                    child: const Text('View all'),
                  ),
                ),
                const SizedBox(height: 12),
                SectionCard(
                  child: Column(
                    children: _actions
                        .skip(4)
                        .map(
                          (action) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _OperationTile(action: action),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );

  Widget _taskList() => ListView(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
    children: [
      const SectionHeader(
        title: 'Assigned Tasks',
        subtitle: 'Choose an operation to record in the field.',
      ),
      const SizedBox(height: 16),
      ..._actions.map(
        (action) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: SectionCard(child: _OperationTile(action: action)),
        ),
      ),
    ],
  );

  Widget _records() => ListView(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
    children: [
      const SectionHeader(
        title: 'Offline Records',
        subtitle: 'Review saved records, media, and synchronization status.',
      ),
      const SizedBox(height: 16),
      SectionCard(
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(child: Icon(Icons.sync_outlined)),
              title: const Text(
                'Synchronization queue',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: const Text(
                'Pending, syncing, synced, failed, and conflict records',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _open(const SyncStatusScreen()),
            ),
            const Divider(height: 24),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                child: Icon(Icons.photo_camera_back_outlined),
              ),
              title: const Text(
                'Photo and document evidence',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: const Text(
                'Capture, attach, and review upload status for field evidence',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _open(const PhotoVerificationScreen()),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _mapState() => ListView(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
    children: [
      const SectionHeader(
        title: 'GIS Field Map',
        subtitle: 'View synchronized locations, capture current GPS, and verify pig pen coordinates.',
      ),
      const SizedBox(height: 16),
      SectionCard(
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const CircleAvatar(child: Icon(Icons.map_outlined)),
          title: const Text(
            'Open field map',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: const Text(
            'Markers stay available from locally synchronized records, even while offline.',
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => _open(const GisFieldMapScreen()),
        ),
      ),
    ],
  );

  Widget _profile() => StreamBuilder<int>(
    stream: context.read<NotificationRepository>().watchUnreadCount(),
    builder: (context, snapshot) {
      final unreadCount = snapshot.data ?? 0;
      return ListView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 28),
        children: [
          Center(
            child: CircleAvatar(
              radius: 38,
              backgroundColor: AppTheme.primary,
              child: const Icon(Icons.person, size: 40, color: Colors.white),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              'DA Field Worker',
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              'Magdalena, Laguna',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 28),
          SectionCard(
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.notifications_outlined),
                  title: const Text(
                    'Notifications',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    unreadCount > 0
                        ? '$unreadCount unread alert(s) waiting'
                        : 'No unread alerts right now',
                  ),
                  trailing: unreadCount > 0
                      ? CountBadge(count: unreadCount)
                      : const Icon(Icons.chevron_right),
                  onTap: _openNotifications,
                ),
                const Divider(height: 24),
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  value: _soundEnabled,
                  title: const Text(
                    'Notification sound',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: const Text(
                    'Play a local alert when new notifications sync to this device.',
                  ),
                  secondary: Icon(
                    _soundEnabled
                        ? Icons.volume_up_outlined
                        : Icons.volume_off_outlined,
                  ),
                  onChanged: _toggleNotificationSound,
                ),
                const Divider(height: 24),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.cloud_sync_outlined),
                  title: const Text(
                    'Synchronization',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: const Text('Manage offline records and retry sync'),
                  onTap: () => _open(const SyncStatusScreen()),
                ),
                const Divider(height: 24),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.logout_outlined),
                  title: const Text(
                    'Log out',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  onTap: _isLoggingOut ? null : _logout,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Instant background alerts are limited to times when the app can fetch new data. Full background delivery would require a push service such as Firebase Cloud Messaging.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      );
    },
  );

  bool? _knownBackendReachability(SyncLog? lastLog) {
    if (_backendReachable != null) return _backendReachable;
    if (lastLog == null) return null;
    return switch (lastLog.status) {
      'completed' || 'partial' || 'conflict' => true,
      'failed' => false,
      _ => null,
    };
  }

  bool _isUnauthorizedError(Object error) =>
      error is DioException && error.response?.statusCode == 401;
}

class _DashboardAction {
  const _DashboardAction(
    this.title,
    this.description,
    this.icon,
    this.color,
    this.onTap,
  );

  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
}

class _SyncOverviewCard extends StatelessWidget {
  const _SyncOverviewCard({
    required this.status,
    required this.onOpenSyncStatus,
  });

  final HomeDashboardStatus status;
  final VoidCallback onOpenSyncStatus;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final tone = switch (status.state) {
      HomeDashboardState.offline => const Color(0xFFF3E7BE),
      HomeDashboardState.pendingSync => const Color(0xFFE6EBD5),
      HomeDashboardState.syncFailed => colorScheme.errorContainer,
      HomeDashboardState.syncing => colorScheme.primaryContainer,
      HomeDashboardState.synced => const Color(0xFFDCEAD9),
      _ => const Color(0xFFEAF0E4),
    };
    final accent = switch (status.state) {
      HomeDashboardState.offline => const Color(0xFF8A6100),
      HomeDashboardState.pendingSync => const Color(0xFF4E652C),
      HomeDashboardState.syncFailed => colorScheme.error,
      HomeDashboardState.syncing => AppTheme.primary,
      HomeDashboardState.synced => AppTheme.primary,
      _ => const Color(0xFF44623A),
    };
    final icon = switch (status.state) {
      HomeDashboardState.offline => Icons.cloud_off_outlined,
      HomeDashboardState.pendingSync => Icons.schedule_outlined,
      HomeDashboardState.syncFailed => Icons.error_outline,
      HomeDashboardState.syncing => Icons.sync_outlined,
      HomeDashboardState.synced => Icons.cloud_done_outlined,
      HomeDashboardState.checking => Icons.wifi_find_outlined,
      HomeDashboardState.online => Icons.wifi_outlined,
    };
    return Container(
      decoration: BoxDecoration(
        color: tone,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Field operations ready',
                      style: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      status.message,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              StatusBadge(label: status.label, color: accent, icon: icon),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _StatusPill(label: 'Network', value: status.networkLabel),
              _StatusPill(label: 'Server', value: status.serverLabel),
              _StatusPill(label: 'Sync', value: status.syncLabel),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: onOpenSyncStatus,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Open sync status'),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: .66),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall
              ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.labelLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}

class _OperationTile extends StatelessWidget {
  const _OperationTile({required this.action});

  final _DashboardAction action;

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: CircleAvatar(
      backgroundColor: action.color.withValues(alpha: .12),
      child: Icon(action.icon, color: action.color),
    ),
    title: Text(
      action.title,
      style: const TextStyle(fontWeight: FontWeight.w700),
    ),
    subtitle: Text(action.description),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    onTap: action.onTap,
  );
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.action});

  final _DashboardAction action;

  @override
  Widget build(BuildContext context) => Material(
    color: action.color,
    borderRadius: BorderRadius.circular(20),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: action.onTap,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(action.icon, color: Colors.white, size: 28),
            const Spacer(),
            Text(
              action.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              action.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
