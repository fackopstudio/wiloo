import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_declaration_period_dto.freezed.dart';
part 'create_declaration_period_dto.g.dart';

@freezed
abstract class CreateDeclarationPeriodDto with _$CreateDeclarationPeriodDto {
  const factory CreateDeclarationPeriodDto({
    String? companyId,
    required String periodType,
    required int year,
    int? month,
    int? quarter,
    required String startDate,
    required String endDate,
    int? payrollMonth,
    int? payrollYear,
    Map<String, Object?>? metadata,
  }) = _CreateDeclarationPeriodDto;

  factory CreateDeclarationPeriodDto.fromJson(Map<String, Object?> json) =>
      _$CreateDeclarationPeriodDtoFromJson(json);
}
