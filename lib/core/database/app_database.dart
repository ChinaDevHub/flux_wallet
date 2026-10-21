import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase({this.path});

  /// Pass [inMemoryDatabasePath] in tests.
  final String? path;
  Future<Database>? _db;

  Future<Database> get instance => _db ??= _open();

  Future<Database> _open() async {
    final target = path ?? p.join(await getDatabasesPath(), 'flux_wallet.db');
    return openDatabase(
      target,
      version: 1,
      onConfigure: (db) => db.execute('PRAGMA foreign_keys = ON'),
      onCreate: (db, _) async {
        for (final sql in createStatements) {
          await db.execute(sql);
        }
      },
    );
  }

  Future<void> close() async => (await _db)?.close();
}
