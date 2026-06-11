import '../../features/auth/domain/session_snapshot.dart';
import '../../features/compliance/domain/value_objects/compliance_access.dart';
import 'app_routes.dart';

/// Centralized, UX-only route guard for the Compliance branch.
///
/// The backend remains the source of truth for authorization. This guard only
/// decides client-side navigation based on the centralized session/role model.
///
/// Returns the redirect path, or `null` when navigation is allowed.
String? complianceRouteRedirect({
  required String location,
  required SessionSnapshot session,
}) {
  if (!_isComplianceLocation(location)) {
    return null;
  }

  if (!session.isAuthenticated) {
    // Unauthenticated users follow the session redirect rules.
    return AppRoute.auth.path;
  }

  final access = ComplianceAccess.forRole(session.role);

  if (!access.canView) {
    return AppRoute.unauthorized.path;
  }

  if (_isGenerateLocation(location)) {
    return access.canGenerate ? null : AppRoute.unauthorized.path;
  }

  if (_isExportLocation(location)) {
    return access.canExport ? null : AppRoute.unauthorized.path;
  }

  if (_isArchiveLocation(location)) {
    return access.canArchive ? null : AppRoute.unauthorized.path;
  }

  // Dashboard, periods, declarations and detail are read routes.
  return null;
}

bool _isComplianceLocation(String location) {
  return location == AppRoute.compliance.path ||
      location.startsWith('${AppRoute.compliance.path}/');
}

bool _isGenerateLocation(String location) {
  return location == AppRoute.complianceGenerate.path;
}

bool _isArchiveLocation(String location) {
  return location == AppRoute.complianceArchive.path;
}

final _exportLocationPattern = RegExp(
  r'^/compliance/declarations/[^/]+/export$',
);

bool _isExportLocation(String location) {
  return _exportLocationPattern.hasMatch(location);
}
