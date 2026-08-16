import 'dart:developer' as developer;

import 'package:dio/dio.dart';

import '../config/api_config.dart';
import '../security/secure_session_storage.dart';

class DioClient {
  DioClient(this._sessionStorage, {Dio? dio}) : _dio = dio ?? Dio() {
    _configureDio();
  }

  static const _logName = 'DioClient';

  final SecureSessionStorage _sessionStorage;
  final Dio _dio;

  Dio get dio => _dio;

  void _configureDio() {
    _dio.options
      ..baseUrl = ApiConfig.baseUrl
      ..connectTimeout = const Duration(seconds: 15)
      ..sendTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30)
      ..responseType = ResponseType.json
      ..headers['Accept'] = Headers.jsonContentType;

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            final token = await _sessionStorage.readAccessToken();

            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            } else {
              options.headers.remove('Authorization');
            }
          } catch (error, stackTrace) {
            options.headers.remove('Authorization');
            developer.log(
              'Unable to read the access token; proceeding without it.',
              name: _logName,
              error: error,
              stackTrace: stackTrace,
            );
          }

          handler.next(options);
        },
      ),
    );
  }
}
