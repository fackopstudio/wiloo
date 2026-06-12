import 'package:dio/dio.dart';

import '../auth/session_token_store.dart';

/// Header used by Better Auth to deliver a fresh session token on auth
/// responses (sign-in) and on token rotation.
const String kSetAuthTokenHeader = 'set-auth-token';

/// Injects the Better Auth bearer token, captures `set-auth-token` rotations
/// and reacts to protected `401` responses.
///
/// This interceptor depends only on the core [SessionTokenStore] abstraction
/// and a plain callback, so `core/network` never imports `features/auth`.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.tokenStore, required this.onUnauthorized});

  final SessionTokenStore tokenStore;

  /// Invoked when a protected request is rejected with `401`, after the stored
  /// token has been cleared.
  final void Function() onUnauthorized;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenStore.readToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    await _captureRotatedToken(response.headers);
    handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // A rotated token can still be delivered alongside an error response.
    final response = err.response;
    if (response != null) {
      await _captureRotatedToken(response.headers);
    }

    if (response?.statusCode == 401) {
      await tokenStore.clearToken();
      onUnauthorized();
    }

    handler.next(err);
  }

  Future<void> _captureRotatedToken(Headers headers) async {
    final rotated = headers.value(kSetAuthTokenHeader);
    if (rotated == null || rotated.isEmpty) {
      return;
    }

    final current = await tokenStore.readToken();
    if (rotated != current) {
      await tokenStore.saveToken(rotated);
    }
  }
}
