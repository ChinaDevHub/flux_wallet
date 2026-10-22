import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/features/settings/data/backup_relations.dart';
import 'package:sqflite/sqflite.dart' show DatabaseExecutor;

/// Removes the signed-in user's rows (children first).
Future<void> clearUserData(DatabaseExecutor txn, UserScope scope) async {
  for (final table in Tables.userData.reversed) {
    await txn.delete(table, where: scope.where(), whereArgs: scope.args());
  }
}

/// Inserts [tables] as the signed-in user's rows. Rows get new ids, so other
/// users' ids never collide; references between rows are rewritten and rows
/// whose parent is missing are skipped.
Future<void> restoreUserData(
  DatabaseExecutor txn,
  UserScope scope,
  Map<String, List<Map<String, Object?>>> tables,
) async {
  final newIds = <String, Map<Object?, int>>{};
  for (final table in Tables.userData) {
    for (final source in tables[table] ?? const <Map<String, Object?>>[]) {
      final row = Map<String, Object?>.of(source)..remove('user_id');
      final oldId = row.remove('id');
      if (!_relink(row, backupRelations[table], newIds)) continue;
      final id = await txn.insert(table, scope.stamp(row));
      if (oldId != null) (newIds[table] ??= {})[oldId] = id;
    }
  }
}

bool _relink(
  Map<String, Object?> row,
  Map<String, String>? relations,
  Map<String, Map<Object?, int>> newIds,
) {
  for (final e in (relations ?? const <String, String>{}).entries) {
    final id = newIds[e.value]?[row[e.key]];
    if (id == null) return false;
    row[e.key] = id;
  }
  return true;
}
