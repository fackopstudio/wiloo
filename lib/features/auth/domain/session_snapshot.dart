import 'auth_scope.dart';
import 'auth_session.dart';
import 'auth_user.dart';
import 'user_role.dart';

/// Single source of truth consumed by the UI and route guards.
///
/// This is a pure projection of the backend session. Authorization decisions
/// remain backend-driven; this snapshot only drives client-side UX.
class SessionSnapshot {
  const SessionSnapshot({
    required this.isAuthenticated,
    this.user,
    this.role,
    this.scope,
    this.tenantId,
  });

  const SessionSnapshot.guest()
    : isAuthenticated = false,
      user = null,
      role = null,
      scope = null,
      tenantId = null;

  factory SessionSnapshot.authenticated(AuthSession session) {
    return SessionSnapshot(
      isAuthenticated: true,
      user: session.user,
      role: session.role ?? session.user.role,
      scope: session.scope,
      tenantId: session.tenantId,
    );
  }

  final bool isAuthenticated;
  final AuthUser? user;
  final UserRole? role;
  final AuthScope? scope;
  final String? tenantId;

  bool get isTerminalSession =>
      role == UserRole.timeTerminal || scope == AuthScope.timeclock;
}
