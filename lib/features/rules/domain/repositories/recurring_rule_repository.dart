import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';

abstract interface class RecurringRuleRepository {
  Future<List<RecurringRule>> getActive();
  Future<List<RecurringRule>> getAll();
  Future<int> add(RecurringRule rule);
  Future<void> update(RecurringRule rule);
  Future<void> setActive(int id, {required bool active});
}
