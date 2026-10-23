import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/schedule_context.dart';
import 'package:flux_wallet/features/rules/domain/entities/weekdays.dart';
import 'package:flux_wallet/features/rules/domain/usecases/monthly_dates.dart';

/// Turns a [RecurringRule] into concrete dates inside `[from, to]` (inclusive),
/// minus its paused months and the dates the [ScheduleContext] switches off
/// (single skips, "işə getmirəm" days and stretches the rule was switched off).
/// Whether the rule is switched off *today* is not checked here: a rule that
/// is off still ran on the days before.
class RecurrenceExpander {
  const RecurrenceExpander();

  List<DateTime> expand(
    RecurringRule rule,
    DateTime from,
    DateTime to, {
    ScheduleContext ctx = ScheduleContext.empty,
  }) {
    final start = dateOnly(rule.startDate);
    final lo = from.isBefore(start) ? start : dateOnly(from);
    final end = rule.endDate == null ? null : dateOnly(rule.endDate!);
    final hi = end != null && end.isBefore(to) ? end : dateOnly(to);
    if (lo.isAfter(hi)) return const [];
    final dates = rule.frequency == Frequency.monthly
        ? monthlyDates(start.day, lo, hi)
        : _days(lo, hi, (d) => _onDay(rule, d, ctx));
    return dates
        .where((d) => !rule.skipMonths.contains(d.month))
        .where((d) => !ctx.isSkipped(rule, d))
        .toList();
  }

  /// Only "İş günləri" rules also respect the "işə getmirəm" switch.
  bool _onDay(RecurringRule rule, DateTime d, ScheduleContext ctx) =>
      rule.activeWeekdays.contains(d.weekday) &&
      !(rule.frequency == Frequency.weekdays && ctx.offDays.contains(d));

  List<DateTime> _days(DateTime lo, DateTime hi, bool Function(DateTime) ok) {
    return [
      for (var d = lo; !d.isAfter(hi); d = addDays(d, 1))
        if (ok(d)) d,
    ];
  }
}
