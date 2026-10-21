import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/schedule_context.dart';
import 'package:flux_wallet/features/rules/domain/usecases/monthly_dates.dart';

/// Turns a [RecurringRule] into concrete dates inside `[from, to]` (inclusive),
/// minus the dates the [ScheduleContext] switches off.
class RecurrenceExpander {
  const RecurrenceExpander();

  List<DateTime> expand(
    RecurringRule rule,
    DateTime from,
    DateTime to, {
    ScheduleContext ctx = ScheduleContext.empty,
  }) {
    if (!rule.isActive) return const [];
    final start = dateOnly(rule.startDate);
    final lo = from.isBefore(start) ? start : dateOnly(from);
    final end = rule.endDate == null ? null : dateOnly(rule.endDate!);
    final hi = end != null && end.isBefore(to) ? end : dateOnly(to);
    if (lo.isAfter(hi)) return const [];
    final dates = switch (rule.frequency) {
      Frequency.daily => _days(lo, hi, (_) => true),
      Frequency.weekly => _days(lo, hi, (d) => d.weekday == start.weekday),
      Frequency.weekdays => _days(
        lo,
        hi,
        (d) => d.weekday <= DateTime.friday && !ctx.offDays.contains(d),
      ),
      Frequency.monthly => monthlyDates(start.day, lo, hi),
    };
    return dates.where((d) => !ctx.isSkipped(rule, d)).toList();
  }

  List<DateTime> _days(DateTime lo, DateTime hi, bool Function(DateTime) ok) {
    return [
      for (var d = lo; !d.isAfter(hi); d = addDays(d, 1))
        if (ok(d)) d,
    ];
  }
}
