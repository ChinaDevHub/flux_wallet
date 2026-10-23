import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan_draft.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule_copy.dart';
import 'package:flux_wallet/features/rules/domain/usecases/resolve_rule_end.dart';
import 'package:flux_wallet/features/rules/domain/usecases/rule_edit.dart';

extension RuleEditApply on RuleEdit {
  /// The rule as it should be from `from` on: [old]'s kind and on/off state,
  /// the form's content, the end date resolved.
  RecurringRule applyTo(RecurringRule old) {
    final draft = plan
        .draft(
          title: title.trim(),
          amount: amount,
          category: category,
          start: dateOnly(from),
          type: old.type,
        )
        .copyWith(isActive: old.isActive);
    return draft.copyWith(endDate: const ResolveRuleEnd()(draft, plan.end));
  }
}
