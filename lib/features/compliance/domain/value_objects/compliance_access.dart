import '../../../auth/domain/user_role.dart';

class ComplianceAccess {
  const ComplianceAccess({
    required this.canView,
    required this.canCreatePeriod,
    required this.canGenerate,
    required this.canMarkReady,
    required this.canValidate,
    required this.canExport,
    required this.canDownloadExport,
    required this.canMarkSubmitted,
    required this.canArchive,
  });

  const ComplianceAccess.none()
    : canView = false,
      canCreatePeriod = false,
      canGenerate = false,
      canMarkReady = false,
      canValidate = false,
      canExport = false,
      canDownloadExport = false,
      canMarkSubmitted = false,
      canArchive = false;

  const ComplianceAccess.readOnly()
    : canView = true,
      canCreatePeriod = false,
      canGenerate = false,
      canMarkReady = false,
      canValidate = false,
      canExport = false,
      canDownloadExport = false,
      canMarkSubmitted = false,
      canArchive = false;

  const ComplianceAccess.readWrite()
    : canView = true,
      canCreatePeriod = true,
      canGenerate = true,
      canMarkReady = true,
      canValidate = true,
      canExport = true,
      canDownloadExport = true,
      canMarkSubmitted = true,
      canArchive = true;

  /// Maps a backend role to its Compliance capabilities.
  ///
  /// This mirrors backend RBAC for UX/display guards only. The backend remains
  /// the source of truth and re-enforces access on every request.
  factory ComplianceAccess.forRole(UserRole? role) {
    switch (role) {
      case UserRole.admin:
      case UserRole.hr:
        return const ComplianceAccess.readWrite();
      case UserRole.manager:
        return const ComplianceAccess.readOnly();
      case UserRole.employee:
      case UserRole.supervisor:
      case UserRole.timeTerminal:
      case null:
        return const ComplianceAccess.none();
    }
  }

  final bool canView;
  final bool canCreatePeriod;
  final bool canGenerate;
  final bool canMarkReady;
  final bool canValidate;
  final bool canExport;
  final bool canDownloadExport;
  final bool canMarkSubmitted;
  final bool canArchive;

  bool get isReadOnly => canView && !canGenerate;
}
