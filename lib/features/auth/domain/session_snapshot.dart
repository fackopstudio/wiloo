import 'auth_scope.dart';
import 'user_role.dart';

class SessionSnapshot {
  const SessionSnapshot({required this.isAuthenticated, this.role, this.scope});

  const SessionSnapshot.guest()
    : isAuthenticated = false,
      role = null,
      scope = null;

  final bool isAuthenticated;
  final UserRole? role;
  final AuthScope? scope;
}
