enum HomeDashboardState {
  checking,
  online,
  offline,
  syncing,
  pendingSync,
  syncFailed,
  synced,
}

class HomeDashboardStatus {
  const HomeDashboardStatus({
    required this.state,
    required this.label,
    required this.message,
    required this.networkLabel,
    required this.serverLabel,
    required this.syncLabel,
    required this.pendingCount,
    required this.failedCount,
  });

  final HomeDashboardState state;
  final String label;
  final String message;
  final String networkLabel;
  final String serverLabel;
  final String syncLabel;
  final int pendingCount;
  final int failedCount;

  bool get isAttentionState => switch (state) {
    HomeDashboardState.offline ||
    HomeDashboardState.pendingSync ||
    HomeDashboardState.syncFailed => true,
    _ => false,
  };

  static HomeDashboardStatus resolve({
    required bool checkingConnectivity,
    required bool hasNetwork,
    required bool isSyncing,
    required int pendingCount,
    required int syncingCount,
    required int failedCount,
    required int conflictCount,
    required bool? backendReachable,
    String? lastSyncStatus,
  }) {
    final combinedFailedCount = failedCount + conflictCount;
    final networkLabel = hasNetwork ? 'Available' : 'Offline';
    final serverLabel = switch (backendReachable) {
      true => 'Reachable',
      false => 'Unavailable',
      null => hasNetwork ? 'Checking' : 'Waiting',
    };

    if (checkingConnectivity) {
      return HomeDashboardStatus(
        state: HomeDashboardState.checking,
        label: 'Checking',
        message: 'Verifying network and server availability.',
        networkLabel: hasNetwork ? 'Available' : 'Checking',
        serverLabel: hasNetwork ? 'Checking' : 'Waiting',
        syncLabel: pendingCount > 0 ? '$pendingCount queued' : 'Idle',
        pendingCount: pendingCount,
        failedCount: combinedFailedCount,
      );
    }

    if (!hasNetwork) {
      return HomeDashboardStatus(
        state: HomeDashboardState.offline,
        label: 'Offline',
        message: pendingCount > 0
            ? '$pendingCount field updates are safe on this device until reconnection.'
            : 'You can keep recording field work and sync later.',
        networkLabel: networkLabel,
        serverLabel: 'Waiting',
        syncLabel: pendingCount > 0 ? '$pendingCount queued' : 'Ready offline',
        pendingCount: pendingCount,
        failedCount: combinedFailedCount,
      );
    }

    if (isSyncing || syncingCount > 0) {
      return HomeDashboardStatus(
        state: HomeDashboardState.syncing,
        label: 'Syncing',
        message: 'Uploading saved work and checking for server updates.',
        networkLabel: networkLabel,
        serverLabel: serverLabel,
        syncLabel: syncingCount > 0 ? '$syncingCount active' : 'In progress',
        pendingCount: pendingCount,
        failedCount: combinedFailedCount,
      );
    }

    if (backendReachable == false ||
        lastSyncStatus == 'failed' ||
        combinedFailedCount > 0) {
      return HomeDashboardStatus(
        state: HomeDashboardState.syncFailed,
        label: 'Sync Failed',
        message: combinedFailedCount > 0
            ? '$combinedFailedCount item(s) need attention before they can fully sync.'
            : 'Network is available, but the server is not responding yet.',
        networkLabel: networkLabel,
        serverLabel: serverLabel,
        syncLabel: combinedFailedCount > 0
            ? '$combinedFailedCount failed'
            : 'Retry needed',
        pendingCount: pendingCount,
        failedCount: combinedFailedCount,
      );
    }

    if (pendingCount > 0) {
      return HomeDashboardStatus(
        state: HomeDashboardState.pendingSync,
        label: 'Pending Sync',
        message:
            'Connection is back. $pendingCount saved item(s) will sync automatically.',
        networkLabel: networkLabel,
        serverLabel: serverLabel,
        syncLabel: '$pendingCount queued',
        pendingCount: pendingCount,
        failedCount: combinedFailedCount,
      );
    }

    if (backendReachable == true || lastSyncStatus == 'completed') {
      return HomeDashboardStatus(
        state: HomeDashboardState.synced,
        label: 'Synced',
        message:
            'This device is up to date with the latest saved field records.',
        networkLabel: networkLabel,
        serverLabel: serverLabel,
        syncLabel: 'All caught up',
        pendingCount: pendingCount,
        failedCount: combinedFailedCount,
      );
    }

    return HomeDashboardStatus(
      state: HomeDashboardState.online,
      label: 'Online',
      message:
          'Network is available. The next sync check will verify the server.',
      networkLabel: networkLabel,
      serverLabel: serverLabel,
      syncLabel: 'Ready',
      pendingCount: pendingCount,
      failedCount: combinedFailedCount,
    );
  }
}
