// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_declaration_periods_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ListDeclarationPeriodsQueryDto _$ListDeclarationPeriodsQueryDtoFromJson(
  Map<String, dynamic> json,
) => _ListDeclarationPeriodsQueryDto(
  companyId: json['companyId'] as String?,
  periodType: json['periodType'] as String?,
  status: json['status'] as String?,
  year: (json['year'] as num?)?.toInt(),
  month: (json['month'] as num?)?.toInt(),
  quarter: (json['quarter'] as num?)?.toInt(),
  payrollMonth: (json['payrollMonth'] as num?)?.toInt(),
  payrollYear: (json['payrollYear'] as num?)?.toInt(),
);

Map<String, dynamic> _$ListDeclarationPeriodsQueryDtoToJson(
  _ListDeclarationPeriodsQueryDto instance,
) => <String, dynamic>{
  'companyId': instance.companyId,
  'periodType': instance.periodType,
  'status': instance.status,
  'year': instance.year,
  'month': instance.month,
  'quarter': instance.quarter,
  'payrollMonth': instance.payrollMonth,
  'payrollYear': instance.payrollYear,
};
