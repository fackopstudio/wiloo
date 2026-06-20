import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/config/app_config.dart';
import '../../core/config/app_mode.dart';
import '../../features/auth/application/session_controller.dart';
import '../../features/auth/domain/session_snapshot.dart';
import '../../features/auth/presentation/auth_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/presentation/unauthorized_screen.dart';
import '../../features/backoffice/presentation/backoffice_dashboard_page.dart';
import '../../features/compliance/presentation/pages/compliance_dashboard_page.dart';
import '../../features/compliance/presentation/pages/declaration_archive_page.dart';
import '../../features/compliance/presentation/pages/declaration_detail_page.dart';
import '../../features/compliance/presentation/pages/declaration_export_page.dart';
import '../../features/compliance/presentation/pages/declaration_generate_page.dart';
import '../../features/compliance/presentation/pages/declaration_list_page.dart';
import '../../features/compliance/presentation/pages/declaration_periods_page.dart';
import '../../features/employee/presentation/employee_home_screen.dart';
import '../../features/hr_admin/presentation/hr_admin_home_screen.dart';
import '../../features/manager/presentation/manager_home_screen.dart';
import '../../features/onboarding/presentation/welcome_screen.dart';
import '../../features/timeclock/presentation/timeclock_home_screen.dart';
import '../shell/backoffice_shell.dart';
import 'app_redirect.dart';
import 'app_routes.dart';

/// Active runtime mode. Defaults to [AppConfig.appMode] (backoffice) and can be
/// overridden in tests to exercise the terminal/kiosk startup flow.
final appModeProvider = Provider<AppMode>((ref) => AppConfig.appMode);

final appRouterProvider = Provider<GoRouter>((ref) {
  final mode = ref.watch(appModeProvider);

  // Bridges Riverpod session changes to go_router so login/logout/expiry all
  // refresh redirects. Redirect logic stays centralized here (never in widgets).
  final refreshSignal = ValueNotifier<int>(0);
  ref.listen<SessionSnapshot>(sessionControllerProvider, (previous, next) {
    refreshSignal.value++;
  });
  ref.onDispose(refreshSignal.dispose);

  return GoRouter(
    initialLocation: mode == AppMode.terminal
        ? AppRoute.terminal.path
        : AppRoute.welcome.path,
    refreshListenable: refreshSignal,
    redirect: (context, state) {
      final session = ref.read(sessionControllerProvider);
      return resolveAppRedirect(
        location: state.uri.path,
        session: session,
        mode: mode,
      );
    },
    routes: [
      GoRoute(
        path: AppRoute.welcome.path,
        name: AppRoute.welcome.name,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoute.auth.path,
        name: AppRoute.auth.name,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: AppRoute.register.path,
        name: AppRoute.register.name,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoute.unauthorized.path,
        name: AppRoute.unauthorized.name,
        builder: (context, state) => const UnauthorizedScreen(),
      ),
      GoRoute(
        path: AppRoute.terminal.path,
        name: AppRoute.terminal.name,
        builder: (context, state) => const TimeclockHomeScreen(),
      ),
      GoRoute(
        path: AppRoute.timeclock.path,
        name: AppRoute.timeclock.name,
        builder: (context, state) => const TimeclockHomeScreen(),
      ),
      GoRoute(
        path: AppRoute.employee.path,
        name: AppRoute.employee.name,
        builder: (context, state) => const EmployeeHomeScreen(),
      ),
      GoRoute(
        path: AppRoute.manager.path,
        name: AppRoute.manager.name,
        builder: (context, state) => const ManagerHomeScreen(),
      ),
      GoRoute(
        path: AppRoute.hrAdmin.path,
        name: AppRoute.hrAdmin.name,
        builder: (context, state) => const HrAdminHomeScreen(),
      ),
      // Authenticated backoffice landing wrapped in the shared shell.
      ShellRoute(
        builder: (context, state, child) =>
            BackofficeShell(location: state.uri.path, child: child),
        routes: [
          GoRoute(
            path: AppRoute.backofficeDashboard.path,
            name: AppRoute.backofficeDashboard.name,
            builder: (context, state) => const BackofficeDashboardPage(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoute.compliance.path,
        name: AppRoute.compliance.name,
        builder: (context, state) => const ComplianceDashboardPage(),
      ),
      GoRoute(
        path: AppRoute.compliancePeriods.path,
        name: AppRoute.compliancePeriods.name,
        builder: (context, state) => const DeclarationPeriodsPage(),
      ),
      GoRoute(
        path: AppRoute.complianceDeclarations.path,
        name: AppRoute.complianceDeclarations.name,
        builder: (context, state) => const DeclarationListPage(),
      ),
      // Declared before the ":declarationId" route so that "generate" is not
      // matched as a declaration id.
      GoRoute(
        path: AppRoute.complianceGenerate.path,
        name: AppRoute.complianceGenerate.name,
        builder: (context, state) => const DeclarationGeneratePage(),
      ),
      GoRoute(
        path: AppRoute.complianceDeclarationDetail.path,
        name: AppRoute.complianceDeclarationDetail.name,
        builder: (context, state) => DeclarationDetailPage(
          declarationId: state.pathParameters['declarationId']!,
        ),
      ),
      GoRoute(
        path: AppRoute.complianceExport.path,
        name: AppRoute.complianceExport.name,
        builder: (context, state) => DeclarationExportPage(
          declarationId: state.pathParameters['declarationId']!,
        ),
      ),
      GoRoute(
        path: AppRoute.complianceArchive.path,
        name: AppRoute.complianceArchive.name,
        builder: (context, state) => const DeclarationArchivePage(),
      ),
    ],
  );
});
