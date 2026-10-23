import 'package:flux_wallet/features/rules/domain/entities/recurrence_end.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';

extension RecurrencePlanCopy on RecurrencePlan {
  RecurrencePlan copyWith({
    Set<int>? weekdays,
    Set<int>? skipMonths,
    RecurrenceEnd? end,
  }) => RecurrencePlan(
    frequency: frequency,
    weekdays: weekdays ?? this.weekdays,
    skipMonths: skipMonths ?? this.skipMonths,
    end: end ?? this.end,
  );

  /// Adds or removes one weekday.
  RecurrencePlan toggleWeekday(int day) => copyWith(
    weekdays: weekdays.contains(day)
        ? (weekdays.toSet()..remove(day))
        : (weekdays.toSet()..add(day)),
  );

  /// The transaction moved to another day: a weekly plan follows it, the
  /// others keep the days the user picked.
  RecurrencePlan rebase(DateTime start) => frequency == Frequency.weekly
      ? copyWith(weekdays: {start.weekday})
      : this;
}
