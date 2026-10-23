import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/usecases/rule_edit.dart';

enum RuleSaveStatus { editing, saving, done, failure }

/// Plain class: every emit counts, so a repeated failure still notifies.
class RuleEditState {
  const RuleEditState({
    required this.rule,
    required this.today,
    required this.title,
    required this.amountText,
    required this.category,
    required this.plan,
    required this.from,
    this.status = RuleSaveStatus.editing,
  });

  /// The rule as it is stored now.
  final RecurringRule rule;
  final DateTime today;
  final String title, amountText, category;
  final RecurrencePlan plan;

  /// The first day the change applies to.
  final DateTime from;
  final RuleSaveStatus status;

  double get amount => parseMoney(amountText) ?? 0;

  RuleEdit get edit => RuleEdit(
    title: title,
    amount: amount,
    category: category,
    plan: plan,
    from: from,
  );

  bool get canSubmit => edit.isValid && status != RuleSaveStatus.saving;
}
