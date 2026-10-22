import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';

/// Debts I took, as one-off mandatory expenses on their due date (an overdue
/// one is due today), so the daily limit, timeline and "Qarşıda" see them.
/// Debts I gave are expected income and are deliberately left out.
List<RecurringRule> debtPlanningRules(List<DebtSummary> debts, DateTime today) {
  return [
    for (final s in debts)
      if (s.debt.direction == DebtDirection.borrowed &&
          !s.debt.isClosed &&
          !s.isSettled &&
          s.debt.dueDate != null)
        _oneOff(s, _dueOrToday(s.debt.dueDate!, today)),
  ];
}

DateTime _dueOrToday(DateTime due, DateTime today) {
  final day = dateOnly(due);
  return day.isBefore(today) ? today : day;
}

RecurringRule _oneOff(DebtSummary s, DateTime day) => RecurringRule(
  title: '${s.debt.person} (Borc)',
  amount: s.remaining,
  category: 'debt',
  frequency: Frequency.monthly,
  startDate: day,
  endDate: day,
);
