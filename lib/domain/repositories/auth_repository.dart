import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/config/api_config.dart';
import '../../core/network/dio_client.dart';
import '../../core/security/secure_session_storage.dart';

class AuthRepository {
  AuthRepository(
    this._dioClient,
    this._sessionStorage,
    this._preferences,
  );

  final DioClient _dioClient;
  final SecureSessionStorage _sessionStorage;
  final SharedPreferences _preferences;

  Future<void> login(String email, String password) async {
    final normalizedEmail = email.trim().toLowerCase();

    if (normalizedEmail.isEmpty) {
      throw const AuthException('Email must not be empty.');
    }
    if (password.isEmpty) {
      throw const AuthException('Password must not be empty.');
    }

    try {
      final response = await _dioClient.dio.post<Map<String, dynamic>>(
        '/auth/token',
        data: {'username': normalizedEmail, 'password': password},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      final accessToken = response.data?['access_token'];
      if (accessToken is! String || accessToken.trim().isEmpty) {
        throw const AuthException(
          'The server returned an invalid authentication response.',
        );
      }

      await _sessionStorage.writeAccessToken(accessToken);

      final profile = await _dioClient.dio.get<Map<String, dynamic>>(
        '/auth/me',
      );
      final fieldWorkerId = profile.data?['id'];
      if (fieldWorkerId is! String || fieldWorkerId.trim().isEmpty) {
        throw const AuthException(
          'The server returned an invalid user profile.',
        );
      }
      final wasProfileSaved = await _preferences.setString(
        ApiConfig.fieldWorkerIdKey,
        fieldWorkerId,
      );
      if (!wasProfileSaved) {
        throw const AuthException('Unable to save the field worker identity.');
      }
    } on DioException catch (error) {
      await _sessionStorage.clearAccessToken();
      throw AuthException(_messageForDioError(error));
    } on AuthException {
      await _sessionStorage.clearAccessToken();
      rethrow;
    } catch (_) {
      await _sessionStorage.clearAccessToken();
      throw const AuthException(
        'An unexpected error occurred while signing in.',
      );
    }
  }

  Future<void> logout() async {
    try {
      try {
        await _dioClient.dio.post<void>('/auth/logout');
      } on DioException {
        // Local logout must remain available while the field worker is offline.
      }
      await _sessionStorage.clearAccessToken();
      final wasRemoved = await _preferences.remove(ApiConfig.fieldWorkerIdKey);
      if (!wasRemoved && _preferences.containsKey(ApiConfig.fieldWorkerIdKey)) {
        throw const AuthException('Unable to clear the authentication token.');
      }
    } on AuthException {
      rethrow;
    } catch (_) {
      throw const AuthException(
        'An unexpected error occurred while signing out.',
      );
    }
  }

  String _messageForDioError(DioException error) {
    final responseData = error.response?.data;
    if (responseData is Map<String, dynamic>) {
      final detail = responseData['detail'];
      if (detail is String && detail.trim().isNotEmpty) {
        return detail;
      }
    }

    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        'The server took too long to respond. Please try again.',
      DioExceptionType.connectionError =>
        'Unable to connect to the server. Check your network and API address.',
      DioExceptionType.badCertificate =>
        'A secure connection to the server could not be established.',
      DioExceptionType.cancel => 'The sign-in request was cancelled.',
      _ => 'Unable to sign in. Please verify your email and password.',
    };
  }
}

class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}
