import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/rule_exception.dart';
import 'package:flux_wallet/features/rules/domain/repositories/rule_exception_repository.dart';
import 'package:sqflite/sqflite.dart' show ConflictAlgorithm;

class RuleExceptionRepositoryImpl implements RuleExceptionRepository {
  const RuleExceptionRepositoryImpl(this._db, this._scope);

  final AppDatabase _db;
  final UserScope _scope;

  @override
  Future<Map<int, Set<DateTime>>> getFrom(DateTime from) async {
    final db = await _db.instance;
    final rows = await db.query(
      Tables.ruleExceptions,
      where: _scope.where('date >= ?'),
      whereArgs: _scope.args([dayKey(from)]),
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
    (db) => db.insert(
      Tables.ruleExceptions,
      _scope.stamp({'rule_id': e.ruleId, 'date': dayKey(e.date)}),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    ),
  );

  @override
  Future<void> remove(RuleException e) => _db.write(
    (db) => db.delete(
      Tables.ruleExceptions,
      where: _scope.where('rule_id = ? AND date = ?'),
      whereArgs: _scope.args([e.ruleId, dayKey(e.date)]),
    ),
  );
}
