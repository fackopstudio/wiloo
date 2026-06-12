import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'session_token_store.dart';

/// [SessionTokenStore] backed by `flutter_secure_storage`.
class SecureSessionTokenStore implements SessionTokenStore {
  const SecureSessionTokenStore([
    this._storage = const FlutterSecureStorage(),
  ]);

  final FlutterSecureStorage _storage;

  @override
  Future<String?> readToken() {
    return _storage.read(key: kSessionTokenStorageKey);
  }

  @override
  Future<void> saveToken(String token) {
    return _storage.write(key: kSessionTokenStorageKey, value: token);
  }

  @override
  Future<void> clearToken() {
    return _storage.delete(key: kSessionTokenStorageKey);
  }
}
