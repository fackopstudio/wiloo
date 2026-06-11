import 'package:freezed_annotation/freezed_annotation.dart';

part 'declaration_export_dto.freezed.dart';
part 'declaration_export_dto.g.dart';

@freezed
abstract class DeclarationExportDto with _$DeclarationExportDto {
  const factory DeclarationExportDto({
    // TODO(compliance): replace raw snapshot with typed fields after the
    // backend confirms DeclarationExport and POST export response shape.
    @Default(<String, Object?>{}) Map<String, Object?> raw,
  }) = _DeclarationExportDto;

  factory DeclarationExportDto.fromJson(Map<String, Object?> json) =>
      DeclarationExportDto(raw: json);
}
