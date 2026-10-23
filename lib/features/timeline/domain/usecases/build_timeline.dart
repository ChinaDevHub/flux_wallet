import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/core/utils/group_by.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/schedule_context.dart';
import 'package:flux_wallet/features/timeline/domain/entities/month_frame.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_view.dart';
import 'package:flux_wallet/features/timeline/domain/usecases/build_month_view.dart';
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
    double? cap,
  }) {
    final last = monthEnd(month);
    final txByDay = groupBy(transactions, (t) => dateOnly(t.date));
    MonthFrame frame(ScheduleContext c) => MonthFrame(
      month: monthStart(month),
      today: today,
      balance: balance,
      rules: rules,
      ctx: ctx,
      transactions: txByDay,
      plans: timelinePlans(rules, today, last, c),
      accountNames: accountNames,
      cap: cap,
    );
    // The listed plans keep single-day skips (switched off, not gone).
    return buildMonthView(frame(ctx), shown: frame(ctx.withoutExceptions()));
  }
}
