import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/app/router/app_redirect.dart';
import 'package:wiloo/app/router/app_routes.dart';
import 'package:wiloo/core/config/app_mode.dart';
import 'package:wiloo/features/auth/domain/auth_user.dart';
import 'package:wiloo/features/auth/domain/session_snapshot.dart';
import 'package:wiloo/features/auth/domain/user_role.dart';

void main() {
  group('resolveAppRedirect - backoffice mode', () {
    test('unauthenticated user on welcome stays on welcome', () {
      final redirect = resolveAppRedirect(
        location: AppRoute.welcome.path,
        session: const SessionSnapshot.guest(),
        mode: AppMode.backoffice,
      );

      expect(redirect, isNull);
    });

    test('unauthenticated user on a compliance route is sent to /auth', () {
      final redirect = resolveAppRedirect(
        location: AppRoute.compliance.path,
        session: const SessionSnapshot.guest(),
        mode: AppMode.backoffice,
      );

      expect(redirect, AppRoute.auth.path);
    });

    test('unauthenticated user on /auth stays on /auth', () {
      final redirect = resolveAppRedirect(
        location: AppRoute.auth.path,
        session: const SessionSnapshot.guest(),
        mode: AppMode.backoffice,
      );

      expect(redirect, isNull);
    });

    test('unauthenticated user on /auth/register stays on register', () {
      final redirect = resolveAppRedirect(
        location: AppRoute.register.path,
        session: const SessionSnapshot.guest(),
        mode: AppMode.backoffice,
      );

      expect(redirect, isNull);
    });

    test(
      'authenticated admin/hr leaving /auth land on the backoffice dashboard',
      () {
        for (final role in [UserRole.admin, UserRole.hr]) {
          final redirect = resolveAppRedirect(
            location: AppRoute.auth.path,
            session: _authed(role),
            mode: AppMode.backoffice,
          );

          expect(redirect, AppRoute.backofficeDashboard.path);
        }
      },
    );

    test(
      'authenticated user leaving welcome lands on backoffice dashboard',
      () {
        final redirect = resolveAppRedirect(
          location: AppRoute.welcome.path,
          session: _authed(UserRole.manager),
          mode: AppMode.backoffice,
        );

        expect(redirect, AppRoute.backofficeDashboard.path);
      },
    );

    test(
      'authenticated admin/hr leaving register land on backoffice dashboard',
      () {
        for (final role in [UserRole.admin, UserRole.hr]) {
          final redirect = resolveAppRedirect(
            location: AppRoute.register.path,
            session: _authed(role),
            mode: AppMode.backoffice,
          );

          expect(redirect, AppRoute.backofficeDashboard.path);
        }
      },
    );

    test(
      'unauthenticated user on a protected backoffice route goes to /auth',
      () {
        final redirect = resolveAppRedirect(
          location: AppRoute.backofficeDashboard.path,
          session: const SessionSnapshot.guest(),
          mode: AppMode.backoffice,
        );

        expect(redirect, AppRoute.auth.path);
      },
    );

    test('admin and hr may reach the compliance dashboard', () {
      for (final role in [UserRole.admin, UserRole.hr]) {
        final redirect = resolveAppRedirect(
          location: AppRoute.compliance.path,
          session: _authed(role),
          mode: AppMode.backoffice,
        );

        expect(redirect, isNull);
      }
    });

    test('manager may reach compliance read routes but not generate', () {
      expect(
        resolveAppRedirect(
          location: AppRoute.compliance.path,
          session: _authed(UserRole.manager),
          mode: AppMode.backoffice,
        ),
        isNull,
      );

      expect(
        resolveAppRedirect(
          location: AppRoute.complianceGenerate.path,
          session: _authed(UserRole.manager),
          mode: AppMode.backoffice,
        ),
        AppRoute.unauthorized.path,
      );
    });

    test('employee is denied access to compliance', () {
      final redirect = resolveAppRedirect(
        location: AppRoute.compliance.path,
        session: _authed(UserRole.employee),
        mode: AppMode.backoffice,
      );

      expect(redirect, AppRoute.unauthorized.path);
    });
  });

  group('resolveAppRedirect - terminal mode', () {
    test('compliance routes are redirected to /terminal', () {
      final redirect = resolveAppRedirect(
        location: AppRoute.compliance.path,
        session: const SessionSnapshot.guest(),
        mode: AppMode.terminal,
      );

      expect(redirect, AppRoute.terminal.path);
    });

    test('terminal route is allowed without a backoffice login', () {
      final redirect = resolveAppRedirect(
        location: AppRoute.terminal.path,
        session: const SessionSnapshot.guest(),
        mode: AppMode.terminal,
      );

      expect(redirect, isNull);
    });
  });

  group('postLoginLocation', () {
    test('terminal sessions land on /terminal', () {
      expect(
        postLoginLocation(_authed(UserRole.timeTerminal)),
        AppRoute.terminal.path,
      );
    });

    test('backoffice roles land on the backoffice dashboard', () {
      for (final role in [
        UserRole.admin,
        UserRole.hr,
        UserRole.manager,
        UserRole.supervisor,
        UserRole.employee,
      ]) {
        expect(
          postLoginLocation(_authed(role)),
          AppRoute.backofficeDashboard.path,
        );
      }
    });
  });
}

SessionSnapshot _authed(UserRole role) => SessionSnapshot(
  isAuthenticated: true,
  user: AuthUser(id: 'u1', email: '${role.apiValue}@b.com', role: role),
  role: role,
);
