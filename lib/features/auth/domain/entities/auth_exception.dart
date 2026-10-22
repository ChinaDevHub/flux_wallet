enum AuthFailure {
  /// Another account already uses this username.
  usernameTaken,

  /// Unknown username or wrong password (deliberately not distinguished).
  invalidCredentials,

  /// The old password typed while changing it is wrong.
  wrongPassword,

  /// A field failed validation.
  invalidInput,
}

class AuthException implements Exception {
  const AuthException(this.failure);

  final AuthFailure failure;

  @override
  String toString() => 'AuthException: $failure';
}
