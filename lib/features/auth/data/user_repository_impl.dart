import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/session/session.dart';
import 'package:flux_wallet/features/auth/data/user_sql.dart';
import 'package:flux_wallet/features/auth/domain/entities/user.dart';
import 'package:flux_wallet/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(this._db, this._session);

  final AppDatabase _db;
  final Session _session;

  Future<User?> _find(String where, List<Object?> args) async =>
      findUser(await _db.instance, where, args);

  @override
  Future<User?> byId(String id) => _find('id = ?', [id]);

  @override
  Future<User?> current() async {
    final id = _session.activeId;
    return id == null ? null : byId(id);
  }

  @override
  Future<User?> byUsername(String normalized) =>
      _find('username = ?', [normalized]);

  @override
  Future<int> count() async => countUsers(await _db.instance);

  @override
  Future<bool> isUsernameTaken(String normalized, {String? exceptId}) async {
    final other = await byUsername(normalized);
    return other != null && other.id != exceptId;
  }

  @override
  Future<void> create(User user) => _db.write((db) => insertUser(db, user));

  @override
  Future<void> update(User user) => _db.write((db) => updateUserRow(db, user));

  @override
  Future<void> setPasswordHash(String userId, String hash) =>
      _db.write((db) => updatePasswordHash(db, userId, hash));
}
