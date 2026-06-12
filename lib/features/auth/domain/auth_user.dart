import 'user_role.dart';

/// Authenticated user as resolved by the backend (`/api/auth/get-session`).
///
/// The backend remains the source of truth for identity, role and tenant. This
/// model is a read-only projection; no token is decoded locally.
class AuthUser {
  const AuthUser({
    required this.id,
    required this.email,
    this.name,
    this.role,
    this.tenantId,
  });

  final String id;
  final String email;
  final String? name;
  final UserRole? role;

  /// Tenant declared on the user object, when present.
  final String? tenantId;
}
