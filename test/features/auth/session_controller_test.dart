import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/core/auth/auth_core_providers.dart';
import 'package:wiloo/features/auth/application/session_controller.dart';
import 'package:wiloo/features/auth/domain/auth_repository.dart';
import 'package:wiloo/features/auth/domain/auth_user.dart';
import 'package:wiloo/features/auth/domain/session_snapshot.dart';
import 'package:wiloo/features/auth/domain/user_role.dart';

import '../../support/in_memory_token_store.dart';

void main() {
  group('SessionManager', () {
    test('bootstraps to authenticated when repository resolves a session',
        () async {
      final repo = _FakeAuthRepository(
        bootstrap: _adminSnapshot,
      );
      final container = _container(repo);
      addTearDown(container.dispose);

      // Trigger build + bootstrap.
      expect(
        container.read(sessionControllerProvider).isAuthenticated,
        isFalse,
      );
      await _pumpEventQueue();

      expect(container.read(sessionControllerProvider).isAuthenticated, isTrue);
      expect(container.read(sessionControllerProvider).role, UserRole.admin);
    });

    test('login updates the snapshot', () async {
      final repo = _FakeAuthRepository(signIn: _adminSnapshot);
      final container = _container(repo);
      addTearDown(container.dispose);
      await _pumpEventQueue();

      await container.read(sessionManagerProvider.notifier).login('a', 'b');

      expect(container.read(sessionControllerProvider).isAuthenticated, isTrue);
      expect(container.read(sessionControllerProvider).role, UserRole.admin);
    });

    test('logout returns to guest and clears repository session', () async {
      final repo = _FakeAuthRepository(bootstrap: _adminSnapshot);
      final container = _container(repo);
      addTearDown(container.dispose);
      await _pumpEventQueue();

      await container.read(sessionManagerProvider.notifier).logout();

      expect(
        container.read(sessionControllerProvider).isAuthenticated,
        isFalse,
      );
      expect(repo.logoutCalls, 1);
    });

    test('401 invalidation signal drops the session to guest', () async {
      final repo = _FakeAuthRepository(bootstrap: _adminSnapshot);
      final container = _container(repo);
      addTearDown(container.dispose);
      // Mount the manager so bootstrap runs, then let it complete.
      container.read(sessionControllerProvider);
      await _pumpEventQueue();
      expect(container.read(sessionControllerProvider).isAuthenticated, isTrue);

      container.read(sessionInvalidationProvider.notifier).signal();
      await _pumpEventQueue();

      expect(
        container.read(sessionControllerProvider).isAuthenticated,
        isFalse,
      );
    });
  });
}

ProviderContainer _container(AuthRepository repo) {
  return ProviderContainer(
    overrides: [
      sessionTokenStoreProvider.overrideWithValue(InMemoryTokenStore()),
      authRepositoryProvider.overrideWithValue(repo),
    ],
  );
}

Future<void> _pumpEventQueue() async {
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
}

const _adminSnapshot = SessionSnapshot(
  isAuthenticated: true,
  user: AuthUser(id: 'u1', email: 'admin@b.com', role: UserRole.admin),
  role: UserRole.admin,
);

class _FakeAuthRepository implements AuthRepository {
  _FakeAuthRepository({
    SessionSnapshot? bootstrap,
    SessionSnapshot? signIn,
  }) : _bootstrap = bootstrap ?? const SessionSnapshot.guest(),
       _signIn = signIn ?? const SessionSnapshot.guest();

  final SessionSnapshot _bootstrap;
  final SessionSnapshot _signIn;

  int logoutCalls = 0;

  @override
  Future<SessionSnapshot> bootstrapSession() async => _bootstrap;

  @override
  Future<SessionSnapshot> signIn(String email, String password) async =>
      _signIn;

  @override
  Future<SessionSnapshot> getCurrentSession() async => _bootstrap;

  @override
  Future<void> logout() async {
    logoutCalls++;
  }
}
