import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/rule_exception.dart';
import 'package:flux_wallet/features/rules/domain/repositories/recurring_rule_repository.dart';
import 'package:flux_wallet/features/rules/domain/repositories/rule_exception_repository.dart';
import 'package:flux_wallet/features/transactions/domain/entities/new_transaction.dart';

/// "Təkrarla": turns a just-recorded transaction into a recurring rule.
class CreateRuleFromTransaction {
  const CreateRuleFromTransaction(this._rules, this._exceptions);

  final RecurringRuleRepository _rules;
  final RuleExceptionRepository _exceptions;

  Future<void> call(NewTransaction n, Frequency frequency) async {
    final day = dateOnly(n.date);
    final id = await _rules.add(
      RecurringRule(
        title: n.title,
        amount: n.amount,
        category: n.category,
        frequency: frequency,
        startDate: day,
        type: n.kind.type,
      ),
    );
    // The first occurrence is the transaction that was just recorded.
    await _exceptions.add(RuleException(ruleId: id, date: day));
  }
}
