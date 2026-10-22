import 'package:flux_wallet/features/auth/domain/entities/username.dart';
import 'package:flux_wallet/features/auth/domain/repositories/user_repository.dart';

class GetPasswordHint {
  const GetPasswordHint(this._users);

  final UserRepository _users;

  /// Null when there is no such user or no hint was set.
  Future<String?> call(String username) async =>
      (await _users.byUsername(normalizeUsername(username)))?.passwordHint;
}
