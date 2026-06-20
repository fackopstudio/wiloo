import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/core/auth/auth_core_providers.dart';
import 'package:wiloo/features/auth/application/session_controller.dart';
import 'package:wiloo/features/auth/domain/auth_repository.dart';
import 'package:wiloo/features/auth/domain/auth_user.dart';
import 'package:wiloo/features/auth/domain/session_snapshot.dart';
import 'package:wiloo/features/auth/domain/user_role.dart';
import 'package:wiloo/features/backoffice/presentation/backoffice_dashboard_page.dart';

import '../../support/in_memory_token_store.dart';

void main() {
  group('BackofficeDashboardPage', () {
    testWidgets('renders for admin', (tester) async {
      await _pump(tester, role: UserRole.admin);

      expect(find.byKey(const Key('welcome_title')), findsOneWidget);
      expect(find.byKey(const Key('dashboard_role_badge')), findsOneWidget);
      expect(find.text('Administrateur'), findsOneWidget);
    });

    testWidgets('renders for hr', (tester) async {
      await _pump(tester, role: UserRole.hr);

      expect(find.byKey(const Key('welcome_title')), findsOneWidget);
      expect(find.text('RH'), findsOneWidget);
    });

    testWidgets('Compliance card is visible and actionable for admin', (
      tester,
    ) async {
      await _pump(tester, role: UserRole.admin);

      expect(find.byKey(const Key('compliance_card')), findsOneWidget);
      expect(find.byKey(const Key('compliance_open_button')), findsOneWidget);
      expect(find.text('Ouvrir la conformité'), findsOneWidget);
    });

    testWidgets('Compliance card is visible and actionable for hr', (
      tester,
    ) async {
      await _pump(tester, role: UserRole.hr);

      expect(find.byKey(const Key('compliance_card')), findsOneWidget);
      expect(find.text('Ouvrir la conformité'), findsOneWidget);
    });

    testWidgets('Compliance card is visible with read-only label for manager', (
      tester,
    ) async {
      await _pump(tester, role: UserRole.manager);

      expect(find.byKey(const Key('compliance_card')), findsOneWidget);
      expect(find.text('Consulter la conformité'), findsOneWidget);
    });

    testWidgets('Compliance card is hidden for employee', (tester) async {
      await _pump(tester, role: UserRole.employee);

      expect(find.byKey(const Key('compliance_card')), findsNothing);
      expect(find.byKey(const Key('compliance_open_button')), findsNothing);
    });

    testWidgets('Compliance card is hidden for supervisor', (tester) async {
      await _pump(tester, role: UserRole.supervisor);

      expect(find.byKey(const Key('compliance_card')), findsNothing);
    });

    testWidgets('coming soon cards render without navigation errors', (
      tester,
    ) async {
      await _pump(tester, role: UserRole.admin);

      // All four coming-soon modules should appear.
      expect(find.byKey(const Key('coming_soon_Employés')), findsOneWidget);
      expect(find.byKey(const Key('coming_soon_Présences')), findsOneWidget);
      expect(find.byKey(const Key('coming_soon_Paie')), findsOneWidget);
      expect(find.byKey(const Key('coming_soon_Congés')), findsOneWidget);

      // Tapping a coming-soon card must not throw.
      await tester.tap(find.byKey(const Key('coming_soon_Employés')));
      await tester.pumpAndSettle();
    });

    testWidgets('coming soon chips show "Bientôt" label', (tester) async {
      await _pump(tester, role: UserRole.hr);

      expect(find.text('Bientôt'), findsWidgets);
    });

    testWidgets('Timeclock quick-access card is shown for all roles', (
      tester,
    ) async {
      await _pump(tester, role: UserRole.employee);

      expect(find.byKey(const Key('timeclock_card')), findsOneWidget);
      expect(find.byKey(const Key('timeclock_open_button')), findsOneWidget);
    });

    testWidgets('dev environment indicator is visible outside production', (
      tester,
    ) async {
      await _pump(tester, role: UserRole.admin);

      expect(find.byKey(const Key('dashboard_env_indicator')), findsOneWidget);
    });
  });
}

Future<void> _pump(WidgetTester tester, {required UserRole role}) async {
  final container = ProviderContainer(
    overrides: [
      sessionTokenStoreProvider.overrideWithValue(InMemoryTokenStore()),
      authRepositoryProvider.overrideWithValue(_FakeAuthRepository(role)),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        home: Scaffold(
          body: UncontrolledProviderScope(
            container: container,
            child: const BackofficeDashboardPage(),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

class _FakeAuthRepository implements AuthRepository {
  _FakeAuthRepository(UserRole role)
    : _snapshot = SessionSnapshot(
        isAuthenticated: true,
        user: AuthUser(
          id: 'u1',
          email: '${role.apiValue}@wiloo.test',
          name: role == UserRole.admin ? 'Admin Wiloo' : null,
          role: role,
        ),
        role: role,
      );

  final SessionSnapshot _snapshot;

  @override
  Future<SessionSnapshot> bootstrapSession() async => _snapshot;

  @override
  Future<SessionSnapshot> getCurrentSession() async => _snapshot;

  @override
  Future<SessionSnapshot> signIn(String email, String password) async =>
      _snapshot;

  @override
  Future<void> logout() async {}
}
