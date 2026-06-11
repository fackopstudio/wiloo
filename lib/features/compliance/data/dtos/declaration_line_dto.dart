import 'package:freezed_annotation/freezed_annotation.dart';

part 'declaration_line_dto.freezed.dart';
part 'declaration_line_dto.g.dart';

@freezed
abstract class DeclarationLineDto with _$DeclarationLineDto {
  const factory DeclarationLineDto({
    // TODO(compliance): replace raw snapshot with typed fields after the
    // backend confirms DeclarationLine in the Compliance API contract.
    @Default(<String, Object?>{}) Map<String, Object?> raw,
  }) = _DeclarationLineDto;

  factory DeclarationLineDto.fromJson(Map<String, Object?> json) =>
      DeclarationLineDto(raw: json);
}
