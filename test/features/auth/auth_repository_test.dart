import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/core/error/failure.dart';
import 'package:wiloo/features/auth/data/auth_remote_data_source.dart';
import 'package:wiloo/features/auth/data/auth_repository_impl.dart';
import 'package:wiloo/features/auth/domain/auth_session.dart';
import 'package:wiloo/features/auth/domain/auth_user.dart';
import 'package:wiloo/features/auth/domain/user_role.dart';

import '../../support/in_memory_token_store.dart';

void main() {
  group('AuthRepositoryImpl', () {
    test('signIn saves token and returns authenticated snapshot', () async {
      final store = InMemoryTokenStore();
      final remote = _FakeRemote(
        signInResult: const AuthSignInResult(token: 'tok'),
        session: const AuthSession(
          user: AuthUser(id: 'u1', email: 'a@b.com', role: UserRole.admin),
          role: UserRole.admin,
        ),
      );
      final repo = AuthRepositoryImpl(
        remoteDataSource: remote,
        tokenStore: store,
      );

      final snapshot = await repo.signIn('a@b.com', 'pw');

      expect(await store.readToken(), 'tok');
      expect(snapshot.isAuthenticated, isTrue);
      expect(snapshot.role, UserRole.admin);
    });

    test('signIn without a token throws unauthorized', () async {
      final store = InMemoryTokenStore();
      final remote = _FakeRemote(
        signInResult: const AuthSignInResult(token: null),
      );
      final repo = AuthRepositoryImpl(
        remoteDataSource: remote,
        tokenStore: store,
      );

      await expectLater(
        repo.signIn('a@b.com', 'pw'),
        throwsA(
          isA<Failure>().having(
            (f) => f.type,
            'type',
            FailureType.unauthorized,
          ),
        ),
      );
    });

    test('signIn maps 401 DioException to unauthorized failure', () async {
      final store = InMemoryTokenStore();
      final remote = _FakeRemote(
        signInError: DioException(
          requestOptions: RequestOptions(path: '/auth/sign-in/email'),
          response: Response(
            requestOptions: RequestOptions(path: '/auth/sign-in/email'),
            statusCode: 401,
          ),
        ),
      );
      final repo = AuthRepositoryImpl(
        remoteDataSource: remote,
        tokenStore: store,
      );

      await expectLater(
        repo.signIn('a@b.com', 'bad'),
        throwsA(
          isA<Failure>().having(
            (f) => f.type,
            'type',
            FailureType.unauthorized,
          ),
        ),
      );
    });

    test('bootstrap with a stored token hydrates the session', () async {
      final store = InMemoryTokenStore('tok');
      final remote = _FakeRemote(
        session: const AuthSession(
          user: AuthUser(id: 'u1', email: 'a@b.com', role: UserRole.hr),
          role: UserRole.hr,
        ),
      );
      final repo = AuthRepositoryImpl(
        remoteDataSource: remote,
        tokenStore: store,
      );

      final snapshot = await repo.bootstrapSession();

      expect(snapshot.isAuthenticated, isTrue);
      expect(snapshot.role, UserRole.hr);
    });

    test('bootstrap with no token returns guest', () async {
      final store = InMemoryTokenStore();
      final repo = AuthRepositoryImpl(
        remoteDataSource: _FakeRemote(),
        tokenStore: store,
      );

      final snapshot = await repo.bootstrapSession();

      expect(snapshot.isAuthenticated, isFalse);
    });

    test('get-session returning null clears token and becomes guest', () async {
      final store = InMemoryTokenStore('tok');
      final repo = AuthRepositoryImpl(
        remoteDataSource: _FakeRemote(session: null),
        tokenStore: store,
      );

      final snapshot = await repo.bootstrapSession();

      expect(snapshot.isAuthenticated, isFalse);
      expect(await store.readToken(), isNull);
    });

    test('protected 401 during get-session clears token', () async {
      final store = InMemoryTokenStore('tok');
      final repo = AuthRepositoryImpl(
        remoteDataSource: _FakeRemote(
          getSessionError: DioException(
            requestOptions: RequestOptions(path: '/auth/get-session'),
            response: Response(
              requestOptions: RequestOptions(path: '/auth/get-session'),
              statusCode: 401,
            ),
          ),
        ),
        tokenStore: store,
      );

      final snapshot = await repo.getCurrentSession();

      expect(snapshot.isAuthenticated, isFalse);
      expect(await store.readToken(), isNull);
    });

    test('role mapping covers all six backend roles', () async {
      for (final apiValue in const [
        'employee',
        'manager',
        'supervisor',
        'hr',
        'admin',
        'time_terminal',
      ]) {
        final store = InMemoryTokenStore('tok');
        final repo = AuthRepositoryImpl(
          remoteDataSource: _FakeRemote(
            session: AuthSession(
              user: AuthUser(
                id: 'u1',
                email: 'a@b.com',
                role: UserRole.fromApi(apiValue),
              ),
              role: UserRole.fromApi(apiValue),
            ),
          ),
          tokenStore: store,
        );

        final snapshot = await repo.getCurrentSession();
        expect(snapshot.role, UserRole.fromApi(apiValue));
        expect(snapshot.role, isNotNull);
      }
    });

    test('tenantId prefers user.tenantId over session.tenantId', () async {
      final store = InMemoryTokenStore('tok');
      final repo = AuthRepositoryImpl(
        remoteDataSource: _FakeRemote(
          session: const AuthSession(
            user: AuthUser(id: 'u1', email: 'a@b.com', tenantId: 'user-tenant'),
            sessionTenantId: 'session-tenant',
          ),
        ),
        tokenStore: store,
      );

      final snapshot = await repo.getCurrentSession();

      expect(snapshot.tenantId, 'user-tenant');
    });

    test('logout clears token', () async {
      final store = InMemoryTokenStore('tok');
      final remote = _FakeRemote();
      final repo = AuthRepositoryImpl(
        remoteDataSource: remote,
        tokenStore: store,
      );

      await repo.logout();

      expect(await store.readToken(), isNull);
      expect(remote.signOutCalls, 1);
    });
  });
}

class _FakeRemote implements AuthRemoteDataSource {
  _FakeRemote({
    this.signInResult,
    this.signInError,
    this.session,
    this.getSessionError,
  });

  final AuthSignInResult? signInResult;
  final Object? signInError;
  final AuthSession? session;
  final Object? getSessionError;

  int signOutCalls = 0;

  @override
  Future<AuthSignInResult> signInEmail(String email, String password) async {
    if (signInError != null) {
      throw signInError!;
    }
    return signInResult ?? const AuthSignInResult();
  }

  @override
  Future<AuthSession?> getSession() async {
    if (getSessionError != null) {
      throw getSessionError!;
    }
    return session;
  }

  @override
  Future<void> signOut() async {
    signOutCalls++;
  }
}
