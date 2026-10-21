import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/features/rules/data/mappers/recurring_rule_mapper.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/repositories/recurring_rule_repository.dart';

class RecurringRuleRepositoryImpl implements RecurringRuleRepository {
  const RecurringRuleRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<List<RecurringRule>> getActive() async => _query('is_active = 1');

  @override
  Future<List<RecurringRule>> getAll() => _query(null);

  Future<List<RecurringRule>> _query(String? where) async {
    final db = await _db.instance;
    final rows = await db.query(Tables.recurringRules, where: where);
    return rows.map(ruleFromMap).toList();
  }

  @override
  Future<int> add(RecurringRule rule) => _db.write(
    (db) => db.insert(Tables.recurringRules, rule.toMap()..remove('id')),
  );

  @override
  Future<void> update(RecurringRule rule) => _db.write(
    (db) => db.update(
      Tables.recurringRules,
      rule.toMap()..remove('id'),
      where: 'id = ?',
      whereArgs: [rule.id],
    ),
  );

  @override
  Future<void> setActive(int id, {required bool active}) => _db.write(
    (db) => db.update(
      Tables.recurringRules,
      {'is_active': active ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    ),
  );
}
