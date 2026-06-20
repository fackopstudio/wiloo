import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/features/compliance/data/dtos/declaration_export_dto.dart';
import 'package:wiloo/features/compliance/data/dtos/declaration_line_dto.dart';
import 'package:wiloo/features/compliance/data/dtos/declaration_period_dto.dart';
import 'package:wiloo/features/compliance/data/dtos/social_fiscal_declaration_dto.dart';
import 'package:wiloo/features/compliance/data/mappers/compliance_mappers.dart';
import 'package:wiloo/features/compliance/domain/enums/declaration_status.dart';
import 'package:wiloo/features/compliance/domain/enums/declaration_type.dart';
import 'package:wiloo/features/compliance/domain/enums/export_format.dart';
import 'package:wiloo/features/compliance/domain/enums/period_type.dart';

void main() {
  test('maps declaration period dto to domain', () {
    final domain = const DeclarationPeriodDto(
      id: 'period-1',
      tenantId: 'tenant-1',
      periodType: 'MONTHLY',
      year: 2026,
      month: 6,
      startDate: '2026-06-01T00:00:00.000Z',
      endDate: '2026-06-30T23:59:59.000Z',
      status: 'READY_TO_REVIEW',
      createdAt: '2026-06-01T00:00:00.000Z',
      updatedAt: '2026-06-02T00:00:00.000Z',
    ).toDomain();

    expect(domain.periodType, PeriodType.monthly);
    expect(domain.status, DeclarationStatus.readyToReview);
    expect(domain.month, 6);
  });

  test('maps declaration dto to domain without calculating money values', () {
    final domain = const SocialFiscalDeclarationDto(
      id: 'decl-1',
      tenantId: 'tenant-1',
      declarationPeriodId: 'period-1',
      type: 'IRPP',
      status: 'VALIDATED',
      totalGrossSalary: '100.40',
      totalTaxableBase: '80.30',
      totalEmployeeContributions: '10.20',
      totalEmployerContributions: '15.10',
      totalWithholdings: '8.00',
      createdAt: '2026-06-01T00:00:00.000Z',
      updatedAt: '2026-06-02T00:00:00.000Z',
    ).toDomain();

    expect(domain.type, DeclarationType.irpp);
    expect(domain.status, DeclarationStatus.validated);
    expect(domain.totalGrossSalary.displayValue, '100.40');
    expect(domain.totalTaxableBase.displayValue, '80.30');
  });

  test('maps confirmed declaration line fields to domain while keeping raw', () {
    final domain = DeclarationLineDto.fromJson({
      'id': 'line-1',
      'declarationId': 'decl-1',
      'employeeId': 'employee-1',
      'grossSalary': '450000.00',
      'taxableSalary': '450000.00',
      'warnings': ['missing field'],
      'createdAt': '2026-06-16T02:28:49.528Z',
      'updatedAt': '2026-06-16T02:28:49.528Z',
    }).toDomain();

    expect(domain.id, 'line-1');
    expect(domain.employeeId, 'employee-1');
    expect(domain.grossSalary?.displayValue, '450000.00');
    expect(domain.taxableSalary?.displayValue, '450000.00');
    expect(domain.warnings, ['missing field']);
    expect(domain.raw['declarationId'], 'decl-1');
  });

  test('maps confirmed export fields from composite payload to domain', () {
    final domain = DeclarationExportDto.fromJson({
      'declaration': {'id': 'decl-1'},
      'export': {
        'id': 'export-1',
        'declarationId': 'decl-1',
        'format': 'CSV',
        'fileName': 'file.csv',
        'storageKey': 'storage/file.csv',
        'checksum': 'checksum',
        'generatedBy': 'user-1',
        'generatedAt': '2026-06-16T02:28:49.615Z',
        'status': 'GENERATED',
      },
      'download': {'exportId': 'export-1'},
    }).toDomain();

    expect(domain.id, 'export-1');
    expect(domain.declarationId, 'decl-1');
    expect(domain.format, ExportFormat.csv);
    expect(domain.fileName, 'file.csv');
    expect(domain.generatedAt, DateTime.parse('2026-06-16T02:28:49.615Z'));
    expect(domain.raw['download'], isA<Map<String, Object?>>());
  });
}
