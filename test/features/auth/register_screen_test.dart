import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:wiloo/app/router/app_routes.dart';
import 'package:wiloo/features/auth/presentation/register_screen.dart';

void main() {
  group('RegisterScreen', () {
    testWidgets('renders the invitation-only account policy', (tester) async {
      await _pumpRegister(tester);

      expect(find.text('Accès sur invitation'), findsOneWidget);
      expect(find.text(RegisterScreen.invitationMessage), findsOneWidget);
      expect(
        find.byKey(const Key('register_invitation_message')),
        findsOneWidget,
      );
      expect(find.byType(TextFormField), findsNothing);
      expect(find.textContaining('Créer mon organisation'), findsNothing);
      expect(find.textContaining('Rejoindre mon organisation'), findsNothing);
    });

    testWidgets('contains no public registration submission control', (
      tester,
    ) async {
      await _pumpRegister(tester);

      expect(find.byKey(const Key('register_submit_button')), findsNothing);
      expect(find.byKey(const Key('register_mode_selector')), findsNothing);
      expect(
        find.byKey(const Key('register_company_name_field')),
        findsNothing,
      );
      expect(
        find.byKey(const Key('register_company_code_field')),
        findsNothing,
      );
    });

    testWidgets('returns to the login screen', (tester) async {
      final router = await _pumpRegister(tester);

      await tester.tap(find.byKey(const Key('register_login_link')));
      await tester.pumpAndSettle();

      expect(
        router.routeInformationProvider.value.uri.path,
        AppRoute.auth.path,
      );
      expect(find.text('AUTH_DESTINATION'), findsOneWidget);
    });
  });
}

Future<GoRouter> _pumpRegister(WidgetTester tester) async {
  final router = GoRouter(
    initialLocation: AppRoute.register.path,
    routes: [
      GoRoute(
        path: AppRoute.register.path,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoute.auth.path,
        builder: (context, state) =>
            const Scaffold(body: Text('AUTH_DESTINATION')),
      ),
      GoRoute(
        path: AppRoute.welcome.path,
        builder: (context, state) =>
            const Scaffold(body: Text('WELCOME_DESTINATION')),
      ),
    ],
  );
  addTearDown(router.dispose);

  await tester.pumpWidget(
    MaterialApp.router(
      theme: ThemeData(useMaterial3: true),
      routerConfig: router,
    ),
  );
  await tester.pumpAndSettle();

  return router;
}
