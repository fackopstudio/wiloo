import '../enums/declaration_status.dart';
import '../enums/period_type.dart';

class DeclarationPeriod {
  const DeclarationPeriod({
    required this.id,
    required this.tenantId,
    required this.periodType,
    required this.year,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.companyId,
    this.month,
    this.quarter,
    this.payrollMonth,
    this.payrollYear,
    this.metadata,
  });

  final String id;
  final String tenantId;
  final String? companyId;
  final PeriodType periodType;
  final int year;
  final int? month;
  final int? quarter;
  final DateTime startDate;
  final DateTime endDate;
  final int? payrollMonth;
  final int? payrollYear;
  final DeclarationStatus status;
  final Map<String, Object?>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
}
