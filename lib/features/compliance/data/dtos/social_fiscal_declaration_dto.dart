import 'declaration_attachment_dto.dart';
import 'declaration_export_dto.dart';
import 'declaration_line_dto.dart';
import 'declaration_period_dto.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_fiscal_declaration_dto.freezed.dart';
part 'social_fiscal_declaration_dto.g.dart';

@freezed
abstract class SocialFiscalDeclarationDto with _$SocialFiscalDeclarationDto {
  const factory SocialFiscalDeclarationDto({
    required String id,
    required String tenantId,
    String? companyId,
    required String declarationPeriodId,
    required String type,
    required String status,
    String? ruleSetId,
    required Object totalGrossSalary,
    required Object totalTaxableBase,
    required Object totalEmployeeContributions,
    required Object totalEmployerContributions,
    required Object totalWithholdings,
    List<String>? warnings,
    Map<String, Object?>? metadata,
    String? validatedBy,
    String? validatedAt,
    String? exportedAt,
    String? submittedManuallyAt,
    DeclarationPeriodDto? period,
    List<DeclarationLineDto>? lines,
    List<DeclarationExportDto>? exports,
    List<DeclarationAttachmentDto>? attachments,
    required String createdAt,
    required String updatedAt,
  }) = _SocialFiscalDeclarationDto;

  factory SocialFiscalDeclarationDto.fromJson(Map<String, Object?> json) =>
      _$SocialFiscalDeclarationDtoFromJson(json);
}
