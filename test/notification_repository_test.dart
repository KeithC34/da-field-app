import 'package:da_field_app/core/sync/offline_sync_status.dart';
import 'package:da_field_app/data/local/database/app_database.dart';
import 'package:da_field_app/domain/repositories/notification_repository.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late Dio dio;
  late NotificationRepository repository;
  Object responsePayload = const <Object>[];

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    dio = Dio()
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            if (options.path == '/notifications') {
              handler.resolve(
                Response<Object>(
                  requestOptions: options,
                  data: responsePayload,
                  statusCode: 200,
                ),
              );
              return;
            }
            handler.reject(
              DioException(
                requestOptions: options,
                error: 'Unhandled path ${options.path}',
              ),
            );
          },
        ),
      );
    repository = NotificationRepository(database, dio);
  });

  tearDown(() => database.close());

  test('refresh returns only newly received unread alerts once', () async {
    responsePayload = [
      {
        'notification_id': 'notif-1',
        'title': 'Vaccination due',
        'message': 'Schedule a follow-up health check.',
        'category': 'health',
        'priority': 'important',
        'is_read': false,
        'created_at': '2026-08-17T02:30:00Z',
      },
    ];

    final firstRefresh = await repository.refresh();
    final secondRefresh = await repository.refresh();
    final stored = await database.select(database.notifications).get();

    expect(firstRefresh.newUnreadCount, 1);
    expect(firstRefresh.newAlerts.single.id, 'notif-1');
    expect(secondRefresh.newUnreadCount, 0);
    expect(stored, hasLength(1));
    expect(stored.single.isRead, isFalse);
  });

  test(
    'markRead updates local state and queues one offline sync item',
    () async {
      await database
          .into(database.notifications)
          .insert(
            NotificationsCompanion.insert(
              id: 'notif-read',
              category: const Value('task'),
              priority: const Value('normal'),
              title: 'Inspection assigned',
              message: 'Open the task list for details.',
              createdAt: DateTime.utc(2026, 8, 17, 3),
              syncStatus: const Value(OfflineSyncStatus.synced),
            ),
          );

      await repository.markRead('notif-read');
      await repository.markRead('notif-read');

      final stored = await (database.select(
        database.notifications,
      )..where((t) => t.id.equals('notif-read'))).getSingle();
      final queueItems = await database.select(database.syncQueue).get();

      expect(stored.isRead, isTrue);
      expect(stored.syncStatus, OfflineSyncStatus.pending);
      expect(queueItems, hasLength(1));
      expect(queueItems.single.recordType, 'notification_read');
      expect(queueItems.single.recordId, 'notification:notif-read');
    },
  );
}
