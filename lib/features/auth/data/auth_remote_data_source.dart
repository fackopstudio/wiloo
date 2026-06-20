import 'package:dio/dio.dart';

import '../../../core/network/auth_interceptor.dart';
import '../domain/auth_scope.dart';
import '../domain/auth_session.dart';
import '../domain/auth_user.dart';
import '../domain/user_role.dart';

/// Result of a sign-in call: the captured bearer token (from `set-auth-token`)
/// and, when present, the user returned in the response body.
class AuthSignInResult {
  const AuthSignInResult({this.token, this.user});

  final String? token;
  final AuthUser? user;
}

/// Talks to the Better Auth endpoints. Uses [Dio] directly (not
/// `GeneralApiClient`) because sign-in must read the `set-auth-token` response
/// header and the Better Auth body is not necessarily wrapped in the standard
/// API envelope.
abstract class AuthRemoteDataSource {
  Future<AuthSignInResult> signInEmail(String email, String password);

  /// Returns the resolved session, or `null` when the backend reports no
  /// session (`200` with a `null`/empty body).
  Future<AuthSession?> getSession();

  /// Best-effort server-side sign-out. Never throws: local logout must always
  /// proceed even if the endpoint is unavailable.
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<AuthSignInResult> signInEmail(String email, String password) async {
    final response = await _dio.post<Object?>(
      '/auth/sign-in/email',
      data: {'email': email, 'password': password},
    );

    return _authResultFromResponse(response);
  }

  @override
  Future<AuthSession?> getSession() async {
    final response = await _dio.get<Object?>('/auth/get-session');
    final body = _unwrap(response.data);
    if (body == null) {
      // get-session returns 200 with null for an invalid/missing session.
      return null;
    }

    final userMap = _userMap(body);
    if (userMap == null) {
      return null;
    }

    final sessionMap = _sessionMap(body);
    final user = _parseUser(userMap);
    final role =
        UserRole.fromApi(_stringOf(userMap['role'])) ??
        UserRole.fromApi(_stringOf(sessionMap?['role']));
    final scope =
        AuthScope.fromApi(_stringOf(userMap['scope'])) ??
        AuthScope.fromApi(_stringOf(sessionMap?['scope']));

    return AuthSession(
      user: user,
      role: role,
      scope: scope,
      sessionTenantId: _tenantOf(sessionMap),
    );
  }

  @override
  Future<void> signOut() async {
    try {
      await _dio.post<Object?>('/auth/sign-out');
    } on Object {
      // Local logout must remain safe even if the call fails.
    }
  }

  AuthSignInResult _authResultFromResponse(Response<Object?> response) {
    final body = _unwrap(response.data);
    final token =
        response.headers.value(kSetAuthTokenHeader) ?? _tokenFromBody(body);
    final userMap = _userMap(body);

    return AuthSignInResult(
      token: (token != null && token.isNotEmpty) ? token : null,
      user: userMap == null ? null : _parseUser(userMap),
    );
  }

  AuthUser _parseUser(Map<String, Object?> userMap) {
    return AuthUser(
      id: _stringOf(userMap['id']) ?? '',
      email: _stringOf(userMap['email']) ?? '',
      name: _stringOf(userMap['name']),
      role: UserRole.fromApi(_stringOf(userMap['role'])),
      tenantId: _tenantOf(userMap),
    );
  }

  String? _tokenFromBody(Object? body) {
    if (body is Map<String, Object?>) {
      return _stringOf(body['token']);
    }
    return null;
  }

  /// Unwraps the standard API envelope (`{success, data, ...}`) when present,
  /// otherwise returns the raw Better Auth body. A `null`/empty payload becomes
  /// `null` (unauthenticated).
  Object? _unwrap(Object? data) {
    if (data is Map<String, Object?>) {
      if (data.containsKey('success') && data.containsKey('data')) {
        return data['data'];
      }
      return data;
    }
    return data;
  }

  Map<String, Object?>? _userMap(Object? body) {
    if (body is! Map<String, Object?>) {
      return null;
    }
    final user = body['user'];
    if (user is Map<String, Object?>) {
      return user;
    }
    // Some responses return the user fields at the top level.
    if (body.containsKey('id') || body.containsKey('email')) {
      return body;
    }
    return null;
  }

  Map<String, Object?>? _sessionMap(Object? body) {
    if (body is Map<String, Object?>) {
      final session = body['session'];
      if (session is Map<String, Object?>) {
        return session;
      }
    }
    return null;
  }

  String? _tenantOf(Map<String, Object?>? map) {
    if (map == null) {
      return null;
    }
    return _stringOf(map['tenantId']) ??
        _stringOf(map['organizationId']) ??
        _stringOf(map['activeOrganizationId']);
  }

  String? _stringOf(Object? value) {
    if (value is String && value.isNotEmpty) {
      return value;
    }
    return null;
  }
}
