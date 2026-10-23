import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

extension RecurrencePlanDraft on RecurrencePlan {
  /// The rule this plan describes, before its end date is resolved.
  RecurringRule draft({
    required String title,
    required double amount,
    required String category,
    required DateTime start,
    TxType type = TxType.expense,
  }) => RecurringRule(
    title: title,
    amount: amount,
    category: category,
    frequency: frequency,
    startDate: start,
    type: type,
    weekdays: picksDays ? weekdays : null,
    skipMonths: skipMonths,
  );
}
