import 'package:freezed_annotation/freezed_annotation.dart';

part 'archive_declaration_dto.freezed.dart';
part 'archive_declaration_dto.g.dart';

@freezed
abstract class ArchiveDeclarationDto with _$ArchiveDeclarationDto {
  const factory ArchiveDeclarationDto({String? reason}) =
      _ArchiveDeclarationDto;

  factory ArchiveDeclarationDto.fromJson(Map<String, Object?> json) =>
      _$ArchiveDeclarationDtoFromJson(json);
}
