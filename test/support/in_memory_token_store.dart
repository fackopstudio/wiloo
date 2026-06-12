import 'package:wiloo/core/auth/session_token_store.dart';

/// In-memory [SessionTokenStore] for tests. Mirrors the secure store contract
/// without touching platform channels.
class InMemoryTokenStore implements SessionTokenStore {
  InMemoryTokenStore([this._token]);

  String? _token;

  int saveCount = 0;
  int clearCount = 0;

  @override
  Future<String?> readToken() async => _token;

  @override
  Future<void> saveToken(String token) async {
    _token = token;
    saveCount++;
  }

  @override
  Future<void> clearToken() async {
    _token = null;
    clearCount++;
  }
}
