import '../../../../core/error/failure.dart';
import '../../../../core/network/general_api_client.dart';
import '../dtos/archive_declaration_dto.dart';
import '../dtos/create_declaration_period_dto.dart';
import '../dtos/declaration_download_result_dto.dart';
import '../dtos/declaration_export_dto.dart';
import '../dtos/declaration_period_dto.dart';
import '../dtos/export_declaration_dto.dart';
import '../dtos/generate_declaration_dto.dart';
import '../dtos/list_declaration_periods_query.dart';
import '../dtos/list_declarations_query.dart';
import '../dtos/mark_submitted_declaration_dto.dart';
import '../dtos/social_fiscal_declaration_dto.dart';

abstract interface class ComplianceRemoteDataSource {
  Future<List<DeclarationPeriodDto>> getPeriods(
    ListDeclarationPeriodsQueryDto query,
  );

  Future<DeclarationPeriodDto> createPeriod(CreateDeclarationPeriodDto request);

  Future<List<SocialFiscalDeclarationDto>> getDeclarations(
    ListDeclarationsQueryDto query,
  );

  Future<SocialFiscalDeclarationDto> generateDeclaration(
    GenerateDeclarationDto request,
  );

  Future<SocialFiscalDeclarationDto> getDeclaration(String id);

  Future<SocialFiscalDeclarationDto> markReady(String id);

  Future<SocialFiscalDeclarationDto> validateDeclaration(String id);

  Future<DeclarationExportDto> exportDeclaration(
    String id,
    ExportDeclarationDto request,
  );

  Future<DeclarationDownloadResultDto> downloadExport(
    String id,
    String exportId,
  );

  Future<SocialFiscalDeclarationDto> markSubmitted(
    String id,
    MarkSubmittedDeclarationDto request,
  );

  Future<SocialFiscalDeclarationDto> archiveDeclaration(
    String id,
    ArchiveDeclarationDto request,
  );
}

class ComplianceRemoteDataSourceImpl implements ComplianceRemoteDataSource {
  const ComplianceRemoteDataSourceImpl(this._client);

  static const _basePath = '/compliance';

  final GeneralApiClient _client;

  @override
  Future<List<DeclarationPeriodDto>> getPeriods(
    ListDeclarationPeriodsQueryDto query,
  ) async {
    final data = await _client.getJson<List<Object?>>(
      '$_basePath/periods',
      queryParameters: _withoutNulls(query.toJson()),
    );

    return data.map(_asJsonObject).map(DeclarationPeriodDto.fromJson).toList();
  }

  @override
  Future<DeclarationPeriodDto> createPeriod(
    CreateDeclarationPeriodDto request,
  ) async {
    final data = await _client.postJson<Map<String, Object?>>(
      '$_basePath/periods',
      data: request.toJson(),
    );

    return DeclarationPeriodDto.fromJson(data);
  }

  @override
  Future<List<SocialFiscalDeclarationDto>> getDeclarations(
    ListDeclarationsQueryDto query,
  ) async {
    final data = await _client.getJson<List<Object?>>(
      '$_basePath/declarations',
      queryParameters: _withoutNulls(query.toJson()),
    );

    return data
        .map(_asJsonObject)
        .map(SocialFiscalDeclarationDto.fromJson)
        .toList();
  }

  @override
  Future<SocialFiscalDeclarationDto> generateDeclaration(
    GenerateDeclarationDto request,
  ) async {
    final data = await _client.postJson<Map<String, Object?>>(
      '$_basePath/declarations/generate',
      data: request.toJson(),
    );

    return SocialFiscalDeclarationDto.fromJson(data);
  }

  @override
  Future<SocialFiscalDeclarationDto> getDeclaration(String id) async {
    final data = await _client.getJson<Map<String, Object?>>(
      '$_basePath/declarations/$id',
    );

    return SocialFiscalDeclarationDto.fromJson(data);
  }

  @override
  Future<SocialFiscalDeclarationDto> markReady(String id) async {
    final data = await _client.postJson<Map<String, Object?>>(
      '$_basePath/declarations/$id/mark-ready',
    );

    return SocialFiscalDeclarationDto.fromJson(data);
  }

  @override
  Future<SocialFiscalDeclarationDto> validateDeclaration(String id) async {
    final data = await _client.postJson<Map<String, Object?>>(
      '$_basePath/declarations/$id/validate',
    );

    return SocialFiscalDeclarationDto.fromJson(data);
  }

  @override
  Future<DeclarationExportDto> exportDeclaration(
    String id,
    ExportDeclarationDto request,
  ) async {
    final data = await _client.postJson<Map<String, Object?>>(
      '$_basePath/declarations/$id/export',
      data: request.toJson(),
    );

    return DeclarationExportDto.fromJson(data);
  }

  @override
  Future<DeclarationDownloadResultDto> downloadExport(
    String id,
    String exportId,
  ) async {
    final response = await _client.getBinary(
      '$_basePath/declarations/$id/exports/$exportId/download',
    );

    return DeclarationDownloadResultDto(
      bytes: response.bytes,
      fileName: _fileNameFromContentDisposition(
        response.headers.value('content-disposition'),
      ),
      contentType:
          response.headers.value('content-type') ?? 'application/octet-stream',
    );
  }

  @override
  Future<SocialFiscalDeclarationDto> markSubmitted(
    String id,
    MarkSubmittedDeclarationDto request,
  ) async {
    final data = await _client.postJson<Map<String, Object?>>(
      '$_basePath/declarations/$id/mark-submitted',
      data: request.toJson(),
    );

    return SocialFiscalDeclarationDto.fromJson(data);
  }

  @override
  Future<SocialFiscalDeclarationDto> archiveDeclaration(
    String id,
    ArchiveDeclarationDto request,
  ) async {
    final data = await _client.postJson<Map<String, Object?>>(
      '$_basePath/declarations/$id/archive',
      data: request.toJson(),
    );

    return SocialFiscalDeclarationDto.fromJson(data);
  }

  Map<String, Object?> _withoutNulls(Map<String, Object?> value) {
    return Map.fromEntries(value.entries.where((entry) => entry.value != null));
  }

  Map<String, Object?> _asJsonObject(Object? value) {
    if (value is Map<String, Object?>) {
      return value;
    }

    throw Failure.decoding(cause: value);
  }

  String _fileNameFromContentDisposition(String? value) {
    if (value == null || value.isEmpty) {
      return 'declaration-export';
    }

    final utf8Match = RegExp("filename\\*=UTF-8''([^;]+)").firstMatch(value);
    if (utf8Match != null) {
      return Uri.decodeComponent(utf8Match.group(1)!);
    }

    final quotedMatch = RegExp(r'filename="([^"]+)"').firstMatch(value);
    if (quotedMatch != null) {
      return quotedMatch.group(1)!;
    }

    final plainMatch = RegExp(r'filename=([^;]+)').firstMatch(value);
    if (plainMatch != null) {
      return plainMatch.group(1)!.trim();
    }

    return 'declaration-export';
  }
}
