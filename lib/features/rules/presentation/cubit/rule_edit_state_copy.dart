import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan.dart';
import 'package:flux_wallet/features/rules/presentation/cubit/rule_edit_state.dart';

extension RuleEditStateCopy on RuleEditState {
  RuleEditState copyWith({
    String? title,
    String? amountText,
    String? category,
    RecurrencePlan? plan,
    DateTime? from,
    RuleSaveStatus? status,
  }) => RuleEditState(
    rule: rule,
    today: today,
    title: title ?? this.title,
    amountText: amountText ?? this.amountText,
    category: category ?? this.category,
    plan: plan ?? this.plan,
    from: from ?? this.from,
    status: status ?? this.status,
  );
}
