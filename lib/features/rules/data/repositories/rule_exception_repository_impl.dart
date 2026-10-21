import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/rule_exception.dart';
import 'package:flux_wallet/features/rules/domain/repositories/rule_exception_repository.dart';
import 'package:sqflite/sqflite.dart' show ConflictAlgorithm;

class RuleExceptionRepositoryImpl implements RuleExceptionRepository {
  const RuleExceptionRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<Map<int, Set<DateTime>>> getFrom(DateTime from) async {
    final db = await _db.instance;
    final rows = await db.query(
      Tables.ruleExceptions,
      where: 'date >= ?',
      whereArgs: [dayKey(from)],
    );
    final result = <int, Set<DateTime>>{};
    for (final r in rows) {
      final date = DateTime.parse(r['date'] as String);
      (result[r['rule_id'] as int] ??= {}).add(date);
    }
    return result;
  }

  @override
  Future<void> add(RuleException e) => _db.write(
    (db) => db.insert(Tables.ruleExceptions, {
      'rule_id': e.ruleId,
      'date': dayKey(e.date),
    }, conflictAlgorithm: ConflictAlgorithm.ignore),
  );
}
