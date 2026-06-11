import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/app/router/app_routes.dart';
import 'package:wiloo/app/router/compliance_route_guard.dart';
import 'package:wiloo/features/auth/domain/session_snapshot.dart';
import 'package:wiloo/features/auth/domain/user_role.dart';

SessionSnapshot _session(UserRole role) =>
    SessionSnapshot(isAuthenticated: true, role: role);

String? _redirect(String location, SessionSnapshot session) =>
    complianceRouteRedirect(location: location, session: session);

void main() {
  const guest = SessionSnapshot.guest();

  group('non-compliance routes', () {
    test('are never guarded', () {
      expect(_redirect(AppRoute.timeclock.path, guest), isNull);
      expect(
        _redirect(AppRoute.timeclock.path, _session(UserRole.admin)),
        isNull,
      );
    });
  });

  group('unauthenticated', () {
    test('redirects to auth on compliance routes', () {
      expect(_redirect(AppRoute.compliance.path, guest), AppRoute.auth.path);
      expect(
        _redirect(AppRoute.complianceGenerate.path, guest),
        AppRoute.auth.path,
      );
    });
  });

  group('admin', () {
    test('has full access', () {
      final session = _session(UserRole.admin);
      expect(_redirect(AppRoute.compliance.path, session), isNull);
      expect(_redirect(AppRoute.compliancePeriods.path, session), isNull);
      expect(_redirect(AppRoute.complianceDeclarations.path, session), isNull);
      expect(_redirect(AppRoute.complianceGenerate.path, session), isNull);
      expect(_redirect('/compliance/declarations/abc', session), isNull);
      expect(_redirect('/compliance/declarations/abc/export', session), isNull);
      expect(_redirect(AppRoute.complianceArchive.path, session), isNull);
    });
  });

  group('hr', () {
    test('has full access including write routes', () {
      final session = _session(UserRole.hr);
      expect(_redirect(AppRoute.complianceGenerate.path, session), isNull);
      expect(_redirect('/compliance/declarations/abc/export', session), isNull);
      expect(_redirect(AppRoute.complianceArchive.path, session), isNull);
    });
  });

  group('manager (read-only)', () {
    final session = _session(UserRole.manager);

    test('can access read routes', () {
      expect(_redirect(AppRoute.compliance.path, session), isNull);
      expect(_redirect(AppRoute.compliancePeriods.path, session), isNull);
      expect(_redirect(AppRoute.complianceDeclarations.path, session), isNull);
      expect(_redirect('/compliance/declarations/abc', session), isNull);
    });

    test('cannot generate, export or archive', () {
      expect(
        _redirect(AppRoute.complianceGenerate.path, session),
        AppRoute.unauthorized.path,
      );
      expect(
        _redirect('/compliance/declarations/abc/export', session),
        AppRoute.unauthorized.path,
      );
      expect(
        _redirect(AppRoute.complianceArchive.path, session),
        AppRoute.unauthorized.path,
      );
    });
  });

  group('no-access roles', () {
    test('employee, supervisor and time_terminal are unauthorized', () {
      for (final role in [
        UserRole.employee,
        UserRole.supervisor,
        UserRole.timeTerminal,
      ]) {
        expect(
          _redirect(AppRoute.compliance.path, _session(role)),
          AppRoute.unauthorized.path,
          reason: 'role ${role.apiValue} must be blocked',
        );
      }
    });
  });

  group('generate vs detail disambiguation', () {
    test('generate path is treated as a write route, not a detail id', () {
      // Manager may read details but must be blocked on generate.
      final session = _session(UserRole.manager);
      expect(
        _redirect('/compliance/declarations/generate', session),
        AppRoute.unauthorized.path,
      );
      expect(_redirect('/compliance/declarations/some-id', session), isNull);
    });
  });
}
