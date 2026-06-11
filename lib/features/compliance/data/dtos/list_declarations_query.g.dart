// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_declarations_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ListDeclarationsQueryDto _$ListDeclarationsQueryDtoFromJson(
  Map<String, dynamic> json,
) => _ListDeclarationsQueryDto(
  declarationPeriodId: json['declarationPeriodId'] as String?,
  companyId: json['companyId'] as String?,
  type: json['type'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$ListDeclarationsQueryDtoToJson(
  _ListDeclarationsQueryDto instance,
) => <String, dynamic>{
  'declarationPeriodId': instance.declarationPeriodId,
  'companyId': instance.companyId,
  'type': instance.type,
  'status': instance.status,
};
