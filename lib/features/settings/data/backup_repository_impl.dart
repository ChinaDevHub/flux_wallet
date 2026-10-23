import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/database/db_schema_v7.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/features/settings/data/backup_format.dart';
import 'package:flux_wallet/features/settings/data/backup_restore.dart';
import 'package:flux_wallet/features/settings/domain/repositories/backup_repository.dart';

/// Backs up and restores the signed-in user's data (not other users', not the
/// per-device settings).
class BackupRepositoryImpl implements BackupRepository {
  const BackupRepositoryImpl(this._db, this._scope);

  final AppDatabase _db;
  final UserScope _scope;

  @override
  Future<String> exportJson(DateTime exportedAt) async {
    final db = await _db.instance;
    final tables = {
      for (final t in Tables.userData)
        t: [
          for (final row in await db.query(
            t,
            where: _scope.where(),
            whereArgs: _scope.args(),
          ))
            Map<String, Object?>.of(row)..remove('user_id'),
        ],
    };
    return encodeBackup(tables, exportedAt);
  }

  @override
  Future<void> importJson(String json) async {
    final tables = decodeBackup(json);
    await _db.write(
      (db) => db.transaction((txn) async {
        await clearUserData(txn, _scope);
        await restoreUserData(txn, _scope, tables);
        // Backups from before pauses existed list switched-off rules only.
        await txn.rawInsert(backfillUserRulePauses, [_scope.id]);
      }),
    );
  }
}
