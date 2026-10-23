import 'package:flux_wallet/core/utils/int_sets.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';

/// Weekday sets, DateTime.monday (1) .. DateTime.sunday (7).
abstract final class Weekdays {
  static const all = {1, 2, 3, 4, 5, 6, 7};
  static const working = {1, 2, 3, 4, 5};

  /// What a frequency means when the user has not customised the days.
  static Set<int> defaultFor(Frequency f, DateTime start) => switch (f) {
    Frequency.daily => all,
    Frequency.weekdays => working,
    Frequency.weekly => {start.weekday},
    Frequency.monthly => const {},
  };
}

extension RecurringRuleDays on RecurringRule {
  Set<int> get defaultWeekdays => Weekdays.defaultFor(frequency, startDate);

  Set<int> get activeWeekdays => weekdays ?? defaultWeekdays;

  /// True when the user changed the frequency's usual days.
  bool get hasCustomDays =>
      weekdays != null && !sameSet(weekdays!, defaultWeekdays);

  /// The usual days the user switched off ("Çər istisna").
  Set<int> get excludedWeekdays => frequency == Frequency.weekly
      ? const {}
      : defaultWeekdays.difference(activeWeekdays);
}
