// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_declaration_period_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateDeclarationPeriodDto _$CreateDeclarationPeriodDtoFromJson(
  Map<String, dynamic> json,
) => _CreateDeclarationPeriodDto(
  companyId: json['companyId'] as String?,
  periodType: json['periodType'] as String,
  year: (json['year'] as num).toInt(),
  month: (json['month'] as num?)?.toInt(),
  quarter: (json['quarter'] as num?)?.toInt(),
  startDate: json['startDate'] as String,
  endDate: json['endDate'] as String,
  payrollMonth: (json['payrollMonth'] as num?)?.toInt(),
  payrollYear: (json['payrollYear'] as num?)?.toInt(),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CreateDeclarationPeriodDtoToJson(
  _CreateDeclarationPeriodDto instance,
) => <String, dynamic>{
  'companyId': instance.companyId,
  'periodType': instance.periodType,
  'year': instance.year,
  'month': instance.month,
  'quarter': instance.quarter,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'payrollMonth': instance.payrollMonth,
  'payrollYear': instance.payrollYear,
  'metadata': instance.metadata,
};
