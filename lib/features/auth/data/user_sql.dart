import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/features/auth/data/legacy_data_adopter.dart';
import 'package:flux_wallet/features/auth/data/user_mapper.dart';
import 'package:flux_wallet/features/auth/domain/entities/user.dart';
import 'package:sqflite/sqflite.dart' show Database, DatabaseExecutor, Sqflite;

Future<User?> findUser(Database db, String where, List<Object?> args) async {
  final rows = await db.query(
    Tables.users,
    where: where,
    whereArgs: args,
    limit: 1,
  );
  return rows.isEmpty ? null : userFromMap(rows.first);
}

Future<int> countUsers(DatabaseExecutor db) async =>
    Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM ${Tables.users}'),
    ) ??
    0;

/// Inserts [user]; the very first one also adopts ownerless legacy rows.
Future<void> insertUser(Database db, User user) => db.transaction((txn) async {
  final first = await countUsers(txn) == 0;
  await txn.insert(Tables.users, user.toMap());
  if (first) await adoptOrphanedRows(txn, user.id);
});

/// Name, username, hint and avatar only: never the id, hash or creation time.
Future<void> updateUserRow(Database db, User user) => db.update(
  Tables.users,
  user.toMap()
    ..remove('id')
    ..remove('password_hash')
    ..remove('created_at'),
  where: 'id = ?',
  whereArgs: [user.id],
);

Future<void> updatePasswordHash(Database db, String userId, String hash) =>
    db.update(
      Tables.users,
      {'password_hash': hash},
      where: 'id = ?',
      whereArgs: [userId],
    );
