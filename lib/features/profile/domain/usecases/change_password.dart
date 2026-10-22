import 'package:flux_wallet/features/auth/domain/entities/auth_exception.dart';
import 'package:flux_wallet/features/auth/domain/repositories/password_hasher.dart';
import 'package:flux_wallet/features/auth/domain/repositories/user_repository.dart';
import 'package:flux_wallet/features/auth/domain/usecases/registration_input.dart';

class ChangePassword {
  const ChangePassword(this._users, this._hasher);

  final UserRepository _users;
  final PasswordHasher _hasher;

  /// The old password must be right; the new one must be long enough and must
  /// not be spelled out by the user's own hint.
  Future<void> call(String oldPassword, String newPassword) async {
    final user =
        await _users.current() ??
        (throw const AuthException(AuthFailure.invalidCredentials));
    if (!await _hasher.verify(oldPassword, user.passwordHash)) {
      throw const AuthException(AuthFailure.wrongPassword);
    }
    final hint = user.passwordHint ?? '';
    final hintGivesItAway =
        hint.isNotEmpty &&
        hint.toLowerCase().contains(newPassword.toLowerCase());
    if (newPassword.length < RegistrationInput.minPassword || hintGivesItAway) {
      throw const AuthException(AuthFailure.invalidInput);
    }
    await _users.setPasswordHash(user.id, await _hasher.hash(newPassword));
  }
}
