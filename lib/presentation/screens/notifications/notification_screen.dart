import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/local/database/app_database.dart' as db;
import '../../../domain/repositories/notification_repository.dart';
import '../../widgets/app_ui.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _filter = 'all';
  bool _refreshing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _refresh());
  }

  Future<void> _refresh() async {
    if (_refreshing) return;
    setState(() => _refreshing = true);
    try {
      await context.read<NotificationRepository>().refresh();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Showing saved notifications. Refresh will retry when the server is reachable.',
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _refreshing = false);
    }
  }

  Future<void> _openNotification(db.Notification item) async {
    if (!item.isRead) {
      await context.read<NotificationRepository>().markRead(item.id);
    }
    if (!mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(width: 8),
                _PriorityChip(priority: item.priority),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${_categoryLabel(item.category)} • ${_date(item.createdAt)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              item.message,
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final repository = context.read<NotificationRepository>();
    return Scaffold(
      appBar: AppHeader(
        title: 'DA Magdalena',
        subtitle: 'Notifications',
        actions: [
          IconButton(
            onPressed: _refreshing ? null : _refresh,
            tooltip: 'Refresh notifications',
            icon: _refreshing
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh),
          ),
        ],
      ),
      body: StreamBuilder<List<db.Notification>>(
        stream: repository.watchAll(),
        builder: (context, snapshot) {
          final allRecords = snapshot.data ?? const <db.Notification>[];
          final records = allRecords.where((item) {
            if (_filter == 'all') return true;
            if (_filter == 'unread') return !item.isRead;
            return item.category == _filter;
          }).toList();
          final unreadCount = allRecords.where((item) => !item.isRead).length;

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionHeader(
                        title: 'Health reminders and updates',
                        subtitle: 'Saved on this device and kept in sync when the server is reachable.',
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _SummaryStat(
                            icon: Icons.mark_email_unread_outlined,
                            label: 'Unread',
                            value: '$unreadCount',
                          ),
                          _SummaryStat(
                            icon: Icons.notifications_active_outlined,
                            label: 'Saved',
                            value: '${allRecords.length}',
                          ),
                          _SummaryStat(
                            icon: Icons.sync_outlined,
                            label: 'Read sync',
                            value: 'Queued offline when needed',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ['all', 'unread', 'health', 'task', 'advisory']
                        .map(
                          (filter) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text(_filterLabel(filter)),
                              selected: _filter == filter,
                              onSelected: (_) =>
                                  setState(() => _filter = filter),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 16),
                if (records.isEmpty)
                  const SectionCard(
                    child: EmptyState(
                      icon: Icons.notifications_none_outlined,
                      title: 'No notifications yet',
                      message: 'Pull to refresh when connected, or check back after your next synchronization.',
                    ),
                  )
                else
                  ...records.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: NotificationListCard(
                        item: item,
                        onOpen: () => _openNotification(item),
                        onMarkRead: item.isRead
                            ? null
                            : () => repository.markRead(item.id),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _filterLabel(String filter) => switch (filter) {
    'all' => 'All',
    'unread' => 'Unread',
    _ => filter[0].toUpperCase() + filter.substring(1),
  };

  String _categoryLabel(String category) => switch (category) {
    'health' => 'Health',
    'task' => 'Task',
    'advisory' => 'Advisory',
    'return_piglet' => 'Return verification',
    _ => 'System',
  };

  String _date(DateTime value) {
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    return '$month/$day/${value.year}';
  }
}

class NotificationListCard extends StatelessWidget {
  const NotificationListCard({super.key,
    required this.item,
    required this.onOpen,
    required this.onMarkRead,
  });

  final db.Notification item;
  final VoidCallback onOpen;
  final VoidCallback? onMarkRead;

  @override
  Widget build(BuildContext context) {
    final highlightColor = item.isRead
        ? Theme.of(context).colorScheme.surface
        : Theme.of(context).colorScheme.primaryContainer.withValues(alpha: .14);
    return Card(
      color: highlightColor,
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: item.isRead
                    ? Colors.grey.shade200
                    : Theme.of(context).colorScheme.primaryContainer,
                child: Icon(
                  _icon(item.category),
                  color: item.isRead
                      ? Theme.of(context).colorScheme.onSurfaceVariant
                      : Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: TextStyle(
                              fontWeight: item.isRead
                                  ? FontWeight.w600
                                  : FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        if (!item.isRead)
                          Container(
                            key: Key('notification-unread-dot-${item.id}'),
                            width: 10,
                            height: 10,
                            margin: const EdgeInsets.only(top: 4, left: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFB3261E),
                              borderRadius: BorderRadius.circular(99),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _PriorityChip(priority: item.priority),
                        StatusBadge(
                          label: item.isRead ? 'Read' : 'Unread',
                          color: item.isRead
                              ? Theme.of(context).colorScheme.onSurfaceVariant
                              : const Color(0xFFB3261E),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.message,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(height: 1.45),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${_categoryLabel(item.category)} • ${_date(item.createdAt)}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                          ),
                        ),
                        if (onMarkRead != null)
                          TextButton(
                            onPressed: onMarkRead,
                            child: const Text('Mark read'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static IconData _icon(String category) => switch (category) {
    'health' || 'vaccination' => Icons.vaccines_outlined,
    'task' => Icons.assignment_outlined,
    'advisory' => Icons.campaign_outlined,
    'return_piglet' => Icons.assignment_return_outlined,
    _ => Icons.notifications_outlined,
  };

  static String _categoryLabel(String category) => switch (category) {
    'health' => 'Health',
    'task' => 'Task',
    'advisory' => 'Advisory',
    'return_piglet' => 'Return verification',
    _ => 'System',
  };

  static String _date(DateTime value) {
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    return '$month/$day/${value.year}';
  }
}

class _PriorityChip extends StatelessWidget {
  const _PriorityChip({required this.priority});

  final String priority;

  @override
  Widget build(BuildContext context) {
    final color = switch (priority) {
      'urgent' => const Color(0xFF9B263B),
      'important' => const Color(0xFF8A6100),
      _ => Theme.of(context).colorScheme.primary,
    };
    final icon = switch (priority) {
      'urgent' => Icons.priority_high_outlined,
      'important' => Icons.notifications_active_outlined,
      _ => Icons.notifications_none_outlined,
    };
    final label = switch (priority) {
      'urgent' => 'Urgent',
      'important' => 'Important',
      _ => 'Normal',
    };
    return StatusBadge(label: label, color: color, icon: icon);
  }
}

class _SummaryStat extends StatelessWidget {
  const _SummaryStat({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Container(
    constraints: const BoxConstraints(minWidth: 120),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(context).textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
