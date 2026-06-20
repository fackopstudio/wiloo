import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/app/router/app_router.dart';
import 'package:wiloo/core/auth/auth_core_providers.dart';
import 'package:wiloo/features/auth/application/session_controller.dart';
import 'package:wiloo/features/auth/domain/auth_repository.dart';
import 'package:wiloo/features/auth/domain/auth_user.dart';
import 'package:wiloo/features/auth/domain/session_snapshot.dart';
import 'package:wiloo/features/auth/domain/user_role.dart';

import '../../support/in_memory_token_store.dart';

void main() {
  group('BackofficeShell navigation', () {
    testWidgets('admin sees the Compliance nav item', (tester) async {
      await _pumpShell(tester, role: UserRole.admin);
      expect(_complianceNavItem, findsOneWidget);
    });

    testWidgets('hr sees the Compliance nav item', (tester) async {
      await _pumpShell(tester, role: UserRole.hr);
      expect(_complianceNavItem, findsOneWidget);
    });

    testWidgets('manager sees the Compliance nav item (read-only)', (
      tester,
    ) async {
      await _pumpShell(tester, role: UserRole.manager);
      expect(_complianceNavItem, findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(NavigationRail),
          matching: find.textContaining('lecture'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('employee does not see the Compliance nav item', (
      tester,
    ) async {
      await _pumpShell(tester, role: UserRole.employee);
      expect(_complianceNavItem, findsNothing);
    });

    testWidgets('logout calls SessionManager and returns to auth', (
      tester,
    ) async {
      final repo = _FakeAuthRepository(_snapshot(UserRole.admin));
      final container = _container(repo);
      addTearDown(container.dispose);

      await _pumpRouter(tester, container);

      expect(find.byKey(const Key('backoffice_logout_button')), findsOneWidget);

      await tester.tap(find.byKey(const Key('backoffice_logout_button')));
      await tester.pumpAndSettle();

      expect(repo.logoutCalls, 1);
      expect(find.text('Connexion Wiloo'), findsOneWidget);
    });
  });
}

final _complianceNavItem = find.descendant(
  of: find.byType(NavigationRail),
  matching: find.textContaining('Conformité'),
);

Future<void> _pumpShell(WidgetTester tester, {required UserRole role}) async {
  final container = _container(_FakeAuthRepository(_snapshot(role)));
  addTearDown(container.dispose);
  await _pumpRouter(tester, container);
}

Future<void> _pumpRouter(
  WidgetTester tester,
  ProviderContainer container,
) async {
  final router = container.read(appRouterProvider);
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  // Bootstrap authenticates and the centralized redirect lands on the
  // backoffice dashboard inside the shell.
  await tester.pumpAndSettle();
}

ProviderContainer _container(_FakeAuthRepository repo) {
  return ProviderContainer(
    overrides: [
      sessionTokenStoreProvider.overrideWithValue(InMemoryTokenStore()),
      authRepositoryProvider.overrideWithValue(repo),
    ],
  );
}

SessionSnapshot _snapshot(UserRole role) => SessionSnapshot(
  isAuthenticated: true,
  user: AuthUser(id: 'u1', email: '${role.apiValue}@b.com', role: role),
  role: role,
);

class _FakeAuthRepository implements AuthRepository {
  _FakeAuthRepository(this.bootstrap);

  final SessionSnapshot bootstrap;
  int logoutCalls = 0;

  @override
  Future<SessionSnapshot> bootstrapSession() async => bootstrap;

  @override
  Future<SessionSnapshot> getCurrentSession() async => bootstrap;

  @override
  Future<SessionSnapshot> signIn(String email, String password) async =>
      bootstrap;

  @override
  Future<void> logout() async {
    logoutCalls++;
  }
}
