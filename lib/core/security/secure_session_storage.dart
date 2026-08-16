import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/api_config.dart';

class SecureSessionStorage {
  SecureSessionStorage({FlutterSecureStorage? storage})
    : _storage = storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(),
          );

  final FlutterSecureStorage _storage;
  String? _cachedAccessToken;

  bool get hasAccessToken => _cachedAccessToken?.isNotEmpty == true;

  Future<void> initialize(SharedPreferences preferences) async {
    _cachedAccessToken = (await _storage.read(
      key: ApiConfig.accessTokenKey,
    ))?.trim();

    // One-time migration from the pre-Phase-24 plaintext preference.
    final legacyToken = preferences
        .getString(ApiConfig.accessTokenKey)
        ?.trim();
    if (!hasAccessToken && legacyToken != null && legacyToken.isNotEmpty) {
      await writeAccessToken(legacyToken);
    }
    await preferences.remove(ApiConfig.accessTokenKey);
  }

  Future<String?> readAccessToken() async {
    final token = (await _storage.read(
      key: ApiConfig.accessTokenKey,
    ))?.trim();
    _cachedAccessToken = token;
    return token;
  }

  Future<void> writeAccessToken(String token) async {
    final normalized = token.trim();
    if (normalized.isEmpty) {
      throw ArgumentError.value(token, 'token', 'must not be empty');
    }
    await _storage.write(key: ApiConfig.accessTokenKey, value: normalized);
    _cachedAccessToken = normalized;
  }

  Future<void> clearAccessToken() async {
    await _storage.delete(key: ApiConfig.accessTokenKey);
    _cachedAccessToken = null;
  }
}
