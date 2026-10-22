import 'package:flux_wallet/features/auth/domain/entities/auth_exception.dart';
import 'package:flux_wallet/features/auth/domain/entities/user.dart';
import 'package:flux_wallet/features/auth/domain/entities/user_copy.dart';
import 'package:flux_wallet/features/auth/domain/repositories/user_repository.dart';
import 'package:flux_wallet/features/profile/domain/entities/profile_edit.dart';

/// Saves name, username and hint of the signed-in user right away.
class UpdateProfile {
  const UpdateProfile(this._users);

  final UserRepository _users;

  Future<User> call(ProfileEdit edit) async {
    if (!edit.isValid) throw const AuthException(AuthFailure.invalidInput);
    final user =
        await _users.current() ??
        (throw const AuthException(AuthFailure.invalidCredentials));
    final username = edit.normalizedUsername;
    if (await _users.isUsernameTaken(username, exceptId: user.id)) {
      throw const AuthException(AuthFailure.usernameTaken);
    }
    final hint = edit.hint.trim();
    final updated = user.copyWith(
      fullName: edit.fullName.trim(),
      username: username,
      passwordHint: hint,
      clearHint: hint.isEmpty,
    );
    await _users.update(updated);
    return updated;
  }
}
