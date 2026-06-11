import '../entities/declaration_export.dart';
import '../entities/declaration_period.dart';
import '../entities/social_fiscal_declaration.dart';
import '../value_objects/compliance_requests.dart';
import '../value_objects/declaration_download_result.dart';

abstract interface class ComplianceRepository {
  Future<List<DeclarationPeriod>> getPeriods(ListDeclarationPeriodsQuery query);

  Future<DeclarationPeriod> createPeriod(
    CreateDeclarationPeriodRequest request,
  );

  Future<List<SocialFiscalDeclaration>> getDeclarations(
    ListDeclarationsQuery query,
  );

  Future<SocialFiscalDeclaration> generateDeclaration(
    GenerateDeclarationRequest request,
  );

  Future<SocialFiscalDeclaration> getDeclaration(String id);

  Future<SocialFiscalDeclaration> markReady(String id);

  Future<SocialFiscalDeclaration> validateDeclaration(String id);

  Future<DeclarationExport> exportDeclaration(
    String id,
    ExportDeclarationRequest request,
  );

  Future<DeclarationDownloadResult> downloadExport(String id, String exportId);

  Future<SocialFiscalDeclaration> markSubmitted(
    String id,
    MarkSubmittedDeclarationRequest request,
  );

  Future<SocialFiscalDeclaration> archiveDeclaration(
    String id,
    ArchiveDeclarationRequest request,
  );
}
