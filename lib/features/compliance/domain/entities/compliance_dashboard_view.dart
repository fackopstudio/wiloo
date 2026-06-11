import 'declaration_period.dart';
import 'social_fiscal_declaration.dart';

class ComplianceDashboardView {
  const ComplianceDashboardView({
    required this.periods,
    required this.declarations,
  });

  final List<DeclarationPeriod> periods;
  final List<SocialFiscalDeclaration> declarations;
}
