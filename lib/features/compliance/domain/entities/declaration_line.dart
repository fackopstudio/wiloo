import '../value_objects/money_amount.dart';

class DeclarationLine {
  const DeclarationLine({
    required this.raw,
    this.id,
    this.declarationId,
    this.employeeId,
    this.payrollId,
    this.userId,
    this.employeeSnapshot,
    this.contractSnapshot,
    this.companySnapshot,
    this.grossSalary,
    this.taxableSalary,
    this.socialContributionBase,
    this.employeeContributionAmount,
    this.employerContributionAmount,
    this.withholdingAmount,
    this.deductionsSnapshot,
    this.benefitsInKindSnapshot,
    this.calculationDetails,
    this.warnings,
    this.createdAt,
    this.updatedAt,
  });

  final Map<String, Object?> raw;

  /// Runtime-confirmed declaration line fields.
  ///
  /// `raw` remains the compatibility surface for snapshots and future backend
  /// additions. Money values are display-only and must never be recalculated in
  /// Flutter.
  final String? id;
  final String? declarationId;
  final String? employeeId;
  final String? payrollId;
  final String? userId;
  final Map<String, Object?>? employeeSnapshot;
  final Map<String, Object?>? contractSnapshot;
  final Map<String, Object?>? companySnapshot;
  final MoneyAmount? grossSalary;
  final MoneyAmount? taxableSalary;
  final MoneyAmount? socialContributionBase;
  final MoneyAmount? employeeContributionAmount;
  final MoneyAmount? employerContributionAmount;
  final MoneyAmount? withholdingAmount;
  final Map<String, Object?>? deductionsSnapshot;
  final Map<String, Object?>? benefitsInKindSnapshot;
  final Map<String, Object?>? calculationDetails;
  final List<String>? warnings;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
