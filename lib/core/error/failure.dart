enum FailureType {
  invalidStateTransition,
  forbidden,
  network,
  server,
  decoding,
  unknown,
}

class Failure implements Exception {
  const Failure({
    required this.type,
    required this.message,
    this.statusCode,
    this.cause,
  });

  const Failure.invalidStateTransition({
    this.message = 'Invalid declaration state transition.',
    this.statusCode = 400,
    this.cause,
  }) : type = FailureType.invalidStateTransition;

  const Failure.forbidden({
    this.message = 'You are not allowed to perform this action.',
    this.statusCode = 403,
    this.cause,
  }) : type = FailureType.forbidden;

  const Failure.network({
    this.message = 'Network request failed.',
    this.statusCode,
    this.cause,
  }) : type = FailureType.network;

  const Failure.server({
    this.message = 'Server request failed.',
    this.statusCode,
    this.cause,
  }) : type = FailureType.server;

  const Failure.decoding({
    this.message = 'Unable to decode server response.',
    this.statusCode,
    this.cause,
  }) : type = FailureType.decoding;

  const Failure.unknown({
    this.message = 'Unexpected error.',
    this.statusCode,
    this.cause,
  }) : type = FailureType.unknown;

  final FailureType type;
  final String message;
  final int? statusCode;
  final Object? cause;

  @override
  String toString() => 'Failure($type, $message, statusCode: $statusCode)';
}
