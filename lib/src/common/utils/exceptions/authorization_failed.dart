class AuthorizationFailed implements Exception {
  final String message;

  AuthorizationFailed({required this.message});
}