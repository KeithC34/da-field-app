import 'package:da_field_app/data/local/database/app_database.dart' as db;
import 'package:da_field_app/presentation/screens/notifications/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows a visible unread marker only for unread notifications', (
    tester,
  ) async {
    final unread = db.Notification(
      id: 'unread-notif',
      category: 'health',
      priority: 'important',
      title: 'Unread alert',
      message: 'This should stand out.',
      relatedRecordId: null,
      relatedRecordType: null,
      isRead: false,
      readAt: null,
      createdAt: DateTime.utc(2026, 8, 17, 4),
      scheduledAt: null,
      syncStatus: 'synced',
      lastError: null,
    );
    final read = db.Notification(
      id: 'read-notif',
      category: 'task',
      priority: 'normal',
      title: 'Read alert',
      message: 'This should look quieter.',
      relatedRecordId: null,
      relatedRecordType: null,
      isRead: true,
      readAt: DateTime.utc(2026, 8, 17, 5),
      createdAt: DateTime.utc(2026, 8, 17, 5),
      scheduledAt: null,
      syncStatus: 'synced',
      lastError: null,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            children: [
              NotificationListCard(
                item: unread,
                onOpen: () {},
                onMarkRead: () {},
              ),
              NotificationListCard(item: read, onOpen: () {}, onMarkRead: null),
            ],
          ),
        ),
      ),
    );
    await tester.pump();

    expect(
      find.byKey(const Key('notification-unread-dot-unread-notif')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('notification-unread-dot-read-notif')),
      findsNothing,
    );
  });
}
