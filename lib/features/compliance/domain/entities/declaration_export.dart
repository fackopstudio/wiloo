import '../enums/export_format.dart';

class DeclarationExport {
  const DeclarationExport({
    required this.raw,
    this.id,
    this.declarationId,
    this.format,
    this.fileName,
    this.storageKey,
    this.checksum,
    this.generatedBy,
    this.generatedAt,
    this.status,
  });

  final Map<String, Object?> raw;

  /// Runtime-confirmed fields from `DeclarationExport`.
  ///
  /// The raw snapshot is still preserved because POST /export returns a
  /// composite payload and the backend may add fields without a mobile release.
  final String? id;
  final String? declarationId;
  final ExportFormat? format;
  final String? fileName;
  final String? storageKey;
  final String? checksum;
  final String? generatedBy;
  final DateTime? generatedAt;
  final String? status;
}
