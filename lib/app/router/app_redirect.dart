import '../../core/config/app_mode.dart';
import '../../features/auth/domain/session_snapshot.dart';
import '../../features/auth/domain/user_role.dart';
import 'app_routes.dart';
import 'compliance_route_guard.dart';

/// Centralized, mode-aware navigation guard for the app shell.
///
/// Redirect logic stays here (never inside widgets) and reacts to the active
/// [AppMode] plus the centralized [SessionSnapshot]. Returns the redirect path,
/// or `null` when the current navigation is allowed.
String? resolveAppRedirect({
  required String location,
  required SessionSnapshot session,
  required AppMode mode,
}) {
  if (mode == AppMode.terminal) {
    // Kiosk/terminal mode never exposes the backoffice Compliance branch and
    // does not require a backoffice login.
    if (_isComplianceLocation(location)) {
      return AppRoute.terminal.path;
    }
    return null;
  }

  // Backoffice mode.
  if (_isGuestEntryLocation(location) && session.isAuthenticated) {
    return postLoginLocation(session);
  }

  // Protected backoffice landing routes require authentication. Compliance
  // routes keep their own RBAC handling below.
  if (!session.isAuthenticated && _isProtectedBackofficeLocation(location)) {
    return AppRoute.auth.path;
  }

  return complianceRouteRedirect(location: location, session: session);
}

/// Landing route for an authenticated session, based on role/scope.
String postLoginLocation(SessionSnapshot session) {
  if (session.isTerminalSession) {
    return AppRoute.terminal.path;
  }

  return switch (session.role) {
    UserRole.timeTerminal => AppRoute.terminal.path,
    // All backoffice roles land in the shell-backed dashboard, which exposes
    // the modules each role may reach (Compliance for admin/hr/manager).
    UserRole.admin ||
    UserRole.hr ||
    UserRole.manager ||
    UserRole.supervisor ||
    UserRole.employee ||
    null => AppRoute.backofficeDashboard.path,
  };
}

bool _isComplianceLocation(String location) {
  return location == AppRoute.compliance.path ||
      location.startsWith('${AppRoute.compliance.path}/');
}

bool _isGuestEntryLocation(String location) {
  return location == AppRoute.welcome.path ||
      location == AppRoute.auth.path ||
      location == AppRoute.register.path;
}

bool _isProtectedBackofficeLocation(String location) {
  return location == AppRoute.backofficeDashboard.path ||
      location == AppRoute.hrAdmin.path ||
      location == AppRoute.manager.path ||
      location == AppRoute.employee.path;
}
