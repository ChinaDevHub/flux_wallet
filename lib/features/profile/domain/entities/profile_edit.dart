import 'package:flux_wallet/features/auth/domain/entities/user.dart';
import 'package:flux_wallet/features/auth/domain/entities/username.dart';

/// The editable text fields of a profile and their validation.
class ProfileEdit {
  const ProfileEdit({
    required this.fullName,
    required this.username,
    this.hint = '',
  });

  final String fullName, username, hint;

  String get normalizedUsername => normalizeUsername(username);

  bool get fullNameOk => fullName.trim().length >= 2;
  bool get usernameOk => isValidUsername(normalizedUsername);
  bool get isValid => fullNameOk && usernameOk;

  bool differsFrom(User u) =>
      fullName.trim() != u.fullName ||
      normalizedUsername != u.username ||
      hint.trim() != (u.passwordHint ?? '');
}
