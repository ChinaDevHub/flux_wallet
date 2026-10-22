import 'package:flux_wallet/features/auth/domain/entities/auth_exception.dart';
import 'package:flux_wallet/features/auth/domain/entities/user.dart';
import 'package:flux_wallet/features/auth/domain/repositories/password_hasher.dart';
import 'package:flux_wallet/features/auth/domain/repositories/user_repository.dart';
import 'package:flux_wallet/features/auth/domain/usecases/registration_input.dart';
import 'package:flux_wallet/core/session/session.dart';
import 'package:uuid/uuid.dart';

/// Creates the account and signs it in.
class RegisterUser {
  const RegisterUser(this._users, this._hasher, this._session);

  final UserRepository _users;
  final PasswordHasher _hasher;
  final Session _session;

  Future<User> call(RegistrationInput input) async {
    if (!input.isValid) throw const AuthException(AuthFailure.invalidInput);
    final username = input.normalizedUsername;
    if (await _users.isUsernameTaken(username)) {
      throw const AuthException(AuthFailure.usernameTaken);
    }
    final hint = input.hint.trim();
    final user = User(
      id: const Uuid().v4(),
      username: username,
      passwordHash: await _hasher.hash(input.password),
      passwordHint: hint.isEmpty ? null : hint,
      fullName: input.fullName.trim(),
      createdAt: DateTime.now(),
    );
    await _users.create(user);
    await _session.signIn(user.id);
    return user;
  }
}
