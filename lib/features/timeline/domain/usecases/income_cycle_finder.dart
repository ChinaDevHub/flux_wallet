import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/schedule_context.dart';
import 'package:flux_wallet/features/rules/domain/usecases/next_income_finder.dart';
import 'package:flux_wallet/features/timeline/domain/entities/income_cycle.dart';

class IncomeCycleFinder {
  const IncomeCycleFinder();

  static const _fallbackCycleDays = 30;

  IncomeCycle? call(
    List<RecurringRule> rules,
    DateTime today,
    ScheduleContext ctx,
  ) {
    const finder = NextIncomeFinder();
    final next = finder.nextPayment(rules, today, ctx);
    if (next == null) return null;
    final previous = finder.previous(rules, today, ctx);
    final length = previous == null
        ? _fallbackCycleDays
        : daysBetween(previous, next.date);
    final daysLeft = daysBetween(today, next.date);
    return IncomeCycle(
      date: next.date,
      title: next.rule.title,
      daysLeft: daysLeft,
      progress: length <= 0 ? 1 : (1 - daysLeft / length).clamp(0.0, 1.0),
    );
  }
}
