import 'package:freezed_annotation/freezed_annotation.dart';

part 'declaration_period_dto.freezed.dart';
part 'declaration_period_dto.g.dart';

@freezed
abstract class DeclarationPeriodDto with _$DeclarationPeriodDto {
  const factory DeclarationPeriodDto({
    required String id,
    required String tenantId,
    String? companyId,
    required String periodType,
    required int year,
    int? month,
    int? quarter,
    required String startDate,
    required String endDate,
    int? payrollMonth,
    int? payrollYear,
    required String status,
    Map<String, Object?>? metadata,
    required String createdAt,
    required String updatedAt,
  }) = _DeclarationPeriodDto;

  factory DeclarationPeriodDto.fromJson(Map<String, Object?> json) =>
      _$DeclarationPeriodDtoFromJson(json);
}
