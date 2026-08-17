import 'package:da_field_app/core/config/api_config.dart';
import 'package:da_field_app/core/network/dio_client.dart';
import 'package:da_field_app/core/security/secure_session_storage.dart';
import 'package:da_field_app/domain/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('login stores a token, uses it for auth/me, logout clears it, and re-login replaces it', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final storage = _FakeSecureSessionStorage();
    final dio = Dio();
    final client = DioClient(storage, dio: dio);
    final repository = AuthRepository(client, storage, preferences);

    var issuedToken = 'token-one';
    String? meAuthorizationHeader;

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          switch (options.path) {
            case '/auth/token':
              handler.resolve(
                Response<Map<String, dynamic>>(
                  requestOptions: options,
                  data: {'access_token': issuedToken},
                  statusCode: 200,
                ),
              );
            case '/auth/me':
              meAuthorizationHeader = options.headers['Authorization']
                  ?.toString();
              handler.resolve(
                Response<Map<String, dynamic>>(
                  requestOptions: options,
                  data: {'id': 'field-worker-123'},
                  statusCode: 200,
                ),
              );
            case '/auth/logout':
              handler.resolve(
                Response<void>(requestOptions: options, statusCode: 204),
              );
            default:
              handler.reject(
                DioException(
                  requestOptions: options,
                  error: 'Unhandled path ${options.path}',
                ),
              );
          }
        },
      ),
    );

    await repository.login('worker@example.com', 'password-123');

    expect(await storage.readAccessToken(), 'token-one');
    expect(meAuthorizationHeader, 'Bearer token-one');
    expect(
      preferences.getString(ApiConfig.fieldWorkerIdKey),
      'field-worker-123',
    );

    await repository.logout();
    expect(await storage.readAccessToken(), isNull);
    expect(preferences.getString(ApiConfig.fieldWorkerIdKey), isNull);

    issuedToken = 'token-two';
    await repository.login('worker@example.com', 'password-123');
    expect(await storage.readAccessToken(), 'token-two');
    expect(meAuthorizationHeader, 'Bearer token-two');
  });
}

class _FakeSecureSessionStorage extends SecureSessionStorage {
  _FakeSecureSessionStorage();

  String? token;

  @override
  bool get hasAccessToken => token?.isNotEmpty == true;

  @override
  Future<String?> readAccessToken() async => token;

  @override
  Future<void> writeAccessToken(String token) async {
    this.token = token.trim();
  }

  @override
  Future<void> clearAccessToken() async {
    token = null;
  }
}
