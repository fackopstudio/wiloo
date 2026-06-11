import '../enums/declaration_status.dart';

enum DeclarationAction { markReady, validate, export, markSubmitted, archive }

class DeclarationTransition {
  const DeclarationTransition({
    required this.action,
    required this.from,
    required this.to,
  });

  final DeclarationAction action;
  final DeclarationStatus from;
  final DeclarationStatus to;

  static const confirmed = [
    DeclarationTransition(
      action: DeclarationAction.markReady,
      from: DeclarationStatus.draft,
      to: DeclarationStatus.readyToReview,
    ),
    DeclarationTransition(
      action: DeclarationAction.validate,
      from: DeclarationStatus.readyToReview,
      to: DeclarationStatus.validated,
    ),
    DeclarationTransition(
      action: DeclarationAction.export,
      from: DeclarationStatus.validated,
      to: DeclarationStatus.exported,
    ),
    DeclarationTransition(
      action: DeclarationAction.export,
      from: DeclarationStatus.readyToReview,
      to: DeclarationStatus.readyToReview,
    ),
    DeclarationTransition(
      action: DeclarationAction.export,
      from: DeclarationStatus.exported,
      to: DeclarationStatus.exported,
    ),
    DeclarationTransition(
      action: DeclarationAction.markSubmitted,
      from: DeclarationStatus.validated,
      to: DeclarationStatus.submittedManually,
    ),
    DeclarationTransition(
      action: DeclarationAction.markSubmitted,
      from: DeclarationStatus.exported,
      to: DeclarationStatus.submittedManually,
    ),
  ];

  static bool canApply(DeclarationAction action, DeclarationStatus status) {
    if (action == DeclarationAction.archive) {
      return status != DeclarationStatus.archived;
    }

    return confirmed.any(
      (transition) => transition.action == action && transition.from == status,
    );
  }
}
