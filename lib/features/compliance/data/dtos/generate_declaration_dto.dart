import 'package:freezed_annotation/freezed_annotation.dart';

part 'generate_declaration_dto.freezed.dart';
part 'generate_declaration_dto.g.dart';

@freezed
abstract class GenerateDeclarationDto with _$GenerateDeclarationDto {
  const factory GenerateDeclarationDto({
    required String declarationPeriodId,
    required String type,
    String? ruleSetId,
    Map<String, Object?>? metadata,
  }) = _GenerateDeclarationDto;

  factory GenerateDeclarationDto.fromJson(Map<String, Object?> json) =>
      _$GenerateDeclarationDtoFromJson(json);
}
