abstract final class OfflineSyncStatus {
  static const pending = 'pending';
  static const syncing = 'syncing';
  static const synced = 'synced';
  static const failed = 'failed';
  static const conflict = 'conflict';

  static const values = <String>{pending, syncing, synced, failed, conflict};

  static bool contains(String value) => values.contains(value);
}
