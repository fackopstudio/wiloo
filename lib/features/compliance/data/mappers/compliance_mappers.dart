import '../../domain/entities/declaration_attachment.dart';
import '../../domain/entities/declaration_export.dart';
import '../../domain/entities/declaration_line.dart';
import '../../domain/entities/declaration_period.dart';
import '../../domain/entities/social_fiscal_declaration.dart';
import '../../domain/enums/declaration_status.dart';
import '../../domain/enums/declaration_type.dart';
import '../../domain/enums/export_format.dart';
import '../../domain/enums/period_type.dart';
import '../../domain/value_objects/compliance_requests.dart';
import '../../domain/value_objects/declaration_download_result.dart';
import '../../domain/value_objects/money_amount.dart';
import '../dtos/archive_declaration_dto.dart';
import '../dtos/create_declaration_period_dto.dart';
import '../dtos/declaration_attachment_dto.dart';
import '../dtos/declaration_download_result_dto.dart';
import '../dtos/declaration_export_dto.dart';
import '../dtos/declaration_line_dto.dart';
import '../dtos/declaration_period_dto.dart';
import '../dtos/export_declaration_dto.dart';
import '../dtos/generate_declaration_dto.dart';
import '../dtos/list_declaration_periods_query.dart';
import '../dtos/list_declarations_query.dart';
import '../dtos/mark_submitted_declaration_dto.dart';
import '../dtos/social_fiscal_declaration_dto.dart';

extension DeclarationPeriodDtoMapper on DeclarationPeriodDto {
  DeclarationPeriod toDomain() {
    return DeclarationPeriod(
      id: id,
      tenantId: tenantId,
      companyId: companyId,
      periodType: _periodTypeFromApi(periodType),
      year: year,
      month: month,
      quarter: quarter,
      startDate: DateTime.parse(startDate),
      endDate: DateTime.parse(endDate),
      payrollMonth: payrollMonth,
      payrollYear: payrollYear,
      status: _statusFromApi(status),
      metadata: metadata,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
    );
  }
}

extension SocialFiscalDeclarationDtoMapper on SocialFiscalDeclarationDto {
  SocialFiscalDeclaration toDomain() {
    return SocialFiscalDeclaration(
      id: id,
      tenantId: tenantId,
      companyId: companyId,
      declarationPeriodId: declarationPeriodId,
      type: _declarationTypeFromApi(type),
      status: _statusFromApi(status),
      ruleSetId: ruleSetId,
      totalGrossSalary: MoneyAmount.fromApi(totalGrossSalary),
      totalTaxableBase: MoneyAmount.fromApi(totalTaxableBase),
      totalEmployeeContributions: MoneyAmount.fromApi(
        totalEmployeeContributions,
      ),
      totalEmployerContributions: MoneyAmount.fromApi(
        totalEmployerContributions,
      ),
      totalWithholdings: MoneyAmount.fromApi(totalWithholdings),
      warnings: warnings,
      metadata: metadata,
      validatedBy: validatedBy,
      validatedAt: _parseOptionalDate(validatedAt),
      exportedAt: _parseOptionalDate(exportedAt),
      submittedManuallyAt: _parseOptionalDate(submittedManuallyAt),
      period: period?.toDomain(),
      lines: lines?.map((line) => line.toDomain()).toList(),
      exports: exports?.map((export) => export.toDomain()).toList(),
      attachments: attachments
          ?.map((attachment) => attachment.toDomain())
          .toList(),
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
    );
  }
}

extension DeclarationLineDtoMapper on DeclarationLineDto {
  DeclarationLine toDomain() {
    return DeclarationLine(
      raw: raw,
      id: id,
      declarationId: declarationId,
      employeeId: employeeId,
      payrollId: payrollId,
      userId: userId,
      employeeSnapshot: employeeSnapshot,
      contractSnapshot: contractSnapshot,
      companySnapshot: companySnapshot,
      grossSalary: _optionalMoney(grossSalary),
      taxableSalary: _optionalMoney(taxableSalary),
      socialContributionBase: socialContributionBase == null
          ? null
          : _optionalMoney(socialContributionBase),
      employeeContributionAmount: employeeContributionAmount == null
          ? null
          : _optionalMoney(employeeContributionAmount),
      employerContributionAmount: employerContributionAmount == null
          ? null
          : _optionalMoney(employerContributionAmount),
      withholdingAmount: _optionalMoney(withholdingAmount),
      deductionsSnapshot: deductionsSnapshot,
      benefitsInKindSnapshot: benefitsInKindSnapshot,
      calculationDetails: calculationDetails,
      warnings: warnings,
      createdAt: _parseOptionalDate(createdAt),
      updatedAt: _parseOptionalDate(updatedAt),
    );
  }
}

extension DeclarationExportDtoMapper on DeclarationExportDto {
  DeclarationExport toDomain() {
    return DeclarationExport(
      raw: raw,
      id: id,
      declarationId: declarationId,
      format: format == null ? null : _exportFormatFromApi(format!),
      fileName: fileName,
      storageKey: storageKey,
      checksum: checksum,
      generatedBy: generatedBy,
      generatedAt: _parseOptionalDate(generatedAt),
      status: status,
    );
  }
}

extension DeclarationAttachmentDtoMapper on DeclarationAttachmentDto {
  DeclarationAttachment toDomain() => DeclarationAttachment(raw: raw);
}

extension DeclarationDownloadResultDtoMapper on DeclarationDownloadResultDto {
  DeclarationDownloadResult toDomain() {
    return DeclarationDownloadResult(
      bytes: bytes,
      fileName: fileName,
      contentType: contentType,
    );
  }
}

extension CreateDeclarationPeriodRequestMapper
    on CreateDeclarationPeriodRequest {
  CreateDeclarationPeriodDto toDto() {
    return CreateDeclarationPeriodDto(
      companyId: companyId,
      periodType: periodType.apiValue,
      year: year,
      month: month,
      quarter: quarter,
      startDate: startDate.toIso8601String(),
      endDate: endDate.toIso8601String(),
      payrollMonth: payrollMonth,
      payrollYear: payrollYear,
      metadata: metadata,
    );
  }
}

extension GenerateDeclarationRequestMapper on GenerateDeclarationRequest {
  GenerateDeclarationDto toDto() {
    return GenerateDeclarationDto(
      declarationPeriodId: declarationPeriodId,
      type: type.apiValue,
      ruleSetId: ruleSetId,
      metadata: metadata,
    );
  }
}

extension ExportDeclarationRequestMapper on ExportDeclarationRequest {
  ExportDeclarationDto toDto() {
    return ExportDeclarationDto(
      format: format.apiValue,
      templateVersion: templateVersion,
    );
  }
}

extension MarkSubmittedDeclarationRequestMapper
    on MarkSubmittedDeclarationRequest {
  MarkSubmittedDeclarationDto toDto() {
    return MarkSubmittedDeclarationDto(
      submittedAt: submittedAt?.toIso8601String(),
      notes: notes,
      supportingDocument: supportingDocument == null
          ? null
          : SupportingDocumentDto(
              fileName: supportingDocument!.fileName,
              storageKey: supportingDocument!.storageKey,
              checksum: supportingDocument!.checksum,
              description: supportingDocument!.description,
              type: supportingDocument!.type,
            ),
    );
  }
}

extension ArchiveDeclarationRequestMapper on ArchiveDeclarationRequest {
  ArchiveDeclarationDto toDto() => ArchiveDeclarationDto(reason: reason);
}

extension ListDeclarationPeriodsQueryMapper on ListDeclarationPeriodsQuery {
  ListDeclarationPeriodsQueryDto toDto() {
    return ListDeclarationPeriodsQueryDto(
      companyId: companyId,
      periodType: periodType?.apiValue,
      status: status?.apiValue,
      year: year,
      month: month,
      quarter: quarter,
      payrollMonth: payrollMonth,
      payrollYear: payrollYear,
    );
  }
}

extension ListDeclarationsQueryMapper on ListDeclarationsQuery {
  ListDeclarationsQueryDto toDto() {
    return ListDeclarationsQueryDto(
      declarationPeriodId: declarationPeriodId,
      companyId: companyId,
      type: type?.apiValue,
      status: status?.apiValue,
    );
  }
}

DateTime? _parseOptionalDate(String? value) {
  if (value == null) {
    return null;
  }

  return DateTime.parse(value);
}

MoneyAmount? _optionalMoney(Object? value) {
  if (value == null) {
    return null;
  }
  return MoneyAmount.fromApi(value);
}

DeclarationType _declarationTypeFromApi(String value) {
  return DeclarationType.values.firstWhere((type) => type.apiValue == value);
}

DeclarationStatus _statusFromApi(String value) {
  return DeclarationStatus.values.firstWhere(
    (status) => status.apiValue == value,
  );
}

PeriodType _periodTypeFromApi(String value) {
  return PeriodType.values.firstWhere((type) => type.apiValue == value);
}

ExportFormat _exportFormatFromApi(String value) {
  return ExportFormat.values.firstWhere((format) => format.apiValue == value);
}
