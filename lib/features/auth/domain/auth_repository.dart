import 'session_snapshot.dart';

/// Coordinates Better Auth sign-in, session hydration and logout.
abstract class AuthRepository {
  /// Signs in with email/password, persists the bearer token and returns the
  /// authoritative session snapshot resolved from `/api/auth/get-session`.
  Future<SessionSnapshot> signIn(String email, String password);

  /// App-start hydration from the securely stored token.
  Future<SessionSnapshot> bootstrapSession();

  /// Re-resolves the current session from the backend.
  Future<SessionSnapshot> getCurrentSession();

  /// Clears the local token and best-effort signs out server-side.
  Future<void> logout();
}
