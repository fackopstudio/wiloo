import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/app/app.dart';
import 'package:wiloo/app/router/app_router.dart';
import 'package:wiloo/core/auth/auth_core_providers.dart';
import 'package:wiloo/core/config/app_mode.dart';
import 'package:wiloo/features/auth/application/session_controller.dart';
import 'package:wiloo/features/auth/domain/auth_repository.dart';
import 'package:wiloo/features/auth/domain/session_snapshot.dart';

import '../../support/in_memory_token_store.dart';

void main() {
  group('Theme consistency across app modes', () {
    testWidgets('backoffice mode uses the light blue Wiloo theme', (
      tester,
    ) async {
      final app = await _materialApp(tester, AppMode.backoffice);

      expect(app.themeMode, ThemeMode.light);
      final primary = app.theme!.colorScheme.primary;
      expect(primary.b, greaterThan(primary.r));
      expect(primary.b, greaterThan(primary.g));
    });

    testWidgets('terminal mode uses the same light blue Wiloo theme', (
      tester,
    ) async {
      final app = await _materialApp(tester, AppMode.terminal);

      expect(app.themeMode, ThemeMode.light);
      final primary = app.theme!.colorScheme.primary;
      expect(primary.b, greaterThan(primary.r));
    });

    testWidgets('APP_MODE does not change the brand palette', (tester) async {
      final backoffice = await _materialApp(tester, AppMode.backoffice);
      final terminal = await _materialApp(tester, AppMode.terminal);

      expect(
        backoffice.theme!.colorScheme.primary,
        terminal.theme!.colorScheme.primary,
      );
      expect(
        backoffice.theme!.colorScheme.surface,
        terminal.theme!.colorScheme.surface,
      );
      expect(backoffice.themeMode, terminal.themeMode);
    });
  });
}

Future<MaterialApp> _materialApp(WidgetTester tester, AppMode mode) async {
  final container = ProviderContainer(
    overrides: [
      appModeProvider.overrideWithValue(mode),
      sessionTokenStoreProvider.overrideWithValue(InMemoryTokenStore()),
      authRepositoryProvider.overrideWithValue(_GuestAuthRepository()),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const WilooApp()),
  );
  await tester.pump();

  final app = tester.widget<MaterialApp>(find.byType(MaterialApp));

  // Dispose the tree to cancel any in-flight startup work before teardown.
  await tester.pumpWidget(const SizedBox());

  return app;
}

class _GuestAuthRepository implements AuthRepository {
  @override
  Future<SessionSnapshot> bootstrapSession() async =>
      const SessionSnapshot.guest();

  @override
  Future<SessionSnapshot> getCurrentSession() async =>
      const SessionSnapshot.guest();

  @override
  Future<SessionSnapshot> signIn(String email, String password) async =>
      const SessionSnapshot.guest();

  @override
  Future<void> logout() async {}
}
