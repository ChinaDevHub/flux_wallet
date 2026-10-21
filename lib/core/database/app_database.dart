import 'dart:async';

import 'package:flux_wallet/core/database/db_migrations.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase({this.path});

  /// Pass [inMemoryDatabasePath] in tests.
  final String? path;
  final _changes = StreamController<void>.broadcast();
  Future<Database>? _db;

  Future<Database> get instance => _db ??= _open();

  /// Fires after every [write]; screens reload themselves from it.
  Stream<void> get changes => _changes.stream;

  Future<T> write<T>(Future<T> Function(Database db) action) async {
    final result = await action(await instance);
    _changes.add(null);
    return result;
  }

  Future<Database> _open() async {
    final target = path ?? p.join(await getDatabasesPath(), 'flux_wallet.db');
    return openDatabase(
      target,
      version: migrations.length,
      onConfigure: (db) => db.execute('PRAGMA foreign_keys = ON'),
      onCreate: (db, version) => _migrate(db, 0, version),
      onUpgrade: _migrate,
    );
  }

  Future<void> _migrate(Database db, int from, int to) async {
    for (var v = from + 1; v <= to; v++) {
      for (final sql in migrations[v]!) {
        await db.execute(sql);
      }
    }
  }

  Future<void> close() async {
    await _changes.close();
    await (await _db)?.close();
  }
}
