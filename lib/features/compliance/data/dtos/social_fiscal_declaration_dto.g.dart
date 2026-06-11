// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_fiscal_declaration_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SocialFiscalDeclarationDto _$SocialFiscalDeclarationDtoFromJson(
  Map<String, dynamic> json,
) => _SocialFiscalDeclarationDto(
  id: json['id'] as String,
  tenantId: json['tenantId'] as String,
  companyId: json['companyId'] as String?,
  declarationPeriodId: json['declarationPeriodId'] as String,
  type: json['type'] as String,
  status: json['status'] as String,
  ruleSetId: json['ruleSetId'] as String?,
  totalGrossSalary: json['totalGrossSalary'] as Object,
  totalTaxableBase: json['totalTaxableBase'] as Object,
  totalEmployeeContributions: json['totalEmployeeContributions'] as Object,
  totalEmployerContributions: json['totalEmployerContributions'] as Object,
  totalWithholdings: json['totalWithholdings'] as Object,
  warnings: (json['warnings'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  metadata: json['metadata'] as Map<String, dynamic>?,
  validatedBy: json['validatedBy'] as String?,
  validatedAt: json['validatedAt'] as String?,
  exportedAt: json['exportedAt'] as String?,
  submittedManuallyAt: json['submittedManuallyAt'] as String?,
  period: json['period'] == null
      ? null
      : DeclarationPeriodDto.fromJson(json['period'] as Map<String, dynamic>),
  lines: (json['lines'] as List<dynamic>?)
      ?.map((e) => DeclarationLineDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  exports: (json['exports'] as List<dynamic>?)
      ?.map((e) => DeclarationExportDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  attachments: (json['attachments'] as List<dynamic>?)
      ?.map((e) => DeclarationAttachmentDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
);

Map<String, dynamic> _$SocialFiscalDeclarationDtoToJson(
  _SocialFiscalDeclarationDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'tenantId': instance.tenantId,
  'companyId': instance.companyId,
  'declarationPeriodId': instance.declarationPeriodId,
  'type': instance.type,
  'status': instance.status,
  'ruleSetId': instance.ruleSetId,
  'totalGrossSalary': instance.totalGrossSalary,
  'totalTaxableBase': instance.totalTaxableBase,
  'totalEmployeeContributions': instance.totalEmployeeContributions,
  'totalEmployerContributions': instance.totalEmployerContributions,
  'totalWithholdings': instance.totalWithholdings,
  'warnings': instance.warnings,
  'metadata': instance.metadata,
  'validatedBy': instance.validatedBy,
  'validatedAt': instance.validatedAt,
  'exportedAt': instance.exportedAt,
  'submittedManuallyAt': instance.submittedManuallyAt,
  'period': instance.period,
  'lines': instance.lines,
  'exports': instance.exports,
  'attachments': instance.attachments,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
