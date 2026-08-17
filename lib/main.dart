import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/config/api_config.dart';
import 'core/network/dio_client.dart';
import 'core/notifications/notification_alert_service.dart';
import 'core/security/secure_session_storage.dart';
import 'core/theme/app_theme.dart';
import 'data/local/database/app_database.dart';
import 'data/sync/sync_processor.dart';
import 'data/sync/sync_coordinator.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/disease_report_repository.dart';
import 'domain/repositories/dispersal_repository.dart';
import 'domain/repositories/farmer_repository.dart';
import 'domain/repositories/field_operations_repository.dart';
import 'domain/repositories/inspection_repository.dart';
import 'domain/repositories/offline_record_repository.dart';
import 'domain/repositories/notification_repository.dart';
import 'domain/repositories/pig_repository.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  final secureSessionStorage = SecureSessionStorage();
  await secureSessionStorage.initialize(preferences);
  final notificationAlertService = LocalNotificationAlertService(preferences);
  await notificationAlertService.initialize();
  final database = AppDatabase();
  final dioClient = DioClient(secureSessionStorage);
  final authRepository = AuthRepository(
    dioClient,
    secureSessionStorage,
    preferences,
  );
  String fieldWorkerIdProvider() =>
      preferences.getString(ApiConfig.fieldWorkerIdKey) ?? 'local-field-worker';
  final farmerRepository = FarmerRepository(
    database,
    fieldWorkerIdProvider: fieldWorkerIdProvider,
  );
  final diseaseReportRepository = DiseaseReportRepository(
    database,
    fieldWorkerIdProvider: fieldWorkerIdProvider,
  );
  final inspectionRepository = InspectionRepository(
    database,
    fieldWorkerIdProvider: fieldWorkerIdProvider,
  );
  final pigRepository = PigRepository(
    database,
    fieldWorkerIdProvider: fieldWorkerIdProvider,
  );
  final dispersalRepository = DispersalRepository(
    database,
    fieldWorkerIdProvider: fieldWorkerIdProvider,
  );
  final offlineRecordRepository = OfflineRecordRepository(
    database,
    fieldWorkerIdProvider: fieldWorkerIdProvider,
  );
  final fieldOperationsRepository = FieldOperationsRepository(
    offlineRecordRepository,
  );
  final connectivity = Connectivity();
  final notificationRepository = NotificationRepository(
    database,
    dioClient.dio,
  );
  final syncProcessor = SyncProcessor(database, dioClient.dio, connectivity);
  final syncCoordinator = SyncCoordinator(
    syncProcessor,
    connectivity,
    hasAuthenticatedSession: () => secureSessionStorage.hasAccessToken,
  )..start();

  runApp(
    MultiProvider(
      providers: [
        Provider<SharedPreferences>.value(value: preferences),
        Provider<SecureSessionStorage>.value(value: secureSessionStorage),
        Provider<AppDatabase>.value(value: database),
        Provider<DioClient>.value(value: dioClient),
        Provider<NotificationAlertService>.value(
          value: notificationAlertService,
        ),
        Provider<AuthRepository>.value(value: authRepository),
        Provider<FarmerRepository>.value(value: farmerRepository),
        Provider<DiseaseReportRepository>.value(value: diseaseReportRepository),
        Provider<InspectionRepository>.value(value: inspectionRepository),
        Provider<PigRepository>.value(value: pigRepository),
        Provider<DispersalRepository>.value(value: dispersalRepository),
        Provider<OfflineRecordRepository>.value(value: offlineRecordRepository),
        Provider<FieldOperationsRepository>.value(
          value: fieldOperationsRepository,
        ),
        Provider<NotificationRepository>.value(value: notificationRepository),
        Provider<SyncProcessor>.value(value: syncProcessor),
        Provider<SyncCoordinator>.value(value: syncCoordinator),
      ],
      child: MyApp(initiallyAuthenticated: secureSessionStorage.hasAccessToken),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.initiallyAuthenticated = false});

  final bool initiallyAuthenticated;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DA Field Operations',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: initiallyAuthenticated ? const HomeScreen() : const LoginScreen(),
    );
  }
}
