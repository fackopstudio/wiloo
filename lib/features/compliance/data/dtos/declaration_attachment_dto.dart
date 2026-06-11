import 'package:freezed_annotation/freezed_annotation.dart';

part 'declaration_attachment_dto.freezed.dart';
part 'declaration_attachment_dto.g.dart';

@freezed
abstract class DeclarationAttachmentDto with _$DeclarationAttachmentDto {
  const factory DeclarationAttachmentDto({
    // TODO(compliance): replace raw snapshot with typed fields after the
    // backend confirms DeclarationAttachment in the Compliance API contract.
    @Default(<String, Object?>{}) Map<String, Object?> raw,
  }) = _DeclarationAttachmentDto;

  factory DeclarationAttachmentDto.fromJson(Map<String, Object?> json) =>
      DeclarationAttachmentDto(raw: json);
}
