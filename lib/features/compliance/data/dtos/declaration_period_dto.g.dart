// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'declaration_period_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeclarationPeriodDto _$DeclarationPeriodDtoFromJson(
  Map<String, dynamic> json,
) => _DeclarationPeriodDto(
  id: json['id'] as String,
  tenantId: json['tenantId'] as String,
  companyId: json['companyId'] as String?,
  periodType: json['periodType'] as String,
  year: (json['year'] as num).toInt(),
  month: (json['month'] as num?)?.toInt(),
  quarter: (json['quarter'] as num?)?.toInt(),
  startDate: json['startDate'] as String,
  endDate: json['endDate'] as String,
  payrollMonth: (json['payrollMonth'] as num?)?.toInt(),
  payrollYear: (json['payrollYear'] as num?)?.toInt(),
  status: json['status'] as String,
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
);

Map<String, dynamic> _$DeclarationPeriodDtoToJson(
  _DeclarationPeriodDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'tenantId': instance.tenantId,
  'companyId': instance.companyId,
  'periodType': instance.periodType,
  'year': instance.year,
  'month': instance.month,
  'quarter': instance.quarter,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'payrollMonth': instance.payrollMonth,
  'payrollYear': instance.payrollYear,
  'status': instance.status,
  'metadata': instance.metadata,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
