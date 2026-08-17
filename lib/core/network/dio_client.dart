import 'dart:developer' as developer;

import 'package:dio/dio.dart';

import '../config/api_config.dart';
import '../security/secure_session_storage.dart';

class DioClient {
  DioClient(this._sessionStorage, {Dio? dio}) : _dio = dio ?? Dio() {
    _configureDio();
  }

  static const _logName = 'DioClient';
  static const _requestTokenKey = 'request_access_token';

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
            options.extra.remove(_requestTokenKey);

            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
              options.extra[_requestTokenKey] = token;
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
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await _clearExpiredTokenIfRequestStillOwnsSession(error);
          }

          handler.next(error);
        },
      ),
    );
  }

  Future<void> _clearExpiredTokenIfRequestStillOwnsSession(
    DioException error,
  ) async {
    final tokenUsedByRequest = error.requestOptions.extra[_requestTokenKey];
    if (tokenUsedByRequest is! String || tokenUsedByRequest.isEmpty) {
      return;
    }

    try {
      final currentToken = await _sessionStorage.readAccessToken();
      if (currentToken == tokenUsedByRequest) {
        await _sessionStorage.clearAccessToken();
      }
    } catch (clearError, stackTrace) {
      developer.log(
        'Unable to clear the expired access token after a 401 response.',
        name: _logName,
        error: clearError,
        stackTrace: stackTrace,
      );
    }
  }
}
