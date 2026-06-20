enum AppRoute {
  welcome('/'),
  auth('/auth'),
  register('/auth/register'),
  unauthorized('/unauthorized'),
  terminal('/terminal'),
  timeclock('/timeclock'),
  backofficeDashboard('/backoffice/dashboard'),
  employee('/employee'),
  manager('/manager'),
  hrAdmin('/hr-admin'),
  compliance('/compliance'),
  compliancePeriods('/compliance/periods'),
  complianceDeclarations('/compliance/declarations'),
  complianceGenerate('/compliance/declarations/generate'),
  complianceDeclarationDetail('/compliance/declarations/:declarationId'),
  complianceExport('/compliance/declarations/:declarationId/export'),
  complianceArchive('/compliance/archive');

  const AppRoute(this.path);

  final String path;
}
