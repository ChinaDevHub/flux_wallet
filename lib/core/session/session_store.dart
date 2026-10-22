import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/current_user.dart';
import 'package:flux_wallet/core/session/session.dart';
import 'package:sqflite/sqflite.dart' show ConflictAlgorithm;

/// The signed-in user id, in memory and in `settings` (survives restarts).
class SessionStore implements Session, CurrentUser {
  SessionStore(this._db);

  static const _key = 'active_user_id';
  final AppDatabase _db;
  String? _id;

  @override
  String? get activeId => _id;

  @override
  String get id => _id ?? (throw StateError('Nobody is signed in'));

  @override
  Future<String?> restore() async {
    final db = await _db.instance;
    final rows = await db.query(
      Tables.settings,
      where: 'key = ?',
      whereArgs: [_key],
    );
    return _id = rows.isEmpty ? null : rows.first['value'] as String;
  }

  @override
  Future<void> signIn(String userId) async {
    _id = userId;
    await _db.write(
      (db) => db.insert(Tables.settings, {
        'key': _key,
        'value': userId,
      }, conflictAlgorithm: ConflictAlgorithm.replace),
    );
  }

  @override
  Future<void> signOut() async {
    _id = null;
    await _db.write(
      (db) => db.delete(Tables.settings, where: 'key = ?', whereArgs: [_key]),
    );
  }
}
