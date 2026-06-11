import '../enums/declaration_status.dart';
import '../enums/declaration_type.dart';
import '../value_objects/money_amount.dart';
import 'declaration_attachment.dart';
import 'declaration_export.dart';
import 'declaration_line.dart';
import 'declaration_period.dart';

class SocialFiscalDeclaration {
  const SocialFiscalDeclaration({
    required this.id,
    required this.tenantId,
    required this.declarationPeriodId,
    required this.type,
    required this.status,
    required this.totalGrossSalary,
    required this.totalTaxableBase,
    required this.totalEmployeeContributions,
    required this.totalEmployerContributions,
    required this.totalWithholdings,
    required this.createdAt,
    required this.updatedAt,
    this.companyId,
    this.ruleSetId,
    this.warnings,
    this.metadata,
    this.validatedBy,
    this.validatedAt,
    this.exportedAt,
    this.submittedManuallyAt,
    this.period,
    this.lines,
    this.exports,
    this.attachments,
  });

  final String id;
  final String tenantId;
  final String? companyId;
  final String declarationPeriodId;
  final DeclarationType type;
  final DeclarationStatus status;
  final String? ruleSetId;
  final MoneyAmount totalGrossSalary;
  final MoneyAmount totalTaxableBase;
  final MoneyAmount totalEmployeeContributions;
  final MoneyAmount totalEmployerContributions;
  final MoneyAmount totalWithholdings;
  final List<String>? warnings;
  final Map<String, Object?>? metadata;
  final String? validatedBy;
  final DateTime? validatedAt;
  final DateTime? exportedAt;
  final DateTime? submittedManuallyAt;
  final DeclarationPeriod? period;
  final List<DeclarationLine>? lines;
  final List<DeclarationExport>? exports;
  final List<DeclarationAttachment>? attachments;
  final DateTime createdAt;
  final DateTime updatedAt;
}
