import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/features/home/data/mappers/recurring_rule_mapper.dart';
import 'package:flux_wallet/features/home/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/home/domain/repositories/recurring_rule_repository.dart';

class RecurringRuleRepositoryImpl implements RecurringRuleRepository {
  const RecurringRuleRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<List<RecurringRule>> getActive() async {
    final db = await _db.instance;
    final rows = await db.query(Tables.recurringRules, where: 'is_active = 1');
    return rows.map(ruleFromMap).toList();
  }

  @override
  Future<int> add(RecurringRule rule) async {
    final db = await _db.instance;
    return db.insert(Tables.recurringRules, rule.toMap()..remove('id'));
  }
}
