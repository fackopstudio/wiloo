import '../enums/declaration_status.dart';
import '../enums/declaration_type.dart';
import '../enums/export_format.dart';
import '../enums/period_type.dart';

class CreateDeclarationPeriodRequest {
  const CreateDeclarationPeriodRequest({
    required this.periodType,
    required this.year,
    required this.startDate,
    required this.endDate,
    this.companyId,
    this.month,
    this.quarter,
    this.payrollMonth,
    this.payrollYear,
    this.metadata,
  });

  final String? companyId;
  final PeriodType periodType;
  final int year;
  final int? month;
  final int? quarter;
  final DateTime startDate;
  final DateTime endDate;
  final int? payrollMonth;
  final int? payrollYear;
  final Map<String, Object?>? metadata;
}

class GenerateDeclarationRequest {
  const GenerateDeclarationRequest({
    required this.declarationPeriodId,
    required this.type,
    this.ruleSetId,
    this.metadata,
  });

  final String declarationPeriodId;
  final DeclarationType type;
  final String? ruleSetId;
  final Map<String, Object?>? metadata;
}

class ExportDeclarationRequest {
  const ExportDeclarationRequest({required this.format, this.templateVersion});

  final ExportFormat format;
  final String? templateVersion;
}

class MarkSubmittedDeclarationRequest {
  const MarkSubmittedDeclarationRequest({
    this.submittedAt,
    this.notes,
    this.supportingDocument,
  });

  final DateTime? submittedAt;
  final String? notes;
  final SupportingDocumentRequest? supportingDocument;
}

class SupportingDocumentRequest {
  const SupportingDocumentRequest({
    required this.fileName,
    required this.storageKey,
    this.checksum,
    this.description,
    this.type,
  });

  final String fileName;
  final String storageKey;
  final String? checksum;
  final String? description;
  final String? type;
}

class ArchiveDeclarationRequest {
  const ArchiveDeclarationRequest({this.reason});

  final String? reason;
}

class ListDeclarationPeriodsQuery {
  const ListDeclarationPeriodsQuery({
    this.companyId,
    this.periodType,
    this.status,
    this.year,
    this.month,
    this.quarter,
    this.payrollMonth,
    this.payrollYear,
  });

  final String? companyId;
  final PeriodType? periodType;
  final DeclarationStatus? status;
  final int? year;
  final int? month;
  final int? quarter;
  final int? payrollMonth;
  final int? payrollYear;
}

class ListDeclarationsQuery {
  const ListDeclarationsQuery({
    this.declarationPeriodId,
    this.companyId,
    this.type,
    this.status,
  });

  final String? declarationPeriodId;
  final String? companyId;
  final DeclarationType? type;
  final DeclarationStatus? status;
}
