import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart' show OrderingTerm;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/sync/offline_sync_status.dart';
import '../../../data/local/database/app_database.dart';
import '../../../data/sync/sync_processor.dart';
import '../../widgets/app_ui.dart';

class SyncStatusScreen extends StatefulWidget {
  const SyncStatusScreen({super.key});

  @override
  State<SyncStatusScreen> createState() => _SyncStatusScreenState();
}

class _SyncStatusScreenState extends State<SyncStatusScreen> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _isOnline = false;
  bool _isSyncing = false;

  @override
  void initState() {
    super.initState();
    _refreshConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      results,
    ) {
      if (mounted) {
        setState(() => _isOnline = _hasConnection(results));
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  Future<void> _refreshConnectivity() async {
    final results = await _connectivity.checkConnectivity();
    if (mounted) {
      setState(() => _isOnline = _hasConnection(results));
    }
  }

  bool _hasConnection(List<ConnectivityResult> results) =>
      results.any((result) => result != ConnectivityResult.none);

  Future<void> _syncNow() async {
    if (_isSyncing) return;
    final syncProcessor = context.read<SyncProcessor>();
    setState(() => _isSyncing = true);
    await _refreshConnectivity();
    try {
      final result = await syncProcessor.processQueue(force: true);
      if (mounted) {
        _showMessage(
          result.status == 'offline'
              ? 'Offline: records remain safely queued on this device.'
              : 'Sync complete: ${result.uploaded} uploaded, '
                    '${result.downloaded} downloaded, ${result.failed} failed.',
        );
      }
    } finally {
      if (mounted) setState(() => _isSyncing = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  @override
  Widget build(BuildContext context) {
    final database = context.read<AppDatabase>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: const AppHeader(title: 'DA Magdalena', subtitle: 'Synchronization'),
      body: StreamBuilder<List<SyncQueueData>>(
        stream: database.select(database.syncQueue).watch(),
        builder: (context, snapshot) {
          final items = snapshot.data ?? const <SyncQueueData>[];
          final counts = <String, int>{
            for (final status in OfflineSyncStatus.values) status: 0,
          };
          for (final item in items) {
            counts.update(
              item.syncStatus,
              (count) => count + 1,
              ifAbsent: () => 1,
            );
          }

          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Card(
                  elevation: 0,
                  color: _isOnline
                      ? colorScheme.primaryContainer
                      : colorScheme.errorContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      children: [
                        Icon(
                          _isOnline
                              ? Icons.cloud_done_outlined
                              : Icons.cloud_off_outlined,
                          color: _isOnline
                              ? colorScheme.onPrimaryContainer
                              : colorScheme.onErrorContainer,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _isOnline ? 'Online' : 'Offline',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text('${items.length} retained'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _StatusChip(
                      label: 'Pending Sync',
                      count: counts[OfflineSyncStatus.pending] ?? 0,
                      color: colorScheme.tertiary,
                    ),
                    _StatusChip(
                      label: 'Syncing',
                      count: counts[OfflineSyncStatus.syncing] ?? 0,
                      color: colorScheme.primary,
                    ),
                    _StatusChip(
                      label: 'Synced',
                      count: counts[OfflineSyncStatus.synced] ?? 0,
                      color: Colors.green,
                    ),
                    _StatusChip(
                      label: 'Failed Sync',
                      count: counts[OfflineSyncStatus.failed] ?? 0,
                      color: colorScheme.error,
                    ),
                    _StatusChip(
                      label: 'Conflict',
                      count: counts[OfflineSyncStatus.conflict] ?? 0,
                      color: Colors.deepOrange,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 52,
                  child: FilledButton.icon(
                    onPressed: _isSyncing ? null : _syncNow,
                    icon: _isSyncing
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2.3),
                          )
                        : const Icon(Icons.sync_outlined),
                    label: Text(_isSyncing ? 'Syncing...' : 'Sync Now'),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Queue history',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                if (items.isEmpty)
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(18),
                      child: Text('No field records have been queued yet.'),
                    ),
                  )
                else
                  ...items.reversed.map(
                    (item) => Card(
                      child: ListTile(
                        leading: _SyncStatusIcon(status: item.syncStatus),
                        title: Text(item.recordType ?? item.endpoint),
                        subtitle: Text(
                          item.lastError?.isNotEmpty == true
                              ? item.lastError!
                              : '${item.method} ${item.endpoint}',
                        ),
                        trailing: Text(item.syncStatus),
                      ),
                    ),
                  ),
                const SizedBox(height: 24),
                Text(
                  'Sync logs',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                StreamBuilder<List<SyncLog>>(
                  stream:
                      (database.select(database.syncLogs)
                            ..orderBy([
                              (table) => OrderingTerm.desc(table.startedAt),
                            ])
                            ..limit(20))
                          .watch(),
                  builder: (context, logSnapshot) {
                    final logs = logSnapshot.data ?? const <SyncLog>[];
                    if (logs.isEmpty) {
                      return const Card(
                        child: Padding(
                          padding: EdgeInsets.all(18),
                          child: Text('No synchronization attempts yet.'),
                        ),
                      );
                    }
                    return Column(
                      children: logs
                          .map(
                            (log) => Card(
                              child: ListTile(
                                leading: Icon(
                                  log.status == 'completed'
                                      ? Icons.check_circle_outline
                                      : log.status == 'offline'
                                      ? Icons.cloud_off_outlined
                                      : Icons.info_outline,
                                ),
                                title: Text('${log.trigger} · ${log.status}'),
                                subtitle: Text(
                                  '${log.uploadedCount} uploaded · '
                                  '${log.downloadedCount} downloaded · '
                                  '${log.failedCount} failed · '
                                  '${log.conflictCount} conflicts'
                                  '${log.message == null ? '' : '\n${log.message}'}',
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.count,
    required this.color,
  });

  final String label;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: CircleAvatar(
        backgroundColor: color,
        child: Text('$count', style: const TextStyle(color: Colors.white)),
      ),
      label: Text(label),
    );
  }
}

class _SyncStatusIcon extends StatelessWidget {
  const _SyncStatusIcon({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final icon = switch (status) {
      OfflineSyncStatus.pending => Icons.schedule_outlined,
      OfflineSyncStatus.syncing => Icons.sync,
      OfflineSyncStatus.synced => Icons.cloud_done_outlined,
      OfflineSyncStatus.failed => Icons.error_outline,
      OfflineSyncStatus.conflict => Icons.warning_amber_outlined,
      _ => Icons.help_outline,
    };
    return Icon(icon);
  }
}
