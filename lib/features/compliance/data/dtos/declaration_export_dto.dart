import 'package:freezed_annotation/freezed_annotation.dart';

part 'declaration_export_dto.freezed.dart';

@freezed
abstract class DeclarationExportDto with _$DeclarationExportDto {
  const DeclarationExportDto._();

  const factory DeclarationExportDto({
    String? id,
    String? declarationId,
    String? format,
    String? fileName,
    String? storageKey,
    String? checksum,
    String? generatedBy,
    String? generatedAt,
    String? status,

    // Runtime-confirmed fields are exposed above, but the full snapshot is
    // preserved because POST /export may return either a direct export object
    // or the composite { declaration, export, download } payload.
    @Default(<String, Object?>{}) Map<String, Object?> raw,
  }) = _DeclarationExportDto;

  factory DeclarationExportDto.fromJson(Map<String, Object?> json) {
    final exportObject = json['export'];
    final source = exportObject is Map<String, Object?>
        ? exportObject
        : json;

    return DeclarationExportDto(
      id: _stringOf(source['id']),
      declarationId: _stringOf(source['declarationId']),
      format: _stringOf(source['format']),
      fileName: _stringOf(source['fileName']),
      storageKey: _stringOf(source['storageKey']),
      checksum: _stringOf(source['checksum']),
      generatedBy: _stringOf(source['generatedBy']),
      generatedAt: _stringOf(source['generatedAt']),
      status: _stringOf(source['status']),
      raw: json,
    );
  }

  Map<String, Object?> toJson() => raw;
}

String? _stringOf(Object? value) => value is String ? value : null;
