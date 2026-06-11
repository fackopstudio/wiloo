import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_declaration_periods_query.freezed.dart';
part 'list_declaration_periods_query.g.dart';

@freezed
abstract class ListDeclarationPeriodsQueryDto
    with _$ListDeclarationPeriodsQueryDto {
  const factory ListDeclarationPeriodsQueryDto({
    String? companyId,
    String? periodType,
    String? status,
    int? year,
    int? month,
    int? quarter,
    int? payrollMonth,
    int? payrollYear,
  }) = _ListDeclarationPeriodsQueryDto;

  factory ListDeclarationPeriodsQueryDto.fromJson(Map<String, Object?> json) =>
      _$ListDeclarationPeriodsQueryDtoFromJson(json);
}
