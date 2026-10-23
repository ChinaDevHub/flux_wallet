import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_end.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan.dart';

/// What the rule edit form collects (see `RuleEditApply` for the result).
class RuleEdit {
  const RuleEdit({
    required this.title,
    required this.amount,
    required this.category,
    required this.plan,
    required this.from,
  });

  final String title;
  final double amount;
  final String category;
  final RecurrencePlan plan;

  /// The first day the change applies to.
  final DateTime from;

  /// The chosen last day lies before the first day.
  bool get endsBeforeStart {
    final end = plan.end;
    return end is EndsOn && dateOnly(end.date).isBefore(dateOnly(from));
  }

  bool get isValid =>
      title.trim().isNotEmpty && amount > 0 && plan.isValid && !endsBeforeStart;

  /// The same edit, but never reaching back before [day]: yesterday is over.
  RuleEdit startingNoEarlierThan(DateTime day) => RuleEdit(
    title: title,
    amount: amount,
    category: category,
    plan: plan,
    from: from.isBefore(day) ? dateOnly(day) : dateOnly(from),
  );
}
