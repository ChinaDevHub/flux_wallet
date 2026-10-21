import 'package:flux_wallet/features/home/domain/entities/recurring_rule.dart';

abstract interface class RecurringRuleRepository {
  Future<List<RecurringRule>> getActive();
  Future<int> add(RecurringRule rule);
}
