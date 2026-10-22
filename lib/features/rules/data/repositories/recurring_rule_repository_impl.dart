import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/features/rules/data/mappers/recurring_rule_mapper.dart';
import 'package:flux_wallet/features/rules/data/repositories/rule_sql.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/repositories/recurring_rule_repository.dart';

class RecurringRuleRepositoryImpl implements RecurringRuleRepository {
  const RecurringRuleRepositoryImpl(this._db, this._scope);

  final AppDatabase _db;
  final UserScope _scope;

  @override
  Future<List<RecurringRule>> getActive() =>
      selectRules(_db, _scope, 'is_active = 1');

  @override
  Future<List<RecurringRule>> getAll() => selectRules(_db, _scope);

  @override
  Future<int> add(RecurringRule rule) => _db.write(
    (db) => db.insert(
      Tables.recurringRules,
      _scope.stamp(rule.toMap()..remove('id')),
    ),
  );

  @override
  Future<void> update(RecurringRule rule) => _db.write(
    (db) => db.update(
      Tables.recurringRules,
      rule.toMap()..remove('id'),
      where: _scope.where('id = ?'),
      whereArgs: _scope.args([rule.id]),
    ),
  );

  @override
  Future<void> setActive(int id, {required bool active}) => _db.write(
    (db) => db.update(
      Tables.recurringRules,
      {'is_active': active ? 1 : 0},
      where: _scope.where('id = ?'),
      whereArgs: _scope.args([id]),
    ),
  );
}
