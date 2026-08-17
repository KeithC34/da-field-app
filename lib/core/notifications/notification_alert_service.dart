import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/notification_repository.dart';

abstract class NotificationAlertService {
  bool get isSoundEnabled;
  Future<void> initialize();
  Future<void> setSoundEnabled(bool value);
  Future<bool> ensurePermission();
  Future<void> notifyFreshNotifications(Iterable<NotificationAlert> alerts);
}

class LocalNotificationAlertService implements NotificationAlertService {
  LocalNotificationAlertService(
    this._preferences, {
    FlutterLocalNotificationsPlugin? plugin,
  }) : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  static const String _soundPreferenceKey = 'notification_sound_enabled';
  static const String _defaultChannelId = 'agriguard_alerts';
  static const String _urgentChannelId = 'agriguard_alerts_urgent';
  static const String _channelDescription =
      'Field task, disease, health monitoring, and system notifications';
  static const String _urgentChannelDescription =
      'Urgent field and disease notifications';

  final SharedPreferences _preferences;
  final FlutterLocalNotificationsPlugin _plugin;
  bool _initialized = false;

  @override
  bool get isSoundEnabled => _preferences.getBool(_soundPreferenceKey) ?? true;

  @override
  Future<void> initialize() async {
    if (_initialized) return;
    await _plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );
    if (Platform.isAndroid) {
      final android = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      if (android != null) {
        await android.createNotificationChannel(
          const AndroidNotificationChannel(
            _defaultChannelId,
            'AgriGuard Alerts',
            description: _channelDescription,
            importance: Importance.defaultImportance,
          ),
        );
        await android.createNotificationChannel(
          const AndroidNotificationChannel(
            _urgentChannelId,
            'AgriGuard Urgent Alerts',
            description: _urgentChannelDescription,
            importance: Importance.high,
          ),
        );
      }
    }
    _initialized = true;
  }

  @override
  Future<void> setSoundEnabled(bool value) =>
      _preferences.setBool(_soundPreferenceKey, value);

  @override
  Future<bool> ensurePermission() async {
    if (!Platform.isAndroid) return true;
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (android == null) return false;
    final enabled = await android.areNotificationsEnabled();
    if (enabled == true) return true;
    return await android.requestNotificationsPermission() ?? false;
  }

  @override
  Future<void> notifyFreshNotifications(
    Iterable<NotificationAlert> alerts,
  ) async {
    final items = alerts.toList(growable: false);
    if (items.isEmpty || !isSoundEnabled) return;
    await initialize();
    final permissionGranted = await ensurePermission();
    if (!permissionGranted) {
      await SystemSound.play(SystemSoundType.alert);
      return;
    }

    final lead = _pickLead(items);
    final isUrgent = lead.priority == 'urgent';
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        isUrgent ? _urgentChannelId : _defaultChannelId,
        isUrgent ? 'AgriGuard Urgent Alerts' : 'AgriGuard Alerts',
        channelDescription: isUrgent
            ? _urgentChannelDescription
            : _channelDescription,
        importance: isUrgent
            ? Importance.high
            : lead.priority == 'important'
            ? Importance.defaultImportance
            : Importance.low,
        priority: isUrgent
            ? Priority.high
            : lead.priority == 'important'
            ? Priority.defaultPriority
            : Priority.low,
        category: AndroidNotificationCategory.status,
        ticker: 'AgriGuard alert',
        playSound: true,
        enableVibration: lead.priority != 'normal',
      ),
      iOS: const DarwinNotificationDetails(),
    );

    final title = items.length == 1
        ? lead.title
        : '${items.length} new AgriGuard alerts';
    final body = items.length == 1 ? lead.message : lead.title;
    await _plugin.show(
      _stableId(lead.id),
      title,
      body,
      details,
      payload: lead.id,
    );
  }

  NotificationAlert _pickLead(List<NotificationAlert> alerts) {
    final sorted = [...alerts]
      ..sort((left, right) {
        final byPriority =
            _priorityRank(right.priority) - _priorityRank(left.priority);
        if (byPriority != 0) return byPriority;
        return right.createdAt.compareTo(left.createdAt);
      });
    return sorted.first;
  }

  int _priorityRank(String priority) => switch (priority) {
    'urgent' => 2,
    'important' => 1,
    _ => 0,
  };

  int _stableId(String value) => value.hashCode & 0x7fffffff;
}
