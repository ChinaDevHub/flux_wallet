import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  test('upgrades a v1 database and keeps its data', () async {
    final path = '${await databaseFactory.getDatabasesPath()}/mig_test.db';
    await databaseFactory.deleteDatabase(path);
    final v1 = await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, _) async {
          for (final sql in schemaV1) {
            await db.execute(sql);
          }
          await db.insert(Tables.settings, {
            'key': 'user_name',
            'value': 'Rauf',
          });
        },
      ),
    );
    await v1.close();

    final app = AppDatabase(path: path);
    final db = await app.instance;
    expect(await db.query(Tables.settings), hasLength(1));
    expect(await db.query(Tables.ruleExceptions), isEmpty);
    await app.close();
    await databaseFactory.deleteDatabase(path);
  });
}
