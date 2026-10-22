import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/data/mappers/day_flag_mapper.dart';
import 'package:flux_wallet/features/rules/domain/entities/day_flag.dart';
import 'package:flux_wallet/features/rules/domain/repositories/day_flag_repository.dart';
import 'package:sqflite/sqflite.dart' show ConflictAlgorithm;

class DayFlagRepositoryImpl implements DayFlagRepository {
  const DayFlagRepositoryImpl(this._db, this._scope);

  final AppDatabase _db;
  final UserScope _scope;

  @override
  Future<Set<DateTime>> getOffDaysFrom(DateTime from) async {
    final db = await _db.instance;
    final rows = await db.query(
      Tables.dayFlags,
      where: _scope.where('is_not_working_day = 1 AND date >= ?'),
      whereArgs: _scope.args([dayKey(from)]),
    );
    return {for (final r in rows) DateTime.parse(r['date'] as String)};
  }

  @override
  Future<void> set(DayFlag flag) => _db.write(
    (db) => db.insert(
      Tables.dayFlags,
      _scope.stamp(flag.toMap()),
      conflictAlgorithm: ConflictAlgorithm.replace,
    ),
  );
}
