import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/home/data/mappers/day_flag_mapper.dart';
import 'package:flux_wallet/features/home/domain/entities/day_flag.dart';
import 'package:flux_wallet/features/home/domain/repositories/day_flag_repository.dart';
import 'package:sqflite/sqflite.dart' show ConflictAlgorithm;

class DayFlagRepositoryImpl implements DayFlagRepository {
  const DayFlagRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<Set<DateTime>> getOffDaysFrom(DateTime from) async {
    final db = await _db.instance;
    final rows = await db.query(
      Tables.dayFlags,
      where: 'is_not_working_day = 1 AND date >= ?',
      whereArgs: [dayKey(from)],
    );
    return {for (final r in rows) DateTime.parse(r['date'] as String)};
  }

  @override
  Future<void> set(DayFlag flag) async {
    final db = await _db.instance;
    await db.insert(
      Tables.dayFlags,
      flag.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
