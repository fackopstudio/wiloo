/// Secure storage abstraction for the Better Auth bearer session token.
///
/// Only the opaque Better Auth session token is persisted. Credentials
/// (email/password) are never stored, and the token is never decoded locally.
abstract class SessionTokenStore {
  /// Returns the persisted bearer token, or `null` when none is stored.
  Future<String?> readToken();

  /// Persists the bearer token, replacing any previously stored value.
  Future<void> saveToken(String token);

  /// Removes the persisted bearer token.
  Future<void> clearToken();
}

/// Single source of truth for the secure storage key of the session token.
const String kSessionTokenStorageKey = 'wiloo.session.bearer_token';
