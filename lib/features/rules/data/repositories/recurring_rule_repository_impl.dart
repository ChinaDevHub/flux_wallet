import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/features/rules/data/mappers/recurring_rule_mapper.dart';
import 'package:flux_wallet/features/rules/data/repositories/rule_sql.dart';
import 'package:flux_wallet/features/rules/data/repositories/rule_state_writes.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/repositories/recurring_rule_repository.dart';

class RecurringRuleRepositoryImpl
    with RuleStateWrites
    implements RecurringRuleRepository {
  RecurringRuleRepositoryImpl(this.db, this.scope);

  @override
  final AppDatabase db;
  @override
  final UserScope scope;

  @override
  Future<List<RecurringRule>> getAll() => selectRules(db, scope);

  @override
  Future<int> add(RecurringRule rule) => db.write(
    (d) => d.insert(
      Tables.recurringRules,
      scope.stamp(rule.toMap()..remove('id')),
    ),
  );

  @override
  Future<void> update(RecurringRule rule) => db.write(
    (d) => d.update(
      Tables.recurringRules,
      rule.toMap()..remove('id'),
      where: scope.where('id = ?'),
      whereArgs: scope.args([rule.id]),
    ),
  );

  @override
  Future<void> delete(int id) => db.write(
    (d) => d.delete(
      Tables.recurringRules,
      where: scope.where('id = ?'),
      whereArgs: scope.args([id]),
    ),
  );
}
