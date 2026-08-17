import 'package:da_field_app/presentation/widgets/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows unread count badge when unread notifications exist', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            actions: [NotificationBellButton(unreadCount: 3, onPressed: () {})],
          ),
        ),
      ),
    );

    expect(find.byKey(const Key('home-notification-badge')), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('hides unread badge when there are no unread notifications', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            actions: [NotificationBellButton(unreadCount: 0, onPressed: () {})],
          ),
        ),
      ),
    );

    expect(find.byKey(const Key('home-notification-badge')), findsNothing);
  });
}
