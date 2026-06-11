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
