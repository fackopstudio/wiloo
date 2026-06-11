import 'package:freezed_annotation/freezed_annotation.dart';

part 'export_declaration_dto.freezed.dart';
part 'export_declaration_dto.g.dart';

@freezed
abstract class ExportDeclarationDto with _$ExportDeclarationDto {
  const factory ExportDeclarationDto({
    required String format,
    String? templateVersion,
  }) = _ExportDeclarationDto;

  factory ExportDeclarationDto.fromJson(Map<String, Object?> json) =>
      _$ExportDeclarationDtoFromJson(json);
}
