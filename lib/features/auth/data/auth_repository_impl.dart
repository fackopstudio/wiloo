import 'package:dio/dio.dart';

import '../../../core/auth/session_token_store.dart';
import '../../../core/error/failure.dart';
import '../domain/auth_repository.dart';
import '../domain/session_snapshot.dart';
import 'auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.tokenStore,
  });

  final AuthRemoteDataSource remoteDataSource;
  final SessionTokenStore tokenStore;

  @override
  Future<SessionSnapshot> signIn(String email, String password) async {
    final AuthSignInResult result;
    try {
      result = await remoteDataSource.signInEmail(email, password);
    } on DioException catch (error) {
      throw _mapSignInError(error);
    } on Failure {
      rethrow;
    } on Object catch (error) {
      throw Failure.unknown(cause: error);
    }

    return _persistTokenAndHydrateSession(
      result,
      missingTokenMessage: 'Email ou mot de passe invalide.',
    );
  }

  @override
  Future<SessionSnapshot> bootstrapSession() async {
    final token = await tokenStore.readToken();
    if (token == null || token.isEmpty) {
      return const SessionSnapshot.guest();
    }

    return getCurrentSession(clearTokenWhenGuest: true);
  }

  @override
  Future<SessionSnapshot> getCurrentSession({
    bool clearTokenWhenGuest = false,
  }) async {
    try {
      final session = await remoteDataSource.getSession();
      if (session == null) {
        if (clearTokenWhenGuest) {
          await tokenStore.clearToken();
        }
        return const SessionSnapshot.guest();
      }
      return SessionSnapshot.authenticated(session);
    } on DioException catch (error) {
      final statusCode = error.response?.statusCode;
      if (statusCode == 401) {
        await tokenStore.clearToken();
        return const SessionSnapshot.guest();
      }
      throw _mapNetworkError(error);
    } on Failure {
      rethrow;
    } on Object catch (error) {
      throw Failure.unknown(cause: error);
    }
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.signOut();
    await tokenStore.clearToken();
  }

  Future<SessionSnapshot> _persistTokenAndHydrateSession(
    AuthSignInResult result, {
    required String missingTokenMessage,
  }) async {
    final token = result.token;
    if (token == null) {
      // No token means the backend did not establish a mobile bearer session.
      throw Failure.unauthorized(message: missingTokenMessage);
    }

    await tokenStore.saveToken(token);

    // The session (role/scope/tenant) is authoritative from get-session.
    final snapshot = await getCurrentSession();
    if (!snapshot.isAuthenticated) {
      await tokenStore.clearToken();
      throw const Failure.unauthorized(
        message: 'Session invalide. Veuillez réessayer.',
      );
    }

    return snapshot;
  }

  Failure _mapSignInError(DioException error) {
    final statusCode = error.response?.statusCode;
    if (statusCode == 400 || statusCode == 401) {
      return const Failure.unauthorized(
        message: 'Email ou mot de passe invalide.',
      );
    }
    if (statusCode == 403) {
      return const Failure.forbidden(message: "Accès refusé pour ce compte.");
    }
    return _mapNetworkError(error);
  }

  Failure _mapNetworkError(DioException error) {
    final statusCode = error.response?.statusCode;
    if (statusCode != null && statusCode >= 500) {
      return Failure.server(
        message: 'Le serveur est momentanément indisponible.',
        statusCode: statusCode,
        cause: error,
      );
    }
    if (statusCode != null) {
      return Failure.server(
        message: 'La requête a échoué.',
        statusCode: statusCode,
        cause: error,
      );
    }
    return Failure.network(
      message: 'Connexion au serveur impossible. Vérifiez votre réseau.',
      cause: error,
    );
  }
}
