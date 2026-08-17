import 'package:da_field_app/presentation/screens/home/home_dashboard_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('reports offline with queued work when network is unavailable', () {
    final status = HomeDashboardStatus.resolve(
      checkingConnectivity: false,
      hasNetwork: false,
      isSyncing: false,
      pendingCount: 3,
      syncingCount: 0,
      failedCount: 0,
      conflictCount: 0,
      backendReachable: null,
    );

    expect(status.state, HomeDashboardState.offline);
    expect(status.label, 'Offline');
    expect(status.syncLabel, '3 queued');
  });

  test(
    'reports pending sync when connectivity is back and items are queued',
    () {
      final status = HomeDashboardStatus.resolve(
        checkingConnectivity: false,
        hasNetwork: true,
        isSyncing: false,
        pendingCount: 2,
        syncingCount: 0,
        failedCount: 0,
        conflictCount: 0,
        backendReachable: true,
        lastSyncStatus: 'completed',
      );

      expect(status.state, HomeDashboardState.pendingSync);
      expect(status.label, 'Pending Sync');
      expect(status.message, contains('2 saved item(s)'));
    },
  );

  test('reports sync failed when API is unreachable despite connectivity', () {
    final status = HomeDashboardStatus.resolve(
      checkingConnectivity: false,
      hasNetwork: true,
      isSyncing: false,
      pendingCount: 0,
      syncingCount: 0,
      failedCount: 0,
      conflictCount: 0,
      backendReachable: false,
      lastSyncStatus: 'failed',
    );

    expect(status.state, HomeDashboardState.syncFailed);
    expect(status.serverLabel, 'Unavailable');
  });

  test('reports synced when queue is clear and server is reachable', () {
    final status = HomeDashboardStatus.resolve(
      checkingConnectivity: false,
      hasNetwork: true,
      isSyncing: false,
      pendingCount: 0,
      syncingCount: 0,
      failedCount: 0,
      conflictCount: 0,
      backendReachable: true,
      lastSyncStatus: 'completed',
    );

    expect(status.state, HomeDashboardState.synced);
    expect(status.label, 'Synced');
    expect(status.syncLabel, 'All caught up');
  });
}
