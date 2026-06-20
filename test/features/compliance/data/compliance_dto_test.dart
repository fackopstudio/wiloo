import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/features/compliance/data/dtos/declaration_export_dto.dart';
import 'package:wiloo/features/compliance/data/dtos/declaration_line_dto.dart';
import 'package:wiloo/features/compliance/data/dtos/mark_submitted_declaration_dto.dart';
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

  test('parses runtime-confirmed declaration line fields and keeps raw', () {
    final dto = DeclarationLineDto.fromJson({
      'id': 'line-1',
      'declarationId': 'decl-1',
      'employeeId': 'employee-1',
      'payrollId': 'payroll-1',
      'userId': 'user-1',
      'employeeSnapshot': {'name': 'Smoke Admin'},
      'contractSnapshot': {'salary': '450000.00'},
      'grossSalary': '450000.00',
      'taxableSalary': '450000.00',
      'socialContributionBase': '450000.00',
      'employeeContributionAmount': '0.00',
      'employerContributionAmount': '0.00',
      'withholdingAmount': '0.00',
      'deductionsSnapshot': {'socialCharges': 25000},
      'calculationDetails': {'officialSubmission': false},
      'warnings': ['warning'],
      'createdAt': '2026-06-16T02:28:49.528Z',
      'updatedAt': '2026-06-16T02:28:49.528Z',
    });

    expect(dto.id, 'line-1');
    expect(dto.employeeSnapshot?['name'], 'Smoke Admin');
    expect(dto.grossSalary, '450000.00');
    expect(dto.warnings, ['warning']);
    expect(dto.raw['employeeId'], 'employee-1');
  });

  test('parses composite export payload and keeps raw', () {
    final dto = DeclarationExportDto.fromJson({
      'declaration': {'id': 'decl-1'},
      'export': {
        'id': 'export-1',
        'declarationId': 'decl-1',
        'format': 'PDF',
        'fileName': 'CNSS_preparatory_summary_2026_10.pdf',
        'storageKey': 'smoke-tenant/decl-1/export-1.pdf',
        'checksum': 'checksum',
        'generatedBy': 'user-1',
        'generatedAt': '2026-06-16T02:28:49.615Z',
        'status': 'GENERATED',
      },
      'download': {
        'exportId': 'export-1',
        'fileName': 'CNSS_preparatory_summary_2026_10.pdf',
        'mimeType': 'application/pdf',
      },
    });

    expect(dto.id, 'export-1');
    expect(dto.format, 'PDF');
    expect(dto.fileName, 'CNSS_preparatory_summary_2026_10.pdf');
    expect(dto.raw['download'], isA<Map<String, Object?>>());
  });

  test('serializes typed nested DTOs back to their raw backend snapshot', () {
    final line = DeclarationLineDto.fromJson({
      'id': 'line-1',
      'backendOnly': true,
    });
    final export = DeclarationExportDto.fromJson({
      'export': {'id': 'export-1'},
      'download': {'exportId': 'export-1'},
    });

    expect(line.toJson(), {'id': 'line-1', 'backendOnly': true});
    expect(export.toJson(), {
      'export': {'id': 'export-1'},
      'download': {'exportId': 'export-1'},
    });
  });

  group('MarkSubmittedDeclarationDto contract', () {
    test('supports submittedAt and notes', () {
      const dto = MarkSubmittedDeclarationDto(
        submittedAt: '2026-06-16T00:00:00.000Z',
        notes: 'Submitted manually after external filing.',
      );

      expect(dto.toJson(), {
        'submittedAt': '2026-06-16T00:00:00.000Z',
        'notes': 'Submitted manually after external filing.',
        'supportingDocument': null,
      });
    });

    test('supports supportingDocument', () {
      const dto = MarkSubmittedDeclarationDto(
        supportingDocument: SupportingDocumentDto(
          fileName: 'receipt.pdf',
          storageKey: 'tenant/decl/receipt.pdf',
          checksum: 'sha256',
          description: 'External submission receipt',
          type: 'receipt',
        ),
      );

      final supportingDocument = dto.toJson()['supportingDocument'];

      expect(supportingDocument, isA<SupportingDocumentDto>());
      expect((supportingDocument! as SupportingDocumentDto).toJson(), {
        'fileName': 'receipt.pdf',
        'storageKey': 'tenant/decl/receipt.pdf',
        'checksum': 'sha256',
        'description': 'External submission receipt',
        'type': 'receipt',
      });
    });

    test('does not include unsupported fields such as channel', () {
      const dto = MarkSubmittedDeclarationDto(
        submittedAt: '2026-06-16T00:00:00.000Z',
        notes: 'Submitted manually',
      );

      final json = dto.toJson();

      expect(json.containsKey('channel'), isFalse);
      expect(
        json.keys,
        unorderedEquals(['submittedAt', 'notes', 'supportingDocument']),
      );
    });
  });
}
