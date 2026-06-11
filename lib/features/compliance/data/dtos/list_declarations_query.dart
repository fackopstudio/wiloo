import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_declarations_query.freezed.dart';
part 'list_declarations_query.g.dart';

@freezed
abstract class ListDeclarationsQueryDto with _$ListDeclarationsQueryDto {
  const factory ListDeclarationsQueryDto({
    String? declarationPeriodId,
    String? companyId,
    String? type,
    String? status,
  }) = _ListDeclarationsQueryDto;

  factory ListDeclarationsQueryDto.fromJson(Map<String, Object?> json) =>
      _$ListDeclarationsQueryDtoFromJson(json);
}
