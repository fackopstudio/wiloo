import '../../domain/entities/declaration_export.dart';
import '../../domain/entities/declaration_period.dart';
import '../../domain/entities/social_fiscal_declaration.dart';
import '../../domain/repositories/compliance_repository.dart';
import '../../domain/value_objects/compliance_requests.dart';
import '../../domain/value_objects/declaration_download_result.dart';
import '../datasources/compliance_remote_data_source.dart';
import '../mappers/compliance_mappers.dart';

class ComplianceRepositoryImpl implements ComplianceRepository {
  const ComplianceRepositoryImpl(this._remoteDataSource);

  final ComplianceRemoteDataSource _remoteDataSource;

  @override
  Future<List<DeclarationPeriod>> getPeriods(
    ListDeclarationPeriodsQuery query,
  ) async {
    final periods = await _remoteDataSource.getPeriods(query.toDto());
    return periods.map((period) => period.toDomain()).toList();
  }

  @override
  Future<DeclarationPeriod> createPeriod(
    CreateDeclarationPeriodRequest request,
  ) async {
    final period = await _remoteDataSource.createPeriod(request.toDto());
    return period.toDomain();
  }

  @override
  Future<List<SocialFiscalDeclaration>> getDeclarations(
    ListDeclarationsQuery query,
  ) async {
    final declarations = await _remoteDataSource.getDeclarations(query.toDto());
    return declarations.map((declaration) => declaration.toDomain()).toList();
  }

  @override
  Future<SocialFiscalDeclaration> generateDeclaration(
    GenerateDeclarationRequest request,
  ) async {
    final declaration = await _remoteDataSource.generateDeclaration(
      request.toDto(),
    );
    return declaration.toDomain();
  }

  @override
  Future<SocialFiscalDeclaration> getDeclaration(String id) async {
    final declaration = await _remoteDataSource.getDeclaration(id);
    return declaration.toDomain();
  }

  @override
  Future<SocialFiscalDeclaration> markReady(String id) async {
    final declaration = await _remoteDataSource.markReady(id);
    return declaration.toDomain();
  }

  @override
  Future<SocialFiscalDeclaration> validateDeclaration(String id) async {
    final declaration = await _remoteDataSource.validateDeclaration(id);
    return declaration.toDomain();
  }

  @override
  Future<DeclarationExport> exportDeclaration(
    String id,
    ExportDeclarationRequest request,
  ) async {
    final export = await _remoteDataSource.exportDeclaration(
      id,
      request.toDto(),
    );
    return export.toDomain();
  }

  @override
  Future<DeclarationDownloadResult> downloadExport(
    String id,
    String exportId,
  ) async {
    final result = await _remoteDataSource.downloadExport(id, exportId);
    return result.toDomain();
  }

  @override
  Future<SocialFiscalDeclaration> markSubmitted(
    String id,
    MarkSubmittedDeclarationRequest request,
  ) async {
    final declaration = await _remoteDataSource.markSubmitted(
      id,
      request.toDto(),
    );
    return declaration.toDomain();
  }

  @override
  Future<SocialFiscalDeclaration> archiveDeclaration(
    String id,
    ArchiveDeclarationRequest request,
  ) async {
    final declaration = await _remoteDataSource.archiveDeclaration(
      id,
      request.toDto(),
    );
    return declaration.toDomain();
  }
}
