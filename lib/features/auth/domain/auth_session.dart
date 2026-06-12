import 'auth_scope.dart';
import 'auth_user.dart';
import 'user_role.dart';

/// Authoritative session resolved from `/api/auth/get-session`.
class AuthSession {
  const AuthSession({
    required this.user,
    this.role,
    this.scope,
    this.sessionTenantId,
  });

  final AuthUser user;
  final UserRole? role;
  final AuthScope? scope;

  /// Tenant declared at the session level, used as a fallback only.
  final String? sessionTenantId;

  /// Resolved tenant: the user tenant takes precedence over the session tenant.
  String? get tenantId => user.tenantId ?? sessionTenantId;
}
