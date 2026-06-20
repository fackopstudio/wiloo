import 'package:freezed_annotation/freezed_annotation.dart';

part 'declaration_line_dto.freezed.dart';

@freezed
abstract class DeclarationLineDto with _$DeclarationLineDto {
  const DeclarationLineDto._();

  const factory DeclarationLineDto({
    String? id,
    String? declarationId,
    String? employeeId,
    String? payrollId,
    String? userId,
    Map<String, Object?>? employeeSnapshot,
    Map<String, Object?>? contractSnapshot,
    Map<String, Object?>? companySnapshot,
    Object? grossSalary,
    Object? taxableSalary,
    Object? socialContributionBase,
    Object? employeeContributionAmount,
    Object? employerContributionAmount,
    Object? withholdingAmount,
    Map<String, Object?>? deductionsSnapshot,
    Map<String, Object?>? benefitsInKindSnapshot,
    Map<String, Object?>? calculationDetails,
    List<String>? warnings,
    String? createdAt,
    String? updatedAt,

    // Runtime-confirmed fields are exposed above, while the full backend
    // snapshot is preserved for compatibility and future backend additions.
    @Default(<String, Object?>{}) Map<String, Object?> raw,
  }) = _DeclarationLineDto;

  factory DeclarationLineDto.fromJson(Map<String, Object?> json) {
    return DeclarationLineDto(
      id: _stringOf(json['id']),
      declarationId: _stringOf(json['declarationId']),
      employeeId: _stringOf(json['employeeId']),
      payrollId: _stringOf(json['payrollId']),
      userId: _stringOf(json['userId']),
      employeeSnapshot: _mapOf(json['employeeSnapshot']),
      contractSnapshot: _mapOf(json['contractSnapshot']),
      companySnapshot: _mapOf(json['companySnapshot']),
      grossSalary: json['grossSalary'],
      taxableSalary: json['taxableSalary'],
      socialContributionBase: json['socialContributionBase'],
      employeeContributionAmount: json['employeeContributionAmount'],
      employerContributionAmount: json['employerContributionAmount'],
      withholdingAmount: json['withholdingAmount'],
      deductionsSnapshot: _mapOf(json['deductionsSnapshot']),
      benefitsInKindSnapshot: _mapOf(json['benefitsInKindSnapshot']),
      calculationDetails: _mapOf(json['calculationDetails']),
      warnings: _stringListOf(json['warnings']),
      createdAt: _stringOf(json['createdAt']),
      updatedAt: _stringOf(json['updatedAt']),
      raw: json,
    );
  }

  Map<String, Object?> toJson() => raw;
}

String? _stringOf(Object? value) => value is String ? value : null;

Map<String, Object?>? _mapOf(Object? value) {
  if (value is Map<String, Object?>) {
    return value;
  }
  return null;
}

List<String>? _stringListOf(Object? value) {
  if (value is List) {
    return value.whereType<String>().toList();
  }
  return null;
}
