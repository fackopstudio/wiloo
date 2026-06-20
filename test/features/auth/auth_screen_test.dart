import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/core/auth/auth_core_providers.dart';
import 'package:wiloo/core/error/failure.dart';
import 'package:wiloo/features/auth/application/session_controller.dart';
import 'package:wiloo/features/auth/domain/auth_repository.dart';
import 'package:wiloo/features/auth/domain/auth_user.dart';
import 'package:wiloo/features/auth/domain/session_snapshot.dart';
import 'package:wiloo/features/auth/domain/user_role.dart';
import 'package:wiloo/features/auth/presentation/auth_screen.dart';

import '../../support/in_memory_token_store.dart';

void main() {
  group('AuthScreen', () {
    testWidgets('renders email/password fields and submit button', (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(repository: _FakeAuthRepository()));

      expect(find.text('Connexion Wiloo'), findsOneWidget);
      expect(find.byKey(const Key('auth_email_field')), findsOneWidget);
      expect(find.byKey(const Key('auth_password_field')), findsOneWidget);
      expect(find.byKey(const Key('auth_submit_button')), findsOneWidget);
      expect(find.text('Se connecter'), findsOneWidget);
    });

    testWidgets('empty email/password validation blocks submit', (
      tester,
    ) async {
      final repository = _FakeAuthRepository();
      await tester.pumpWidget(_testApp(repository: repository));

      await tester.tap(find.byKey(const Key('auth_submit_button')));
      await tester.pump();

      expect(find.text('Veuillez saisir votre email.'), findsOneWidget);
      expect(find.text('Veuillez saisir votre mot de passe.'), findsOneWidget);
      expect(repository.signInCalls, 0);
    });

    testWidgets('invalid email validation blocks submit', (tester) async {
      final repository = _FakeAuthRepository();
      await tester.pumpWidget(_testApp(repository: repository));

      await tester.enterText(
        find.byKey(const Key('auth_email_field')),
        'not-an-email',
      );
      await tester.enterText(
        find.byKey(const Key('auth_password_field')),
        'secret-password',
      );
      await tester.tap(find.byKey(const Key('auth_submit_button')));
      await tester.pump();

      expect(find.text('Veuillez saisir un email valide.'), findsOneWidget);
      expect(repository.signInCalls, 0);
    });

    testWidgets('successful login calls SessionManager and updates session', (
      tester,
    ) async {
      final repository = _FakeAuthRepository(signIn: _adminSnapshot);
      final container = _container(repository);
      addTearDown(container.dispose);

      await tester.pumpWidget(_testApp(container: container));
      await tester.enterText(
        find.byKey(const Key('auth_email_field')),
        'admin@wiloo.test',
      );
      await tester.enterText(
        find.byKey(const Key('auth_password_field')),
        'secret-password',
      );
      await tester.tap(find.byKey(const Key('auth_submit_button')));
      await tester.pumpAndSettle();

      expect(repository.signInCalls, 1);
      expect(repository.lastEmail, 'admin@wiloo.test');
      expect(repository.lastPassword, 'secret-password');
      expect(container.read(sessionControllerProvider).isAuthenticated, isTrue);
      expect(container.read(sessionControllerProvider).role, UserRole.admin);
    });

    testWidgets('failed login displays a friendly error', (tester) async {
      final repository = _FakeAuthRepository(
        signInError: const Failure.unauthorized(),
      );

      await tester.pumpWidget(_testApp(repository: repository));
      await tester.enterText(
        find.byKey(const Key('auth_email_field')),
        'admin@wiloo.test',
      );
      await tester.enterText(
        find.byKey(const Key('auth_password_field')),
        'wrong-password',
      );
      await tester.tap(find.byKey(const Key('auth_submit_button')));
      await tester.pumpAndSettle();

      expect(find.text('Email ou mot de passe invalide.'), findsOneWidget);
    });

    testWidgets('loading state disables submit without exposing password', (
      tester,
    ) async {
      final completer = Completer<SessionSnapshot>();
      final repository = _FakeAuthRepository(signInCompleter: completer);

      await tester.pumpWidget(_testApp(repository: repository));
      await tester.enterText(
        find.byKey(const Key('auth_email_field')),
        'admin@wiloo.test',
      );
      await tester.enterText(
        find.byKey(const Key('auth_password_field')),
        'super-secret-password',
      );
      await tester.tap(find.byKey(const Key('auth_submit_button')));
      await tester.pump();

      final button = tester.widget<FilledButton>(
        find.byKey(const Key('auth_submit_button')),
      );
      expect(button.onPressed, isNull);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(
        tester.widget<EditableText>(find.byType(EditableText).last).obscureText,
        isTrue,
      );
      expect(find.textContaining('super-secret-password'), findsOneWidget);
      expect(find.text('Email ou mot de passe invalide.'), findsNothing);

      completer.complete(_adminSnapshot);
      await tester.pumpAndSettle();
    });

    testWidgets('password visibility toggle is available', (tester) async {
      await tester.pumpWidget(_testApp(repository: _FakeAuthRepository()));

      expect(
        find.byKey(const Key('auth_password_visibility_toggle')),
        findsOneWidget,
      );
    });

    testWidgets('shows invitation access instead of public signup', (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(repository: _FakeAuthRepository()));

      expect(find.byKey(const Key('auth_invitation_link')), findsOneWidget);
      expect(find.text('Accès sur invitation'), findsOneWidget);
      expect(find.text('Créer un compte Wiloo'), findsNothing);
    });
  });
}

Widget _testApp({
  _FakeAuthRepository? repository,
  ProviderContainer? container,
}) {
  final effectiveContainer = container ?? _container(repository!);
  return UncontrolledProviderScope(
    container: effectiveContainer,
    child: const MaterialApp(home: AuthScreen()),
  );
}

ProviderContainer _container(_FakeAuthRepository repository) {
  return ProviderContainer(
    overrides: [
      sessionTokenStoreProvider.overrideWithValue(InMemoryTokenStore()),
      authRepositoryProvider.overrideWithValue(repository),
    ],
  );
}

const _adminSnapshot = SessionSnapshot(
  isAuthenticated: true,
  user: AuthUser(id: 'u1', email: 'admin@wiloo.test', role: UserRole.admin),
  role: UserRole.admin,
);

class _FakeAuthRepository implements AuthRepository {
  _FakeAuthRepository({
    SessionSnapshot? bootstrap,
    SessionSnapshot? signIn,
    this.signInError,
    this.signInCompleter,
  }) : bootstrap = bootstrap ?? const SessionSnapshot.guest(),
       signInSnapshot = signIn ?? const SessionSnapshot.guest();

  final SessionSnapshot bootstrap;
  final SessionSnapshot signInSnapshot;
  final Object? signInError;
  final Completer<SessionSnapshot>? signInCompleter;

  int signInCalls = 0;
  String? lastEmail;
  String? lastPassword;

  @override
  Future<SessionSnapshot> bootstrapSession() async => bootstrap;

  @override
  Future<SessionSnapshot> getCurrentSession() async => bootstrap;

  @override
  Future<SessionSnapshot> signIn(String email, String password) async {
    signInCalls++;
    lastEmail = email;
    lastPassword = password;

    if (signInError != null) {
      throw signInError!;
    }
    if (signInCompleter != null) {
      return signInCompleter!.future;
    }
    return signInSnapshot;
  }

  @override
  Future<void> logout() async {}
}
