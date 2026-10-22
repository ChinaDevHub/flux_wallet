import 'package:flux_wallet/core/session/session.dart';
import 'package:flux_wallet/features/auth/domain/entities/auth_exception.dart';
import 'package:flux_wallet/features/auth/domain/entities/user.dart';
import 'package:flux_wallet/features/auth/domain/entities/username.dart';
import 'package:flux_wallet/features/auth/domain/repositories/password_hasher.dart';
import 'package:flux_wallet/features/auth/domain/repositories/user_repository.dart';

class LoginUser {
  const LoginUser(this._users, this._hasher, this._session);

  final UserRepository _users;
  final PasswordHasher _hasher;
  final Session _session;

  /// Unknown username and wrong password look the same on purpose.
  Future<User> call(String username, String password) async {
    final user = await _users.byUsername(normalizeUsername(username));
    if (user == null || !await _hasher.verify(password, user.passwordHash)) {
      throw const AuthException(AuthFailure.invalidCredentials);
    }
    await _session.signIn(user.id);
    return user;
  }
}
