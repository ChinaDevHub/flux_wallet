import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/features/settings/domain/repositories/settings_repository.dart';
import 'package:sqflite/sqflite.dart' show ConflictAlgorithm;

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<String?> read(String key) async {
    final db = await _db.instance;
    final rows = await db.query(
      Tables.settings,
      where: 'key = ?',
      whereArgs: [key],
    );
    return rows.isEmpty ? null : rows.first['value'] as String;
  }

  @override
  Future<void> write(String key, String value) => _db.write(
    (db) => db.insert(Tables.settings, {
      'key': key,
      'value': value,
    }, conflictAlgorithm: ConflictAlgorithm.replace),
  );
}
