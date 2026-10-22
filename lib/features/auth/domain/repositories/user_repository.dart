import 'package:flux_wallet/features/auth/domain/entities/user.dart';

abstract interface class UserRepository {
  Future<User?> byId(String id);

  /// The signed-in user.
  Future<User?> current();

  /// [normalized] must already be passed through `normalizeUsername`.
  Future<User?> byUsername(String normalized);
  Future<int> count();

  /// Whether another account (not [exceptId]) uses this username.
  Future<bool> isUsernameTaken(String normalized, {String? exceptId});

  /// Stores a new user. The very first user also adopts the rows an older,
  /// single-user version of the app left without an owner.
  Future<void> create(User user);

  /// Saves name, username, hint and avatar (not the password).
  Future<void> update(User user);
  Future<void> setPasswordHash(String userId, String hash);
}
