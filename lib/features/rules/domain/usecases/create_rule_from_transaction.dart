import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan_draft.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule_copy.dart';
import 'package:flux_wallet/features/rules/domain/entities/rule_exception.dart';
import 'package:flux_wallet/features/rules/domain/repositories/recurring_rule_repository.dart';
import 'package:flux_wallet/features/rules/domain/repositories/rule_exception_repository.dart';
import 'package:flux_wallet/features/rules/domain/usecases/resolve_rule_end.dart';
import 'package:flux_wallet/features/transactions/domain/entities/new_transaction.dart';

/// Turns what the "+" form collected into a recurring rule.
class CreateRuleFromTransaction {
  const CreateRuleFromTransaction(
    this._rules,
    this._exceptions, [
    this._end = const ResolveRuleEnd(),
  ]);

  final RecurringRuleRepository _rules;
  final RuleExceptionRepository _exceptions;
  final ResolveRuleEnd _end;

  /// "Təkrarla": a transaction was just recorded on its day, so that first
  /// occurrence is already real and the rule skips it.
  Future<void> call(NewTransaction n, RecurrencePlan plan) async {
    final day = dateOnly(n.date);
    final id = await _create(n, plan);
    await _exceptions.add(RuleException(ruleId: id, date: day));
  }

  /// A day that has not come yet cannot hold a transaction: it becomes a
  /// plan. Without a repeat it is a one-off; with one, the rule starts there.
  Future<void> planAhead(NewTransaction n, RecurrencePlan? plan) =>
      _create(n, plan ?? RecurrencePlan.once(dateOnly(n.date)));

  Future<int> _create(NewTransaction n, RecurrencePlan plan) {
    final draft = plan.draft(
      title: n.title,
      amount: n.amount,
      category: n.category,
      type: n.kind.type,
      start: dateOnly(n.date),
    );
    return _rules.add(draft.copyWith(endDate: _end(draft, plan.end)));
  }
}
