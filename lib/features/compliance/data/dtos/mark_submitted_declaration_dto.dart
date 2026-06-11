import 'package:freezed_annotation/freezed_annotation.dart';

part 'mark_submitted_declaration_dto.freezed.dart';
part 'mark_submitted_declaration_dto.g.dart';

@freezed
abstract class MarkSubmittedDeclarationDto with _$MarkSubmittedDeclarationDto {
  const factory MarkSubmittedDeclarationDto({
    String? submittedAt,
    String? notes,
    SupportingDocumentDto? supportingDocument,
  }) = _MarkSubmittedDeclarationDto;

  factory MarkSubmittedDeclarationDto.fromJson(Map<String, Object?> json) =>
      _$MarkSubmittedDeclarationDtoFromJson(json);
}

@freezed
abstract class SupportingDocumentDto with _$SupportingDocumentDto {
  const factory SupportingDocumentDto({
    required String fileName,
    required String storageKey,
    String? checksum,
    String? description,
    String? type,
  }) = _SupportingDocumentDto;

  factory SupportingDocumentDto.fromJson(Map<String, Object?> json) =>
      _$SupportingDocumentDtoFromJson(json);
}
