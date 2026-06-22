import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/app/router/app_router.dart';
import 'package:wiloo/core/auth/auth_core_providers.dart';
import 'package:wiloo/core/config/app_mode.dart';
import 'package:wiloo/features/auth/application/session_controller.dart';
import 'package:wiloo/features/auth/domain/auth_repository.dart';
import 'package:wiloo/features/auth/domain/auth_user.dart';
import 'package:wiloo/features/auth/domain/session_snapshot.dart';
import 'package:wiloo/features/auth/domain/user_role.dart';

import '../../support/in_memory_token_store.dart';

void main() {
  // The default test surface is wide (800px), so NavigationRail is used.
  // Finders look inside the rail for all role-based nav tests.

  group('BackofficeShell — Compliance nav item visibility', () {
    testWidgets('admin sees the Compliance nav item', (tester) async {
      await _pumpShell(tester, role: UserRole.admin);
      expect(_complianceRailItem, findsOneWidget);
    });

    testWidgets('hr sees the Compliance nav item', (tester) async {
      await _pumpShell(tester, role: UserRole.hr);
      expect(_complianceRailItem, findsOneWidget);
    });

    testWidgets('manager sees Compliance (read-only label) in the nav',
        (tester) async {
      await _pumpShell(tester, role: UserRole.manager);
      expect(_complianceRailItem, findsOneWidget);
      expect(
        find.descendant(
          of: find.byKey(const Key('backoffice_navigation_rail')),
          matching: find.textContaining('lecture'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('employee does not see the Compliance nav item', (
      tester,
    ) async {
      await _pumpShell(tester, role: UserRole.employee);
      expect(_complianceRailItem, findsNothing);
    });

    testWidgets('supervisor does not see the Compliance nav item', (
      tester,
    ) async {
      await _pumpShell(tester, role: UserRole.supervisor);
      expect(_complianceRailItem, findsNothing);
    });
  });

  group('BackofficeShell — Timeclock/Pointage nav item', () {
    testWidgets('Pointage item is visible for admin', (tester) async {
      await _pumpShell(tester, role: UserRole.admin);
      expect(_pointageRailItem, findsOneWidget);
    });

    testWidgets('Pointage item is visible for employee', (tester) async {
      await _pumpShell(tester, role: UserRole.employee);
      expect(_pointageRailItem, findsOneWidget);
    });
  });

  group('BackofficeShell — logout', () {
    testWidgets('logout button exists and calls SessionManager', (
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

  group('BackofficeShell — role chip', () {
    testWidgets('role chip shows the current role', (tester) async {
      await _pumpShell(tester, role: UserRole.hr);
      expect(find.byKey(const Key('backoffice_role_chip')), findsOneWidget);
      expect(
        find.descendant(
          of: find.byKey(const Key('backoffice_role_chip')),
          matching: find.text('RH'),
        ),
        findsOneWidget,
      );
    });
  });

  group('BackofficeShell — mobile layout (NavigationBar)', () {
    testWidgets('bottom NavigationBar renders on narrow screens', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await _pumpShell(tester, role: UserRole.admin);

      expect(find.byKey(const Key('backoffice_navigation_bar')), findsOneWidget);
      expect(find.byKey(const Key('backoffice_navigation_rail')), findsNothing);
    });
  });

  group('BackofficeShell — active state', () {
    testWidgets('dashboard is selected when on backoffice/dashboard', (
      tester,
    ) async {
      await _pumpShell(tester, role: UserRole.admin);
      // Default landing is the dashboard — index 0 must be selected.
      final rail = tester.widget<NavigationRail>(
        find.byKey(const Key('backoffice_navigation_rail')),
      );
      expect(rail.selectedIndex, 0);
    });
  });

  group('Terminal mode', () {
    testWidgets('terminal mode starts on /terminal, not backoffice', (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [
          appModeProvider.overrideWithValue(AppMode.terminal),
          sessionTokenStoreProvider.overrideWithValue(InMemoryTokenStore()),
          authRepositoryProvider.overrideWithValue(
            _FakeAuthRepository(const SessionSnapshot.guest()),
          ),
        ],
      );
      addTearDown(container.dispose);

      final router = container.read(appRouterProvider);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Terminal de pointage'), findsOneWidget);
      expect(find.byKey(const Key('backoffice_navigation_rail')), findsNothing);
    });
  });
}

// ── Finders ───────────────────────────────────────────────────────────────────

final _complianceRailItem = find.descendant(
  of: find.byKey(const Key('backoffice_navigation_rail')),
  matching: find.textContaining('Conformité'),
);

final _pointageRailItem = find.descendant(
  of: find.byKey(const Key('backoffice_navigation_rail')),
  matching: find.textContaining('Pointage'),
);

// ── Helpers ───────────────────────────────────────────────────────────────────

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

// ── Fakes ─────────────────────────────────────────────────────────────────────

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
