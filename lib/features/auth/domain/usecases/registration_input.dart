import 'package:flux_wallet/features/auth/domain/entities/username.dart';

/// Raw register-form values and their validation.
class RegistrationInput {
  const RegistrationInput({
    required this.fullName,
    required this.username,
    required this.password,
    this.hint = '',
  });

  static const minPassword = 6;

  final String fullName, username, password, hint;

  String get normalizedUsername => normalizeUsername(username);

  bool get fullNameOk => fullName.trim().length >= 2;
  bool get usernameOk => isValidUsername(normalizedUsername);
  bool get passwordOk => password.length >= minPassword;

  /// A hint that spells the password out defeats the password.
  bool get hintOk =>
      hint.trim().isEmpty ||
      password.isEmpty ||
      !hint.toLowerCase().contains(password.toLowerCase());

  bool get isValid => fullNameOk && usernameOk && passwordOk && hintOk;
}
