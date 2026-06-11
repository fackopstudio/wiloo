// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_submitted_declaration_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MarkSubmittedDeclarationDto _$MarkSubmittedDeclarationDtoFromJson(
  Map<String, dynamic> json,
) => _MarkSubmittedDeclarationDto(
  submittedAt: json['submittedAt'] as String?,
  notes: json['notes'] as String?,
  supportingDocument: json['supportingDocument'] == null
      ? null
      : SupportingDocumentDto.fromJson(
          json['supportingDocument'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$MarkSubmittedDeclarationDtoToJson(
  _MarkSubmittedDeclarationDto instance,
) => <String, dynamic>{
  'submittedAt': instance.submittedAt,
  'notes': instance.notes,
  'supportingDocument': instance.supportingDocument,
};

_SupportingDocumentDto _$SupportingDocumentDtoFromJson(
  Map<String, dynamic> json,
) => _SupportingDocumentDto(
  fileName: json['fileName'] as String,
  storageKey: json['storageKey'] as String,
  checksum: json['checksum'] as String?,
  description: json['description'] as String?,
  type: json['type'] as String?,
);

Map<String, dynamic> _$SupportingDocumentDtoToJson(
  _SupportingDocumentDto instance,
) => <String, dynamic>{
  'fileName': instance.fileName,
  'storageKey': instance.storageKey,
  'checksum': instance.checksum,
  'description': instance.description,
  'type': instance.type,
};
