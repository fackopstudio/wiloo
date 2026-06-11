import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/core/error/failure.dart';
import 'package:wiloo/features/compliance/data/datasources/compliance_remote_data_source.dart';
import 'package:wiloo/features/compliance/data/dtos/archive_declaration_dto.dart';
import 'package:wiloo/features/compliance/data/dtos/create_declaration_period_dto.dart';
import 'package:wiloo/features/compliance/data/dtos/declaration_download_result_dto.dart';
import 'package:wiloo/features/compliance/data/dtos/declaration_export_dto.dart';
import 'package:wiloo/features/compliance/data/dtos/declaration_period_dto.dart';
import 'package:wiloo/features/compliance/data/dtos/export_declaration_dto.dart';
import 'package:wiloo/features/compliance/data/dtos/generate_declaration_dto.dart';
import 'package:wiloo/features/compliance/data/dtos/list_declaration_periods_query.dart';
import 'package:wiloo/features/compliance/data/dtos/list_declarations_query.dart';
import 'package:wiloo/features/compliance/data/dtos/mark_submitted_declaration_dto.dart';
import 'package:wiloo/features/compliance/data/dtos/social_fiscal_declaration_dto.dart';
import 'package:wiloo/features/compliance/data/repositories/compliance_repository_impl.dart';
import 'package:wiloo/features/compliance/domain/enums/declaration_status.dart';
import 'package:wiloo/features/compliance/domain/enums/declaration_type.dart';
import 'package:wiloo/features/compliance/domain/enums/export_format.dart';
import 'package:wiloo/features/compliance/domain/enums/period_type.dart';
import 'package:wiloo/features/compliance/domain/value_objects/compliance_requests.dart';

void main() {
  test('getPeriods maps datasource DTOs to domain models', () async {
    final repository = ComplianceRepositoryImpl(_FakeComplianceDataSource());

    final periods = await repository.getPeriods(
      const ListDeclarationPeriodsQuery(periodType: PeriodType.monthly),
    );

    expect(periods, hasLength(1));
    expect(periods.single.periodType, PeriodType.monthly);
    expect(periods.single.status, DeclarationStatus.draft);
  });

  test('generateDeclaration maps success response', () async {
    final repository = ComplianceRepositoryImpl(_FakeComplianceDataSource());

    final declaration = await repository.generateDeclaration(
      const GenerateDeclarationRequest(
        declarationPeriodId: 'period-1',
        type: DeclarationType.cnss,
      ),
    );

    expect(declaration.type, DeclarationType.cnss);
    expect(declaration.totalGrossSalary.displayValue, '1000');
  });

  test('propagates invalid transition Failure', () async {
    final repository = ComplianceRepositoryImpl(
      _FakeComplianceDataSource(
        failure: const Failure.invalidStateTransition(),
      ),
    );

    expect(
      () => repository.validateDeclaration('decl-1'),
      throwsA(
        isA<Failure>().having(
          (failure) => failure.type,
          'type',
          FailureType.invalidStateTransition,
        ),
      ),
    );
  });

  test('propagates forbidden Failure', () async {
    final repository = ComplianceRepositoryImpl(
      _FakeComplianceDataSource(failure: const Failure.forbidden()),
    );

    expect(
      () => repository.exportDeclaration(
        'decl-1',
        const ExportDeclarationRequest(format: ExportFormat.pdf),
      ),
      throwsA(
        isA<Failure>().having(
          (failure) => failure.type,
          'type',
          FailureType.forbidden,
        ),
      ),
    );
  });
}

class _FakeComplianceDataSource implements ComplianceRemoteDataSource {
  const _FakeComplianceDataSource({this.failure});

  final Failure? failure;

  void _throwIfNeeded() {
    final failure = this.failure;
    if (failure != null) {
      throw failure;
    }
  }

  @override
  Future<List<DeclarationPeriodDto>> getPeriods(
    ListDeclarationPeriodsQueryDto query,
  ) async {
    _throwIfNeeded();
    return [_periodDto];
  }

  @override
  Future<DeclarationPeriodDto> createPeriod(
    CreateDeclarationPeriodDto request,
  ) async {
    _throwIfNeeded();
    return _periodDto;
  }

  @override
  Future<List<SocialFiscalDeclarationDto>> getDeclarations(
    ListDeclarationsQueryDto query,
  ) async {
    _throwIfNeeded();
    return [_declarationDto];
  }

  @override
  Future<SocialFiscalDeclarationDto> generateDeclaration(
    GenerateDeclarationDto request,
  ) async {
    _throwIfNeeded();
    return _declarationDto;
  }

  @override
  Future<SocialFiscalDeclarationDto> getDeclaration(String id) async {
    _throwIfNeeded();
    return _declarationDto;
  }

  @override
  Future<SocialFiscalDeclarationDto> markReady(String id) async {
    _throwIfNeeded();
    return _declarationDto;
  }

  @override
  Future<SocialFiscalDeclarationDto> validateDeclaration(String id) async {
    _throwIfNeeded();
    return _declarationDto;
  }

  @override
  Future<DeclarationExportDto> exportDeclaration(
    String id,
    ExportDeclarationDto request,
  ) async {
    _throwIfNeeded();
    return const DeclarationExportDto(raw: {'id': 'export-1'});
  }

  @override
  Future<DeclarationDownloadResultDto> downloadExport(
    String id,
    String exportId,
  ) async {
    _throwIfNeeded();
    return const DeclarationDownloadResultDto(
      bytes: [1, 2, 3],
      fileName: 'export.pdf',
      contentType: 'application/pdf',
    );
  }

  @override
  Future<SocialFiscalDeclarationDto> markSubmitted(
    String id,
    MarkSubmittedDeclarationDto request,
  ) async {
    _throwIfNeeded();
    return _declarationDto;
  }

  @override
  Future<SocialFiscalDeclarationDto> archiveDeclaration(
    String id,
    ArchiveDeclarationDto request,
  ) async {
    _throwIfNeeded();
    return _declarationDto;
  }
}

const _periodDto = DeclarationPeriodDto(
  id: 'period-1',
  tenantId: 'tenant-1',
  periodType: 'MONTHLY',
  year: 2026,
  startDate: '2026-06-01T00:00:00.000Z',
  endDate: '2026-06-30T23:59:59.000Z',
  status: 'DRAFT',
  createdAt: '2026-06-01T00:00:00.000Z',
  updatedAt: '2026-06-01T00:00:00.000Z',
);

const _declarationDto = SocialFiscalDeclarationDto(
  id: 'decl-1',
  tenantId: 'tenant-1',
  declarationPeriodId: 'period-1',
  type: 'CNSS',
  status: 'DRAFT',
  totalGrossSalary: '1000',
  totalTaxableBase: '900',
  totalEmployeeContributions: '100',
  totalEmployerContributions: '150',
  totalWithholdings: '80',
  createdAt: '2026-06-01T00:00:00.000Z',
  updatedAt: '2026-06-01T00:00:00.000Z',
);
