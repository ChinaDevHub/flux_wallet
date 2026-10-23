import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/usecases/recurrence_expander.dart';
import 'package:flux_wallet/features/rules/presentation/cubit/rule_edit_state.dart';

/// The form filled with [rule]. The change starts on [from], else on the
/// rule's next day (or its first, if it has not started), else today.
RuleEditState startRuleEdit(
  RecurringRule rule,
  DateTime today,
  DateTime? from,
) {
  final next = const RecurrenceExpander()
      .expand(rule, today, addDays(today, 400))
      .firstOrNull;
  final start = from ?? next ?? today;
  return RuleEditState(
    rule: rule,
    today: today,
    title: rule.title,
    amountText: formatPlain(rule.amount),
    category: rule.category,
    plan: RecurrencePlan.fromRule(rule),
    from: start.isBefore(today) ? today : dateOnly(start),
  );
}
