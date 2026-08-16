import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/local/database/app_database.dart' as db;
import '../../../domain/repositories/notification_repository.dart';
import '../../widgets/app_ui.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});
  @override State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _filter = 'all'; bool _refreshing = false;
  @override void initState() { super.initState(); WidgetsBinding.instance.addPostFrameCallback((_) => _refresh()); }
  Future<void> _refresh() async { if (_refreshing) return; setState(() => _refreshing = true); try { await context.read<NotificationRepository>().refresh(); } catch (_) { if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Showing saved notifications. Refresh will retry when online.'))); } finally { if (mounted) setState(() => _refreshing = false); } }
  @override Widget build(BuildContext context) { final repository = context.read<NotificationRepository>(); return Scaffold(appBar: AppHeader(title: 'DA Magdalena', subtitle: 'Notifications', actions: [IconButton(onPressed: _refreshing ? null : _refresh, icon: _refreshing ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.refresh))]), body: StreamBuilder<List<db.Notification>>(
    stream: repository.watchAll(), builder: (context, snapshot) { final List<db.Notification> records = (snapshot.data ?? <db.Notification>[]).where((item) => _filter == 'all' || (_filter == 'unread' && !item.isRead) || item.category == _filter).toList(); return ListView(padding: const EdgeInsets.all(16), children: [const SectionHeader(title: 'Health reminders & updates', subtitle: 'Saved on this device and kept in sync when online.'), const SizedBox(height: 12), SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: ['all', 'unread', 'health', 'task', 'advisory'].map((filter) => Padding(padding: const EdgeInsets.only(right: 8), child: ChoiceChip(label: Text(filter == 'all' ? 'All' : filter == 'unread' ? 'Unread' : filter[0].toUpperCase() + filter.substring(1)), selected: _filter == filter, onSelected: (_) => setState(() => _filter = filter)))).toList())), const SizedBox(height: 16), if (records.isEmpty) const SectionCard(child: Padding(padding: EdgeInsets.all(24), child: Center(child: Text('No saved notifications. Pull down or tap refresh when connected.')))) else ...records.map((item) => Padding(padding: const EdgeInsets.only(bottom: 10), child: SectionCard(child: ListTile(contentPadding: EdgeInsets.zero, leading: CircleAvatar(backgroundColor: item.isRead ? Colors.grey.shade200 : Theme.of(context).colorScheme.primaryContainer, child: Icon(_icon(item.category))), title: Text(item.title, style: TextStyle(fontWeight: item.isRead ? FontWeight.w500 : FontWeight.w800)), subtitle: Padding(padding: const EdgeInsets.only(top: 4), child: Text('${item.message}\n${_date(item.createdAt)} • ${item.priority}')), isThreeLine: true, trailing: item.isRead ? null : TextButton(onPressed: () => repository.markRead(item.id), child: const Text('READ'))))))]); },)); }
  IconData _icon(String category) => switch (category) { 'health' || 'vaccination' => Icons.vaccines_outlined, 'task' => Icons.assignment_outlined, 'advisory' => Icons.campaign_outlined, 'return_piglet' => Icons.assignment_return_outlined, _ => Icons.notifications_outlined };
  String _date(DateTime value) => '${value.day}/${value.month}/${value.year}';
}
