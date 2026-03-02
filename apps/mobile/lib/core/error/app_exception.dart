class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => 'AppException: $message';
}

class DisabledAccountException extends AppException {
  const DisabledAccountException()
    : super('Your account has been disabled. Contact support.');
}
