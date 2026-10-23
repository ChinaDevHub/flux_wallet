import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/core/utils/group_by.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/schedule_context.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_view.dart';
import 'package:flux_wallet/features/timeline/domain/usecases/income_cycle_finder.dart';
import 'package:flux_wallet/features/timeline/domain/usecases/lowest_forecast_day.dart';
import 'package:flux_wallet/features/timeline/domain/usecases/timeline_balances.dart';
import 'package:flux_wallet/features/timeline/domain/usecases/timeline_days.dart';
import 'package:flux_wallet/features/timeline/domain/usecases/timeline_plans.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

/// One month day by day; planned items are computed, never stored.
class BuildTimeline {
  const BuildTimeline();
  TimelineView call({
    required DateTime today,
    required DateTime month,
    required double balance,
    required List<RecurringRule> rules,
    required ScheduleContext ctx,
    required List<Transaction> transactions,
    Map<int, String> accountNames = const {},
  }) {
    final plans = timelinePlans(rules, today, monthEnd(month), ctx);
    final txByDay = groupBy(transactions, (t) => dateOnly(t.date));
    final ends = endBalances(
      month: month,
      today: today,
      balance: balance,
      transactions: txByDay,
      plans: plans,
    );
    final days = timelineDays(
      month: month,
      today: today,
      ctx: ctx,
      ends: ends,
      transactions: txByDay,
      plans: plans,
      accountNames: accountNames,
    );
    final cycle = const IncomeCycleFinder()(rules, today, ctx);
    return TimelineView(
      month: monthStart(month),
      days: days,
      cycle: cycle,
      lowest: lowestForecastDay(days, today, cycle?.date),
    );
  }
}
