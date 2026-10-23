import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule_copy.dart';
import 'package:flux_wallet/features/rules/domain/entities/rule_exception.dart';
import 'package:flux_wallet/features/rules/domain/repositories/recurring_rule_repository.dart';
import 'package:flux_wallet/features/rules/domain/repositories/rule_exception_repository.dart';
import 'package:flux_wallet/features/rules/domain/usecases/resolve_rule_end.dart';
import 'package:flux_wallet/features/transactions/domain/entities/new_transaction.dart';

/// "Təkrarla": turns a just-recorded transaction into a recurring rule.
class CreateRuleFromTransaction {
  const CreateRuleFromTransaction(
    this._rules,
    this._exceptions, [
    this._end = const ResolveRuleEnd(),
  ]);

  final RecurringRuleRepository _rules;
  final RuleExceptionRepository _exceptions;
  final ResolveRuleEnd _end;

  Future<void> call(NewTransaction n, RecurrencePlan plan) async {
    final day = dateOnly(n.date);
    final draft = plan.draft(
      title: n.title,
      amount: n.amount,
      category: n.category,
      type: n.kind.type,
      start: day,
    );
    final id = await _rules.add(draft.copyWith(endDate: _end(draft, plan.end)));
    // The first occurrence is the transaction that was just recorded.
    await _exceptions.add(RuleException(ruleId: id, date: day));
  }
}
