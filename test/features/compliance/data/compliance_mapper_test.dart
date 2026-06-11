import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/features/compliance/data/dtos/declaration_period_dto.dart';
import 'package:wiloo/features/compliance/data/dtos/social_fiscal_declaration_dto.dart';
import 'package:wiloo/features/compliance/data/mappers/compliance_mappers.dart';
import 'package:wiloo/features/compliance/domain/enums/declaration_status.dart';
import 'package:wiloo/features/compliance/domain/enums/declaration_type.dart';
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
}
