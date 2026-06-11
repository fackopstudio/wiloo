// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_declaration_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GenerateDeclarationDto _$GenerateDeclarationDtoFromJson(
  Map<String, dynamic> json,
) => _GenerateDeclarationDto(
  declarationPeriodId: json['declarationPeriodId'] as String,
  type: json['type'] as String,
  ruleSetId: json['ruleSetId'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$GenerateDeclarationDtoToJson(
  _GenerateDeclarationDto instance,
) => <String, dynamic>{
  'declarationPeriodId': instance.declarationPeriodId,
  'type': instance.type,
  'ruleSetId': instance.ruleSetId,
  'metadata': instance.metadata,
};
