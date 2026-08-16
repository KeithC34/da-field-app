import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart' show OrderingTerm;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../../core/sync/offline_record_type.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/network/dio_client.dart';
import '../../../data/local/database/app_database.dart';
import '../../../domain/repositories/field_operations_repository.dart';
import '../../widgets/app_ui.dart';

class GisFieldMapScreen extends StatefulWidget {
  const GisFieldMapScreen({super.key});
  @override
  State<GisFieldMapScreen> createState() => _GisFieldMapScreenState();
}

class _GisFieldMapScreenState extends State<GisFieldMapScreen> {
  final _controller = MapController();
  final _filters = <String>{'Pig Farmers', 'Pig Pens', 'Disease Reports', 'Assigned Tasks', 'Dispersal Recipients'};
  final List<_MapRecord> _remote = [];
  Position? _position;
  _MapRecord? _selected;
  bool _loading = true;
  bool _locating = false;

  @override
  void initState() { super.initState(); _load(); }

  Future<void> _load() async {
    setState(() => _loading = true);
    final requests = <String, String>{'Pig Farmers': 'pig-farmers', 'Pig Pens': 'pig-pens', 'Disease Reports': 'disease-reports', 'Dispersal Recipients': 'dispersal-recipients', 'Assigned Tasks': 'assigned-tasks'};
    final dio = context.read<DioClient>().dio;
    final results = await Future.wait(requests.entries.map((entry) async {
      try {
        final response = await dio.get<Object?>('/gis/layers/${entry.value}');
        return _fromFeatureCollection(entry.key, response.data);
      } on DioException { return const <_MapRecord>[]; }
    }));
    if (mounted) setState(() { _remote..clear()..addAll(results.expand((items) => items)); _loading = false; });
  }

  List<_MapRecord> _fromFeatureCollection(String type, Object? data) {
    if (data is! Map || data['features'] is! List) return const [];
    return (data['features'] as List).whereType<Map>().map((feature) {
      final geometry = feature['geometry']; final properties = feature['properties'];
      if (geometry is! Map || geometry['coordinates'] is! List || (geometry['coordinates'] as List).length < 2) return null;
      final coordinates = geometry['coordinates'] as List; final longitude = (coordinates[0] as num?)?.toDouble(); final latitude = (coordinates[1] as num?)?.toDouble();
      if (latitude == null || longitude == null) return null;
      final values = properties is Map ? properties : const <dynamic, dynamic>{};
      return _MapRecord(id: feature['id']?.toString() ?? values['sync_id']?.toString() ?? '', type: type, latitude: latitude, longitude: longitude, title: values['full_name']?.toString() ?? values['pen_id']?.toString() ?? values['pig_id']?.toString() ?? type, barangay: values['barangay']?.toString() ?? values['barangay_name']?.toString() ?? '—', status: values['sync_status']?.toString() ?? values['verification_status']?.toString() ?? 'Synced', penId: values['pen_id']?.toString());
    }).whereType<_MapRecord>().toList();
  }

  Future<void> _locate() async {
    if (_locating) return; setState(() => _locating = true);
    try {
      if (!await Geolocator.isLocationServiceEnabled()) { _notice('Turn on location services and try again.'); return; }
      var permission = await Geolocator.checkPermission(); if (permission == LocationPermission.denied) permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) { _notice('Location permission is permanently denied.', action: SnackBarAction(label: 'SETTINGS', onPressed: Geolocator.openAppSettings)); return; }
      if (permission == LocationPermission.denied) { _notice('Location permission was denied.'); return; }
      final value = await Geolocator.getCurrentPosition(locationSettings: const LocationSettings(accuracy: LocationAccuracy.high, timeLimit: Duration(seconds: 30)));
      if (mounted) { setState(() => _position = value); _controller.move(LatLng(value.latitude, value.longitude), 16); }
    } on TimeoutException { _notice('Location capture timed out.'); } catch (_) { _notice('Unable to get current location.'); } finally { if (mounted) setState(() => _locating = false); }
  }

  Future<void> _verifySelectedPen() async {
    final selected = _selected; final position = _position;
    if (selected?.penId == null) { _notice('Select a pig pen marker to verify its location.'); return; }
    if (position == null) { _notice('Capture your current location first.'); return; }
    try {
      await context.read<FieldOperationsRepository>().saveOperation(
        recordType: OfflineRecordType.fieldVerification,
        latitude: position.latitude, longitude: position.longitude,
        payload: {'verification_type': 'pig_pen_coordinate', 'pen_id': selected!.penId, 'registered_location': {'longitude': selected.longitude, 'latitude': selected.latitude}, 'captured_location': {'longitude': position.longitude, 'latitude': position.latitude}, 'accuracy_m': position.accuracy, 'verification_result': 'pending'},
      );
      _notice('GPS verification saved offline and queued for synchronization.');
    } catch (_) { _notice('Unable to save the location verification.'); }
  }

  void _notice(String text, {SnackBarAction? action}) => ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(text), action: action));

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppHeader(title: 'DA Magdalena', subtitle: 'GIS Field Map', actions: [IconButton(onPressed: _loading ? null : _load, icon: const Icon(Icons.refresh), tooltip: 'Refresh map records')]),
    body: StreamBuilder<List<OfflineRecord>>(
      stream: (context.read<AppDatabase>().select(context.read<AppDatabase>().offlineRecords)..orderBy([(table) => OrderingTerm.desc(table.updatedAt)])).watch(),
      builder: (context, snapshot) {
        final local = (snapshot.data ?? const <OfflineRecord>[]).map(_localRecord).whereType<_MapRecord>().toList();
        final records = [..._remote, ...local].where((record) => _filters.contains(record.type)).toList();
        final center = _position == null ? const LatLng(14.202, 121.432) : LatLng(_position!.latitude, _position!.longitude);
        return Column(children: [
          SizedBox(
            height: 58,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              scrollDirection: Axis.horizontal,
              children: ['Pig Farmers', 'Pig Pens', 'Disease Reports', 'Assigned Tasks', 'Dispersal Recipients']
                  .map((filter) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(filter),
                          selected: _filters.contains(filter),
                          onSelected: (selected) => setState(() {
                            if (selected) {
                              _filters.add(filter);
                            } else {
                              _filters.remove(filter);
                            }
                          }),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Expanded(child: Stack(children: [
            FlutterMap(mapController: _controller, options: MapOptions(initialCenter: center, initialZoom: 14, onTap: (_, _) => setState(() => _selected = null)), children: [
              TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', userAgentPackageName: 'com.da.magdalena.fieldapp'),
              MarkerLayer(markers: [
                ...records.map((record) => Marker(point: LatLng(record.latitude, record.longitude), width: 44, height: 44, child: GestureDetector(onTap: () => setState(() => _selected = record), child: Icon(record.type == 'Disease Reports' ? Icons.warning_amber_rounded : record.type == 'Pig Pens' ? Icons.home_work_outlined : Icons.location_on, size: 38, color: record.type == 'Disease Reports' ? Colors.red : AppTheme.primary)))),
                if (_position != null) Marker(point: LatLng(_position!.latitude, _position!.longitude), width: 44, height: 44, child: const Icon(Icons.my_location, size: 36, color: Colors.blue)),
              ]),
            ]),
            Positioned(right: 16, bottom: _selected == null ? 20 : 176, child: FloatingActionButton.small(onPressed: _locating ? null : _locate, child: _locating ? const CircularProgressIndicator() : const Icon(Icons.my_location))),
            if (_loading) const Center(child: CircularProgressIndicator()),
            if (_selected != null) Positioned(left: 16, right: 16, bottom: 16, child: _details(_selected!)),
          ])),
        ]);
      },
    ),
  );

  _MapRecord? _localRecord(OfflineRecord record) {
    final type = switch (record.recordType) { OfflineRecordType.farmer => 'Pig Farmers', OfflineRecordType.pigPenInspection => 'Pig Pens', OfflineRecordType.diseaseReport => 'Disease Reports', OfflineRecordType.dispersalMonitoring => 'Dispersal Recipients', OfflineRecordType.inspection => 'Assigned Tasks', _ => null };
    if (type == null) return null;
    Map<String, dynamic> payload = {}; try { payload = Map<String, dynamic>.from(jsonDecode(record.payload) as Map); } catch (_) {}
    return _MapRecord(id: record.id, type: type, latitude: record.latitude, longitude: record.longitude, title: payload['full_name']?.toString() ?? payload['pen_id']?.toString() ?? payload['pig_id']?.toString() ?? type, barangay: payload['barangay']?.toString() ?? '—', status: record.syncStatus, penId: payload['pen_id']?.toString());
  }

  Widget _details(_MapRecord record) => SectionCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Expanded(child: Text(record.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700))), IconButton(onPressed: () => setState(() => _selected = null), icon: const Icon(Icons.close))]), Text(record.type), const SizedBox(height: 8), Wrap(spacing: 8, runSpacing: 8, children: [StatusBadge(label: record.status), StatusBadge(label: record.barangay, color: const Color(0xFF536B42))]), const SizedBox(height: 10), Text('${record.latitude.toStringAsFixed(6)}, ${record.longitude.toStringAsFixed(6)}'), if (record.penId != null) ...[const SizedBox(height: 10), FilledButton.icon(onPressed: _verifySelectedPen, icon: const Icon(Icons.verified_outlined), label: const Text('VERIFY CURRENT LOCATION'))]]));
}

class _MapRecord { const _MapRecord({required this.id, required this.type, required this.latitude, required this.longitude, required this.title, required this.barangay, required this.status, this.penId}); final String id; final String type; final double latitude; final double longitude; final String title; final String barangay; final String status; final String? penId; }
