import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:wiloo/app/router/app_routes.dart';
import 'package:wiloo/features/onboarding/presentation/welcome_screen.dart';

void main() {
  testWidgets('welcome renders the Wiloo onboarding and primary actions', (
    tester,
  ) async {
    await _pumpWelcome(tester);

    expect(find.text('Toute votre RH,\nau même endroit'), findsOneWidget);
    expect(find.byKey(const Key('welcome_page_view')), findsOneWidget);
    expect(find.byKey(const Key('welcome_sign_in_button')), findsOneWidget);
    expect(find.byKey(const Key('welcome_invitation_button')), findsOneWidget);
    expect(find.text('Accès sur invitation'), findsOneWidget);
    expect(find.text('1/3'), findsOneWidget);
  });

  testWidgets('welcome can browse the onboarding pages', (tester) async {
    await _pumpWelcome(tester);

    await tester.tap(find.byKey(const Key('welcome_indicator_1')));
    await tester.pumpAndSettle();

    expect(find.text('Le pointage devient\nsimple et fiable'), findsOneWidget);
    expect(find.text('2/3'), findsOneWidget);

    await tester.tap(find.byKey(const Key('welcome_indicator_2')));
    await tester.pumpAndSettle();

    expect(find.text('Préparez vos échéances\navec confiance'), findsOneWidget);
    expect(find.text('3/3'), findsOneWidget);
  });

  testWidgets('welcome actions navigate to sign-in and invitation info', (
    tester,
  ) async {
    final router = await _pumpWelcome(tester);

    await tester.tap(find.byKey(const Key('welcome_sign_in_button')));
    await tester.pumpAndSettle();

    expect(router.routeInformationProvider.value.uri.path, AppRoute.auth.path);
    expect(find.text('AUTH_DESTINATION'), findsOneWidget);

    router.go(AppRoute.welcome.path);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('welcome_invitation_button')));
    await tester.pumpAndSettle();

    expect(
      router.routeInformationProvider.value.uri.path,
      AppRoute.register.path,
    );
    expect(find.text('REGISTER_DESTINATION'), findsOneWidget);
  });

  testWidgets('welcome remains usable on a compact mobile viewport', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await _pumpWelcome(tester);

    expect(tester.takeException(), isNull);
    expect(find.byKey(const Key('welcome_sign_in_button')), findsOneWidget);
    expect(find.byKey(const Key('welcome_invitation_button')), findsOneWidget);
  });
}

Future<GoRouter> _pumpWelcome(WidgetTester tester) async {
  final router = GoRouter(
    initialLocation: AppRoute.welcome.path,
    routes: [
      GoRoute(
        path: AppRoute.welcome.path,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoute.auth.path,
        builder: (context, state) =>
            const Scaffold(body: Text('AUTH_DESTINATION')),
      ),
      GoRoute(
        path: AppRoute.register.path,
        builder: (context, state) =>
            const Scaffold(body: Text('REGISTER_DESTINATION')),
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
