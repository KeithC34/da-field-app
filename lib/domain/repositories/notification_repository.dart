import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';

import '../../core/sync/offline_sync_status.dart';
import '../../data/local/database/app_database.dart';

class NotificationAlert {
  const NotificationAlert({
    required this.id,
    required this.title,
    required this.message,
    required this.priority,
    required this.category,
    required this.createdAt,
  });

  final String id;
  final String title;
  final String message;
  final String priority;
  final String category;
  final DateTime createdAt;
}

class NotificationRefreshResult {
  const NotificationRefreshResult({
    this.newUnreadCount = 0,
    this.newAlerts = const <NotificationAlert>[],
  });

  final int newUnreadCount;
  final List<NotificationAlert> newAlerts;
}

class NotificationRepository {
  NotificationRepository(this._database, this._dio);
  final AppDatabase _database;
  final Dio _dio;

  Stream<List<Notification>> watchAll() => (_database.select(
    _database.notifications,
  )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).watch();
  Stream<int> watchUnreadCount() => (_database.select(
    _database.notifications,
  )..where((t) => t.isRead.equals(false))).watch().map((items) => items.length);

  Future<NotificationRefreshResult> refresh() async {
    final response = await _dio.get<Object>(
      '/notifications',
      queryParameters: {'limit': 100},
    );
    final records = response.data;
    if (records is! List) return const NotificationRefreshResult();
    final newAlerts = <NotificationAlert>[];
    await _database.transaction(() async {
      for (final item in records.whereType<Map>()) {
        final value = Map<String, dynamic>.from(item);
        final id = value['notification_id']?.toString();
        if (id == null || id.isEmpty) continue;
        final serverRead = value['is_read'] == true;
        final local = await (_database.select(
          _database.notifications,
        )..where((t) => t.id.equals(id))).getSingleOrNull();
        final createdAt = _date(value['created_at']) ?? DateTime.now().toUtc();
        if (local == null && !serverRead) {
          newAlerts.add(
            NotificationAlert(
              id: id,
              title: value['title']?.toString() ?? '',
              message: value['message']?.toString() ?? '',
              priority: value['priority']?.toString() ?? 'normal',
              category: value['category']?.toString() ?? 'system',
              createdAt: createdAt,
            ),
          );
        }
        await _database
            .into(_database.notifications)
            .insertOnConflictUpdate(
              NotificationsCompanion.insert(
                id: id,
                category: Value(value['category']?.toString() ?? 'system'),
                priority: Value(value['priority']?.toString() ?? 'normal'),
                title: value['title']?.toString() ?? '',
                message: value['message']?.toString() ?? '',
                relatedRecordId: Value(value['related_record_id']?.toString()),
                relatedRecordType: Value(
                  value['related_record_type']?.toString(),
                ),
                isRead: Value(serverRead || (local?.isRead ?? false)),
                readAt: Value(_date(value['read_at']) ?? local?.readAt),
                createdAt: createdAt,
                scheduledAt: Value(_date(value['scheduled_at'])),
                syncStatus: const Value(OfflineSyncStatus.synced),
              ),
            );
      }
    });
    return NotificationRefreshResult(
      newUnreadCount: newAlerts.length,
      newAlerts: List<NotificationAlert>.unmodifiable(newAlerts),
    );
  }

  Future<void> markRead(String id) async {
    final now = DateTime.now().toUtc();
    await _database.transaction(() async {
      final current = await (_database.select(
        _database.notifications,
      )..where((t) => t.id.equals(id))).getSingleOrNull();
      if (current == null || current.isRead) return;
      await (_database.update(
        _database.notifications,
      )..where((t) => t.id.equals(id))).write(
        NotificationsCompanion(
          isRead: const Value(true),
          readAt: Value(now),
          syncStatus: const Value(OfflineSyncStatus.pending),
        ),
      );
      final existingQueueItem =
          await (_database.select(_database.syncQueue)..where(
                (t) =>
                    t.recordId.equals('notification:$id') &
                    t.recordType.equals('notification_read') &
                    t.syncStatus.isNotValue(OfflineSyncStatus.synced),
              ))
              .getSingleOrNull();
      if (existingQueueItem != null) return;
      await _database
          .into(_database.syncQueue)
          .insert(
            SyncQueueCompanion.insert(
              endpoint: '/notifications/$id/read',
              method: 'PATCH',
              payload: jsonEncode({}),
              recordId: Value('notification:$id'),
              recordType: const Value('notification_read'),
              createdBy: const Value('notification-client'),
              fieldWorkerId: const Value('notification-client'),
              status: const Value(OfflineSyncStatus.pending),
              syncStatus: const Value(OfflineSyncStatus.pending),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
    });
  }

  DateTime? _date(Object? value) =>
      value == null ? null : DateTime.tryParse(value.toString())?.toUtc();
}
