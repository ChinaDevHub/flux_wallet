import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/debts/domain/repositories/debt_repository.dart';
import 'package:flux_wallet/features/debts/domain/usecases/debt_planning_rules.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/repositories/recurring_rule_repository.dart';

/// Everything that plans money: every rule (the ones that ended or are off
/// still ran on earlier days, see `ScheduleContext`) plus debts due.
class LoadPlanningRules {
  const LoadPlanningRules(this._rules, this._debts, this._clock);

  final RecurringRuleRepository _rules;
  final DebtRepository _debts;
  final Clock _clock;

  Future<List<RecurringRule>> call() async => [
    ...await _rules.getAll(),
    ...debtPlanningRules(await _debts.getAll(), dateOnly(_clock())),
  ];
}
