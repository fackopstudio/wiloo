import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/features/compliance/data/dtos/declaration_line_dto.dart';
import 'package:wiloo/features/compliance/data/dtos/social_fiscal_declaration_dto.dart';

void main() {
  test(
    'parses social fiscal declaration dto with string and numeric amounts',
    () {
      final dto = SocialFiscalDeclarationDto.fromJson({
        'id': 'decl-1',
        'tenantId': 'tenant-1',
        'companyId': null,
        'declarationPeriodId': 'period-1',
        'type': 'CNSS',
        'status': 'DRAFT',
        'ruleSetId': null,
        'totalGrossSalary': '1250000.50',
        'totalTaxableBase': 1000000,
        'totalEmployeeContributions': '12000',
        'totalEmployerContributions': '18000',
        'totalWithholdings': '9000',
        'warnings': ['missing employee snapshot'],
        'metadata': {'source': 'test'},
        'validatedBy': null,
        'validatedAt': null,
        'exportedAt': null,
        'submittedManuallyAt': null,
        'lines': [
          {'backendOnly': true},
        ],
        'exports': [
          {'id': 'export-1'},
        ],
        'attachments': [
          {'id': 'attachment-1'},
        ],
        'createdAt': '2026-06-01T00:00:00.000Z',
        'updatedAt': '2026-06-01T00:00:00.000Z',
      });

      expect(dto.type, 'CNSS');
      expect(dto.totalGrossSalary, '1250000.50');
      expect(dto.totalTaxableBase, 1000000);
      expect(dto.lines, hasLength(1));
      expect(dto.lines!.single.raw['backendOnly'], true);
    },
  );

  test('keeps unresolved declaration line dto as raw backend snapshot', () {
    final dto = DeclarationLineDto.fromJson({
      'code': 'CNSS_EMPLOYEE',
      'amount': '2500',
    });

    expect(dto.raw['code'], 'CNSS_EMPLOYEE');
    expect(dto.raw['amount'], '2500');
  });
}
