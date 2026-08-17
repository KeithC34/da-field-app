import 'dart:io';

import 'package:da_field_app/core/network/dio_client.dart';
import 'package:da_field_app/core/security/secure_session_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'authenticated requests include a Bearer header from secure storage',
    () async {
      final storage = _FakeSecureSessionStorage(token: 'live-token');
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      String? authorizationHeader;
      server.listen((request) async {
        authorizationHeader = request.headers.value(
          HttpHeaders.authorizationHeader,
        );
        request.response.statusCode = HttpStatus.ok;
        request.response.write('{}');
        await request.response.close();
      });

      final client = DioClient(storage, dio: Dio());
      client.dio.options.baseUrl = 'http://127.0.0.1:${server.port}';
      try {
        final response = await client.dio.get<Object?>('/notifications');
        expect(response.statusCode, HttpStatus.ok);
        expect(authorizationHeader, 'Bearer live-token');
      } finally {
        await server.close(force: true);
      }
    },
  );

  test(
    '401 responses clear the cached mobile session token that made the request',
    () async {
      final storage = _FakeSecureSessionStorage(token: 'expired-token');
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      server.listen((request) async {
        request.response.statusCode = HttpStatus.unauthorized;
        request.response.write('unauthorized');
        await request.response.close();
      });

      final client = DioClient(storage, dio: Dio());
      client.dio.options.baseUrl = 'http://127.0.0.1:${server.port}';
      try {
        await expectLater(
          client.dio.get<Object?>('/notifications'),
          throwsA(isA<DioException>()),
        );
        expect(storage.cleared, isTrue);
        expect(storage.hasAccessToken, isFalse);
      } finally {
        await server.close(force: true);
      }
    },
  );

  test(
    'a delayed 401 from an old token does not clear a newer re-login token',
    () async {
      final storage = _FakeSecureSessionStorage(token: 'stale-token');
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      server.listen((request) async {
        await Future<void>.delayed(const Duration(milliseconds: 120));
        request.response.statusCode = HttpStatus.unauthorized;
        request.response.write('unauthorized');
        await request.response.close();
      });

      final client = DioClient(storage, dio: Dio());
      client.dio.options.baseUrl = 'http://127.0.0.1:${server.port}';
      try {
        final pendingRequest = client.dio.get<Object?>('/mobile-sync/changes');
        await Future<void>.delayed(const Duration(milliseconds: 20));
        await storage.writeAccessToken('fresh-token');

        await expectLater(pendingRequest, throwsA(isA<DioException>()));
        expect(storage.cleared, isFalse);
        expect(storage.hasAccessToken, isTrue);
        expect(await storage.readAccessToken(), 'fresh-token');
      } finally {
        await server.close(force: true);
      }
    },
  );
}

class _FakeSecureSessionStorage extends SecureSessionStorage {
  _FakeSecureSessionStorage({this.token});

  String? token;
  bool cleared = false;

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
    cleared = true;
    token = null;
  }
}
