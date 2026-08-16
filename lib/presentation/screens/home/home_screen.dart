import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../widgets/app_ui.dart';
import '../auth/login_screen.dart';
import '../disease_reports/disease_report_screen.dart';
import '../dispersals/dispersal_screen.dart';
import '../farmers/farmer_registration_screen.dart';
import '../inspections/inspection_screen.dart';
import '../gis/gis_field_map_screen.dart';
import '../media/photo_verification_screen.dart';
import '../notifications/notification_screen.dart';
import '../pig_health/pig_health_screen.dart';
import '../pigs/pig_registration_screen.dart';
import '../piglets/piglet_registration_screen.dart';
import '../returns/return_piglet_verification_screen.dart';
import '../sync/sync_status_screen.dart';
import '../waste/waste_management_inspection_screen.dart';
import '../wastewater/wastewater_inspection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoggingOut = false;
  int _tab = 0;

  Future<void> _logout() async {
    if (_isLoggingOut) return;
    setState(() => _isLoggingOut = true);
    try {
      await context.read<AuthRepository>().logout();
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute<void>(builder: (_) => const LoginScreen()), (route) => false);
    } on AuthException catch (error) {
      _message(error.message);
    } finally {
      if (mounted) setState(() => _isLoggingOut = false);
    }
  }

  Future<void> _open(Widget screen) => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => screen));
  void _message(String text) => ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(text)));

  List<_DashboardAction> get _actions => [
    _DashboardAction('Register Farmer', 'Farmer and GPS details', Icons.person_add_alt_1_outlined, AppTheme.primary, () => _open(const FarmerRegistrationScreen())),
    _DashboardAction('Register Pig', 'Livestock and pen record', Icons.pets_outlined, AppTheme.primary, () => _open(const PigRegistrationScreen())),
    _DashboardAction('Health Check', 'Health, GPS, and evidence', Icons.vaccines_outlined, const Color(0xFF536B42), () => _open(const PigHealthScreen())),
    _DashboardAction('Report Disease', 'Suspected illness report', Icons.health_and_safety_outlined, const Color(0xFF9B263B), () => _open(const DiseaseReportScreen())),
    _DashboardAction('Pen Inspection', 'Pen and waste conditions', Icons.fact_check_outlined, const Color(0xFF536B42), () => _open(const InspectionScreen())),
    _DashboardAction('Dispersal', 'Pig follow-up record', Icons.volunteer_activism_outlined, const Color(0xFF536B42), () => _open(const DispersalScreen())),
    _DashboardAction('Photo Verification', 'Photos and documents', Icons.verified_user_outlined, const Color(0xFF536B42), () => _open(const PhotoVerificationScreen())),
    _DashboardAction('Synchronization', 'Review queue and retry', Icons.sync_outlined, const Color(0xFF536B42), () => _open(const SyncStatusScreen())),
    _DashboardAction('Register Piglet', 'Link sow, farmer, and pen', Icons.cruelty_free_outlined, AppTheme.primary, () => _open(const PigletRegistrationScreen())),
    _DashboardAction('Waste Inspection', 'Waste compliance and evidence', Icons.delete_outline, const Color(0xFF536B42), () => _open(const WasteManagementInspectionScreen())),
    _DashboardAction('Wastewater Inspection', 'Discharge and GPS evidence', Icons.water_drop_outlined, const Color(0xFF536B42), () => _open(const WastewaterInspectionScreen())),
    _DashboardAction('Return Verification', 'Verify distributed piglet returns', Icons.assignment_return_outlined, const Color(0xFF536B42), () => _open(const ReturnPigletVerificationScreen())),
  ];

  @override
  Widget build(BuildContext context) {
    const titles = ['Home', 'Assigned Tasks', 'Offline Records', 'GIS Field Map', 'Profile'];
    return Scaffold(
      appBar: AppHeader(title: 'DA Magdalena', subtitle: titles[_tab], actions: [IconButton(onPressed: () => _open(const NotificationScreen()), tooltip: 'Notifications', icon: const Icon(Icons.notifications_outlined)), if (_tab == 4) IconButton(onPressed: _isLoggingOut ? null : _logout, tooltip: 'Log out', icon: _isLoggingOut ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.logout_outlined))]),
      body: IndexedStack(index: _tab, children: [_dashboard(), _taskList(), _records(), _mapState(), _profile()]),
      bottomNavigationBar: NavigationBar(selectedIndex: _tab, onDestinationSelected: (value) => setState(() => _tab = value), destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.checklist_outlined), selectedIcon: Icon(Icons.checklist), label: 'Tasks'),
        NavigationDestination(icon: Icon(Icons.folder_open_outlined), selectedIcon: Icon(Icons.folder_open), label: 'Records'),
        NavigationDestination(icon: Icon(Icons.map_outlined), selectedIcon: Icon(Icons.map), label: 'Map'),
        NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
      ]),
    );
  }

  Widget _dashboard() => StreamBuilder<List<ConnectivityResult>>(
    stream: Connectivity().onConnectivityChanged,
    builder: (context, snapshot) {
      final online = (snapshot.data ?? const <ConnectivityResult>[]).any((item) => item != ConnectivityResult.none);
      return ListView(padding: const EdgeInsets.fromLTRB(16, 16, 16, 28), children: [
        Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Good day, Field Worker', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)), const SizedBox(height: 4), Text('Magdalena, Laguna', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant))])), StatusBadge(label: online ? 'Online' : 'Offline', icon: online ? Icons.cloud_done_outlined : Icons.cloud_off_outlined, color: online ? AppTheme.primary : const Color(0xFF7A5A00))]),
        const SizedBox(height: 24),
        SectionCard(child: Row(children: [Container(width: 48, height: 48, decoration: BoxDecoration(color: AppTheme.primaryContainer, borderRadius: BorderRadius.circular(24)), child: const Icon(Icons.assignment_outlined, color: Color(0xFF9DD090))), const SizedBox(width: 14), const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Field operations ready', style: TextStyle(fontWeight: FontWeight.w700)), SizedBox(height: 3), Text('Records remain safe on this device until synchronization.', maxLines: 2)])), IconButton(onPressed: () => _open(const SyncStatusScreen()), icon: const Icon(Icons.arrow_forward))])),
        const SizedBox(height: 28), const SectionHeader(title: 'Quick Actions'), const SizedBox(height: 12),
        GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: 4, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.18), itemBuilder: (context, index) => _ActionCard(action: _actions[index])),
        const SizedBox(height: 28), SectionHeader(title: 'Field Operations', trailing: TextButton(onPressed: () => setState(() => _tab = 1), child: const Text('VIEW ALL'))), const SizedBox(height: 12),
        SectionCard(child: Column(children: _actions.skip(4).map((action) => ListTile(contentPadding: EdgeInsets.zero, leading: CircleAvatar(backgroundColor: action.color.withValues(alpha: .12), child: Icon(action.icon, color: action.color)), title: Text(action.title, style: const TextStyle(fontWeight: FontWeight.w700)), subtitle: Text(action.description), trailing: const Icon(Icons.chevron_right), onTap: action.onTap)).toList())),
      ]);
    },
  );

  Widget _taskList() => ListView(padding: const EdgeInsets.fromLTRB(16, 16, 16, 28), children: [const SectionHeader(title: 'Assigned Tasks', subtitle: 'Choose an operation to record in the field.'), const SizedBox(height: 16), ..._actions.map((action) => Padding(padding: const EdgeInsets.only(bottom: 12), child: SectionCard(child: ListTile(contentPadding: EdgeInsets.zero, leading: CircleAvatar(backgroundColor: action.color.withValues(alpha: .12), child: Icon(action.icon, color: action.color)), title: Text(action.title, style: const TextStyle(fontWeight: FontWeight.w700)), subtitle: Text(action.description), trailing: const Icon(Icons.arrow_forward_ios, size: 16), onTap: action.onTap))))]);

  Widget _records() => ListView(padding: const EdgeInsets.fromLTRB(16, 16, 16, 28), children: [const SectionHeader(title: 'Offline Records', subtitle: 'Review saved records, media, and synchronization status.'), const SizedBox(height: 16), SectionCard(child: ListTile(contentPadding: EdgeInsets.zero, leading: const CircleAvatar(child: Icon(Icons.sync_outlined)), title: const Text('Synchronization queue', style: TextStyle(fontWeight: FontWeight.w700)), subtitle: const Text('Pending, syncing, synced, failed, and conflict records'), trailing: const Icon(Icons.chevron_right), onTap: () => _open(const SyncStatusScreen()))), const SizedBox(height: 12), SectionCard(child: ListTile(contentPadding: EdgeInsets.zero, leading: const CircleAvatar(child: Icon(Icons.photo_camera_back_outlined)), title: const Text('Photo & document evidence', style: TextStyle(fontWeight: FontWeight.w700)), subtitle: const Text('Capture, attach, and view pending upload status'), trailing: const Icon(Icons.chevron_right), onTap: () => _open(const PhotoVerificationScreen())))]) ;

  Widget _mapState() => ListView(padding: const EdgeInsets.fromLTRB(16, 16, 16, 28), children: [const SectionHeader(title: 'GIS Field Map', subtitle: 'View synchronized locations, capture current GPS, and verify pig pen coordinates.'), const SizedBox(height: 16), SectionCard(child: ListTile(contentPadding: EdgeInsets.zero, leading: const CircleAvatar(child: Icon(Icons.map_outlined)), title: const Text('Open field map', style: TextStyle(fontWeight: FontWeight.w700)), subtitle: const Text('OpenStreetMap markers remain available from locally synchronized records when offline.'), trailing: const Icon(Icons.arrow_forward_ios, size: 16), onTap: () => _open(const GisFieldMapScreen())))]);

  Widget _profile() => ListView(padding: const EdgeInsets.fromLTRB(16, 24, 16, 28), children: [Center(child: CircleAvatar(radius: 38, backgroundColor: AppTheme.primary, child: const Icon(Icons.person, size: 40, color: Colors.white))), const SizedBox(height: 12), Center(child: Text('DA Field Worker', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700))), const SizedBox(height: 4), Center(child: Text('Magdalena, Laguna', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant))), const SizedBox(height: 28), SectionCard(child: Column(children: [ListTile(contentPadding: EdgeInsets.zero, leading: const Icon(Icons.cloud_sync_outlined), title: const Text('Synchronization'), subtitle: const Text('Manage offline records'), onTap: () => _open(const SyncStatusScreen())), const Divider(), ListTile(contentPadding: EdgeInsets.zero, leading: const Icon(Icons.logout_outlined), title: const Text('Log out'), onTap: _isLoggingOut ? null : _logout)]))]);
}

class _DashboardAction {
  const _DashboardAction(this.title, this.description, this.icon, this.color, this.onTap);
  final String title; final String description; final IconData icon; final Color color; final VoidCallback onTap;
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.action});
  final _DashboardAction action;
  @override
  Widget build(BuildContext context) => Material(color: action.color, borderRadius: BorderRadius.circular(12), clipBehavior: Clip.antiAlias, child: InkWell(onTap: action.onTap, child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(action.icon, color: Colors.white, size: 28), const Spacer(), Text(action.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)), const SizedBox(height: 3), Text(action.description, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70, fontSize: 12))]))));
}
